local constants = import './constants.libsonnet';
{
  IngressAnnotations: {
    'cert-manager.io/cluster-issuer': constants.cert_manager.issuer.name
  }
}
