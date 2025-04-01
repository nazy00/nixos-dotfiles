{
  pkgs,
  inputs,
  ...
}:
let
  cypkgs = import inputs.cypkgs { inherit pkgs; };
in
{
  home = {
    packages =
      (with cypkgs; [
        cutefetch
        ytgo
      ])
      ++ (with pkgs; [
        gnome-mahjongg
        signal-desktop
        lunar-client
        imagemagick
        visidata
        inkscape
        aseprite
        shotcut
        cmatrix
        zoom-us
        logseq
        thonny
        krita
        gimp

        # >---< DO NOT REMOVE >---< #
        nixfmt-rfc-style
        nix-search-cli
        xorg.xdpyinfo
        nerdfonts
        lunarvim
        dfu-util
        openssl
        poppler
        luajit
        docker
        ccache
        p7zip
        cmake
        ninja
        unzip
        rustc
        brave
        nixd
        wget
        unar
        feh
        go
      ])
      ++ (with pkgs.python3Packages; [
        ptpython
      ])
      ++ (with pkgs.luajitPackages; [
        luarocks
      ]);

    file = {
      # Custom Kitty Icon
      # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
      ".config/kitty/kitty.app.png".source = ../cfg/kitty.png;
      ".config/lvim" = {
        source = ../cfg/lvim;
        recursive = true;
      };
      ".config/eww" = {
        source = ../cfg/eww;
        recursive = true;
      };
      ".config/ptpython/config.py".source = ../cfg/ptpython.py;
    };

    # environment variables
    sessionVariables = {
      EDITOR = "lvim";
      PTPYTHON_CONFIG_HOME = "$HOME/.config/ptpython/";
    };
  };
}
