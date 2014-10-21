#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename 'dirname';
use File::Spec;

use lib join '/', File::Spec->splitdir( dirname(__FILE__) ), 'lib';
use lib join '/', File::Spec->splitdir( dirname(__FILE__) ), '..', 'lib';

use Mojolicious::Lite;

use MojoX::JSON::RPC::Service;


# Documentation browser under "/perldoc" (this plugin requires Perl 5.10)
plugin 'pod_renderer';

plugin 'json_rpc_dispatcher' => {
    services => {
        '/jsonrpc' => MojoX::JSON::RPC::Service->new->register(
            'sum',
            sub {
                my @params = @_;
                my $sum    = 0;
                $sum += $_ for @params;
                return $sum;
            }
        )
    }
};

#-------------------------------------------------------------------

# Back to tests

package main;

use TestUts;

use Test::More tests => 2;
use Test::Mojo;

use_ok 'MojoX::JSON::RPC::Client';

my $t = Test::Mojo->new( app => app );
my $client = MojoX::JSON::RPC::Client->new( ua => $t->app->ua );

TestUts::test_call(
    $client,
    '/jsonrpc',
    {   id     => 1,
        method => 'sum',
        params => [ 17, 25 ]
    },
    { result => 42 },
    'sum 1'
);

1;

