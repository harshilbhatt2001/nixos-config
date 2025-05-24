{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waypaper
    swaybg

    #bluez
    gpustat

    jdk17
    graphviz

    obsidian
    vscode
    #rustup
    poetry
    lazygit

    grim
    slurp
    sxiv

    distrobox

    bun
    nodejs
    nodePackages_latest.ts-node
    nodePackages.pnpm
    yarn

    nodePackages_latest.bash-language-server

    mendeley
    zlib
    cachix

    hyprlock

    nrfutil
    nrf-command-line-tools

    tio
    ollama
    zls

    #jetbrains.pycharm-professional
    #jetbrains.rust-rover
    segger-jlink

    mpv
    python2Full

    gh
    psst
    code-cursor
  ];

  nixpkgs.config.permittedInsecurePackages = [
      "segger-jlink-qt4-810"
      "python-2.7.18.8"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;
}
