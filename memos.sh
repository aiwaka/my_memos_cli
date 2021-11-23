#!/usr/bin/env zsh

MEMOS_STORAGE_DIR=${HOME}/Documents/projects/memos/

usage () {
    cat <<EOM
Usage: $(basename "$0") [OPTION] / NAME
  -h          Display help
  -d          Display where files storaged
  -l          List up memo files
  -e [NAME]   Browse NAME.txt (using 'less')
  -r [NAME]   Remove NAME.txt file from storage

This command manages text files, and edit NAME.txt using 'vi'.
text files are in ${MEMOS_STORAGE_DIR}
EOM

  exit 2
}

while getopts :dlr:e:h OPT
do
    case $OPT in
        d)
            echo $MEMOS_STORAGE_DIR
            exit
            ;;
        l)
            for f in $MEMOS_STORAGE_DIR*.txt ; do
                # ファイル末尾から見て任意数の.以外の文字がマッチして, 空白に置き換えられる.
                basename $f | sed 's/\.[^\.]*$//'
            done
            exit
            ;;
        r)
            if [ -e $MEMOS_STORAGE_DIR$OPTARG.txt ]; then
                echo "Do you want to remove ${OPTARG}.txt? (y/n)"
                read input
                if [ $input = 'y' ]; then
                    rm $MEMOS_STORAGE_DIR$OPTARG.txt && echo "${OPTARG}.txt removed"
                    exit
                else
                    echo "skipped, ${OPTARG}.txt still exists."
                    exit
                fi
            else
                echo "${OPTARG}.txt does not exist."
                exit
            fi
            ;;
        e)
            if [ -e $MEMOS_STORAGE_DIR$OPTARG.txt ]; then
                less $MEMOS_STORAGE_DIR$OPTARG.txt
            else
                echo "${OPTARG} does not exist."
            fi
            exit
            ;;
        h)
            usage
            ;;
        \?)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

if [ $# -eq 0 ]; then
    vi ${MEMOS_STORAGE_DIR}memo.txt
    exit 0
fi

[ $# -ge 2 ] && echo "too many arguments."
FILE_PATH=${MEMOS_STORAGE_DIR}$1.txt
if [ -e $FILE_PATH ]; then
    vi $FILE_PATH
else
    echo "${1}.txt does not exist. create new memo? (y/n)"
    read input
    if [ $input = 'y' ]; then
        touch $FILE_PATH
        vi $FILE_PATH
    else
        echo "skipped."
    fi
fi