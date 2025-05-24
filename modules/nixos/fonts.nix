{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    powerline
    nerd-fonts.inconsolata
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
    fira-code
    fira-code-symbols
    jetbrains-mono
  ];
}

