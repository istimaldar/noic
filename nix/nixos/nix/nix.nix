{ ... }: {
  extraOptions = ''
  experimental-features = nix-command flakes
  min-free = ${toString (10 * 1024 * 1024 * 1024)}
  max-free = ${toString (25 * 1024 * 1024 * 1024)}
  '';
  gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };
  settings = {
    auto-optimise-store = true;
  };
}
