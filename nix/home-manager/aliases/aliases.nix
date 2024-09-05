{ ... }: {
  vpna5 = "openvpn3 session-start --config $HOME/.openvpn/a5labs.ovpn";
  vpnka = "openvpn3 session-start --config $HOME/.openvpn/kashxa.ovpn";
  vpnno = "openvpn3 sessions-list | grep Path | awk '{ print $2 }' | xargs -I{} openvpn3 session-manage -D --session-path {}";
}
