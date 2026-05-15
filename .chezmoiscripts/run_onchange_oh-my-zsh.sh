#!/bin/sh
export ZSH="$HOME/.local/share/oh-my-zsh"

if [ -d "$ZSH" ]; then
	echo "Oh My Zsh is already installed at $ZSH"
	exit 0
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
