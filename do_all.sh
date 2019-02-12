#!/usr/bin/env bash

cd initial_bootstrap && docker build -f Dockerfile -t gentoo_prefix_32b_latest_image .

cd ..
cd stage_3_1 && docker build -f Dockerfile -t gentoo_prefix_32b_latest_image .

cd ..
cd stage_3_2 && docker build -f Dockerfile -t gentoo_prefix_32b_latest_image .

docker tag `docker ps -a -l -q | xargs docker commit | awk -F":" '{print $2}'` awesomebytes/gentoo_prefix_32b_latest_image:latest
docker push awesomebytes/gentoo_prefix_32b_latest_image
echo "Done!"
