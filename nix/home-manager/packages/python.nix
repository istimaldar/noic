{ pkgs, ... }: with pkgs; (wrapHelm kubernetes-helm
  {
    plugins =  with kubernetes-helmPlugins; [
      helm-secrets
      helm-diff
    ];
  }
)
