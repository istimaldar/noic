local argocd = import './helpers/argocd.libsonnet';
local constants = import 'helpers/constants.libsonnet';
argocd.HelmArgoApplication + {
  name:: 'metrics-server',
  repo:: 'https://kubernetes-sigs.github.io/metrics-server/',
  version:: '3.12.2',
  syncWave:: -5
}
