#!/usr/bin/env bash

set -Eeuo pipefail
trap 'echo "⚠  Error ($0:$LINENO, exit code: $?): $BASH_COMMAND" >&2' ERR

location=$(dirname $0)/backup
mkdir -p "$location"

export GPG_TTY=$(tty)

function _backup_gpg_public_keys() {
    cat << EOM > $location/restore-gpg-public-keys.sh
# restore gpg public keys
# backup date: $(date)

set -Eeuo pipefail
trap 'echo "⚠  Error (\$0:\$LINENO, exit code: \$?): \$BASH_COMMAND" >&2' ERR

cat << EOF | gpg --import --import-options restore
$(gpg --export --armor --export-options backup)
EOF

cat << EOF | gpg --import-ownertrust
$(gpg --export-ownertrust | grep -v '^#')
EOF
EOM
}

function _backup_gpg_secret_key() {
    local key=${1:-}
    local passphrase=$(bash <(curl -fsSL "https://raw.githubusercontent.com/softvisio/scripts/main/unlock-gpg.sh") "$key" get-passphrase)
    local exported_key=$(gpg --export-secret-key --pinentry-mode=loopback --batch --passphrase "$passphrase" --armor --export-options backup "$key")
    local exported_ownertrust=$(gpg --export-ownertrust | grep $(gpg --list-secret-keys --with-colons "$key" | grep "^sec:" | cut --delimiter ":" --fields 5))

    cat << EOM > $location/restore-gpg-key-$key.sh
# restore gpg key: $key
# backup date: $(date)

set -Eeuo pipefail
trap 'echo "⚠  Error (\$0:\$LINENO, exit code: \$?): \$BASH_COMMAND" >&2' ERR

cat << EOF | gpg --import --batch --passphrase "" --import-options restore
$exported_key
EOF

cat << EOF | gpg --import-ownertrust
$exported_ownertrust
EOF
EOM

    cat << EOM > $location/import-gpg-key-$key.sh
# import gpg key: $key
# backup date: $(date)

set -Eeuo pipefail
trap 'echo "⚠  Error (\$0:\$LINENO, exit code: \$?): \$BASH_COMMAND" >&2' ERR

cat << EOF | gpg --import --batch --passphrase ""
$exported_key
EOF

cat << EOF | gpg --import-ownertrust
$exported_ownertrust
EOF
EOM
}

_backup_gpg_public_keys
_backup_gpg_secret_key "dzagashev@gmail.com"
_backup_gpg_secret_key "deb@softvisio.net"
_backup_gpg_secret_key "deployment@softvisio.net"
