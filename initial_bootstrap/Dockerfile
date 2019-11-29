# Just Ubuntu 16.04 with a user called user and some basic tools
FROM 32bit/ubuntu:16.04

RUN apt-get update
# Add sudo
RUN apt-get install apt-utils sudo -y

# Create user
RUN useradd --create-home --shell=/bin/bash user
RUN chown -R user /home/user/
# Add the user to sudoers
RUN chmod -R o-w /etc/sudoers.d/
RUN usermod -aG sudo user
# Give the user a password
RUN echo user:user | chpasswd

# Instal basic stuff
RUN apt-get install build-essential -y

# Nice tools to have
RUN apt-get install bash-completion nano net-tools less iputils-ping vim emacs wget -y
RUN apt-get install python-pip python-dev  -y
# To enable ssh
RUN apt-get install openssh-server -y

WORKDIR /home/user
USER user

# Let's get some specs of the machine that is running this job
RUN cat /proc/cpuinfo && cat /proc/meminfo && df -h

# hack until https://bugs.gentoo.org/699718 is fixed
COPY --chown=user:user bootstrap-prefix.sh /home/user/bootstrap-prefix.sh
RUN chmod +x bootstrap-prefix.sh
# RUN wget https://gitweb.gentoo.org/repo/proj/prefix.git/plain/scripts/bootstrap-prefix.sh && chmod +x bootstrap-prefix.sh
ENV EPREFIX /tmp/gentoo

# Bootstrap Gentoo Prefix
RUN LATEST_TREE_YES=1 TESTING_PV=latest linux32 ./bootstrap-prefix.sh ${EPREFIX} noninteractive

ENTRYPOINT ["/bin/bash"]
