{ ... }:
let
  home = {
    username = "rndll";
    homeDirectory = "/home/rndll";
  };
in
{
  home = home;

  imports = [
    ./gitconfig.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
