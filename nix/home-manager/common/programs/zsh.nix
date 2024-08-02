{ ... }: {
  enable = true;
  syntaxHighlighting = {
    enable = true;
  };
  autosuggestion = {
    enable = true;
  };
  historySubstringSearch = {
    enable = true;
    searchUpKey = [
      "^[[A"
      "$terminfo[kcuu1]"
    ];
    searchDownKey = [
      "^[[B"
      "$terminfo[kcud1]"
    ];
  };
  enableCompletion = true;
  initExtra = ''
  source ~/.p10k.zsh
  '';
  prezto = {
    enable = true;
    prompt.theme = "powerlevel10k";
  };
}
