#!/bin/env bash

install_nvm()
{
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
}

install_rvm()
{
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable --ruby
}

install_vscode()
{
    echo "Adding vscode repository..."
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    echo "Updating package list and installing Code..."
    sudo apt-get update
    sudo apt-get install code
}


install_development_kit()
{
    echo "Install base development tools and dependencies?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo apt-get install build-essential python3 ipython3 curl vim git; break;;
            No ) break;;
        esac
    done
    
    echo "Install NVM?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) install_nvm; break;;
            No ) break;;
        esac
    done

    echo "Install RVM?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) install_rvm; break;;
            No ) break;;
        esac
    done

    echo "Install vs-code?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) install_vscode; break;;
            No ) break;;
        esac
    done

}

install_development_kit
