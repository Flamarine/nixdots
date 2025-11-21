final: prev: {
  final.stdenv = prev.stdenvAdapters.impureUseNativeOptimizations (prev.stdenvAdapters.addAttrsToDerivation {
    env.CFLAGS = "-O3 -mtune=native -pipe -flto=thin";
    env.CXXFLAGS = "-O3 -mtune=native -pipe -flto=thin";
    env.LDFLAGS = "-Wl,-O3 -Wl,--as-needed";
    env.RUSTFLAGS = "-C target-cpu=native";
    env.NIX_BUILD_CORES = "0";
    env.NIX_CFLAGS_LINK = "-Wl,-O3 -Wl,--as-needed";
    env.NIX_CFLAGS_COMPILE = "-O3 -mtune=native -pipe -flto=thin";
    env.MOLD_JOBS = "1";
  } prev.stdenv);
}
