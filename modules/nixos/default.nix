# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  clash = import ./clash.nix;
  fonts = import ./fonts.nix;
  gdm = import ./gdm.nix;
  plasma = import ./plasma.nix;
  miscpkgs = import ./miscpkgs.nix;

  platform = import ./platform;
}
