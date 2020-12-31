#!/bin/bash

# exit script if anything fails
set -e

# print banner
cat << 'EOF'
     _                            _           
  __| |_ __ ___  _ __      __   _(_)_ __ ___  
 / _` | '__/ _ \| '_ \ ____\ \ / / | '_ ` _ \ 
| (_| | | | (_) | |_) |_____\ V /| | | | | | |
 \__,_|_|  \___/| .__/       \_/ |_|_| |_| |_|
                |_|                           
EOF

# run commands with neovim, if available, otherwise use vim
function command_wrapper {
	if [ -f "$(command -v nvim)" ] ; then 
        echo "Using nvim to execute command ..." 
		nvim --headless "$1" +qa
	elif [ -f "$(command -v vim)" ] ; then 
        echo "Using vim to execute command ..."
		vim "$1" +qa
	else
		echo "ERROR: Could not find neither vim or neovim, check that they are installed and on PATH."
	fi
}

# check that exernal tools are installed before trying to invoke them
function check_application_installed {
	if [ -f "$(command -v ${1})" ] ; then 
        echo "Found $1 ..."
    else
        echo "ERROR: Please install $1 and run the script again."
        exit
    fi
}

# options to choose from
options="
copy_config
install_plug
upgrade_plug
install_plugins
update_plugins
exit
"

# interactively select what to do 
select opt in $options ; do
	case $opt in 

		copy_config)

            if [ -f "$(command -v nvim)" ] ; then 
                echo ">>> USING NEOVIM <<<"
                echo "Copying init.vim ..."

                if [ -f "/home/$USER/.config/nvim/init.vim" ] ; then
                    echo "ERROR: Found ~/.config/nvim/init.vim already - please remove the existing configuration!"
                    exit
                else
                    [ ! -f "/home/$USER/.config/nvim" ] && echo "Creating ~/.config/nvim directory ..." && mkdir -pv /home/$USER/.config/nvim
                    echo "Copying init.vim ..."
                    cp -v /home/$USER/drop-vim/init.vim /home/$USER/.config/nvim/init.vim
                fi

            elif [ -f "$(command -v vim)" ] ; then 
                echo ">>> USING VIM <<<"
                cp -v /home/$USER/drop-vim/init.vim /home/$USER/.vimrc

            else
                echo "ERROR: Could not find neither vim or neovim, check that they are installed and on PATH."
            fi

            echo "Done copying."
            echo
			;;

		install_plug)
			echo "Getting latest version of Plug from github using curl ..."
            check_application_installed "curl"

            if [ -f "$(command -v nvim)" ] ; then 
                echo ">>> USING NEOVIM <<<"
                curl -fLo /home/$USER/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            elif [ -f "$(command -v vim)" ] ; then 
                echo ">>> USING VIM <<<"
                curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            else
                echo "ERROR: Could not find neither vim or neovim, check that they are installed and on PATH."
            fi

            echo "Done getting Plug."
            echo
			;;

		upgrade_plug)
            echo "Upgrading Plug to the latest version ..."
			check_application_installed "curl"
			command_wrapper "+PlugUpgrade"
            echo "Done upgrading Plug to the latest version."
            echo
			;;

		install_plugins)
            echo "Installing vim plugins using Plug ..."
            echo "nvim/vim might throw some error for plugins that are not installed yet, these can be disregarded."
			check_application_installed "git"
			command_wrapper "+PlugInstall"
            echo "Done installing plugins."
            echo
			;;

		update_plugins)
            echo "Updating existing plugins ..."
			check_application_installed "git"
			command_wrapper "+PlugUpdate"
            echo "Done updating plugins."
            echo
			;;

		exit)
			exit
			;;

		*)
			echo "Press return to options ..."
			;;
	esac
done

