# Install stow (macOS)
brew install stow

# Clone and deploy all packages
git clone <your-repo> ~/dotfiles
cd ~/dotfiles
stow */
