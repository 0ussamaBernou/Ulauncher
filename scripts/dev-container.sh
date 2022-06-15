#!/usr/bin/env bash

##########################################################
# Runs Docker container to run build scripts from this dir
##########################################################
dev-container () {
  # port 3002 is used for developing Preferences UI

  # If SELinux is enabled, the volumes mounted into the container
  # need to have the right labels. This is accomplished by appending
  # ":z" to the volume option.
  if command -v selinuxenabled && selinuxenabled
  then
      vol_suffix=":z"
  else
      vol_suffix=""
  fi

  exec docker run \
    --rm \
    -it \
    -v $(pwd):/root/ulauncher${vol_suffix} \
    -v $HOME/.bash_history:/root/.bash_history${vol_suffix} \
    -p 3002:3002 \
    --name ulauncher \
    $BUILD_IMAGE \
    bash
}
