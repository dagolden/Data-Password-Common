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

use Sub::Exporter -setup => { exports => ['check'] };

my $list_path = File::ShareDir::dist_file( "Data-Password-Common", "common.txt" );

my $list_handle = IO::File->new($list_path);

sub check {
  return unless @_;
  my $password = shift;
  return -1 != look $list_handle, $password;
}

1;

=for Pod::Coverage method_names_here

=head1 SYNOPSIS

  use Data::Password::Common;

=head1 DESCRIPTION

This module might be cool, but you'd never know it from the lack
of documentation.

=head1 USAGE

Good luck!

=head1 SEE ALSO

Maybe other modules do related things.

=cut

# vim: ts=2 sts=2 sw=2 et:
