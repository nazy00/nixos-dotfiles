{
  description = "nazy00/nixos-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cypkgs = {
      url = "github:cybardev/nix-channel?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      userConfig = {
        nickname = "Naziya";
        username = "nazy00";
        hostname = "hostility";
        locale = "en_CA.UTF-8";
        timezone = "America/Halifax";
        nixos = "~/.config/nixos";
        system = "x86_64-linux";
      };
      genArgs =
        { host, ... }@extraArgs:
        {
          inherit inputs;
          inherit extraArgs;
          inherit userConfig;
          hostName = host;
        };
      moduleArgs = genArgs {
        host = userConfig.hostname;
        home = "/home/${userConfig.username}";
      };
    in
    {
      homeConfigurations.${userConfig.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${userConfig.system};
        modules = [
          ./sys/nonfree.nix
          ./sys/home.nix
          ./pkg/list.nix
          ./pkg/bspwm.nix
          ./pkg/zsh.nix
          ./pkg/yazi.nix
          ./pkg/vscode.nix
        ];
        extraSpecialArgs = moduleArgs;
      };

      nixosConfigurations.${userConfig.hostname} = nixpkgs.lib.nixosSystem {
        modules = [
          ./sys/nonfree.nix
          ./sys/configuration.nix
          ./sys/hardware-configuration.nix
          ./pkg/steam.nix
        ];
        specialArgs = moduleArgs;
      };
    };
}
