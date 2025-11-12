{
  pkgs,
  userConfig,
  ...
}:
let
  homeDir = userConfig.home;
  marketplaceExt = with pkgs.vscode-marketplace; [
    # add VS Code Marketplace extensions (pre-release)
    zhuangtongfa.material-theme
    vscodevim.vim
    tomoki1207.pdf
    adpyke.codesnap
    ms-python.python
    jnoortheen.nix-ide
    charliermarsh.ruff
    ms-vscode.live-server
    espressif.esp-idf-extension
    ms-azuretools.vscode-docker
    github.vscode-github-actions
    github.vscode-pull-request-github
    amazonwebservices.amazon-q-vscode
  ];
  marketplaceReleaseExt = with pkgs.vscode-marketplace-release; [
    # add VS Code Marketplace extensions (release)
    eamodio.gitlens
  ];
in
{
  programs.vscode = {
    enable = false;
    # package = pkgs.vscodium;
    profiles.default = {
      extensions = marketplaceReleaseExt ++ marketplaceExt;
      userSettings = {
        "editor.fontFamily" = "'CaskaydiaCove Nerd Font', Menlo, Monaco, 'Courier New', monospace";
        "editor.formatOnSave" = true;
        "explorer.sortOrder" = "type";
        "files.autoSave" = "afterDelay";
        "git.allowForcePush" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "idf.espIdfPath" = "${homeDir}/Documents/Git/esp/v5.4/esp-idf";
        "idf.gitPath" = "git";
        "idf.hasWalkthroughBeenShown" = true;
        "idf.pythonInstallPath" = "/usr/bin/python3";
        "idf.toolsPath" = "${homeDir}/Documents/Git/esp/.espressif";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "python.languageServer" = "Jedi";
        "vim.smartRelativeLine" = true;
        "update.showReleaseNotes" = false;
        "workbench.colorTheme" = "One Dark Pro Night Flat";
      };
    };
  };
}
