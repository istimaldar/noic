{
  email: 'istimaldar@gmail.com',
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
  }
}
