# zsh

## install

Zsh is the default shell on later macOS (replacing bash).

```sh
zsh --version
```

after any changes,

```sh
source ~/.zshrc
```

## customise

```sh
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install zsh-completions
brew install powerlevel10k
```

then put this in your .zshrc file

```sh
if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
fi

# zsh =========================================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Completion
fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)
autoload -Uz compinit
compinit -i -d "${XDG_CACHE_HOME:-$HOME/.zcompdump-${ZSH_VERSION}}"

# Plugins
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Theme
source "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"

# Syntax highlighting LAST
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

### powerlevel10k

You can reconfigure by running

```sh
p10k configure
```

You can make numerous modifications via the `.p10k.zsh` file.

For modifying what elements you see in the prompt you can modify these settings:

* `typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(...`
* `typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(...`

You can also modify icons in the prompt - e.g.

* `typeset -g POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='🐍'`
* `typeset -g POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='' # python icon`
* `typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=true`
 


### fonts

If your prompt is not rendering special characters correctly you might need to install additional fonts

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

then select JetBrainsMono Nerd Font:

iTerm2: `Preferences → Profiles → Text → Font → select`

macOS Terminal.app: `Settings → Profiles → Text → Font`

VS Code: `Terminal > Integrated: Font Family` set to `JetBrainsMono Nerd Font`

