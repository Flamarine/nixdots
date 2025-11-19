{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      twemoji-color-font
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
    ];
  };
}
