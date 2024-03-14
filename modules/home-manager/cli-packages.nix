{pkgs, ...}:
{
  home.packages = with pkgs; [
    ripgrep
    bat
    bottom
    btop
    unzip
    brightnessctl
    fzf
    pamixer
    clipman
    pciutils
    difftastic
    autojump
  ];
}
