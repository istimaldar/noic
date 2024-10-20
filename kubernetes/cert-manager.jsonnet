local argocd = import 'helpers/argocd.libsonnet';
argocd.HelmArgoApplication + {
  name:: 'cert-manager',
  repo:: 'https://charts.jetstack.io',
  version:: '1.16.1',
  syncWave:: -5,
  values:: {
    crds: {
      enabled: true,
      keep: true
    }
  }
}
