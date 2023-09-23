#!/bin/bash

# Function to ask for SSH key generation
ask_for_ssh_key() {
  read -p "Do you want to generate SSH keys? (y/n): " generate_ssh_key
  if [ "$generate_ssh_key" = "y" ]; then
    read -p "Enter your email address for SSH key generation: " email
    ssh-keygen -t rsa -b 4096 -C "$email"
    echo ""
    cat ~/.ssh/id_rsa.pub
    echo ""
    echo "Your public SSH key has been generated."
    echo "Now you can add the public key to your GitHub account for easy authentication."
    echo "Visit https://github.com/settings/keys and add your key there."
    read -p "Press Enter to continue..."
  fi
}

# Check if Oh My Zsh is installed, install if not
if ! command -v zsh >/dev/null 2>&1; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

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
      sed -i '' "/^plugins=/ s/)/ $plugin)/" ~/.zshrc
  fi
done

# Ask if SSH keys should be generated
ask_for_ssh_key

add_dotfiles_source() {
  local file_to_source="$1"
  if grep -q "$file_to_source" ~/.zshrc; then
    echo "$file_to_source already sourced in .zshrc"
  else
    echo "$file_to_source" >> ~/.zshrc
    echo "sourced $file_to_source in .zshrc!"
  fi
}

# If mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Check if the line exists in .zshrc
  file_to_source="source ~/.dotfiles/.dotfiles-setup-mac"
  add_dotfiles_source "$file_to_source"
else
  # Check if the line exists in .zshrc
  file_to_source="source ~/.dotfiles/.dotfiles-setup-ubuntu"
  add_dotfiles_source "$file_to_source"
fi

echo "Terminal environment setup completed."