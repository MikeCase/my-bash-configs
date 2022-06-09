pm_update() {
    ## Download bitwarden data, update pass with the data, remove data.
    local EXPORT_FILE="/tmp/bw.json"
    local EXPORT_FORMAT="json"
    bw sync
    bw export --output "$EXPORT_FILE" --format $EXPORT_FORMAT

    pass import -a bitwarden "$EXPORT_FILE"
    rm "$EXPORT_FILE"
}