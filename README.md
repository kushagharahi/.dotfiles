# .dotfiles
My dotfiles

## Usage
Mac - Export dotfiles in .zshrc or .bash_rc
```
for DOTFILE in `find ~/.dotfiles`
do
  [ -f “$DOTFILE” ] && source “$DOTFILE”
done
```