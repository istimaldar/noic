{ pkgs, helm, ... }: with pkgs; [
  kubectl
  kubeswitch
  kube-capacity
  helm
  helmsman
  kube3d
  jsonnet
  jsonnet-language-server
]
