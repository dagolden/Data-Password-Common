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
  my $list_handle = IO::File->new($list_path, "<:utf8");

  return sub {
    return unless @_;
    my $password = shift;
    look $list_handle, $password;
    chomp( my $found = <$list_handle> );
    return $found eq $password;
  };
}

1;

=for Pod::Coverage build_finder

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

This module installs a list of over 557,000 common passwords and provides
a function to check a string against the list.

The password list is taken from InfoSecDaily at
L<http://www.isdpodcast.com/resources/62k-common-passwords/>. (They claim their
list is over 62K, but they must have misread their C<wc> output.)

=head1 USAGE

Functions are provided via L<Sub::Exporter>.  Nothing is exported by default.

=head2 found

  found($password);

Returns true if the password is in the common passwords list.

=head1 CUSTOMIZING

You may choose an alternate password list to check by passing a C<list> parameter
during import:

  use Data::Password::Common found => { list => "/usr/share/dict/words" };

The file must be sorted.

=head1 SEE ALSO

=head2 Password checkers

=for :list
* L<Data::Password>
* L<Data::Password::Entropy>
* L<Data::Password::BasicCheck>

=head2 Lists of common passwords

=for :list
* L<InfoSecDaily|http://www.isdpodcast.com/resources/62k-common-passwords/>
* L<Skull Security|http://www.skullsecurity.org/wiki/index.php/Passwords>

=cut

# vim: ts=2 sts=2 sw=2 et:
