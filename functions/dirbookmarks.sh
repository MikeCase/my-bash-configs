## Create directory bookmarks
# Not my code.
bookmark_file="$BASE_CONFIG/.bookmarks"
. "$bookmark_file"

bm() {
    usage='Usage:
    bm add <name> <path>           Create a bookmark for path.
    bm add <name>                  Create a bookmark for the current directory.
    bm update                      Source the bookmark file.
    bm remove <name>               Remove a bookmark
    bm list                        List available bookmarks'

    case $1 in
        add)
            local path
            if [[ $# -eq 2 ]]; then
                path=.
            elif [[ $# -eq 3 ]]; then
                if [[ -e $3 ]]; then
                    path="$3"
                else
                    echo "bm: ${3}: No such file or directory."
                    return 1
                fi
            else
                echo "$usage"
                return 1
            fi

            if declare | grep "^${2}=" > /dev/null; then
                echo "bm: The name $2 is in use."
                return 1
            fi
            path=$(readlink -f "$path")
            echo "${2}"=\""$path"\" >> "$bookmark_file"
            eval "${2}"=\""$path"\"
            return 0
            ;;
        update)
            if [[ $# -eq 1 ]]; then
                source "$bookmark_file"
                return 0
            fi
            ;;
        remove)
            if [[ $# -eq 2 ]]; then
                unset $2
                local contents=$(grep -v "^${2}=" "$bookmark_file")
                echo "$contents" > "${bookmark_file}.tmp"
                rm -f "$bookmark_file"
                mv "${bookmark_file}.tmp" "$bookmark_file"
                return 0
            fi
            ;;
        # My addition, list available bookmarks.
        list)
            if [ -e "$bookmark_file" ]; then
                cat "$bookmark_file"
                return 0
            fi
            ;;
    esac

    echo "$usage"
    return 1
}