{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    helix
    curl
    wget
    fastfetch
    hyfetch
    bcachefs-tools
  ];
}
