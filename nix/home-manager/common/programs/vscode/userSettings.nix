{ pkgs, ... }: {
  "workbench.colorTheme" = "Nord";
  "redhat.telemetry.enabled" = true;
  "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
  "editor.fontLigatures" = true;
  "languageToolLinter.managed.classPath" = "/home/istimaldar/.nix-profile/share/languagetool-server.jar";
  "languageToolLinter.serviceType" = "managed";
  "files.autoSave" = "afterDelay";
  "files.autoSaveDelay" = "500ms";
  "window.menuBarVisibility" = "toggle";
  "terraform.languageServer.enable" = true;
  "terraform.languageServer.path" = "${pkgs.terraform-ls}/bin/terraform-ls";
  "terraform.languageServer.terraform.path" = "${pkgs.terraform}/bin/terraform";
  "git.autofetch" = true;
}