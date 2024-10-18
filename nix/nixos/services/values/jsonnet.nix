{ ... }: {
  cert_manager__token = builtins.readFile /run/secrets/kubernetes/cert_manager/token;
}
