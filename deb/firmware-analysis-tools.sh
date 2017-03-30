#!/usr/bin/env bash

install_sasquatch() 
{
    echo "Installing necessary dependencies first..."
    sudo apt-get -y install build-essential liblzma-dev liblzo2-dev zlib1g-dev
    
    echo "Cloning sasquatch repo from GitHub..."
    cd /tmp
    git clone https://github.com/devttys0/sasquatch.git 
    echo "Building..."
    cd sasquatch 
    if [[ $(./build.sh) ]] ; then
        echo "Installation completed successfully. Done."
        cd .. && sudo rm -rf sasquatch
    else echo "Installation failed. Exiting."
    fi
}

install_binwalk()
{
    echo "Cloning binwalk..."
    cd /tmp
    git clone https://github.com/devttys0/binwalk.git
    cd binwalk
    echo "Installing..."
    if [[ $(sudo python setup.py install) ]] ; then
        echo "Installation completed successfully. Done."
        cd .. && sudo rm -rf binwalk
    else echo "Installation failed. Exiting."
    fi     
}


install_basic_tools()
{
    echo "Installing archivers and other dependecies"s
    apt-get -y install mtd-utils cramfsprogs cramfsswap squashfs-tools
}


echo "Install archivers and other utilities?"
select yn in "Yes" "No"; do
    case $yn in
	Yes ) install_basic_tools; break;;
	No ) break;;
    esac
done

echo "Install binwalk?"
select yn in "Yes" "No"; do
    case $yn in
	Yes ) install_binwalk; break;;
	No ) break;;
    esac
done

echo "Install sasqautch?"
select yn in "Yes" "No"; do
    case $yn in
	Yes ) install_sasquatch; break;;
	No ) break;;
    esac
done

