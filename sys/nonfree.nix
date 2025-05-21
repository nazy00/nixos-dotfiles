{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "signal-desktop"
      "lunarclient"
      "aseprite"
      "vscode"
      "zoom"
      "rar"
      "steam"
      "steam-run"
      "steam-unwrapped"
      "steam-original"
      "balatro"
    ];
}
