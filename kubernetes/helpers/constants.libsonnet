local variables = import './variables.libsonnet';
{
  email: 'istimaldar@gmail.com',
  tld: 'istimaldar.site',
  host_domain: '%s.%s' % [variables.hostname.value, $.tld],
  acme: {
    staging_url: 'https://acme-staging-v02.api.letsencrypt.org/directory',
    production_url: 'https://acme-v02.api.letsencrypt.org/directory'
  },
  cert_manager: {
    issuer: {
      name: 'acme-cloudflare',
      staging: true,
      secret_name: 'cert-manager-acme-cloudflare',
      secret_key: 'token',
      acme_email: $.email,
    }
  },
  external_dns: {
    cloudflare: {
      email: $.email,
      secret_name: 'external-dns-cloudflare'
    }
  },
  traefik: {
    ingressClassName: 'traefik'
  },
  argocd: {
    domain: 'argocd.%s' % $.host_domain
  },
  headlamp: {
    domain: 'headlamp.%s' % $.host_domain
  }
}
