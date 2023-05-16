{ pkgs, host, ... }: {
  enable = true;
  package = pkgs.vscodium;
  enableExtensionUpdateCheck = false;
  enableUpdateCheck = false;
  mutableExtensionsDir = false;
  extensions =  pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./vscode/extensions.nix { inherit pkgs host; });
  userSettings = import ./vscode/userSettings.nix { inherit pkgs host; };
}