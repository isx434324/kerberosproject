#! /bin/bash
# Tania Gabriela Bonilla Alvarenga - Isx434324
# Hisx2 2017-2018
# Convert file with format md to html slides

pandoc \
	--standalone \
	--to=dzslides \
	--incremental \
	--css=propi_style.css \
	--output=presentacio.html \
	presentacio.md
