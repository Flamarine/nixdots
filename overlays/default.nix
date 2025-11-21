# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  clang-stdenv = final: prev: {
    final.stdenv = prev.pkgs.clangStdenv;
  };

  mold-linker = final: prev: {
    final.stdenv = prev.stdenvAdapters.useMoldLinker prev.stdenv;
  };

  fix-aclhash = final: prev: {
    final.pkgs.acl = prev.pkgs.acl-hashfix;
  };

  legion-flags = import ./platform/legion.nix;

  /*
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  */
}
