{pkgs, ...}: let
  vencordConfig = {
    notifyAboutUpdates = true;
    autoUpdate = false;
    autoUpdateNotification = true;
    useQuickCss = true;
    themeLinks = [];
    enableReactDevtools = false;
    frameless = false;
    transparent = false;
    winCtrlQ = false;
    macosTranslucency = false;
    disableMinSize = false;
    winNativeTitleBar = false;
    plugins = {
      AlwaysAnimate.enabled = false;
      AlwaysTrust.enabled = false;
      AnonymiseFileNames.enabled = false;
      BadgeAPI.enabled = true;
      CommandsAPI.enabled = true;
      ContextMenuAPI.enabled = true;
      MemberListDecoratorsAPI.enabled = false;
      MessageAccessoriesAPI.enabled = false;
      MessageDecorationsAPI.enabled = false;
      MessageEventsAPI.enabled = false;
      MessagePopoverAPI.enabled = false;
      NoticesAPI.enabled = true;
      ServerListAPI.enabled = false;
      SettingsStoreAPI.enabled = false;
      "WebRichPresence (arRPC)".enabled = true;
      BANger.enabled = false;
      BetterFolders.enabled = false;
      BetterGifAltText.enabled = false;
      BetterNotesBox.enabled = false;
      BetterRoleDot.enabled = false;
      BetterUploadButton.enabled = false;
      BlurNSFW.enabled = false;
      CallTimer.enabled = false;
      ClearURLs.enabled = false;
      ColorSighted.enabled = false;
      ConsoleShortcuts.enabled = false;
      CrashHandler.enabled = true;
      CustomRPC.enabled = false;
      DisableDMCallIdle.enabled = false;
      EmoteCloner.enabled = false;
      Experiments.enabled = true;
      F8Break.enabled = false;
      FakeNitro.enabled = false;
      FakeProfileThemes.enabled = false;
      Fart2.enabled = false;
      FixInbox.enabled = false;
      ForceOwnerCrown.enabled = false;
      FriendInvites.enabled = false;
      FxTwitter.enabled = false;
      GameActivityToggle.enabled = false;
      GifPaste.enabled = false;
      HideAttachments.enabled = false;
      iLoveSpam.enabled = false;
      IgnoreActivities.enabled = false;
      ImageZoom.enabled = false;
      InvisibleChat.enabled = false;
      KeepCurrentChannel.enabled = false;
      LastFMRichPresence.enabled = false;
      LoadingQuotes.enabled = false;
      MemberCount.enabled = false;
      MessageClickActions.enabled = false;
      MessageLinkEmbeds.enabled = false;
      MessageLogger.enabled = false;
      MessageTags.enabled = false;
      MoreCommands.enabled = false;
      MoreKaomoji.enabled = false;
      MoreUserTags.enabled = false;
      Moyai.enabled = false;
      MuteNewGuild.enabled = false;
      NoBlockedMessages.enabled = false;
      NoCanaryMessageLinks.enabled = false;
      NoDevtoolsWarning.enabled = false;
      NoF1.enabled = false;
      NoReplyMention = {
        # Example of the config for a plugin. You need to look in Vencord's source code.
        # For example for this, it's in https://github.com/Vendicated/Vencord/blob/bf795c49dfe988f3013cda35cfe18e124456f23f/src/plugins/noReplyMention.tsx#L25
        exemptList = "123456789";
        enabled = true;
      };
      NoScreensharePreview.enabled = false;
      NoTrack.enabled = true;
      NoUnblockToJump.enabled = false;
      NSFWGateBypass.enabled = false;
      oneko.enabled = false;
      petpet.enabled = false;
      PinDMs.enabled = false;
      PlainFolderIcon.enabled = false;
      PlatformIndicators.enabled = false;
      PronounDB.enabled = false;
      QuickMention.enabled = false;
      QuickReply.enabled = true;
      ReadAllNotificationsButton.enabled = false;
      RelationshipNotifier.enabled = false;
      RevealAllSpoilers.enabled = false;
      ReverseImageSearch.enabled = false;
      ReviewDB.enabled = false;
      RoleColorEverywhere.enabled = false;
      SearchReply.enabled = false;
      SendTimestamps.enabled = false;
      ServerListIndicators.enabled = false;
      Settings = {
        enabled = true;
        settingsLocation = "aboveActivity";
      };
      ShikiCodeblocks.enabled = false;
      ShowHiddenChannels.enabled = false;
      ShowMeYourName.enabled = false;
      SilentMessageToggle.enabled = false;
      SilentTyping.enabled = false;
      SortFriendRequests.enabled = false;
      SpotifyControls.enabled = false;
      SpotifyCrack.enabled = false;
      SpotifyShareCommands.enabled = false;
      StartupTimings.enabled = false;
      SupportHelper.enabled = true;
      TimeBarAllActivities.enabled = false;
      TypingIndicator.enabled = false;
      TypingTweaks.enabled = false;
      Unindent.enabled = false;
      ReactErrorDecoder.enabled = false;
      UrbanDictionary.enabled = false;
      UserVoiceShow.enabled = false;
      USRBG.enabled = false;
      UwUifier.enabled = false;
      VoiceChatDoubleClick.enabled = false;
      VcNarrator.enabled = false;
      ViewIcons.enabled = false;
      ViewRaw.enabled = false;
      WebContextMenus = {
        enabled = true;
        addBack = false;
      };
      GreetStickerPicker.enabled = false;
      WhoReacted.enabled = false;
      Wikisearch.enabled = false;
    };
    notifications = {
      timeout = 5000;
      position = "bottom-right";
      useNative = "not-focused";
      logLimit = 50;
    };
    cloud = {
      authenticated = false;
      url = "https://api.vencord.dev/";
      settingsSync = false;
      settingsSyncVersion = 1682768329526;
    };
  };
in {
  home.packages = with pkgs; [
    (runCommand "webcord-vencord-repro" {} ''
      mkdir $out
      ln -s ${webcord-vencord}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${webcord-vencord}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "
         DBPATH=\"\$XDG_CONFIG_HOME/WebCord/Local Storage/leveldb\" ${leveldb-cli}/bin/leveldb-cli put \"_https://discord.com\0\x01VencordSettings\" \"\$(printf '\\001${lib.escape ["\""] (builtins.toJSON vencordConfig)}')\"
         exec $bin \$@
       " > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '')
  ];

  xdg.configFile."WebCord/Themes/transparency".text = ''
    body{
        background-color: transparent;
    }

    #app-mount{
        background-color: transparent;
        border-color: transparent;
    }

    .container-2o3qEW, .chat-2ZfjoI, .bg-1QIAus, .app-2CXKsg, .member-2gU6Ar, .sidebar-1tnWFu {
        background: transparent !important;
    }

    .members-3WRCEx, .container-1NXEtd, .guilds-2JjMmN, .chatContent-3KubbW  {
        background: rgba(31, 31, 40, 0.7) !important
    }

    .container-1NXEtd {
      border-right: 1px solid #3d3f45;
      border-left: 1px solid #3d3f45;
    }
  '';
}
