{ pkgs, ... }: {
  dunst = import ./dnust.nix { inherit pkgs; };
  gpg-agent = import ./gpg-agent.nix { inherit pkgs; };
  megasync = import ./megasync.nix { };
}
