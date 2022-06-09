#!/use/bin/env bash

dorganize(){
    ## Keep my downloads folder CLEAN & Organzied
    for file in "${DLDIR}"*; do
        if [ -f "${file}" ]; then
            case "$file" in
                *.iso)
                    mv "$file" "$DLDIR/images/"
                ;;
                *.pdf | *.csv | *.txt | *.xlsx | *.md)
                    mv "$file" "$DLDIR/documents/"
                ;;
                *.tar.gz | *.7z | *.Z | *.tar.bz2 | *.bz2 | *.gz | *.zip | *.tbz2 | *.tgz | *.rar | *.tar)
                    mv "$file" "$DLDIR/archives/"
                ;;
                *.deb)
                    mv "$file" "$DLDIR/deb_packages/"
                ;;
                *.mp3 | *.ogg)
                    mv "$file" "$DLDIR/music/"
                ;;
                *.wav)
                    mv "$file" "$DLDIR/SFX/"
                ;;
                *.mpv | *.mp4 | *.avi | *.mpg | *.mpeg)
                    mv "$file" "$DLDIR/videos/"
                ;;
                *.jpg | *.jpeg | *.png | *.tiff | *.bmp | *.webp)
                    mv "$file" "$DLDIR/pictures/"
                ;;
            esac
        fi
    done
}