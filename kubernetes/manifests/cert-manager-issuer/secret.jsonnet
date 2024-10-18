local constants = import '../../helpers/constants.libsonnet';
local configuration = import '../../helpers/configuration.libsonnet';
{
  apiVersion: 'v1',
  kind: 'Secret',
  metadata: {
    name: constants.cert_manager.issuer.secret_name,
  },
  type: 'Opaque',
  stringData: {
    [constants.cert_manager.issuer.secret_name]: configuration.cert_manager.token.value
  }
}
