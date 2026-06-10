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
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
```

### fonts

If your prompt is not rendering special characters correctly you might need to install additional fonts

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

then select JetBrainsMono Nerd Font:

iTerm2: `Preferences → Profiles → Text → Font → select`

macOS Terminal.app: `Settings → Profiles → Text → Font`

VS Code: `Terminal > Integrated: Font Family` set to `JetBrainsMono Nerd Font`