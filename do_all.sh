#!/usr/bin/env bash

cd initial_bootstrap && linux32 docker build -f Dockerfile -t gentoo_prefix_32b_latest_image .

cd ..
cd stage_3_1 && linux32 docker build -f Dockerfile -t gentoo_prefix_32b_latest_image .

cd ..
cd stage_3_2 && linux32 docker build -f Dockerfile -t gentoo_prefix_32b_latest_image .

docker tag `docker ps -a -l -q | xargs docker commit | awk -F":" '{print $2}'` awesomebytes/gentoo_prefix_32b_latest_image:latest
docker push awesomebytes/gentoo_prefix_32b_latest_image
echo "Done!"
