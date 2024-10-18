local argocd = import 'helpers/argocd.libsonnet';
local configuration = import 'helpers/configuration.libsonnet';
argocd.ArgoApplication + {
  name:: 'cert-manager-issuer'
}
