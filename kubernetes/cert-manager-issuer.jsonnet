local argocd = import 'helpers/argocd.libsonnet';
local configuration = import 'helpers/configuration.libsonnet';
argocd.JsonnetArgoApplication + {
  name:: 'cert-manager-issuer',
  syncWave: 1
}
