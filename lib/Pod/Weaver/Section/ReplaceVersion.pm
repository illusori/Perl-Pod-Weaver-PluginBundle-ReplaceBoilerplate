package Pod::Weaver::Section::ReplaceVersion;

use Moose;

# ABSTRACT: replace a VERSION pod section.

extends 'Pod::Weaver::Section::Version';
with 'Pod::Weaver::Role::SectionReplacer';

our $VERSION = '0.99_01';

sub default_section_name { 'VERSION' }

no Moose;
1;

__END__


=pod

=head1 NAME

Pod::Weaver::Section::ReplaceVersion - replace a VERSION pod section.

=head1 VERSION

version 0.99_01

=head1 OVERVIEW

This section plugin will produce a hunk of Pod meant to indicate the version of
the document being viewed, like this:

  =head1 VERSION

  version 1.234

It will do nothing if there is no C<version> entry in the input.

=head1 AUTHOR

Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl BLAHBLAH illusori.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl BLAHBLAH illusori.co.uk>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
