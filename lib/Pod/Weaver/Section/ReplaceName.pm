package Pod::Weaver::Section::ReplaceName;

# ABSTRACT: adds or replaces a NAME section with abstract.

use Moose;

extends 'Pod::Weaver::Section::Name';
with 'Pod::Weaver::Role::SectionReplacer';

our $VERSION = '0.99_01';

sub default_section_name { 'NAME' }

1;

__END__


=pod

=head1 NAME

Pod::Weaver::Section::ReplaceName - adds or replaces a NAME section with abstract.

=head1 VERSION

version 0.99_01

=head1 OVERVIEW

This section plugin will produce a hunk of Pod giving the name of the document
as well as an abstract, like this:

  =head1 NAME

  Some::Document - a document for some

It will determine the name and abstract by inspecting the C<ppi_document> which
must be given.  It will look for the first package declaration, and for a
comment in this form:

  # ABSTRACT: a document for some

=for readme stop

=begin internal

=head1 INTERNAL METHODS

=over

=item default_section_name

Gives the name used as the heading for this section.
=back

=end internal

=for readme continue

=head1 AUTHOR

Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl BLAHBLAH illusori.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl BLAHBLAH illusori.co.uk>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
