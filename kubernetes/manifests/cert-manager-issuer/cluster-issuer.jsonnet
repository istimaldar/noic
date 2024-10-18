local constants = import '../../helpers/constants.libsonnet';
local argocd = import '../../helpers/argocd.libsonnet';
{
  apiVersion: 'cert-manager.io/v1',
  kind: 'ClusterIssuer',
  metadata: {
    name: constants.cert_manager.issuer.name,
    annotations: argocd.generateSyncWave('-4')
  },
  spec: {
    acme: {
      email: constants.cert_manager.issuer.acme_email,
      server: if constants.cert_manager.issuer.staging then constants.acme.staging_url else constants.acme.production_url,
      privateKeySecretRef: {
        name: constants.cert_manager.issuer.name
      },
      solvers: [
        {
          dns01: {
            cloudflare: {
              apiTokenSecretRef: {
                name: constants.cert_manager.issuer.secret_name,
                key: constants.cert_manager.issuer.secret_key
              }
            }
          }
        }
      ]
    }
  }
}
