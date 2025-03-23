# 🧐 Zoxidify

Enable the use of [**Zoxide**](https://github.com/ajeetdsouza/zoxide) to quickly navigate to frequently used paths in the terminal, with support for opening directories in your favorite editors.

## Features

* Creates aliases for quick directory-based opening using [**Zoxide**](https://github.com/ajeetdsouza/zoxide).
* Supports both interactive and non-interactive [**Zoxide**](https://github.com/ajeetdsouza/zoxide) modes.
* Provides extensive customization options.
* Cleans up functions and variables after execution to minimize shell pollution.

## Installation

> [!WARNING]
> Ensure you have [**Zoxide**](https://github.com/ajeetdsouza/zoxide) installed.

### Manual Installation

1. Download or clone this repository.
2. Source the script in your `~/.zshrc` file:

   ```shell
   source '/path/to/zoxidify.zsh'
   ```

3. Restart your shell or run `source ~/.zshrc`.

### With Oh My Zsh

1. Clone the repository into the `custom/plugins` directory:

   ```shell
   git clone 'https://github.com/Niapoll/zoxidify.git' "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zoxidify"
   ```

2. Add `zoxidify` to the `plugins` list in your `.zshrc`:

   ```shell
   plugins=(... zoxidify)
   ```

3. Restart your shell.

## Usage

**Zoxidify** assigns aliases for editors with the `z` prefix and `zi` for interactive mode by default.

> [!NOTE]
> Assuming `code` is installed, the following aliases will be available:
>
> * `zcode <dir>`: Opens `<dir>` in VS Code using Zoxide.
> * `zicode <dir>`: Opens `<dir>` interactively.

## Configuration

### Customizing Editors

By default, **Zoxidify** detects supported editors using the `ZOXIDIFY_EDITORS` list. You can modify this list by defining it in your `.zshrc` before sourcing the script:

```shell
export ZOXIDIFY_EDITORS=(
    codium
    start
)
```

### Changing the Prefix

To customize the command prefixes, set these variables in your `.zshrc` before sourcing the script:

```shell
export ZOXIDIFY_PREFIX='x'
export ZOXIDIFY_INTERACTIVE_PREFIX='xi'
```

> [!TIP]
> By default, if `ZOXIDIFY_INTERACTIVE_PREFIX` is not set directly, it depends on `ZOXIDIFY_PREFIX` and simply adds the letter `i` at the end of `ZOXIDIFY_PREFIX`. So you can do:
>
> ```shell
> export ZOXIDIFY_PREFIX='x'
> ```
>
> To achive the same behavior.

### Your Own Aliases

The functions `zoxidify_get_alias` and `zoxidify_get_interactive_alias` (if defined in `.zshrc`) are used to retrieve custom alias names for the specified editors. If these functions exist, **Zoxidify** will use them to determine the alias instead of the default naming convention.

* `zoxidify_get_alias <editor>`: Returns the alias name for the given editor.
* `zoxidify_get_interactive_alias <editor>`: Returns the interactive alias name for the given editor.

If these functions are not defined or return an empty string, **Zoxidify** falls back to using `ZOXIDIFY_PREFIX` and `ZOXIDIFY_INTERACTIVE_PREFIX` with the editor name.

> [!NOTE]
> If `code` is installed, the following functions customize the alias names:
>
> ```shell
> zoxidify_get_alias() {
>     case "$1" in
>         code) echo "vsc" ;;  # Use 'vsc' instead of 'zcode'
>     esac
> }
> ```
>
> ```shell
> zoxidify_get_interactive_alias() {
>     case "$1" in
>         code) echo "vsci" ;;  # Use 'vsci' instead of 'zicode'
>     esac
> }
> ```
>
> This configuration changes the alias for `code` from `zcode` to `vsc` and its interactive alias from `zicode` to `vsci`.
