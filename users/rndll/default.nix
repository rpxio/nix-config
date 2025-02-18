{
  config,
  inputs,
  pkgs,
  ...
}:
{
  nix.settings.trusted-users = [ "rndll" ];

  users = {
    users = {
      rndll = {
        shell = pkgs.fish;
	uid = 1000;
	isNormalUser = true;
	initialPassword = "test123";
        extraGroups = [
          "wheel"
	  "users"
	  "video"
	  "podman"
	  "input"
	];
	group = "rndll";
	openssh.authorizedKeys.keys = [
	  sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAh+2LzKiIP2gGC7YrXUyFZGmcsi0gfeCF945oAY6nAaAAAABHNzaDo= randall@rndll.io
	];
      };
    };

    groups = {
      rndll = {
        gid = 1000;
      };
    };
  };

  programs.fish.enable = true;
}
