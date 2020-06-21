# from: https://github.com/rkalis/dotfiles/blob/master/vim/setup.sh

#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Setting up Vim..."

find . -name ".bash*" | while read fn; do
    fn=$(basename $fn)
    ln -s "$SOURCE/$fn" "$DESTINATION/$fn"
done


tt=$(basename terminal-tips.md)
ln -s "$SOURCE/$tt" "$DESTINATION/$tt"
