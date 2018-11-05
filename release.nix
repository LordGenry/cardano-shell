with import ./default.nix {};
{ cardano-shell-execs = cardano-shell.components.exes;
  cardano-shell-tests = cardano-shell.components.tests;
  cardano-shell       = cardano-shell.components.library;
}
