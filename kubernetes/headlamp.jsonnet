local argocd = import './helpers/argocd.libsonnet';
local ingress = import './helpers/ingress.libsonnet';
local constants = import 'helpers/constants.libsonnet';
argocd.HelmArgoApplication + {
  name:: 'headlamp',
  repo:: 'https://headlamp-k8s.github.io/headlamp/',
  version:: '0.25.0',
  syncWave:: -5,
  values:: {
    config: {
      baseURL: constants.headlamp.domain
    },
    ingress: {
      enabled: true,
      ingressClassName: constants.traefik.ingressClassName,
      annotations: ingress.IngressAnnotations,
      hosts: [
        constants.headlamp.domain
      ],
      extraTls: [
        {
          secretName: 'headlamp-tls',
          hosts: [
            constants.headlamp.domain
          ]
        }
      ]
    }
  }
}
