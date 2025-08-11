{ config, lib, pkgs, ... }:

{
  services.nix-daemon.enable = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false; # most recently used - rearranges dock.
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.showhidden = true;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  # Enable the unfree 1Password packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-cli"
    "terraform"
    "nomad"
    "consul"
    "vault"
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs._1password-cli
      pkgs.activemq
      pkgs.amazon-ecr-credential-helper
      # pkgs.ast-grep # doesnt alias sg? try brew instead
      pkgs.aws-iam-authenticator
      pkgs.awscli2
      pkgs.bash
      pkgs.bat
      pkgs.cmake
      pkgs.colima
      pkgs.colordiff
      pkgs.consul
      pkgs.coreutils-full
      pkgs.curl
      pkgs.docker-credential-helpers
      pkgs.dive
      pkgs.envsubst
      # pkgs.exa
      pkgs.fd
      pkgs.findutils
      pkgs.fx
      pkgs.fzf
      pkgs.gawk
      # pkgs.gcc
      pkgs.gh-ost
      pkgs.git-lfs
      pkgs.gitAndTools.gitFull
      # pkgs.gitAndTools.hub
      pkgs.glab
      pkgs.gnugrep
      pkgs.gnupg
      pkgs.gnuplot
      pkgs.gnused
      pkgs.goku
      pkgs.granted
      pkgs.graphviz
      pkgs.gron
      pkgs.htop
      pkgs.hurl
      pkgs.iperf
      pkgs.jira-cli-go
      pkgs.joker
      pkgs.jq
      pkgs.just
      pkgs.k9s
      pkgs.kcat
      pkgs.kubectl
      pkgs.kubectx
      pkgs.kubernetes-helm
      pkgs.kubeseal
      pkgs.less
      pkgs.lima
      pkgs.m-cli
      pkgs.mdbook
      # pkgs.mitmproxy
      pkgs.mosh
      pkgs.moreutils
      pkgs.mtr
      pkgs.neovim
      pkgs.nickel
      pkgs.nodePackages.prettier
      pkgs.nodejs
      pkgs.nomad
      pkgs.openssh
      pkgs.pandoc
      pkgs.pass
      pkgs.procps
      pkgs.proselint
      pkgs.python3
      pkgs.redis
      pkgs.ripgrep
      pkgs.rsync
      pkgs.s3cmd
      pkgs.s4cmd
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.skaffold
      pkgs.socat
      pkgs.speedtest-cli
      pkgs.sqlite
      pkgs.stern
      pkgs.taplo
      pkgs.tcpdump
      pkgs.teleport
      pkgs.telepresence2
      pkgs.terraform
      pkgs.tilt
      pkgs.tldr
      pkgs.topiary
      pkgs.tree
      pkgs.unixtools.watch
      pkgs.uv
      pkgs.vault
      pkgs.vim
      pkgs.watchexec
      pkgs.wget
      pkgs.yq
      pkgs.zsh
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/pkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/pkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.bash.enable = true;
  # programs.zsh.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.settings.max-jobs = 10;
  nix.settings.cores = 10;
}
