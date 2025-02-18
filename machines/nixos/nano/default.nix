{ config, lib, pkgs, ... }:

{
  imports = [

  ];

  wsl.enable = true;
  wsl.defaultUser = "rndll";

  environment.systemPackages = [
    pkgs.linuxPackages.usbip
  ];

  networking = {
    hostName = "nano";

    firewall.enable = false;
  };
}
