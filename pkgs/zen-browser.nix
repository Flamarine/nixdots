{
  buildMozillaMach,
  buildNpmPackage,
  fetchFromGitHub,
  lib,
  fetchurl,
  git,
  pkg-config,
  python3,
  vips,
  runtimeShell,
  writeScriptBin,
}:

let
  zenVersion = "1.17.7b";
  firefoxVersion = "145.0.1";

  firefoxSrc = fetchurl {
    url = "https://archive.mozilla.org/pub/firefox/releases/${firefoxVersion}/source/firefox-${firefoxVersion}.source.tar.xz";
    hash = "sha256-tIEVvTBP8Baf78SIImyvQFPgTMKqg7Gp9KyF+6qf9Fc=";
  };

  patchedSrc = buildNpmPackage {
    pname = "firefox-zen-browser-src-patched";
    version = zenVersion;

    src = fetchFromGitHub {
      owner = "zen-browser";
      repo = "desktop";
      tag = zenVersion;
      hash = "sha256-lQwwjne+HlBwPb3zsA4SUIpX3kvrbGmDc7wSEw8gBIk=";
      fetchSubmodules = true;
    };

    postUnpack = ''
      tar xf ${firefoxSrc}
      mkdir -p source/engine
      mv firefox-${firefoxVersion} source/engine
    '';

    npmDepsHash = "sha256-e2BskX5ocxztx11QcqFyhepAseDnyve2wTB7COySQdo=";

    makeCacheWritable = true;

    nativeBuildInputs = [
      git
      python3
      pkg-config
      (writeScriptBin "sips" ''
        #!${runtimeShell}
        echo >&2 "$@"
      '')
      (writeScriptBin "iconutil" ''
        #!${runtimeShell}
        echo >&2 "$@"
      '')
    ];
    # TODO: this should be in nativeBuildInputs, since sharp is only used during build, but it doesn't seem to be
    # visible in there. why not?
    buildInputs = [
      vips
    ];

    buildPhase = ''
      npm run surfer ci --brand release --display-version ${zenVersion}
      npm run import
      python ./scripts/update_en_US_packs.py
    '';

    installPhase = ''
      cp -r engine $out

      cd $out
      for i in $(find . -type l); do
        realpath=$(readlink $i)
        rm $i
        cp $realpath $i
      done
    '';


    dontFixup = true;
  };
in
(
  (buildMozillaMach {
    pname = "zen-browser";
    packageVersion = zenVersion;
    version = firefoxVersion;
    applicationName = "Zen Browser";
    binaryName = "zen";
    branding = "browser/branding/release";
    requireSigning = false;
    allowAddonSideload = true;

    src = patchedSrc;

    extraConfigureFlags = [
      "--with-app-basename=Zen"
    ];

    meta = {
      description = "Firefox based browser with a focus on privacy and customization";
      homepage = "https://zen-browser.app/";
      downloadPage = "https://zen-browser.app/download/";
      changelog = "https://zen-browser.app/release-notes/#${zenVersion}";
      license = lib.licenses.mpl20;
      maintainers = with lib.maintainers; [
        matthewpi
        titaniumtown
        eveeifyeve
      ];
      # broken = true;
      platforms = lib.platforms.unix;
      mainProgram = "zen";
    };
  }).override
  {
    pgoSupport = false;
    crashreporterSupport = false;
    enableOfficialBranding = false;
  }
).overrideAttrs
  (prev: {
    # Remove patch in nixpkgs already applied upstream
    patches = builtins.filter (
      p: !(lib.hasInfix "firefox-mac-missing-vector-header.patch" p)
    ) prev.patches;
  })
