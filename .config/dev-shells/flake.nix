{
  description = "Multi dev environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };
    in
    {
      devShells.${system} = {
        go = pkgs.mkShell {
          packages = with pkgs; [
            go
            gopls
            git
            docker
            docker-compose
          ];
        };

        node = pkgs.mkShell {
          packages = [
            pkgs.nodejs
            pkgs.pnpm
            pkgs.typescript-language-server
          ];
        };

        blog = pkgs.mkShell {
          packages = with pkgs; [
            zola
            nodejs
            pnpm
          ];
        };

        devops = pkgs.mkShell {
          packages = [
            pkgs.terraform
            pkgs.terragrunt
            pkgs.terraform-ls # LSP (optional)
            pkgs.kubernetes-helm
          ];
        };

        python = pkgs.mkShell {
          packages = [
            pkgs.python3
          ];
          shellHook = ''
            exec zsh
          '';
        };

        fvm = pkgs.mkShell {
          packages = [
            pkgs.clang
            pkgs.cmake
            pkgs.ninja
            pkgs.pkg-config
            pkgs.unzip
            pkgs.fvm
            pkgs.jdk17
            # pkgs.androidsdk
          ];
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk17}
            export ORG_GRADLE_JAVA_INSTALLATIONS_PATHS=$JAVA_HOME
            export ORG_GRADLE_JAVA_INSTALLATIONS_AUTO_DETECT=false
            exec zsh
          '';
        };
      };
    };
}
