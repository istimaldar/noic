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
              fetch_status = true;
              fetch_upstream_icon = true;
              merge_icon = " ";
              no_commits_icon = " ";
              rebase_icon = " ";
              revert_icon = " ";
              tag_icon = " ";
            };
            template = "{{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }}";
            style = "plain";
            type = "git";
          }
          {
            type = "kubectl";
            style = "plain";
            foreground = "p:pink";
            template = " 󱃾 {{.Context}}";
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
    transient_prompt = {
      background = "transparent";
      foreground = "p:closer";
      template = "";
    };
    final_space = true;
    version = 2;
  };
}
