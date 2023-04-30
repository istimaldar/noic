.PHONY: build install
build: export PKGS_BASH = $(shell which bash)

build:
	cat ${src}/kubelocal.env.sh | envsubst > kubelocal
	chmod +x kubelocal

install:
	mkdir -p ${out}/bin
	cp kubelocal ${out}/bin
	mkdir -p ${out}/share
	cp -rf ${src}/k3d.yaml ${src}/bootstrap ${src}/charts ${src}/values ${out}/share
