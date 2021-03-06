#!perl -T

use strict;
use warnings;

use Test::More;
use Test::Differences;
use Moose::Autobox 0.11;

use PPI;

use Pod::Elemental;
use Pod::Elemental::Selectors -all;
use Pod::Elemental::Transformer::Pod5;
use Pod::Elemental::Transformer::Nester;

use Software::License::Perl_5;

use Pod::Weaver;

plan tests => 2;

my $perl_document = <<'END_OF_PERL';
package Module::Name;
# ABSTRACT: abstract text

my $this = 'a test';
END_OF_PERL

my $license = Software::License::Perl_5->new( {
    holder => 'Sam Graham',
    } );
my $license_text = $license->notice();
chomp( $license_text );

my ( $sequence ) = Pod::Weaver::Config::Finder->new->read_config(
    't/test_files/50-replace-boilerplate'
    );
my $weaver = Pod::Weaver->new_from_config_sequence( $sequence, {} );

my $in_file   = 't/test_files/50-replace-boilerplate.in.pod';
my $out_file  = 't/test_files/50-replace-boilerplate.out.pod';

my $in_pod       = do { local $/; open my $fh, '<', $in_file;  <$fh> };
my $expected_pod = do { local $/; open my $fh, '<', $out_file; <$fh> };

$expected_pod =~ s/\{\{LICENSE\}\}/$license_text/;

my $pod_document = Pod::Elemental->read_string( $in_pod );
my $ppi_document = PPI::Document->new( \$perl_document );

my $woven_pod_document = $weaver->weave_document( {
    pod_document => $pod_document,
    ppi_document => $ppi_document,

    version      => '10.2',
    authors      => [ 'Sam Graham', ],
    license      => $license,
    } );

my $expected_pod_document =
    Pod::Elemental->read_string( $expected_pod );
#  Clean it up before we compare.
Pod::Elemental::Transformer::Pod5->new->transform_node(
    $expected_pod_document
    );
my $nester = Pod::Elemental::Transformer::Nester->new( {
    top_selector => s_command( [ qw(head1) ] ),
    content_selectors => [
        s_flat,
        s_command( [ qw(head2 head3 head4 over item back) ]),
        ],
    } );
$nester->transform_node( $expected_pod_document );

#  ReplaceLegal inserts entire license block as single
#  Pod::Elemental::Element::Pod5::Ordinary rather than
#  one-per-paragraph, so won't match the same structure
#  as if it were parsed... we fudge the parsed structure
#  to merge the children of that section into a single para.
my $command_selector = s_command('head1');
my $named_selector = sub {
    my ( $node ) = @_;

    my $content = $node->content;
    $content =~ s/^\s+//;
    $content =~ s/\s+$//;

    return( $command_selector->( $_[ 0 ] ) &&
        $content eq 'COPYRIGHT AND LICENSE' );
};
my $license_node = $expected_pod_document->children->grep($named_selector)->first;
my $license_content = '';
foreach my $child_node ( @{$license_node->children} )
{
    $license_content .= $child_node->as_pod_string;
}
chomp( $license_content );
$license_node->children( [
    Pod::Elemental::Element::Pod5::Ordinary->new( {
        content => $license_content,
        } ) ] );

#
#  1:  Test the Pod::Elemental structure for the Pod.
eq_or_diff(
    $woven_pod_document,
    $expected_pod_document,
    "pod structure correct",
    );

#
#  2:  Test the Pod as a string is the expected.
#  This is more sensitive to upstream changes in Pod::Elemental
#  (for example white-space in the output), and provides little
#  benefit in terms of increased testing, however it _does_ produce
#  output that's considerably more human-readable in the case of
#  test 1 failing.
eq_or_diff(
    $woven_pod_document->as_pod_string,
    $expected_pod,
    "pod string correct",
    );
