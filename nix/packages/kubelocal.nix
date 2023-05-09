{ pkgs, ... }: pkgs.stdenv.mkDerivation {
name = "kubelocal";
src = ./../../kubernetes;
buildInputs = with pkgs; [
  which
  envsubst
  k9s
  (wrapHelm kubernetes-helm 
    { 
      plugins =  with kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
      ]; 
    }
  )
  helmsman
  kube3d
  kubectl
  podman
  jq
  gnused
  wl-clipboard
];
}