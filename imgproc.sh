#!/bin/bash
#Author: Paul C

path=$1
arg=$2

function Help {
    echo #
    echo "Helper for bulk process images with ImageMagick. https://imagemagick.org".
    echo #
    echo "Syntax: script-name [absolute/path/to/file] [no args | -default|-d  | -test|-t]"
    echo #
    echo "Options:"
    echo "no args                 Follow prompts to set custom max-width and quality percentage to process."
    echo "                        ALL target file images will be processed"
    echo #
    echo "-default | -d           Process all images at max-width: 1024 and quality: 75%."
    echo "                        ALL target file images will be processed "
    echo #
    echo "-test | -t              Process all images in temporary directory. Follow prompts to set custom max-width and quality percentage. "
    echo "                        NO TARGET file images will be processed. "
    echo "                        Size of total processed images shown at end."
    echo #
}

if [[ "$path" == "-help" ]];
  then 
    Help
    exit 1

fi

if [[ $# -eq 0 ||  ! -d "$path" ]]
  then
   tput setaf 1 && tput bold;
    echo #
    echo "No path supplied or path is not a valid directory"
    tput sgr0 echo #
    Help
    exit 1
fi





function joke {
    echo "Processing images is hard. Have a joke first: "
    io="$(curl -s http://api.icndb.com/jokes/random?firstName=John\&amp;lastName=Doe)"
    tput setaf 5 && tput bold; echo ${io} | grep -oP "\"joke.*,"
    tput sgr0 echo #
    echo #
}


function -width {
    while read  -p  'Enter a max width: ' width && [[ ! $width =~ ^[+-]?[0-9]+$ ]] ; do
    echo #
    echo "You need to enter a number"
    done
 }

function -quality {
    while read  -p  'Enter a compression number: ' quality && [[ ! $quality =~ ^[+-]?[0-9]+$ ]] ; do
    echo #
    echo "You need to enter a number"
    done
   
 }

function run {
  find "$path" -type f -iname "*.jpg" -exec mogrify -verbose -strip -format jpg -layers Dispose -resize ${width}\>x${width}\> -quality ${quality}% {} +
  find "$path" -type f -iname "*.jpeg" -exec mogrify -verbose -strip -format jpeg -layers Dispose -resize ${width}\>x${width}\> -quality ${quality}% {} +
  find "$path" -type f -iname "*.png" -exec mogrify -verbose -strip -format png -layers Dispose -resize ${width}\>x${width}\> -quality ${quality}% {} +
}

function -default {
  
  find "$path" -type f -iname "*.jpg" -exec mogrify -verbose -strip -format jpg -layers Dispose -resize 1024\>x1024\> -quality 75% {} +
  find "$path" -type f -iname "*.jpeg" -exec mogrify -verbose -strip -format jpeg -layers Dispose -resize 1024\>x1024\> -quality 75% {} +
  find "$path" -type f -iname "*.png" -exec mogrify -verbose -strip -format png -layers Dispose -resize 1024\>x1024\> -quality 75% {} +
}

function spinner {
    #spinner by LOUIS MARASCIO
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

function run_dry {
    find "$path" -type f -iname "*.jpg" -exec mogrify  -strip -format jpg -layers Dispose -resize ${width}\>x${width}\> -quality ${quality}%  -path $tmp_dir {} +
    find "$path" -type f -iname "*.jpeg" -exec mogrify  -strip -format jpeg -layers Dispose -resize ${width}\>x${width}\> -quality ${quality}% -path $tmp_dir {} +
    find "$path" -type f -iname "*.png" -exec mogrify  -strip -format png -layers Dispose -resize ${width}\>x${width}\> -quality ${quality}% -path $tmp_dir {} +
}

function -test {
    tmp_dir=$(mktemp -d -t image-edit-$(date +%Y-%m-%d-%H-%M-%S)-XXXX)
    
    echo -n "Images are processing, please wait..."
    (run_dry) & spinner $!

    file_size=$(du -hs "$tmp_dir" | cut -f1)
    tput setaf 3 && tput bold;
    echo #
    echo "Total size of processed images is:   " "$file_size"
    tput sgr0 echo #

    rm -rf $tmp_dir
}


case "$arg" in 
    -test | -t)
        -width
        -quality
        -test
        ;;
    -default | -d)
        -default
        ;;

    "")
        joke
        -width
        -quality
        run
        ;;
    *)
        echo "Possible arguments are -test|-t or -default|-d "
        exit 1

esac


tput setaf 2 && tput bold;
echo "Thank you for your purchase."

