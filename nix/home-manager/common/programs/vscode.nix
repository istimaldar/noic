{ pkgs, host, ... }: {
  enable = true;
  package = pkgs.vscode;
  enableExtensionUpdateCheck = false;
  enableUpdateCheck = false;
  mutableExtensionsDir = false;
  extensions = with pkgs.vscode-extensions; [
    hashicorp.terraform
    alefragnani.project-manager
    tamasfe.even-better-toml
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
    editorconfig.editorconfig
    continue.continue
    catppuccin.catppuccin-vsc-icons
    (pkgs.catppuccin-vsc.override {
      accent = "lavender";
      boldKeywords = true;
      italicComments = true;
      italicKeywords = true;
      extraBordersEnabled = false;
      workbenchMode = "default";
      bracketMode = "rainbow";
      colorOverrides = {};
      customUIColors = {};
    })
    unifiedjs.vscode-mdx
    dbaeumer.vscode-eslint
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-containers
    redhat.ansible
    tim-koehler.helm-intellisense
    vscjava.vscode-java-pack
    ms-azuretools.vscode-docker
    gitlab.gitlab-workflow
    ms-python.vscode-pylance
    aaron-bond.better-comments
    yzhang.markdown-all-in-one
    ms-vscode.powershell
    signageos.signageos-vscode-sops
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./vscode/extensions.nix { inherit pkgs host; });
  userSettings = import ./vscode/userSettings.nix { inherit pkgs host; };
}
