{pkgs, ...}:
{
  home.packages = with pkgs; [
    gnomeExtensions.espresso
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock

    (jetbrains.plugins.addPlugins jetbrains.rust-rover ["github-copilot"])

    # Frontend for swww
    waypaper

    eww

    jdk17
    graphviz
  ];
}
