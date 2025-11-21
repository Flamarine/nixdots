{ pkgs, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        kdePackages.fcitx5-chinese-addons
      ];
      waylandFrontend = true;
    };
  };
}
