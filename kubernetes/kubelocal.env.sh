#!${PKGS_BASH}

export PATH="${PATH}"

set -eo pipefail

export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"
export DOCKER_SOCK="/run/user/1000/podman/podman.sock"

export REGISTRY_PORT="5000"
export REGISTRY_NAME=podman-registry
export CLUSTER_NAME=local-infra
export KUBERNETES_VERSION=v1.27.4-k3s1

makeSureClusterCreated() {
    if [[ $(k3d cluster ls -o json | jq -r "map(select(.name == \"$$CLUSTER_NAME\")) | length // 0") -eq 0 ]];
    then
        k3d registry create --default-network podman --port 0.0.0.0:$$REGISTRY_PORT $$REGISTRY_NAME
        k3d cluster create --config ${out}/share/k3d.yaml
        jq --arg nodeHosts "$(kubectl get configmaps -n kube-system coredns -o json | jq -r '.data.NodeHosts')" '. * {data: {NodeHosts: $$nodeHosts}}' ${out}/share/patches/coredns.json | kubectl apply -f -
        kubectl delete pod -n kube-system -l k8s-app=kube-dns
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

copyArgoCdCredentials() {
    kubectl get secrets -n argocd argocd-initial-admin-secret -o json | jq -r '.data.password' | base64 -d | wl-copy
}

case $$1 in
    creds)
        copyArgoCdCredentials
        ;;
    stop)
        makeSureClusterStopeed
        ;;
    start)
        makeSureClusterCreated
        makeSureRegistryStarted
        makeSureClusterStarted
        ;;
    *)
        makeSureClusterCreated
        makeSureRegistryStarted
        makeSureClusterStarted
        makeSureClusterBootstraped
        copyArgoCdCredentials
        ;;
esac
