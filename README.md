# .dotfiles
My dotfiles
- Installs oh-my-zsh plus a few opinioned plugins
- Automates ssh key setup
- Works on macOS and Ubuntu
- Features fish like autosuggestions and syntax highlighting
- Few aliases to make life easier
- ubuntu ssh-agent auto start/add identities

## Usage

### Automated setup
Run the install script either via: 
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kushagharahi/.dotfiles/master/install.sh?token=$(date +%s))"
```
or by cloning this repo and running `ìnstall.sh` (safer)

### Manual setup
Required:
1. Clone this folder to ~/.dotfiles

2. Install [ohmyzsh](https://ohmyz.sh/#install)

3. Install oh-my-zsh plugins
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) - fish like autosuggestions
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh) - fish like syntax highlighting
    - Update plugins to be `git zsh-autosuggestions zsh-syntax-highlighting`

4. Export dotfiles - Paste snippet below in `.zshrc`. Ensure this repository is cloned as `~/.dotfiles`

    - Mac - Zsh
      ```
      source ~/.dotfiles/.dotfiles-setup-mac
      ```
    - Ubuntu - Zsh
      ```
      source ~/.dotfiles/.dotfiles-setup-ubuntu
      ```