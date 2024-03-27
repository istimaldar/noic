self: super: let wireplumber_0_4 = super.wireplumber.overrideAttrs (attrs: rec {
    version = "0.4.17";
    src = super.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "pipewire";
      repo = "wireplumber";
      rev = version;
      hash = "sha256-vhpQT67+849WV1SFthQdUeFnYe/okudTQJoL3y+wXwI=";
    };
  }); in {
  # waybar = super.waybar.override {
  #   wireplumber = wireplumber_0_4;
  # };
}
