{ mkDerivation, async, base, cardano-prelude, stdenv }:
mkDerivation {
  pname = "cardano-shell";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ async base cardano-prelude ];
  executableHaskellDepends = [ base cardano-prelude ];
  testHaskellDepends = [ base cardano-prelude ];
  homepage = "https://github.com/input-output-hk/cardano-shell#readme";
  license = stdenv.lib.licenses.mit;
}