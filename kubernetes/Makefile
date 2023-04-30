.PHONY: build install
build: export PKGS_PODMAN = $(shell which helmsman)
build: export PKGS_KUBECTL = $(shell which kubectl)
build: export PKGS_HELMSMAN = $(shell which helmsman)
build: export PKGS_K3D = $(shell which k3d)
build: export PKGS_BASH = $(shell which bash)

build:
	cat ${src}/kubelocal.env.sh | envsubst > kubelocal
	chmod +x kubelocal

install:
	mkdir -p ${out}/bin
	cp kubelocal ${out}/bin
	mkdir -p ${out}/share
	cp ${src}/k3d.yaml ${out}/share