self: super: {
  catppuccin = super.catppuccin.override {
    accent = "lavender";
  };
  catppuccin-gtk = (super.catppuccin-gtk.override {
    accents = [
      "lavender"
    ];
    size = "compact";
    variant = "macchiato";
  });
  # .overrideAttrs (oldAttrs : {
  #     nativeBuildInputs = [
  #       (self.python311.withPackages (ps: [
  #         ps.catppuccin
  #       ]))
  #       self.sassc
  #       self.inkscape
  #       self.optipng
  #       self.ruff
  #       self.git
  #     ];
  # });
}
