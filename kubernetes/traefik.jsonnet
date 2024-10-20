local argocd = import './helpers/argocd.libsonnet';
argocd.HelmArgoApplication + {
  name:: 'traefik',
  repo:: 'https://traefik.github.io/charts',
  version:: '32.1.1',
  syncWave:: -3,
  values:: {
    providers: {
      kubernetesCRD: {
        # -- Allows IngressRoute to reference resources in namespace other than theirs
        allowCrossNamespace: true,
        # -- Allows to return 503 when there is no endpoints available
        allowEmptyServices: false
      },
      kubernetesIngress: {
        # -- Allows to reference ExternalName services in Ingress
        allowExternalNameServices: true,
        # -- Allows to return 503 when there is no endpoints available
        allowEmptyServices: false,
        # Disable cluster IngressClass Lookup - Requires Traefik V3.
        # When combined with rbac.namespaced: true, ClusterRole will not be created and ingresses must use kubernetes.io/ingress.class annotation instead of spec.ingressClassName.
        disableIngressClassLookup: false,
        # IP used for Kubernetes Ingress endpoints
        publishedService: {
          enabled: true
        }
      }
    }
  }
}
