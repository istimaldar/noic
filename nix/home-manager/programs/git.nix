_: {
  enable = true;
  lfs.enable = true;
  signing = {
    key = "istimaldar@gmail.com";
    signByDefault = true;
  };
  userName = "istimaldar";
  userEmail = "istimaldar@gmail.com";
  extraConfig = {
    core.sshCommand = "ssh -i ~/.ssh/git/istimaldar";
  };
  includes = [
    {
      condition = "gitdir:~/code/centaurea/";
      contents = {
        user = {
          name = "Kanstancin Fedarcou";
          email = "kf@centaurea.io";
          signingKey = "kf@centaurea.io";
        };
        core.sshCommand = "ssh -i ~/.ssh/git/centaurea";
      };
    }
    {
      condition = "gitdir:~/code/binkki/";
      contents = {
        core.sshCommand = "ssh -i ~/.ssh/git/binkki";
      };
    }
    {
      condition = "gitdir:~/code/a5labs/";
      contents = {
        user = {
          name = "Kanstancin Fedarcou";
          email = "konstantin.fedortsov@a5labs.co";
          signingKey = "konstantin.fedortsov@a5labs.co";
        };
        core.sshCommand = "ssh -i ~/.ssh/git/a5labs";
        url = {
          "git@bitbucket.org:a5-labs/".insteadOf = "https://bitbucket.org/a5-labs/";
        };
      };
    }
    {
      condition = "gitdir:~/code/kashxa/";
      contents = {
        user = {
          name = "DevOps Engineer (K)";
          email = "devops@kashxa.com";
          signingKey = "devops@kashxa.com";
        };
        core.sshCommand = "ssh -i ~/.ssh/git/kashxa";
      };
    }
    {
      condition = "gitdir:~/code/centaurea_infra/";
      contents = {
        user = {
          name = "Centaurea Dev";
          email = "dev@centaurea.io";
          signingKey = "dev@centaurea.io";
        };
        core.sshCommand = "ssh -i ~/.ssh/git/centaurea_dev";
      };
    }
  ];
}
