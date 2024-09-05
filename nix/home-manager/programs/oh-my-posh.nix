{ ... }: {
  enable = true;
  enableZshIntegration = true;
  settings = {
    palette = {
      os = "#ACB0BE";
      closer = "p:os";
      pink = "#F5BDE6";
      lavender = "#B7BDF8";
      blue = "#8AADF4";
    };
    blocks = [
      {
        alignment = "left";
        segments = [
          {
            foreground = "p:os";
            style = "plain";
            template = "{{.Icon}} ";
            type = "os";
          }
          {
            foreground = "p:pink";
            properties = {
              folder_icon = "  ";
              home_icon = "~";
              style = "agnoster_short";
            };
            style = "plain";
            template = "{{ .Path }} ";
            type = "path";
          }
          {
            foreground = "p:lavender";
            properties = {
              branch_icon = " ";
              cherry_pick_icon = " ";
              commit_icon = " ";
              fetch_status = false;
              fetch_upstream_icon = false;
              merge_icon = " ";
              no_commits_icon = " ";
              rebase_icon = " ";
              revert_icon = " ";
              tag_icon = " ";
            };
            template = "{{ .HEAD }} ";
            style = "plain";
            type = "git";
          }
          {
            style = "plain";
            foreground = "p:closer";
            template = "";
            type = "text";
          }
        ];
        type = "prompt";
      }
    ];
    final_space = true;
    version = 2;
  };
}
