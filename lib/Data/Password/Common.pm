use v5.10;
use strict;
use warnings;

package Data::Password::Common;
# ABSTRACT: Check a password against a list of common passwords
# VERSION

# Dependencies
use File::ShareDir;
use IO::File;
use Search::Dict;
use autodie 2.00;

use Sub::Exporter -setup => { exports => [ 'found' => \&build_finder ] };

sub build_finder {
  my ( $class, $name, $arg, $col ) = @_;
  my $list_path = $arg->{list}
    || File::ShareDir::dist_file( "Data-Password-Common", "common.txt" );
  my $list_handle = IO::File->new($list_path);

  return sub {
    return unless @_;
    my $password = shift;
    look $list_handle, $password;
    chomp( my $found = <$list_handle> );
    return $found eq $password;
  };
}

1;

=for Pod::Coverage method_names_here

=head1 SYNOPSIS

  use Data::Password::Common 'found';

  if ( found( $password ) ) {
    die "'$password' is a common password"
  }

  # import with aliasing
  use Data::Password::Common found => { -as => "found_common" };

  # custom common password list
  use Data::Password::Common found => { list => "/usr/share/dict/words" };

=head1 DESCRIPTION

This module installs a list of 62 thousand common passwords and provides
a function to check a string against the list.

The password list from InfoSecDaily
at L<http://www.isdpodcast.com/resources/62k-common-passwords/>

=head1 USAGE

Functions are provided via L<Sub::Exporter>.  Nothing is exported by default.

=head2 found

  found($password);

Returns true if the password is in the common passwords list.

=head1 CUSTOMIZING

You may choose an alternate password list to check by passing a C<list> parameter
during import:

  use Data::Password::Common found => { list => "/usr/share/dict/words" };

The file must be lexicographically sorted.

=head1 SEE ALSO

=for :list
* L<Data::Password>
* L<Data::Password::Entropy>
* L<Data::Password::BasicCheck>

=cut

# vim: ts=2 sts=2 sw=2 et:
