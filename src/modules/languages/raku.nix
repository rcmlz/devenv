{ pkgs, config, lib, ... }:

let
  cfg = config.languages.raku;
in
{
  options.languages.raku = {
    enable = lib.mkEnableOption "tools for Raku development";
  };

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      rakudo
      zef
    ];

    # Fix this frequent errors when installing modules via zef:
    # Cannot locate native library 'libreadline.so' and 'libssl.so'
    env.LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${lib.makeLibraryPath [ 
      pkgs.readline
      pkgs.openssl
    ]}";

    env.ZEF_FETCH_DEGREE = 4;
    env.ZEF_TEST_DEGREE = 4;
  };
}
