{ inputs, lib, config, pkgs, ... }:
{
  age.secrets.gitIncludes = {
    file = "${inputs.secrets}/gitIncludes.age";
    path = "$HOME/.config/git/includes";
  };

  programs.git = {
    enable = true;

    extraConfig = {
      core = {
        sshCommand = "ssh -o 'IdentitiesOnly=yes' -i ~/.ssh/rndll";
      };
    };

    includes = [
      { # personal
        condition = "gitdir:~/dev/";
	contents.user = {
          name = "randall";
	  email = "randall@rndll.io";
	};
      }
      { # work
        condition = "gitdir:~/work/";
	contents.user = {
          name = "Randall Pace";
	  email = "randall.pace@hfa-ae.com";
	};
      }
    ];
  };
}
