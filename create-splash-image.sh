#! /bin/bash
OUTPUT="letter-montage.jpg"

echo "Compiling the letter..."
pdflatex letter.tex > /dev/null
bibtex letter.aux > /dev/null
pdflatex letter.tex > /dev/null
pdflatex letter.tex > /dev/null
echo "... Done"
echo "Making pictures out of the PDF..."
convert -density 300 letter.pdf -background white -alpha remove -resize 100% -resample 96 -verbose letter.jpg
echo "... Done"
echo "Creating the montage of PDF pages" # Careful: hardwired. With 5 or 3 pages, e.g., this one would not work
montage -mode concatenate -tile x1 letter-[0-3].jpg "${OUTPUT}"
echo "... Done"
echo "Removing temporary images..." # Careful: hardwired. With 5 or 3 pages, e.g., this one would not work
rm letter-0.jpg letter-1.jpg letter-2.jpg letter-3.jpg
echo "... Done. Output saved in ${OUTPUT}"
