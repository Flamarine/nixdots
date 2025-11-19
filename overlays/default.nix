# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    final.stdenv = prev.pkgs.overrideCC prev.pkgs.stdenv prev.pkgs.llvmPackages.clangUseLLVM;
    final.environment.variables = prev.environment.variables // {
      CFLAGS = "-O3 -march=native -mtune=native -pipe -flto=thin";
      CXXFLAGS = "-O3 -march=native -mtune=native -pipe -flto=thin";
      LDFLAGS = "-fuse-ld=lld -Wl,-O3 -Wl,--as-needed";
      RUSTFLAGS = "-C target-cpu=native";
      NIX_BUILD_CORES = "0";
      NIX_CFLAGS_COMPILE = "-O3 -march=native -mtune=native -pipe -flto=thin";
    };
  };

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
