This repo has the data and scripts referenced in [this post](http://endot.org/2011/10/29/git-submodules-vs-subtrees-for-vim-plugins-part-2/).

To run for yourself (after [installing R](http://cran.r-project.org/mirrors.html), of course):

    $ ./generate_repos.pl
    $ scp -r repos user@remoteserver.com:
    $ ./benchmark.pl --remote user@remoteserver.com:repos 2>/dev/null > data.csv
    $ ./benchmark.pl --local $PWD/repos 2>/dev/null >> data.csv
    $ ./submodule_vs_subtree.R
