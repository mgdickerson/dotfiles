echo "Creating an SSH key for you..."
ssh-keygen -t ed25519 -C "mgdicker@uci.edu"

echo "Please add this public key to Github\n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Install xcode..."
xcode-select --install

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Make Homebrew accessible
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/glados/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Update Homebrew recipes
echo "Updating Homebrew..."
brew update

echo "Installing git..."
brew install git

echo "Setting up git config..."
git config --global user.name "Mitchel Dickerson"
git config --global user.email mgdicker@uci.edu
git config --global init.defaultBranch main

echo "Installing utilities..."
brew install ripgrep
brew install fd
brew install tig
brew install neovim

echo "Get packer.nvim..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim 

echo "Installing fish..."
brew install fish

echo "Installing Homebrew cask"
brew install caskroom/cask/brew-cask

echo "Install nerd fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

echo "Copy dotfiles..."
git clone git@github.com:mgdickerson/dotfiles.git 
cp -r dotfiles/nvim ~/.config/.

echo "Add fish to /etc/shells..."
sudo echo /usr/bin/fish >> /etc/shells 

echo "Changing shell to fish..."
chsh -s /usr/bin/fish

echo "Installing oh-my-fish..."
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish 

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Apps to install
apps=(
  alfred
  discord
  iterm2
  slack
  spotify
  steam
  visual-studio-code
  zoomus
)

echo "Installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Linking alfred..."
brew cask alfred link

echo "Setting up fish with iterm2..."
curl -L https://iterm2.com/shell_integration/fish \
-o ~/.iterm2_shell_integration.fish 

sudo echo source ~/.iterm2_shell_integration.fish >> ~/.config/fish/config.fish

brew cask cleanup
brew cleanup

killall Finder

echo "Setup complete!"
