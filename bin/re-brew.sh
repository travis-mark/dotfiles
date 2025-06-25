#!/bin/sh
set -e

# Uninstall all packages
while [[ `brew list | wc -l` -ne 0 ]]; do
    for EACH in `brew list`; do
        brew uninstall --force --ignore-dependencies $EACH
    done
done

# Create temporary Brewfile
cat > /tmp/Brewfile << 'EOF'
tap "rconroy293/seventeenlands"
tap "saulpw/vd"
brew "bat"
brew "cocoapods"
brew "fd"
brew "fzf"
brew "elixir"
brew "gh"
brew "gron"
brew "hugo"
brew "imagemagick"
brew "npm"
brew "python3"
brew "ripgrep"
brew "rconroy293/seventeenlands/seventeenlands"
brew "saulpw/vd/visidata"
EOF

# Install packages
brew bundle install --file=/tmp/Brewfile
rm /tmp/Brewfile