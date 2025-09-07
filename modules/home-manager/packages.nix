{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gpustat

    jdk17
    graphviz

    obsidian
    vscode
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

    zlib
    cachix

    nrfutil
    nrf-command-line-tools

    tio
    ollama
    zls

    segger-jlink

    mpv

    gh
    psst

    rquickshare
    chromium

    zathura
    hypridle
    geoclue2
  ];

  nixpkgs.config.permittedInsecurePackages = [
      "segger-jlink-qt4-810"
      "python-2.7.18.8"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;
}
