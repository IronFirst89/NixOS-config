# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
    config,
    lib,
    pkgs,
    xmonad-contexts,
    ...
}:

{
    imports = [
        ../system.nix
        ../app.nix

        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    networking.hostName = "IronFirst";
    networking.networkmanager.enable = true;

    # Bootloader
    boot = {
        kernelPackages = pkgs.linuxKernel.packages.linux_zen;

        loader = {
            systemd-boot.enable = true; # Pick this xor with GRUB.
            efi = {
                canTouchEfiVariables = true;
                #efiSysMountPoint = "/boot/efi"; # Make sure it's mounted.
            };
            #grub = {
            #    enable = true;
            #    device = "/dev/sda";
            #    efiSupport = true;
            #    useOSProber = true;
            #    #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work.
            #};
        };
    };

    # TODO : Configure Szurubooru.
    #services.szurubooru = {
    #    enable = true;
    #
    #    server = {
    #        port = 8080;
    #
    #        settings = {
    #            domain = "https://szurubooru.domain.tld";
    #        };
    #    };
    #};
    #services.nginx.virtualHosts."szurubooru.domain.tld" = {
    #    locations = {
    #        "/api/".proxyPass = "http://localhost:8080/";
    #        "/data/".root = config.services.szurubooru.dataDir;
    #        "/" = {
    #            root = config.services.szurubooru.client.package;
    #            tryFiles = "$uri /index.htm";
    #        };
    #    };
    #};

    services.xserver.enable = true;
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.options = "eurosign:e,caps:escape";

    services = {
        desktopManager.plasma6.enable = true;

        displayManager.sddm.wayland.enable = true;

        xserver.displayManager.startx.enable = true;
        xserver.windowManager.xmonad = {
            enable = true;
            enableContribAndExtras = true;
            config = builtins.readFile ../.config/xmonad/xmonad.hs;
            enableConfiguredRecompile = true;
            ghcArgs = [
                "-hidir /tmp"
                "-odir /tmp"
                "-i\"github:Procrat/xmonad-contexts\""
            ];
        };

        libinput.enable = true;
    };
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        oxygen
        dolphin
        kate
        elisa
        gwenview
        khelpcenter
        konsole
        plasma-browser-integration
        print-manager
    ];
    services.xserver.displayManager.sessionCommands = ''
        xset -dpms
        xset s blank
        xset s 180
        ${pkgs.lightlocker}/bin/light-locker --idle-hint &
    '';

    systemd.targets.hybrid-sleep.enable = true;
    services.logind.settings.Login.IdleAction = "hybrid-sleep";
    services.logind.settings.Login.IdleActionSec = "20s";

    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true; # Doesn't work with flakes.

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

