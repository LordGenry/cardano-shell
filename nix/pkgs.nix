{ pkgs ? import <nixpkgs> {}
}:
let
  overrideWith = override: default:
   let
     try = builtins.tryEval (builtins.findFile builtins.nixPath override);
   in if try.success then
     builtins.trace "using search host <${override}>" try.value
   else
     default;
in
let
  # all packages from hackage as nix expressions
  hackage = import (overrideWith "hackage"
                    (pkgs.fetchFromGitHub { owner  = "angerman";
                                            repo   = "hackage.nix";
                                            rev    = "d8e03ec0e3c99903d970406ae5bceac7d993035d";
                                            sha256 = "0c7camspw7v5bg23hcas0r10c40fnwwwmz0adsjpsxgdjxayws3v";
                                            name   = "hackage-exprs-source"; }))
                   ;
  # a different haskell infrastructure
  haskell = import (overrideWith "haskell"
                    (pkgs.fetchFromGitHub { owner  = "angerman";
                                            repo   = "haskell.nix";
                                            rev    = "03026b7bb95a6713f4d50b841abadabb343f83d2";
                                            sha256 = "05ma2qmmn4p2xcgyy8waissfj953b7wyq97yx80d936074gyyw4s";
                                            name   = "haskell-lib-source"; }))
                   hackage;

  # the set of all stackage snapshots
  stackage = import (overrideWith "stackage"
                     (pkgs.fetchFromGitHub { owner  = "angerman";
                                             repo   = "stackage.nix";
                                             rev    = "67675ea78ae5c321ed0b8327040addecc743a96c";
                                             sha256 = "1ds2xfsnkm2byg8js6c9032nvfwmbx7lgcsndjgkhgq56bmw5wap";
                                             name   = "stackage-snapshot-source"; }))
                   ;

  # our packages
  stack-pkgs = import ./.stack-pkgs.nix;

  # Build the packageset with module support.
  # We can essentially override anything in the modules
  # section.
  #
  #  packages.cbors.patches = [ ./one.patch ];
  #  packages.cbors.flags.optimize-gmp = false;
  #
  pkgSet = haskell.mkNewPkgSet {
    inherit pkgs;
    pkg-def = stackage.${stack-pkgs.resolver};
    pkg-def-overlays = [
      stack-pkgs.overlay
    ];
    modules = [
    ];
  };

  packages = pkgSet.config.hsPkgs // { _config = pkgSet.config; };

in packages
