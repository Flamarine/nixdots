{ pkgs, ... }: {
  home.packages = with pkgs; [
    # zen-browser
    firefox
    zed-editor-fhs
    netease-cloud-music-gtk
    prismlauncher
    mpv
    qq
    vesktop
  ];
}
