#!/usr/bin/env perl

use 5.008007;

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'MojoX::JSON::RPC',
    VERSION_FROM => 'lib/MojoX/JSON/RPC.pm',
    ABSTRACT     => 'Perl implementation of JSON-RPC 2.0 protocol for Mojolicious',
    AUTHOR       => 'Henry Tang <henryykt@gmail.com>',
    PREREQ_PM    => { 'Mojolicious' => '4.74' },
    LICENSE      => 'artistic_2',
    test         => { TESTS => 't/*.t t/*/*.t t/*/*/*.t' }
);
