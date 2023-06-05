# .dotfiles
My dotfiles

## Usage
##### //todo: automate
Required:
1. Install [ohmyzsh](https://ohmyz.sh/#install)

2. Install oh-my-zsh plugins
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) - fish like autosuggestions as you type
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh)
    - Update plugins to be `git zsh-autosuggestions zsh-syntax-highlighting`

3. Export dotfiles - Paste snippet below in `.zshrc`. Ensure this repository is cloned as `~/.dotfiles`

    - Mac - Zsh
      ```
      #Find only filenames in directory
      for DOTFILE in `find ~/.dotfiles -type f -exec basename {} \;`
      do
        if [[ $DOTFILE == '.'* ]] && [[ $DOTFILE != '.git'* ]] && [[ $DOTFILE != *'-ubuntu' ]]
        then
          source ~/.dotfiles/$DOTFILE
        fi
      done
      ```
    - Ubuntu - Zsh
      ```
      #Find only filenames in directory
      for DOTFILE in `find ~/.dotfiles -type f -exec basename {} \;`
      do
        if [[ $DOTFILE == '.'* ]] && [[ $DOTFILE != '.git'* ]] && [[ $DOTFILE != *'-mac' ]]
        then
          source ~/.dotfiles/$DOTFILE
        fi
      done
      ```