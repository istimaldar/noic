{ pkgs, ... }: with pkgs; (python312.withPackages(ps: with ps; [
  virtualenv
  python-lsp-server
  jupyter-core
  ipykernel
  notebook
]))
