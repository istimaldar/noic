{
  cert_manager: {
    token: {
      name: 'cert_manager__token',
      value: std.extVar(self.token_variable)
    }
  }
}
