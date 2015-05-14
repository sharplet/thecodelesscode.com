pandoc -S -o thecodelesscode.epub $(seq 1 190 | xargs -I{} echo "case/{}.md")
