SRCDIR=`dirname $0`

while read name size; do
    convert $SRCDIR/Icon.png -resize $size $SRCDIR/../Icon-$name.png
done <<END
xxxhdpi 192x192
xxhdpi  144x144
xhdpi   96x96
hdpi    72x72
mdpi    48x48
ldpi    36x36
END
