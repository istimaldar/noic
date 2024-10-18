{
  acme: {
    staging_url: '',
    production_url: ''
  },
  cert_manager: {
    issuer: {
      name: 'acme-cloudflare',
      staging: true,
      secret_name: 'cert-manager-cloudflare-api-token',
      secret_key: 'token',
      acme_email: 'istimaldar@gmail.com',
    }
  }

}
