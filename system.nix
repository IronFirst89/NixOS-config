{
    pkgs,
    lib,
    username,
    ...
}: {
    # Default
    users.users.alice = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
            tree
        ];
    };

    users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [ "wheel" "networkmanager" ];
    };

    nix.settings = {
        trusted-users = [ username ];
        experimental-features = [ "nix-command" "flakes" ];
        trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    nix.gc = with lib; {
        automatic = mkDefault true;
        dates = mkDefault "weekly";
        options = mkDefault "--delete-older-than 7d";
    };

    nixpkgs.config.allowUnfree = true;

    hardware.graphics.enable = true;

    time.timeZone = "Asia/Shanghai";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
    };
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    fonts = {
        packages = with pkgs; [
            material-design-icons

            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji

            nerd-fonts.symbols-only # symbols icon only
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
            nerd-fonts.iosevka

            source-han-sans
            source-han-serif
        ];

        enableDefaultPackages = false;

        fontconfig.defaultFonts = {
            serif = [ "Noto Serif" "Source Han Serif" ];
            sansSerif = [ "Noto Sans" "Source Han Sans" ];
            monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
            emoji = [ "Noto Color Emoji" ];
        };
    };

    programs = {
        firefox.enable = true;
        dconf.enable = true;
        sway.enable = true;
    };

    networking.firewall.enable = false;

    # Enable the OpenSSH daemon.
    services.openssh = {
        enable = true;
        settings = {
            X11Forwarding = true;
        };
        openFirewall = true;
    };

    services.pulseaudio.enable = false;
    services.power-profiles-daemon = {
        enable = true;
    };

    security.polkit.enable = true;

    services = {
        dbus.packages = [pkgs.gcr];

        geoclue2.enable = true;

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };
}
