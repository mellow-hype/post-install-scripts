#!/usr/bin/env bash

cross_arch() {
    echo "[+] Adding crosstools repository..."
    sudo echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list
    sudo apt-get install curl
    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | sudo apt-key add -
    sudo apt-get update
    echo "[+] Installing cross-gcc-dev..."
    sudo apt-get -y install cross-gcc-dev
    echo "[!] Don\'t forget to install cross-build-essentials for the desired architecture after adding the arch in dpkg."
    echo "[+] DONE\n\n"
}

emulation(){
    echo "[+] Installing statically linked QEMU for emulation..."
    sudo apt-get -y install qemu-user-static
    echo "[+] DONE\n\n"
}


install_binwalk()
{
    echo "[+] Cloning binwalk..."
    cd $HOME
    git clone https://github.com/devttys0/binwalk.git
    cd binwalk
    echo "[+] Installing binwalk..."
    sudo apt-get install p7zip-full
    if [[ $(sudo python setup.py install) ]] ; then
        echo "Installation completed successfully. Done."
        cd .. && sudo rm -rf binwalk
    else echo "Installation failed. Exiting."
    fi     
}

install_sasquatch() 
{
    echo "Installing necessary dependencies first..."
    sudo apt-get -y install build-essential liblzma-dev liblzo2-dev zlib1g-dev
    
    echo "Cloning sasquatch repo from GitHub..."
    cd $HOME
    git clone https://github.com/devttys0/sasquatch.git 
    echo "Building..."
    cd sasquatch 
    if [[ $(./build.sh) ]] ; then
        echo "Installation completed successfully. Done."
        cd .. && sudo rm -rf sasquatch
    else echo "Installation failed. Exiting."
    fi
}


install_radare_git()
{
    echo "Installing radare2"
    cd $HOME
    git clone https://github.com/radare/radare2.git
    cd radare2
    echo "Install globally or to the user home directory?"
    select gu in "Yes" "No"; do
        case $gu in
        Global ) sys/install.sh; break;;
        User ) sys/user.sh; break;;
        esac
    done
}

install_base()
{
    echo "Installing basic tools from repos..."
    sudo apt-get -y install build-essential strace hexedit ltrace
    echo "[+] Installing cross-architecture support..."
    cross_arch
    echo "[+] Installing static QEMU for emulation..."
    emulation
    echo "Done"
}

echo "Install base tools?"
select yn in "Yes" "No"; do
    case $yn in
	Yes ) install_base; break;;
	No ) break;;
    esac
done


echo "Install radare2?"
select yn in "Yes" "No"; do
    case $yn in
	Yes ) install_radare_git; break;;
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

