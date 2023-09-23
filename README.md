# .dotfiles
My dotfiles
- Features fish like autosuggestions and syntax highlighting. 
- Few aliases to make life easier
- ubuntu ssh-agent auto start/add identities 

## Usage
Clone this folder to ~/.dotfiles

### Automated setup
Run install.sh

### Manual setup
Required:
1. Install [ohmyzsh](https://ohmyz.sh/#install)

2. Install oh-my-zsh plugins
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) - fish like autosuggestions
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh) - fish like syntax highlighting
    - Update plugins to be `git zsh-autosuggestions zsh-syntax-highlighting`

3. Export dotfiles - Paste snippet below in `.zshrc`. Ensure this repository is cloned as `~/.dotfiles`

    - Mac - Zsh
      ```
      source ~/.dotfiles/.dotfiles-setup-mac
      ```
    - Ubuntu - Zsh
      ```
      source ~/.dotfiles/.dotfiles-setup-ubuntu
      ```