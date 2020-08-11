#!/bin/zsh

CONFIG_ZSH="${(%):-%N}"
CONFIG_DIR=`dirname ${CONFIG_ZSH}`
cd ${CONFIG_DIR}
cd ..

ln -sf ${PWD}/.gitconfig ${HOME}
ln -sf ${PWD}/.zshrc ${HOME}
ln -sf ${PWD}/bin/ ${HOME}
ln -sf ${PWD}/functions/ ${HOME}
ls -al ~