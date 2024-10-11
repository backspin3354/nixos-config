{
  description = "My personal NixOS configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      hosts = (builtins.attrNames (builtins.readDir ./hosts));
      users = (builtins.attrNames (builtins.readDir ./home/users));
    in
    {
      # Generate a system configuration for every configuration in `./hosts`.
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (
          host:
          let
            hostname = "nixos-${host}";
          in
          {
            name = hostname;
            value = nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                ./.
                ./hosts/${host}
                {
                  networking.hostName = hostname;
                }
                {
                  # Generate a NixOS user for every configuration in `./home/users`.
                  users.users = builtins.listToAttrs (
                    builtins.map (user: {
                      name = user;
                      value = {
                        isNormalUser = true;
                        description = user;
                        extraGroups = [
                          "networkmanager"
                          "wheel"
                        ];
                      };
                    }) users
                  );
                }
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;

                    # Generate the `home-manager` configurations for every configuration in `./home/users`.
                    users = builtins.listToAttrs (
                      builtins.map (user: {
                        name = user;
                        value = {
                          imports = [ ./home/users/${user} ];
                          home = {
                            username = user;
                            homeDirectory = "/home/${user}";
                            stateVersion = "24.05";
                          };
                          programs.home-manager.enable = true;
                          systemd.user.startServices = "sd-switch";
                        };
                      }) users
                    );

                    # Give the `home-manager` configurations access to `inputs` as well as additional variables.
                    extraSpecialArgs = inputs // {
                      inherit system host;
                    };
                  };
                }
              ];
            };
          }
        ) hosts
      );

      # Set a formatter for `nix fmt`.
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
