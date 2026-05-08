#!/usr/bin/env bash
# Apply a font family across ghostty, zed, and stylus configs.
# Usage: ./set-font.sh "JetBrainsMonoNL Nerd Font Propo"

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <font-name>" >&2
    echo "Example: $0 'JetBrainsMonoNL Nerd Font Propo'" >&2
    exit 1
fi

FONT="$1"
SOURCE="${BASH_SOURCE[0]}"
while [[ -L "$SOURCE" ]]; do
    DIR="$(cd "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd "$(dirname "$SOURCE")" && pwd)"

GHOSTTY_CFG="$SCRIPT_DIR/ghostty/.config/ghostty/config"
ZED_CFG="$SCRIPT_DIR/zed/.config/zed/settings.json"
STYLUS_CFG="$SCRIPT_DIR/stylus/.config/stylus/style.css"

# Detect sed flavor (BSD vs GNU)
if sed --version >/dev/null 2>&1; then
    SED_INPLACE=(-i)
else
    SED_INPLACE=(-i '')
fi

# --- ghostty ---
if [[ -f "$GHOSTTY_CFG" ]]; then
    if grep -qE '^font-family[[:space:]]*=' "$GHOSTTY_CFG"; then
        sed "${SED_INPLACE[@]}" -E "s|^font-family[[:space:]]*=.*|font-family = ${FONT}|" "$GHOSTTY_CFG"
    else
        tmp=$(mktemp)
        awk -v font="$FONT" '
            { print }
            !done && /^# Font[[:space:]]*$/ { print "font-family = " font; done=1 }
        ' "$GHOSTTY_CFG" > "$tmp" && mv "$tmp" "$GHOSTTY_CFG"
    fi
    echo "ghostty -> font-family = $FONT"
else
    echo "ghostty -> skipped (config not found)"
fi

# --- zed (JSONC; can't use jq because of comments) ---
if [[ -f "$ZED_CFG" ]]; then
    sed "${SED_INPLACE[@]}" -E \
        -e "s|(\"ui_font_family\"[[:space:]]*:[[:space:]]*\")[^\"]*(\")|\\1${FONT}\\2|" \
        -e "s|(\"buffer_font_family\"[[:space:]]*:[[:space:]]*\")[^\"]*(\")|\\1${FONT}\\2|" \
        "$ZED_CFG"
    echo "zed -> ui_font_family + buffer_font_family = \"$FONT\""
else
    echo "zed -> skipped (config not found)"
fi

# --- stylus (replace first quoted entry in --font-stack) ---
if [[ -f "$STYLUS_CFG" ]]; then
    sed "${SED_INPLACE[@]}" -E "s|(--font-stack:[[:space:]]*\")[^\"]*(\")|\\1${FONT}\\2|" "$STYLUS_CFG"
    echo "stylus -> --font-stack primary = \"$FONT\""
else
    echo "stylus -> skipped (config not found)"
fi
