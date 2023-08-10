{ pkgs, host, ... }: {
  enable = true;
  package = pkgs.vscodium;
  enableExtensionUpdateCheck = false;
  enableUpdateCheck = false;
  mutableExtensionsDir = false;
  extensions = with pkgs.vscode-extensions; [
    hashicorp.terraform
    alefragnani.project-manager
    arcticicestudio.nord-visual-studio-code
    bungcip.better-toml
    christian-kohler.path-intellisense
    davidlday.languagetool-linter
    donjayamanne.githistory
    eamodio.gitlens
    foxundermoon.shell-format
    gruntfuggly.todo-tree
    jnoortheen.nix-ide
    kamikillerto.vscode-colorize
    matthewpi.caddyfile-support
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-python.python
    ms-vscode.makefile-tools
    oderwat.indent-rainbow
    redhat.vscode-yaml
    usernamehw.errorlens
    vscode-icons-team.vscode-icons
    waderyan.gitblame
    wix.vscode-import-cost
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./vscode/extensions.nix { inherit pkgs host; });
  userSettings = import ./vscode/userSettings.nix { inherit pkgs host; };
}
