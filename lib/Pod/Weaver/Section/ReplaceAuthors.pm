package Pod::Weaver::Section::ReplaceAuthors;

# ABSTRACT: replace a section listing authors

use Moose;

extends 'Pod::Weaver::Section::Authors';
with 'Pod::Weaver::Role::SectionReplacer';

our $VERSION = '0.99_01';

sub default_section_name { 'AUTHORS' }
sub default_section_aliases { [ 'AUTHOR' ] }

no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Weaver::Section::ReplaceAuthors - replace a section listing authors

=head1 VERSION

version 0.99_01

=head1 OVERVIEW

This section adds a listing of the documents authors.  It expects a C<authors>
input parameter to be an arrayref of strings.  If no C<authors> parameter is
given, it will do nothing.  Otherwise, it produces a hunk like this:

  =head1 AUTHORS

    Author One <a1@example.com>
    Author Two <a2@example.com>

=head1 NAME

Pod::Weaver::Section::ReplaceAuthors - replace a section listing authors

=head1 AUTHOR

Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl@illusori.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl@illusori.co.uk>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
