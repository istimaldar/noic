local argocd = import './helpers/argocd.libsonnet';
local constants = import './helpers/constants.libsonnet';
argocd.HelmArgoApplication + {
  name:: 'argo-cd',
  repo:: 'https://argoproj.github.io/argo-helm',
  version:: '7.6.12',
  syncWave:: -1,
  values:: {
    global: {
      domain: constants.argocd.domain
    },
    configs: {
      params: {
        'server.insecure': true
      },
      cm: {
        'resource.customizations.health.argoproj.io_Application': |||
          hs = {}
          hs.status = "Progressing"
          hs.message = ""
          if obj.status ~= nil then
            if obj.status.health ~= nil then
              hs.status = obj.status.health.status
              if obj.status.health.message ~= nil then
                hs.message = obj.status.health.message
              end
            end
          end
          return hs
        |||
      }
    },
    server: {
      ingress: {
        enabled: true,
        ingressClassName: constants.traefik.ingressClassName,
        annotations: {
          'cert-manager.io/cluster-issuer': constants.cert_manager.issuer.name
        },
        extraTls: [
          {
            secretName: 'argo-cd-tls',
            hosts: [
              constants.argocd.domain
            ]
          }
        ]
      }
    }
  }
}
