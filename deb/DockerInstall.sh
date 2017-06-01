#!/usr/bin/env bash

echo "Installing apt dependencies..."
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
echo "Is this the correct fingerprint?"

select yn in "Yes" "No"; do
    case $yn in
	Yes ) break;;
	No ) echo "Exiting."; exit;
    esac
done

echo "Adding the Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo "Updating repositories and installing Docker..."
sudo apt-get update && sudo apt-get install docker-ce
echo "Installation complete.\n"

