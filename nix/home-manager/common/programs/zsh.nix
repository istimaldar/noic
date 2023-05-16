{ ... }: {
  enable = true;
  enableSyntaxHighlighting = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  initExtra = ''
  source ~/.p10k.zsh
  '';
  prezto = {
    enable = true;
    prompt.theme = "powerlevel10k";
  };
}