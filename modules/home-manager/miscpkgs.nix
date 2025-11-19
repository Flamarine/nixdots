{ pkgs, ... }: {
  home.packages = with pkgs; [
    zen-browser
    zed-editor-fhs
    netease-cloud-music-gtk
    prismlauncher
    mpv
    qq
    vesktop
  ];
}
