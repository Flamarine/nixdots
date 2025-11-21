final: prev: {
  final.stdenv = prev.stdenvAdapters.addAttrsToDerivation {
    env.CFLAGS = "-O3 -march=native -mtune=native -pipe -flto=thin";
    env.CXXFLAGS = "-O3 -march=native -mtune=native -pipe -flto=thin";
    env.LDFLAGS = "-fuse-ld=mold -Wl,-O3 -Wl,--as-needed";
    env.RUSTFLAGS = "-C target-cpu=native";
    env.NIX_BUILD_CORES = "0";
    env.NIX_CFLAGS_LINK = "-fuse-ld=mold -Wl,-O3 -Wl,--as-needed";
    env.NIX_CFLAGS_COMPILE = "-O3 -march=native -mtune=native -pipe -flto=thin";
  } prev.stdenv;
};
