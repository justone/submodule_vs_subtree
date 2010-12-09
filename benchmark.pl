#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use Time::HiRes qw(gettimeofday tv_interval);
use File::Path;
use Cwd;

my $cwd = getcwd;

my $t0 = [gettimeofday];

rmtree('2_plugins');
`git clone --recursive file://$cwd/repos/submodule/2_plugins`;

my $elapsed = tv_interval($t0);

printf "%.03f\n", $elapsed;

$t0 = [gettimeofday];

rmtree('2_plugins');
`git clone file://$cwd/repos/subtree/2_plugins`;

$elapsed = tv_interval($t0);

printf "%.03f\n", $elapsed;
