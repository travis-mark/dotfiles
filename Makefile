all: config setup

config:
	PWD=`pwd`
	ln -sf ${PWD}/.gitconfig ${HOME}
	ln -sf ${PWD}/.zshrc ${HOME}
	ln -sf ${PWD}/bin ${HOME}
	ln -sf ${PWD}/Brewfile ${HOME}
	ln -sf ${PWD}/functions ${HOME}

setup:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	brew bundle 