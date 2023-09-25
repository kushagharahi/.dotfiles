#!/bin/bash

# Ask if SSH keys should be generated
read -p "Do you want to generate SSH keys? [SSH KEY SHOULD BE SET ON GITHUB TO PROCEED] (y/n):" generate_ssh_key
if [ "$generate_ssh_key" = "y" ]; then
    read -p "Enter your email address for SSH key generation: " email
    read -p "Enter the file name in which to save the key [id_rsa]: " key_name
    key_name=${key_name:-id_rsa}
    ssh-keygen -t rsa -b 4096 -C "$email" -f "$HOME/.ssh/$key_name"
    echo ""
    cat ~/.ssh/$key_name.pub
    echo ""
    echo "Visit https://github.com/settings/keys and add your key there."
    read -p "Press Enter to continue once you have set your key [SSH KEY SHOULD BE SET ON GITHUB TO PROCEED]..."
fi


if ! command -v zsh &> /dev/null; then
    # If mac
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Detected OS is macos, expected Zsh to be installed. Did not detect it. Fix this! Exiting."
    else
        # install zsh for ubuntu
        echo "Zsh is not installed. Installing..."
        sudo apt update
        sudo apt install zsh -y
    fi
else
    echo "Zsh is already installed."
fi

zsh -f <<'EOF'

dotfiles_dir="$HOME/.dotfiles"
github_repo="git@github.com:kushagharahi/.dotfiles.git"

# Check if ~/.dotfiles directory exists
if [ -d "$dotfiles_dir" ]; then
  echo "The ~/.dotfiles directory already exists."
else
  echo "Cloning ~/.dotfiles from GitHub..."
  git clone "$github_repo" "$dotfiles_dir"
  
  if [ ! -d "$HOME/.dotfiles/" ]; then
    echo "Cloning failed! Ensure your SSH key is set!"
  else 
    echo "Clone complete!"
  fi
fi

# Check if Oh My Zsh is installed, install if not
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

# restart ZSH
EOF
zsh <<'EOF'

is_plugin_installed() {
    local plugin_name="$1"
    zsh_plugins_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins"
    # Use eval or tilde expansion to expand the path
    zsh_plugins_dir="$(eval echo "$zsh_plugins_dir")"
    plugin="$zsh_plugins_dir/$plugin_name/"
    if [ -d "$plugin" ]; then
        return 0  # Plugin is installed
    else
        return 1  # Plugin is not installed
    fi
}

# Check if zsh-autosuggestions plugin is installed, install if not
if ! is_plugin_installed "zsh-autosuggestions"; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions is already installed."
fi

# Check if zsh-syntax-highlighting plugin is installed, install if not
if ! is_plugin_installed "zsh-syntax-highlighting"; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting is already installed."
fi

echo "Checking if oh-my-zsh plugins list should be updated..."
# Define plugins to add
new_plugins=("git" "zsh-autosuggestions" "zsh-syntax-highlighting")
# Read the existing plugins from .zshrc
existing_plugins=$(grep -o 'plugins=([^)]*' ~/.zshrc | sed 's/plugins=(//' | tr -d '\n' | tr -d '\r')
# Append new plugins that are not already in the list
for plugin in "${new_plugins[@]}"; do
  if [[ ! " $existing_plugins " =~ " $plugin " ]]; then
    echo "Adding $plugin to the list of plugins..."
      sed -i "/^plugins=/ s/)/ $plugin)/" ~/.zshrc
  fi
done

add_dotfiles_sourcing() {
  local file_to_source="$1"
  if grep -q "$file_to_source" ~/.zshrc; then
    echo "$file_to_source already sourced in .zshrc!"
  else
    echo "$file_to_source" >> ~/.zshrc
    echo "sourced $file_to_source in .zshrc!"
  fi
}

# If mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Check if the line exists in .zshrc
  file_to_source="source ~/.dotfiles/.dotfiles-setup-mac"
  add_dotfiles_sourcing "$file_to_source"
else
  # Check if the line exists in .zshrc
  file_to_source="source ~/.dotfiles/.dotfiles-setup-ubuntu"
  add_dotfiles_sourcing "$file_to_source"
fi

echo "Terminal environment setup completed."

source ~/.zshrc

EOF