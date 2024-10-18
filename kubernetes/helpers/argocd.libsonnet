{
  local generateHelmSource = function(releaseName, chart, repo, version, values) {
    chart: chart,
    repoURL: repo,
    targetRevision: version,
    helm: {
      releaseName: releaseName,
      valuesObject: values
    }
  },
  generateSyncWave: function(wave) {
    'argocd.argoproj.io/sync-wave': wave
  },
  ArgoApplication: {
    local application = self,
    name:: error 'Name must be specified',
    namespace:: self.name,
    source:: error 'Source must be specified',

    apiVersion: 'argoproj.io/v1alpha1',
    kind: 'Application',
    metadata: {
      name: application.name,
      namespace: 'argocd'
    },
    spec: {
      project: "default",
      destination: {
        server: "https://kubernetes.default.svc",
        namespace: application.namespace
      },
      syncPolicy: {
        automated: {
          prune: true,
          selfHeal: true,
          allowEmpty: false
        },
        syncOptions: [
          'CreateNamespace=true'
        ]
      },
      source: application.source
    }
  },
  HelmArgoApplication: self.ArgoApplication + {
    releaseName:: self.name,
    chart:: self.name,
    repo:: error 'Repo URL must be specified',
    version:: error 'Chart version must be specified',
    values:: {},
    source:: generateHelmSource(self.releaseName, self.chart, self.repo, self.version, self.values)
  }
}
