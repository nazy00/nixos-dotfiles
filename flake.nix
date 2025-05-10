{
  description = "nazy00/nixos-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cypkgs = {
      url = "github:cybardev/nix-channel";
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
      userConfig =
        let
          nickname = "Naziya";
          username = "nazy00";
          hostname = "hostility";
          home = "/home/${username}";
        in
        {
          inherit nickname;
          inherit username;
          inherit hostname;
          inherit home;
          locale = "en_CA.UTF-8";
          timezone = "America/Halifax";
          nixos = "${home}/.config/nixos";
          system = "x86_64-linux";
        };
      moduleArgs = {
        inherit inputs;
        inherit userConfig;
      };
    in
    {
      homeConfigurations.${userConfig.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${userConfig.system};
        modules = [
          ./sys/gtk.nix
          ./sys/nonfree.nix
          ./sys/home.nix
          ./pkg/list.nix
          ./pkg/bspwm.nix
          ./pkg/picom.nix
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
