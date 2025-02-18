{ config, lib, pkgs, ... }:

{
  imports = [

  ];

  wsl.enable = true;
  wsl.defaultUser = "rndll";

  environment.systemPackages = with pkgs; [
    azure-cli
    azure-functions-core-tools
    opentofu
    tenv
    linuxPackages.usbip
  ];

  networking = {
    hostName = "nano";

    firewall.enable = false;
  };
}
