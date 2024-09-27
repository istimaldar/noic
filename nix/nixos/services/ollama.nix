{ mpkgs, ... }: {
  package = mpkgs.ollama;
  enable = true;
  acceleration = "rocm";
}
