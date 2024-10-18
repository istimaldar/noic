{ lib, ... }: {
  apiVersion = "argoproj.io/v1alpha1";
  kind = "Application";
  metadata = {
    name = "system-applications";
    namespace = "argocd";
  };
  spec = {
    project = "default";
    destination = {
      server = "https://kubernetes.default.svc";
      namespace = "argocd";
    };
    source = {
      repoURL = "https://github.com/istimaldar/noic.git";
      targetRevision = "HEAD";
      path = "kubernetes";
      directory = {
        recurse = false;
        jsonnet = {
          tlas = (
            lib.attrsets.mapAttrsToList (name: value: { inherit name value; }) (import ../values/jsonnet.nix {}));
        };
      };
    };
    syncPolicy = {
      automated = {
        prune = true;
        selfHeal = true;
        allowEmpty = false;
      };
      syncOptions = [
        "CreateNamespace=true"
      ];
    };
  };
}
