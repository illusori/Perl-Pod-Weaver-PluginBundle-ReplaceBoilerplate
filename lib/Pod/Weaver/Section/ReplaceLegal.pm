package Pod::Weaver::Section::ReplaceLegal;

# ABSTRACT: add or replace a section for the copyright and license

use Moose;

extends 'Pod::Weaver::Section::Legal';
with 'Pod::Weaver::Role::SectionReplacer';

our $VERSION = '0.99_01';

sub default_section_name { 'COPYRIGHT AND LICENSE' }
sub default_section_aliases { [ 'LICENSE AND COPYRIGHT' ] }

no Moose;
1;

__END__


=pod

=head1 NAME

Pod::Weaver::Section::ReplaceLegal - add or replace a section for the copyright and license

=head1 VERSION

version 0.99_01

=head1 OVERVIEW

This section plugin will produce a hunk of Pod giving the copyright and license
information for the document, like this:

  =head1 COPYRIGHT AND LICENSE

  This document is copyright (C) 1991, Ricardo Signes.

  This document is available under the blah blah blah.

This plugin will do nothing if no C<license> input parameter is available.  The
C<license> is expected to be a L<Software::License> object.

=head1 NAME

Pod::Weaver::Section::ReplaceLegal - add or replace a section for the copyright and license

=head1 AUTHOR

Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl@illusori.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl@illusori.co.uk>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
