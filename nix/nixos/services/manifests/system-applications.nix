{ host, ... }: {
  apiVersion = "argoproj.io/v1alpha1";
  kind = "Application";
  metadata = {
    name = "system-applications";
    namespace = "argo-cd";
  };
  spec = {
    project = "default";
    destination = {
      server = "https://kubernetes.default.svc";
      namespace = "argo-cd";
    };
    source = {
      repoURL = "https://github.com/istimaldar/noic.git";
      targetRevision = "HEAD";
      path = "kubernetes";
      directory = {
        recurse = false;
        jsonnet = {
          extVars  = [
            {
              name  = "hostname";
              value  = host.features.kubernetes.hostname;
            }
          ];
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
