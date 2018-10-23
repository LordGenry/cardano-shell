# cardano-shell

This is the `cardano-shell` project.
This project uses Github issues for tracking the project progress.

## About

This "node shell" is a thin layer of functionality surrounding the node.
It's a thin layer which brings all the other modules working together and makes sure that they have the required resources (configuration, exception handling, monitoring, logging, ...).

![cardano-shell](https://user-images.githubusercontent.com/6264437/47286557-70baf200-d5ef-11e8-8fe7-8584a9d6ae44.jpg)

From the top level, the "node shell" contains some of the following:
- startup initialization
- configuration loading
- process monitoring

Some of it responsibilities are the cross-cutting concerns like:
- logging
- monitoring
- configuration
- exception handling
- launcher (it's related to startup, but we need to simplify it if possible)

![cardano-shell-responsibilities](https://user-images.githubusercontent.com/6264437/47286789-736a1700-d5f0-11e8-9056-514101b237f0.jpg)

For example, we can see some of the modules `cardano-shell` integrates with:
- network layer
- blockchain layer
- ledger layer
- logging layer
- monitoring layer
- wallet (backend) layer

![cardano-shell-integration](https://user-images.githubusercontent.com/6264437/47286815-88df4100-d5f0-11e8-92a7-c807b6d3b47a.jpg)


Any module that requires a substantial amount of logging or monitoring, should provide such resources iself.
For example, 1 thread per module should be enough from the point of view of `cardano-shell`.
If, for example, `network` module requires 5 threads, it should provide such resources itself.

For serving the module functionality, we can use `withAsync` for top-leve calls which is resource/exception safe.
The option left for discussion is whether we should have a need for a restart on a module/process.

## Example

For example, we can get a chain generator to try to integrate with logging output and `cardano-shell` should be a piece of code that glues them together, providing a very simple (random) chain generation and it's output.
We need to remove a lot of things that are there in the old version. For example, the Servant API.

## People

Core seems to be split into:
- blockchain
- ledger

Currently, the (relevant) team structure seems to be:
- networking    - Duncan
- core          - Eric
- logging       - Alexander (squad 3)
- monitoring    - Alexander (squad 3)

## Building

You can build the project using Stack or Nix.

### Stack

```
stack build --fast
```

### Stack + Nix

```
stack build --fast --nix
```

Or enable the option for nix building in your local configuration for Stack.

### Cabal + Nix

There is an option of using just Cabal + Nix as well:
```
nix-shell ./scripts/nix/stack-shell.nix --run "cabal new-build"
```

Or use a small utility script that does the same as the command above (watch out, it's a dot before the `cabal`!) and work as you would usually if you develop with cabal:
```
./cabal new-build
```




