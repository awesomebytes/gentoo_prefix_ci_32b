# gentoo_prefix_ci

![Build Status](https://github.com/awesomebytes/gentoo_prefix_ci_32b/actions/workflows/docker-publish.yml/badge.svg)

A [Gentoo Prefix](https://wiki.gentoo.org/wiki/Project:Prefix) continuous integration repo.

Bootstrapping Gentoo Prefix every night on `/tmp/gentoo` for x86 over a Docker image of Ubuntu 16.04 32bit.

Builds page (with results and shell outputs): https://github.com/awesomebytes/gentoo_prefix_ci_32b/actions

Ready-to-use releases (with instructions): https://github.com/awesomebytes/gentoo_prefix_ci_32b/releases

Ready-to-use built docker image: `docker pull ghrc.io/awesomebytes/gentoo_prefix_ci_32b/gentoo_prefix_latest_image_package_stage_32b`

# Try Gentoo Prefix

Go to https://github.com/awesomebytes/gentoo_prefix_ci_32b/releases and download the latest release (700MB~).

Extract (2.2GB~):

```bash
tar xvf gentoo_on_tmp*.tar.lzma
```

Run your **prefix** shell by doing:

```bash
./gentoo/startprefix
```

Or use Docker:

```bash
docker pull awesomebytes/gentoo_prefix_boostrapped_32b
docker run -it awesomebytes/gentoo_prefix_boostrapped_32b /bin/bash
./tmp/gentoo/startprefix
```

# What do you mean continuous integration?

Every night (00:00) Sydney time (GMT +10h) the Azure pipelines build farm will bootstrap a Gentoo Prefix by using the configuration found in this repo. (Takes 7h~).

Github actions defines what jobs run. Every job pushes a docker image to github registry container located in this repository .
Right now the build is divided in 3 steps (check the corresponding Dockerfile to see the commands executed):

1. [Dockerfile.prepare](bootstrap_stage/Dockerfile.prepare). Prepares an image with the minimal requirements to build and debug the bootstrap.
2. [Dockerfile.stage1](bootstrap_stage/Dockerfile.stage1). Bootstraps stage 1.
3. [Dockerfile.stage2](bootstrap_stage/Dockerfile.stage2). Bootstraps stage 2.
4. [Dockerfile.stage3](bootstrap_stage/Dockerfile.stage3). Bootstraps stage 3.
5. [Dockerfile.emergesystem](bootstrap_stage/Dockerfile.emergesystem). Does `emerge -e system` after stage 3 to finish bootstrapping the system.

You can use any of those images (intermediate ones to debug, or the final one to play with Gentoo Prefix). Just do:

```bash
# To try Gentoo Prefix already bootstrapped in Docker over Ubuntu 16.04 in /tmp/gentoo
docker pull ghrc.io/awesomebytes/gentoo_prefix_ci_32b/gentoo_prefix_boostrapped_32b:latest
docker run -it awesomebytes/gentoo_prefix_ci_32b/gentoo_prefix_boostrapped_32b
```

# Just, why?

Gentoo Prefix is an awesome framework to deploy (almost) any software in any machine where you have no privileges. Just read the [awesome use-cases article](https://wiki.gentoo.org/wiki/Project:Prefix/Use_cases). I found myself unable to bootstrap the image and neither find an already bootstrapped image. So I built this.

# Acknowledgements

Thanks to the people in the #gentoo-prefix IRC channel, to the Gentoo-Alt mailing list, and in general to anyone that helped me while building all this.
