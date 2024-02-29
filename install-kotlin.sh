#!/bin/sh

set -xe

sudo dnf install java
curl -s https://get.sdkman.io | bash
zsh
sdk install kotlin
