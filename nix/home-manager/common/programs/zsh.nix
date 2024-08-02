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
