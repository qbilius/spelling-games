#!/usr/bin/env bash
# Builds _site/: copies the site, then replaces the <!-- GAMES --> line in
# index.html with one card per games/*.html. Title comes from <title>,
# blurb from <meta name="description">, icon from <meta name="emoji">.
set -euo pipefail
cd "$(dirname "$0")/../.."

meta() { sed -n "s/.*<meta name=\"$2\" content=\"\([^\"]*\)\".*/\1/p" "$1" | head -1; }

rm -rf _site && mkdir -p _site
cp -r index.html games _site/

for f in games/*.html; do
  title=$(sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p' "$f" | head -1)
  printf '%s\t<a class="game" href="%s"><span class="emoji" aria-hidden="true">%s</span><span class="text"><b>%s</b><p>%s</p></span></a>\n' \
    "${title:-$f}" "$f" "$(meta "$f" emoji)" "${title:-$f}" "$(meta "$f" description)"
done | sort -f | cut -f2- > _site/cards.html

sed -e '/<!-- GAMES -->/{r _site/cards.html' -e 'd}' index.html > _site/index.html
rm _site/cards.html
echo "Indexed $(ls games/*.html | wc -l) game(s)"
