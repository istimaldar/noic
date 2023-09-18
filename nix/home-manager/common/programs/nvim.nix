{ ... }: {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  coc = {
    enable = true;
    settings = {
      languageserver = {
        nixd = {
          command = "nil";
          rootPatterns = [
            "flake.nix"
          ];
          filetypes = [
            "nix"
          ];
        };

        bash = {
          command = "bash-language-server";
          args = [
            "start"
          ];
          filetypes = [
            "sh"
          ];
        };
      };
    };
  };
}