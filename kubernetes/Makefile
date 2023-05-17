.PHONY: build install
build: export PKGS_BASH = $(shell which bash)

build:
	cat ${src}/kubelocal.env.sh | envsubst > kubelocal.sh
	chmod +x kubelocal.sh

install:
	mkdir -p ${out}/bin
	cp kubelocal.sh ${out}/bin
	mkdir -p ${out}/share
	cp -rf ${src}/k3d.yaml ${src}/bootstrap ${src}/charts ${src}/values ${src}/patches ${out}/share
