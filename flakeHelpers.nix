inputs:
let
  homeManagerCfg = userPackages: extraImports: {
    home-manager.useGlobalPkgs = false;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };
    home-manager.users.rndll.imports = [
      inputs.agenix.homeManagerModules.default
      ./users/rndll/dots.nix
      ./users/rndll/age.nix
    ];
    home-manager.backupFileExtension = "bak";
    home-manager.useUserPackages = userPackages;
  };
in
{
  mkNixos = machineHostname: nixpkgsVersion: extraModules: rec {
    deploy.nodes.${machineHostname} = {
      hostname = machineHostname;
      profiles.system = {
        user = "root";
	sshUser = "rndll";
	path = inputs.deploy-rs.lib.x86-64-linux.activate.nixos nixosConfigurations.${machineHostname};
      };
    };
    nixosConfigurations.${machineHostname} = nixpkgsVersion.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
	vars = import ./machines/nixos/vars.nix;
      };
      modules = [
        ./machines/nixos/_common
	./machines/nixos/${machineHostname}
	"${inputs.secrets}/default.nix"
	inputs.agenix.nixosModules.default
	./users/rndll
	(homeManagerCfg false [ ])
      ] ++ extraModules;
    };
  };
  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) { };
}
