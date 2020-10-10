# A survey of software related to the Gemini protocol

> This repository can be moved to nix-community when they migrate away from microsoft code hosting.

This is a collection of Nix packages, either picked from the main Nixpkgs repository or locally hosted. Please submit a patch if you wish to add packages in either form.

Requires Nix with flakes supported and enabled.

=> https://www.tweag.io/posts/2020-05-25-flakes.html

To add this collection to your local Nix flake registry:
```
nix registry add gemini git+https://git.sr.ht/~ehmry/gemini-flake
```

To list the contents of this collection:
```
nix flake show gemini
```

To run one of the packages:
```
nix run gemini#kristall
```
