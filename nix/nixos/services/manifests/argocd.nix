{ ... }: {
  apiVersion = "helm.cattle.io/v1";
  kind = "HelmChart";
  metadata = {
    name = "argocd";
    namespace = "kube-system";
  };
  spec = {
    chart = "argo-cd";
    targetNamespace = "argocd";
    createNamespace = true;
    version = "7.6.8";
    repo = "https://argoproj.github.io/argo-helm";
    valuesContent = builtins.toJSON (import ../values/argocd.nix { });
  };
}
