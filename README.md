# Install stow (macOS)
brew install stow

# Clone and deploy all packages
git clone <your-repo> ~/dotfiles
cd ~/dotfiles
stow */

# Deploy all packages
cd ~/dotfiles && stow */

# Deploy specific packages
stow nvim zsh ohmyposh

# Remove a package's symlinks
stow -D nvim