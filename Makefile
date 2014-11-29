DOKKU_VERSION = v0.1.0

SSHCOMMAND_URL ?= https://raw.github.com/brianpattison/sshcommand/master/sshcommand
PLUGINHOOK_URL ?= http://brianpattison.s3.amazonaws.com/pluginhook_0.1.0_amd64.deb
STACK_URL ?= https://github.com/brianpattison/buildstep.git
DOKKU_ROOT ?= /home/dokku

.PHONY: all install copyfiles version plugins dependencies sshcommand pluginhook docker aufs stack count

all:
	# Type "make install" to install.

install: dependencies stack copyfiles plugin-dependencies plugins version

copyfiles:
	cp dokku /usr/local/bin/dokku
	mkdir -p /var/lib/dokku/plugins
	cp -r plugins/* /var/lib/dokku/plugins

version:
	git describe --tags > ${DOKKU_ROOT}/VERSION  2> /dev/null || echo '~${DOKKU_VERSION} ($(shell date -uIminutes))' > ${DOKKU_ROOT}/VERSION

plugin-dependencies: pluginhook
	dokku plugins-install-dependencies

plugins: pluginhook docker
	dokku plugins-install

dependencies: sshcommand pluginhook docker stack

sshcommand:
	wget -qO /usr/local/bin/sshcommand ${SSHCOMMAND_URL}
	chmod +x /usr/local/bin/sshcommand
	sshcommand create dokku /usr/local/bin/dokku

pluginhook:
	wget -qO /tmp/pluginhook_0.1.0_amd64.deb ${PLUGINHOOK_URL}
	dpkg -i /tmp/pluginhook_0.1.0_amd64.deb

docker: aufs
	apt-get install -qq -y curl
	egrep -i "^docker" /etc/group || groupadd docker
	usermod -aG docker dokku
	curl --silent https://get.docker.io/gpg | apt-key add -
	echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
	apt-get update
ifdef DOCKER_VERSION
	apt-get install -qq -y lxc-docker-${DOCKER_VERSION}
else
	apt-get install -qq -y lxc-docker
endif
	sleep 2 # give docker a moment i guess

aufs:
	lsmod | grep aufs || modprobe aufs || apt-get install -qq -y linux-image-extra-`uname -r` > /dev/null

stack:
	@echo "Start building buildstep"
	@docker images | grep progrium/buildstep || (git clone ${STACK_URL} /tmp/buildstep && docker build -t progrium/buildstep /tmp/buildstep && rm -rf /tmp/buildstep)

count:
	@echo "Core lines:"
	@cat dokku bootstrap.sh | wc -l
	@echo "Plugin lines:"
	@find plugins -type f | xargs cat | wc -l
	@echo "Test lines:"
	@find tests -type f | xargs cat | wc -l
