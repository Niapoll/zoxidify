#!/usr/bin/env zsh

ZOXIDIFY_DEFAULT_EDITORS=(
    code
    open
    xdg-open
)

if [ ${#ZOXIDIFY_EDITORS[@]} -eq 0 ]; then
    ZOXIDIFY_EDITORS=("${ZOXIDIFY_DEFAULT_EDITORS[@]}")
fi

unset -v ZOXIDIFY_DEFAULT_EDITORS

___zoxidify_get_zoxide_out() {
    local zoxide_args="$1"
    [ -z "$zoxide_args" ] || zoxide_args="$zoxide_args "

    echo "
        local zoxide_out
        zoxide_out=\"\$(zoxide query $zoxide_args\"\$last_arg\")\"
        [ -z \"\$zoxide_out\" ] && return 1
    "
}

__ZOXIDIFY_GET_ZOXIDE_OUT="$(___zoxidify_get_zoxide_out)"
__ZOXIDIFY_GET_ZOXIDE_INTERACTIVE_OUT="$(___zoxidify_get_zoxide_out --interactive)"

unset -f ___zoxidify_get_zoxide_out

__ZOXIDIFY_GET_LAST_ARG="
    local last_arg
    last_arg=\"\${@:\$#}\"
"

__zoxidify_patch_editor() {
    local editor="$1"

    local lauch_editor="
        $editor \"\${@:1:\$((\$# - 1))}\" \"\$zoxide_out\"
    "

    eval "
        function z$editor() {
            $__ZOXIDIFY_GET_LAST_ARG
            $__ZOXIDIFY_GET_ZOXIDE_OUT
            $lauch_editor
        }

        function zi$editor() {
            $__ZOXIDIFY_GET_LAST_ARG
            $__ZOXIDIFY_GET_ZOXIDE_INTERACTIVE_OUT
            $lauch_editor
        }
    "
}

__zoxidify_main() {
    if ! command -v zoxide &> /dev/null; then
        echo '[!] Zoxidify (ZSH plugin): Zoxide is not installed. Please install Zoxide first.'
        return 1
    fi

    for editor in "${ZOXIDIFY_EDITORS[@]}"; do
        if command -v "$editor" &> /dev/null; then
            __zoxidify_patch_editor "$editor"
        fi
    done
}

__zoxidify_main

unset -f __zoxidify_patch_editor __zoxidify_main
unset -v __ZOXIDIFY_GET_LAST_ARG __ZOXIDIFY_GET_ZOXIDE_OUT __ZOXIDIFY_GET_ZOXIDE_INTERACTIVE_OUT ZOXIDIFY_EDITORS
