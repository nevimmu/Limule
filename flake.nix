{
  description = "Limule - A keyboard for Nevimmu";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_20
            nodePackages.npm
          ];

          shellHook = ''
            echo "Limule development environment"
            echo "Node version: $(node --version)"
            echo "npm version: $(npm --version)"
            echo ""
            echo "Available commands:"
            echo "  npm run ergogen:build  - Build the keyboard layout"
            echo "  npm run ergogen:watch  - Watch for changes and rebuild"
            echo ""
            echo "Run 'npm install' to install dependencies if needed"
          '';
        };
      }
    );
}
