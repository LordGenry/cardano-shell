{ mkDerivation, aeson, base, cardano-prelude, concurrency
, contravariant, dejafu, dhall, directory, ekg, ekg-core
, formatting, hspec, hspec-contrib, hunit-dejafu, katip, QuickCheck
, safe-exceptions, stdenv, text, transformers
}:
mkDerivation {
  pname = "cardano-shell";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base cardano-prelude concurrency contravariant dhall
    directory ekg ekg-core formatting katip QuickCheck safe-exceptions
    text transformers
  ];
  executableHaskellDepends = [ base cardano-prelude ];
  testHaskellDepends = [
    base cardano-prelude concurrency dejafu dhall hspec hspec-contrib
    hunit-dejafu QuickCheck
  ];
  homepage = "https://github.com/input-output-hk/cardano-shell#readme";
  license = stdenv.lib.licenses.mit;
}
