_: {
  polkit = {
    enable = true;
  };

  pki.certificateFiles = [
    ../../../certificates/mitmproxy-ca-cert.pem
    ../../../certificates/rootCACert.pem
  ];
}
