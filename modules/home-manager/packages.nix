{pkgs, ...}:
{
  home.packages = with pkgs; [
    gnomeExtensions.espresso
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock

    (jetbrains.plugins.addPlugins jetbrains.rust-rover ["github-copilot"])

    waypaper
    swaybg
    eww

    jdk17
    graphviz

    obsidian
    #jtbrains.rust-rover
    vscode
    spotify

    grim
    slurp
    sxiv
  ];
}
