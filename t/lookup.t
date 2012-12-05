use 5.010;
use strict;
use warnings;
use Test::More 0.96;
use Test::File::ShareDir -share => {
  -dist => { 'Data-Password-Common' => 'share' }
};

use Data::Password::Common qw/found/;

ok( found("password"), "'password' is a common password" );
ok( ! found("alkdjf1=2"), "'alkdjf1=2' is not a common password" );

done_testing;
# COPYRIGHT
