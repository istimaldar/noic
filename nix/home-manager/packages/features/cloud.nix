{ pkgs, gcloud, ... }: with pkgs; [
  awscli2
  rclone
  storj-uplink
  doctl
  gcloud

  ansible
  ansible-lint
  molecule
  terraform-ls
  terraform
  vagrant
  operator-sdk
]
