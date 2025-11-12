{ pkgs, config, userConfig, ... }:
let
  nixConfigDir = userConfig.nixos;
in
{
  # zshrc
  programs.zsh = {
    dotDir = "${config.xdg.configHome}/zsh";
    enable = true;
    autocd = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    autosuggestion.enable = true;
    autosuggestion.strategy = [
      "history"
      "completion"
      "match_prev_cmd"
    ];
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history = {
      save = 1024;
      size = 2048;
      share = true;
      append = true;
      ignoreAllDups = true;
      path = "$ZDOTDIR/history";
    };
    initContent = ''
      path+=( "$(go env GOPATH)/bin" "$HOME/.local/bin" )
      cutefetch -m bunny

      fpath+="${pkgs.cy.zen-zsh}"
      autoload -Uz promptinit
      promptinit
      prompt zen
    '';
    shellAliases = {
      # shell conveniences
      x = "exit";
      clr = "clear";
      cls = "clear";
      cat = "bat -pp";
      icat = "kitten icat";
      ls = "eza -1 --icons=never";
      ll = "eza -1l";
      lessr = "less -R";
      tree = "eza --tree";
      py = "ptpython";
      yt = "ytgo -i -m -p";
      cf = "cutefetch";
      tf = "cutefetch -m text";
      cd-os = "cd ~/.config/nixos";

      # editing related
      edit = "nvim";
      edit-vim = "(cd ${nixConfigDir}/cfg/nvim && nvim)";
      edit-wm = "nvim ${nixConfigDir}/pkg/bspwm.nix";
      edit-os = "nvim ${nixConfigDir}";

      # reloading configs
      zrc = ". $ZDOTDIR/.zshrc";
      re-hm = "home-manager switch --flake ${nixConfigDir}";
      re-nix = "sudo -H nixos-rebuild switch --flake ${nixConfigDir}";

      # package management
      yin = "nix-shell -p";
      yang = "nix-search";
      wuji = "nix-collect-garbage -d && sudo -H nix-collect-garbage -d";
      yup = "nix flake update --flake ${nixConfigDir} && re-nix";

      # misc
      unly = "f() { curl -Is '$1' | grep ^location | cut -d ' ' -f 2 }; f";
      etch = "f() { sudo dd bs=4M if=$2 of=/dev/$1 status=progress oflag=sync }; f";
    };
  };
}
