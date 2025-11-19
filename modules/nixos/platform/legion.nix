{ pkgs, lib, ... }: {
  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;
  boot.supportedFilesystems = [ "ext4" "btrfs" "bcachefs" ];

  /*
  environment.variables = {
    CFLAGS = "-O3 -march=native -mtune=native -pipe -flto=thin";
    CXXFLAGS = "-O3 -march=native -mtune=native -pipe -flto=thin";
    LDFLAGS = "-fuse-ld=lld -Wl,-O3 -Wl,--as-needed";
    RUSTFLAGS = "-C target-cpu=native";
    NIX_BUILD_CORES = "0";
    NIX_CFLAGS_COMPILE = "-O3 -march=native -mtune=native -pipe";
  };
  */
}
