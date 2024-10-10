# ~/.*

## Installation

To install the config, you can use the bootstrap script:

    sh -c "$(curl -fsLS https://raw.githubusercontent.com/Gueckmooh/newer_dotfiles/refs/heads/main/bootstrap.sh)"

## Debug bootstrap script

You can debug the bootstrap script by running it from a docker container.

    docker run -it debian:latest /bin/bash

Then, in the docker you can do:

``` sh
apt update
apt install git curl sudo xz-utils -y
adduser foo
mkdir -p /home/foo
chown foo /home/foo
echo "foo ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
su foo
```

Once under user `foo` you can do:

``` sh
cd "$HOME"
sh -c "$(curl -fsLS https://raw.githubusercontent.com/Gueckmooh/newer_dotfiles/refs/heads/main/bootstrap.sh)"
```
