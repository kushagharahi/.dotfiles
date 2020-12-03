# .dotfiles
My dotfiles

## Usage
Mac - Export dotfiles in .zshrc. Ensure this repository is cloned as ~/.dotfiles
```
#Find only filenames in directory
for DOTFILE in `find ~/.dotfiles -type f -exec basename {} \;`
do
  if [[ $DOTFILE == '.'* ]] && [[ $DOTFILE != '.git'* ]]
  then
    echo $DOTFILE
    source ~/.dotfiles/$DOTFILE
  fi
done

```