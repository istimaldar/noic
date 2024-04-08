self: super: {
  catppuccin = super.catppuccin.override {
    accent = "lavender";
  };
  catppuccin-gtk = super.catppuccin-gtk.override {
    accents = [
      "lavender"
    ];
    size = "compact";
    variant = "macchiato";
  };
}
