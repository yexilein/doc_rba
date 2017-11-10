
#!/bin/sh

for file in $@
do
    inkscape --file=$file --export-area-drawing --without-gui --export-pdf=`echo ${file%.*}.pdf`;
done;