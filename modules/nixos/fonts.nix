{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Inconsolata" ]; })
    powerline
    inconsolata
    inconsolata-nerdfont
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
    fira-code
    fira-code-symbols
    jetbrains-mono
  ];
}

