{ pkgs, ... }: {
  "workbench.colorTheme" = "Nord";
  "redhat.telemetry.enabled" = true;
  "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
  "editor.fontLigatures" = true;
  "languageToolLinter.managed.classPath" = "${pkgs.languagetool}/share/languagetool-server.jar";
  "languageToolLinter.serviceType" = "managed";
  "files.autoSave" = "afterDelay";
  "files.autoSaveDelay" = "500ms";
  "window.menuBarVisibility" = "toggle";
  "terraform.languageServer.enable" = true;
  "terraform.languageServer.path" = "${pkgs.terraform-ls}/bin/terraform-ls";
  "terraform.languageServer.terraform.path" = "${pkgs.terraform}/bin/terraform";
  "git.autofetch" = true;
  "workbench.iconTheme" = "vscode-icons";
  "gitblame.inlineMessageEnabled" = true;
  "vsicons.dontShowNewVersionMessage" = true;
  "window.titleBarStyle" = "native";
  "editor.bracketPairColorization.enabled" = true;
  "editor.autoClosingBrackets" = "always";
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nil"; 
}