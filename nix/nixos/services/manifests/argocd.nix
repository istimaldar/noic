{ ... }: {
  apiVersion = "helm.cattle.io/v1";
  kind = "HelmChart";
  metadata = {
    name = "argo-cd";
    namespace = "kube-system";
  };
  spec = {
    chart = "argo-cd";
    targetNamespace = "argo-cd";
    createNamespace = true;
    version = "7.6.12";
    repo = "https://argoproj.github.io/argo-helm";
    valuesContent = builtins.toJSON (import ../values/argocd.nix { });
  };
}
