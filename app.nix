{
    pkgs,
    lib,
    ...
}: {
    environment.systemPackages = with pkgs; [
        vscode # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        neovim # Alternative text editor.
        wget
        curl
        git
        sysstat
        lm_sensors
        fastfetch
        nnn
        foot
        wl-clipboard
        mako
        fcitx5-mozc
        fzf
        ripgrep
        nginxMainline
        szurubooru.server
        szurubooru.client
        lxqt.pcmanfm-qt
        scrot
        
#        nodejs_25
 #       dotnetCorePackages.dotnet_10.sdk
  #      rocmPackages.llvm.clang-unwrapped
   #     python314
         ghc
     #   haskellPackages.cabal-install
      #  alire

        steam
    ];
}
