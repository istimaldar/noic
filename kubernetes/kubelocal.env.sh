#!${PKGS_BASH}

export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"
export DOCKER_SOCK="/run/user/1000/podman/podman.sock"

export REGISTRY_PORT="5000"
export REGISTRY_NAME=podman-registry
export CLUSTER_NAME=local-infra


${PKGS_K3D} registry create --default-network podman --port 0.0.0.0:$$REGISTRY_PORT $$REGISTRY_NAME
${PKGS_K3D} cluster create --config ${out}/share/k3d.yaml