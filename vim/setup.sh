# from: https://github.com/rkalis/dotfiles/blob/master/vim/setup.sh
#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

echo "Setting up vim..."
# TODO add darkzen and any other static setup in .vim folder
find . -name ".vim*" | while read fn; do
    fn=$(basename $fn)
    ln -s "$SOURCE/$fn" "$DESTINATION/$fn"
done
