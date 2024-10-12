{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.espresso
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock

    #(jetbrains.plugins.addPlugins jetbrains.rust-rover [ "github-copilot" ])

    waypaper
    swaybg

    jdk17
    graphviz

    obsidian
    #jtbrains.rust-rover
    vscode
    rustup
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

    #android-studio
    #displaylink

    mendeley
    zlib
    cachix

    hyprlock

    cursor
    nrf-command-line-tools

    radvd
  ];

  nixpkgs.config.permittedInsecurePackages = [
      "segger-jlink-qt4-796s"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;
}
