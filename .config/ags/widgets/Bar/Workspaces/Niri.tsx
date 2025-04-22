
function getAllWorkspaces() {
    const command = 'niri msg workspaces | grep -E "[* ][0-9]" | wc -l'
}

function getActiveWorkspace() {
    const command = 'niri msg workspaces | grep -E "\* [0-9]" | cut -d \' \' -f3'
}
