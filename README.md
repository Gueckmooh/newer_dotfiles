## Debug bootstrap script

You can debug the bootstrap script by running it from a docker container.

    docker run -it debian:latest /bin/bash

Then, in the docker you can do:

``` sh
apt install git curl sudo xz-utils
adduser foo
mkdir -p /home/foo
chown foo /home/foo
usermod -aG sudo foo
passwd foo
# Give it a password
su foo
```

Once under user `foo` you can do:

``` sh
cd "$HOME"
sh -c "$(curl -fsLS https://raw.githubusercontent.com/Gueckmooh/newer_dotfiles/refs/heads/main/bootstrap.sh)"
```
