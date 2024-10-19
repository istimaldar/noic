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
  stable.vagrant # TODO: Remove once it's fixed in unstable
  operator-sdk
]
