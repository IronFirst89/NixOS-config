{
    pkgs,
    ...
}: {
    programs = {
        git.settings.user = {
            name = "IronFirst89";
            email = "pizza4dogncat@gmail.com";
        };

        # Let Home Manager install and manage itself.
        home-manager.enable = true;
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
        username = "IronFirst";
        homeDirectory = "/home/IronFirst";

        # This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new Home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update Home Manager without changing this value. See
        # the Home Manager release notes for a list of state version
        # changes in each release.
        stateVersion = "25.11";
    };
}
