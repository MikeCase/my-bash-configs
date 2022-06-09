# Backup and individual directory
# My code.
backup() {
    SRC_DIR=$PWD
    DEST_DIR=$BACKUP_INDV

    ## Quick fix: If you remove things from the backup list without
    ## unsetting BACKUP_SOURCES it adds the next source as
    ## whatever the last source WAS + 1, so if you only have
    ## 3 items in backup sources it would list as item 5, not 4.
    ## That doesn't make much sense. Basically this resets BACKUP_SOURCES to exactly
    ## what is in the .backup_sources file.
    unset BACKUP_SOURCES
    source "$BASE_CONFIG/.backup_sources"


    if [ ! -d "$DEST_DIR" ]; then
        mkdir -p "${DEST_DIR}"
    fi


    if [ -f "${BASE_CONFIG}".backup_sources ]; then
        source "$BASE_CONFIG/.backup_sources"
        case $SRC_DIR in
            "/etc")
                if ! [ $UID -eq 0 ]; then
                    echo "Protected directory, elevate privs."
                else
                    echo "Adding ${SRC_DIR##*/} to SystemBackup."
                    echo "BACKUP_SOURCES[$((${#BACKUP_SOURCES[@]}+1))]=${SRC_DIR}" >> "$BASE_CONFIG/.backup_sources"
                fi
                ;;
            *)
                echo "Adding ${SRC_DIR##*/} to SystemBackup."
                echo "BACKUP_SOURCES[$((${#BACKUP_SOURCES[@]}+1))]=${SRC_DIR}" >> "$BASE_CONFIG/.backup_sources"
            ;;
        esac
    else
        echo "No .backup_sources found. Creating one."
        touch "$BASE_CONFIG/.backup_sources"
        echo "Try again."
    fi

    # BAK_FILE=${PWD##*/}-$(date +%-Y%-m%-d)$(date +%-H%M%S).tgz

    # tar --create --gzip --file="${DEST_DIR}${BAK_FILE}" -C "$SRC_DIR" *

}

# Backup a collection of files/directories.
# Essentially a self defined set of files
# for a "system backup" quick and easy.
# My code
sysbackup() {
    DEST_DIR="$BACKUP_SYS"

    BACKUP_SOURCES="$BASE_CONFIG/.backup_sources"

    if [ -f "$BACKUP_SOURCES" ] && ! [ -s "$BACKUP_SOURCES" ]; then
        echo "Now go run backup from any directory. It will add that directory to your system backup list."
        return 1
    elif ! [ -f "$BACKUP_SOURCES" ]; then
        touch "$BACKUP_SOURCES"
        echo "Put the directories/files you want to backup into $BACKUP_SOURCES"
        return 1
    elif [ -f "$BACKUP_SOURCES" ]; then
        . "$BACKUP_SOURCES"
    fi

    INDV_FILES=()

    if [ ! -d "$DEST_DIR" ]; then
        mkdir "$DEST_DIR"
    fi

    for d in "${BACKUP_SOURCES[@]}"; do
        if [ -d "$d" ]; then
            cd "${d}" || return
            BAK_FILE=${PWD##*/}-$(date +%-Y%-m%-d)$(date +%-H%M%S).tgz
            tar --create --gzip --file="$DEST_DIR/$BAK_FILE" -C "$d" -- *
        fi
        if [ -f "$d" ]; then
            INDV_FILES+=("${d}")
        fi
    done

    for f in "${INDV_FILES[@]}"; do
        BAK_FILE="indv_files-$(date +%-Y%-m%-d)$(date +%-H%M%S)"
        tar --append --file="$DEST_DIR/$BAK_FILE" -C "${f%/*}" "${f##*/}"
    done
        gzip -S ".tgz" "$DEST_DIR/$BAK_FILE"
}