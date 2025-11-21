{ pkgs, ... }: {
  programs.clash-verge = {
    enable = true;
    # package = pkgs.clash-nyanpasu;
    tunMode = true;
    serviceMode = true;
  };
}
