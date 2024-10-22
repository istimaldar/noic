local argocd = import './helpers/argocd.libsonnet';
local constants = import './helpers/constants.libsonnet';
local ingress = import './helpers/ingress.libsonnet';
argocd.HelmArgoApplication + {
  name:: 'plane-ce',
  namespace:: 'plane',
  repo:: 'https://helm.plane.so/',
  version:: '0.23.0',
  syncWave:: 0,
  values:: {
    ingress: {
      enabled: true,
      appHost: constants.plane.domain,
      ingressClass: constants.traefik.ingressClassName
    },
    ssl: {
      issuer: constants.cert_manager.issuer.name
    }
  }
}
