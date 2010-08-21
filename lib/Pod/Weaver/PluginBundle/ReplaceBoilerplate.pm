package Pod::Weaver::PluginBundle::ReplaceBoilerplate;

# ABSTRACT: a bundle for replacing the boilerplate in a pod document

use strict;
use warnings;

use namespace::autoclean;

our $VERSION = '0.99_01';

use Pod::Weaver::Config::Assembler;
sub _exp { Pod::Weaver::Config::Assembler->expand_package($_[0]) }

sub mvp_bundle_config {
  return (
    [ '@ReplaceBoilerplate/CorePrep',         _exp('@CorePrep'),        {} ],
    [ '@ReplaceBoilerplate/ReplaceName',      _exp('ReplaceName'),      {} ],
    [ '@ReplaceBoilerplate/ReplaceVersion',   _exp('ReplaceVersion'),   {} ],

    [ '@ReplaceBoilerplate/Leftovers',        _exp('Leftovers'),        {} ],

    [ '@ReplaceBoilerplate/ReplaceAuthors',   _exp('ReplaceAuthors'),   {} ],
    [ '@ReplaceBoilerplate/ReplaceLegal',     _exp('ReplaceLegal'),     {} ],
  )
}

1;

__END__


=pod

=head1 NAME

Pod::Weaver::PluginBundle::ReplaceBoilerplate - a bundle for replacing the boilerplate in a pod document

=head1 VERSION

version 0.99_01

=head1 OVERVIEW

FIXME: This is the bundle used by default (specifically by Pod::Weaver's
C<new_with_default_config> method).  It may change over time, but should remain
fairly conservative and straightforward.

It is nearly equivalent to the following:

  [@CorePrep]

  [ReplaceName]
  [ReplaceVersion]

  [Leftovers]

  [ReplaceAuthors]
  [ReplaceLegal]

=head1 NAME

Pod::Weaver::PluginBundle::ReplaceBoilerplate - a bundle for replacing the boilerplate in a pod document

=head1 AUTHOR

Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl@illusori.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Sam Graham <libpod-weaver-pluginbundle-replaceboilerplate-perl@illusori.co.uk>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
