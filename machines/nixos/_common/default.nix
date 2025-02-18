{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = "24.05";
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos\\?submodules=1";
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "Sat *-*-* 06:00:00";
    randomizedDelaySec = "45min";
    allowReboot = true;
  };

  imports = [
    ./nix
  ];

  time.timeZone = "US/Chicago";

  services.openssh = {
    enable = lib.mkDefault true;
  };

  programs.git.enable = true;
  programs.fish.enable = true;
  programs.htop.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
  
  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    iperf
    eza
    fastfetch
    (python312.withPackages (ps: with ps; [ pip ]))
    tmux
    rsync
    iotop
    ncdu
    lm_sensors
    nmap
    jq
    jc
    ripgrep
    inputs.agenix.packages."${system}".default
    lsof
    fatrace
    git-crypt
    bfg-repo-cleaner
  ];
}
