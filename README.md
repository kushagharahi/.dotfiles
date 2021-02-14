# .dotfiles
My dotfiles

## Usage
### Mac - Zsh
Export dotfiles in `.zshrc`. Ensure this repository is cloned as `~/.dotfiles`
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
### Ubuntu - Zsh
Export dotfiles in `.zshrc`. Ensure this repository is cloned as `~/.dotfiles`
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