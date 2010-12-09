#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Slurp;
use File::Path;
use Cwd;

my @plugins = (
    'https://github.com/tpope/vim-fugitive.git',
    'https://github.com/tpope/vim-abolish.git',
    'https://github.com/vim-scripts/bufexplorer.zip.git',
    'https://github.com/vim-scripts/The-NERD-Commenter.git',
    'https://github.com/vim-scripts/The-NERD-tree.git',
    'https://github.com/vim-scripts/gnupg.git',
    'https://github.com/spiiph/vim-space.git',
    'https://github.com/vim-scripts/sessionman.vim.git',
    'https://github.com/vim-scripts/snipMate.git',
    'https://github.com/vim-scripts/surround.vim.git',
);

rmtree('repos');
mkdir('repos');
chdir('repos');

foreach my $type (qw(submodule subtree)) {
    mkdir($type);

    foreach my $count ( 1 .. 5 ) {
        my $number_of_repos = $count * 2;

        print $number_of_repos, "\n";
        my $path = sprintf( '%s/%02d_plugins', $type, $number_of_repos );
        mkdir($path);
        chdir($path);

        `git init`;
        write_file( "desc.txt", sprintf( "%d %s", $number_of_repos, $type ) );
        `git add .`;
        `git commit -m "initial commit"`;

        foreach my $y ( 1 .. ($number_of_repos) ) {
            my $plugin_repo = $plugins[ $y - 1 ];
            printf "%s\n", $plugin_repo;
            my ($plugin_dir) = $plugin_repo =~ /.*\/(.*)/;
            print "$plugin_dir\n";
            if ( $type eq 'submodule' ) {
                `git submodule add $plugin_repo $plugin_dir`;
            }
            elsif ( $type eq 'subtree' ) {
                `git subtree add --squash --prefix=$plugin_dir $plugin_repo master`;
            }
        }
        `git commit -m "adding ${type}s"`;

        chdir("../..");
    }
}
