#!/bin/bash
# called as
# git2latexdiff old_SHA old_git_path new_git_path file
# assumes you have checked out the version you want diffed
# and are in the root directory of the repository
#
if [ "$#" -ne 4 ]; then
    echo "Illegal number of parameters"
    echo "Requires 4 parameters:"
    echo "git-dir-latexdiff old_SHA old_git_path new_git_path file"
else
    WASDIR=$(pwd)
    OUTDIR="$WASDIR/$3/"
    TMPDIR=$(mktemp -d /home/mhoecker/tmp/git-latexdiff.XXXXXX)
    newsha=$(git rev-parse --short HEAD)
    cd $TMPDIR
    tmpdif="$4_diff_$1-$newsha"
#    echo "$tmpdif"
    git clone $WASDIR $TMPDIR
    cd $TMPDIR
    git checkout $1
    old="$TMPDIR/$2/$4"
    echo "$old"
    new="$WASDIR/$3/$4"
    echo "$new"
    latexdiff -c PICTUREENV="(?:figure|figure\*|picture|DIFnomarkup)[\w\d*@]*" --flatten --math-markup=1 --floattype=TRADITIONALSAFE --driver=pdftex --type=CFONT "$old" "$new" > "$OUTDIR/$tmpdif.tex"
    rm -rf $TMPDIR
    cd $OUTDIR
    latex -interaction nonstopmode -quiet "$tmpdif.tex"
    bibtex "$tmpdif.aux"
    pdflatex -interaction nonstopmode -quiet "$tmpdif.tex"
    bibtex "$tmpdif.aux"
    pdflatex -interaction nonstopmode -quiet "$tmpdif.tex"
fi
