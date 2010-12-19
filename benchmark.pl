#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use Time::HiRes qw(gettimeofday tv_interval);
use File::Path;
use Cwd;

print "type,count,time\n";

my $cwd  = getcwd;
my $base = "file://$cwd/repos";

foreach my $count ( 2, 4, 6, 8, 10 ) {
    clone_test( 'submodule', $count, 10 );
    clone_test( 'subtree',   $count, 10 );
}

sub clone_test {
    my ( $type, $count, $runs ) = @_;

    $runs ||= 2;

    my $repo_name = sprintf( '%02d_plugins', $count );

    for ( 1 .. $runs ) {
        rmtree($repo_name);

        my $t0 = [gettimeofday];
        if ( $type eq 'submodule' ) {
            `git clone --recursive $base/$type/$repo_name`;
        }
        else {
            `git clone $base/$type/$repo_name`;
        }
        my $elapsed = tv_interval($t0);
        printf "%s,%d,%.03f\n", $type, $count, $elapsed;
    }
}
