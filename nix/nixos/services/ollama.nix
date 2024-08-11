{ pkgs, ... }: {
  package = pkgs.ollama;
  enable = true;
  acceleration = "rocm";
}
