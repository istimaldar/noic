local argocd = import './helpers/argocd.libsonnet';
local constants = import 'helpers/constants.libsonnet';
argocd.HelmArgoApplication + {
  name:: 'external-dns',
  repo:: 'https://charts.bitnami.com/bitnami',
  version:: '8.3.9',
  syncWave:: -5,
  values:: {
    provider: 'cloudflare',
    cloudflare: {
      proxied: false,
      email: constants.external_dns.cloudflare.email,
      secretName: constants.external_dns.cloudflare.secret_name
    },
  }
}
