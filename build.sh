#!/usr/bin/env bash
set -e

slidedecks=()

echo '--------------------------------'
echo '-- Build all slidev decks ...  -'
echo '--------------------------------'
for filename in slides/**/slides.md; do
	presentation_name=$(echo "$filename" | awk -F'/' '{print $2}')
	echo "## Build $filename from $presentation_name"
	yarn slidev build "$filename" --out "../../dist/$presentation_name" --base "/$presentation_name"
  slidedecks+=("$presentation_name")
done


echo '--------------------------------'
echo '-- Build overview page    ...  -'
echo '--------------------------------'
echo "<html>" > ./dist/index.html
for slidedeck in "${slidedecks[@]}"
do
	echo "<a href='${slidedeck}'>${slidedeck}</a>" >> ./dist/index.html
done
echo "<br>" >> ./dist/index.html
echo "</html>" >> ./dist/index.html
