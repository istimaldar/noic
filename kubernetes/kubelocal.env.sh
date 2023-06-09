#!${PKGS_BASH}

export PATH="${PATH}"

set -eo pipefail

export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"
export DOCKER_SOCK="/run/user/1000/podman/podman.sock"

export REGISTRY_PORT="5000"
export REGISTRY_NAME=podman-registry
export CLUSTER_NAME=local-infra

makeSureClusterCreated() {
    if [[ $(k3d cluster ls -o json | jq -r "map(select(.name == \"$$CLUSTER_NAME\")) | length // 0") -eq 0 ]];
    then
        k3d registry create --default-network podman --port 0.0.0.0:$$REGISTRY_PORT $$REGISTRY_NAME
        k3d cluster create --config ${out}/share/k3d.yaml
        kubectl create namespace drone
        jq -r '.drone | to_entries[] | "--from-literal=\(.key)=\(.value)"' ~/common/secrets.json | tr '\n' ' ' | sed 's/^/kubectl create secret -n drone generic drone /' | bash -
    fi
}

makeSureRegistryStarted() {
    if [[ $(k3d registry ls -o json | jq -r "map(select(.name == \"k3d-$$REGISTRY_NAME\"))[0].State.Running // false") != "true" ]];
    then
        podman start k3d-$$REGISTRY_NAME
    fi
}

makeSureClusterStarted() {
    if [[ $(k3d cluster ls -o json | jq -r "map(select(.name == \"$$CLUSTER_NAME\"))[0].serversRunning // 0") -eq 0 ]];
    then
        k3d cluster start $$CLUSTER_NAME
    fi
}

makeSureClusterBootstraped() {
    helmsman --apply -f ${out}/share/bootstrap/bootstrap.toml
}

makeSureClusterStopeed() {
    k3d cluster delete $$CLUSTER_NAME
    k3d registry delete k3d-$$REGISTRY_NAME
}

case $$1 in
    creds)
        copyArgoCdCredentials
        ;;
    stop)
        makeSureClusterStopeed
        ;;
    *)
        makeSureClusterCreated
        makeSureRegistryStarted
        makeSureClusterStarted
        makeSureClusterBootstraped
        ;;
esac
