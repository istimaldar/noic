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
}
