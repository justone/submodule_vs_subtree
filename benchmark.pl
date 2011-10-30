#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use Time::HiRes qw(gettimeofday tv_interval);
use File::Path;
use Getopt::Long;
use Cwd;

my %options;
my $opts_ok = GetOptions( \%options, 'remote|r=s', 'local|l=s', );

print "type,count,time\n";

my $cwd = getcwd;

my ( $tag, $base );
if ( $base = $options{remote} ) {
    $tag = 'remote';
}
elsif ( $base = $options{local} ) {
    $tag = 'local';
}

foreach my $count ( 2, 4, 6, 8, 10 ) {
    clone_test( $tag, 'submodule', $count, 10 );
    clone_test( $tag, 'subtree',   $count, 10 );
}

sub clone_test {
    my ( $tag, $type, $count, $runs ) = @_;

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
        printf "%s.%s,%d,%.03f\n", $type, $tag, $count, $elapsed;
    }
}
