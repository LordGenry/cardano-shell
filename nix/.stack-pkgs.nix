{
  overlay = hackage:
    {
      packages = {
        "aeson-options" = hackage.aeson-options."0.0.0".revisions.default;
        "base58-bytestring" = hackage.base58-bytestring."0.1.0".revisions.default;
        "canonical-json" = hackage.canonical-json."0.5.0.1".revisions.default;
        "half" = hackage.half."0.2.2.3".revisions.default;
        "micro-recursion-schemes" = hackage.micro-recursion-schemes."5.0.2.2".revisions.default;
        "streaming-binary" = hackage.streaming-binary."0.3.0.1".revisions.default;
        "katip" = hackage.katip."0.6.3.0".revisions."55de9e007352cf3fb9de8de8b9ac17c1070824e07e6f6d5b676f9f3cff44d23c";
      } // {
        cardano-shell = ./.stack.nix/cardano-shell.nix;
        cardano-prelude = ./.stack.nix/cardano-prelude.nix;
        cardano-prelude-test = ./.stack.nix/cardano-prelude-test.nix;
        cborg = ./.stack.nix/cborg.nix;
        cardano-crypto = ./.stack.nix/cardano-crypto.nix;
        plutus-prototype = ./.stack.nix/plutus-prototype.nix;
        hedgehog = ./.stack.nix/hedgehog.nix;
      };
      compiler.version = "8.4.4";
      compiler.nix-name = "ghc844";
    };
  resolver = "lts-12.10";
  compiler = "ghc-8.4.4";
}
