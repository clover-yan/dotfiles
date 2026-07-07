#!/bin/bash
if ! command -v git &>/dev/null; then
	echo "git could not be found, please install git first"
	exit 1
fi
if ! command -v sudo &>/dev/null; then
	echo "sudo could not be found, please install sudo first"
	exit 1
fi
if [ ! -f "$HOME/.config/chezmoi/chezmoi.yaml" ]; then
	echo "I think you need a chezmoi config file"
	exit 1
fi
if ! command -v chezmoi &>/dev/null; then
	echo "chezmoi could not be found"
	if command -v pacman &>/dev/null; then
		echo "installing chezmoi using pacman"
		if ! sudo pacman -S chezmoi; then
			echo "failed to install chezmoi using pacman"
			exit 1
		fi
	else
		sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply clover-yan
		sudo cp ~/.local/bin/chezmoi /usr/local/bin/chezmoi
		export PATH="/usr/local/bin:$PATH"
	fi
else
	chezmoi init --apply clover-yan
fi
if ! command -v chezetc &>/dev/null; then
	echo "chezetc could not be found"
	if command -v pacman &>/dev/null; then
		echo "installing chezetc using pacman"
		if ! sudo pacman -S chezetc; then
			echo "failed to install chezetc using pacman, please add archlinuxcn repository"
			exit 1
		fi
	else
		git clone https://github.com/SilverRainZ/chezetc.git ~/.chezetc
		PATH="$HOME/.chezetc:$PATH"
	fi
fi
export ETC_SRC="$HOME/.local/share/chezmoi/.chezetc"
chezetc apply
chezetc apply
echo "dotfiles apply finished, please check the output above for any errors"
