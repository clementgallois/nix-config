{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.firefox = {
    enable = true;
    profiles.clement = {
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
        order = [
          "ddg"
          "google"
        ];
        engines = {
          bing.metaData.hidden = true;
        };
      };
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        proton-pass
        sponsorblock
      ];

      # force the definition of permission for extensions
      extensions.exactPermissions = true;
      extensions.exhaustivePermissions = true;
      extensions.force = true;
      extensions.settings = {

        # proton-pass
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          force = true;
          permissions = [
            # cannot have this with exactPermissions, since it's not requested, prefer to manual add
            #"internal:privateBrowsingAllowed"
            "activeTab"
            "alarms"
            "scripting"
            "storage"
            "unlimitedStorage"
            "webNavigation"
            "webRequest"
            "webRequestBlocking"
            "https://*/*"
            "http://*/*"
            "https://account.proton.me/*"
            "https://pass.proton.me/*"
          ];
          settings = {
          };
        };
        # ublock
        "uBlock0@raymondhill.net" = {
          permissions = [
            "alarms"
            "dns"
            "menus"
            "privacy"
            "storage"
            "tabs"
            "unlimitedStorage"
            "webNavigation"
            "webRequest"
            "webRequestBlocking"
            "<all_urls>"
            "http://*/*"
            "https://*/*"
            "file://*/*"
            "https://easylist.to/*"
            "https://*.fanboy.co.nz/*"
            "https://filterlists.com/*"
            "https://forums.lanik.us/*"
            "https://github.com/*"
            "https://*.github.io/*"
            "https://github.com/uBlockOrigin/*"
            "https://ublockorigin.github.io/*"
            "https://*.reddit.com/r/uBlockOrigin/*"
          ];
        };
        "sponsorBlocker@ajay.app" = {
          permissions = [
            "storage"
            "scripting"
            "unlimitedStorage"
            "https://sponsor.ajay.app/*"
            "https://*.youtube.com/*"
            "https://www.youtube-nocookie.com/embed/*"
          ];

        };
      };
      bookmarks = { };
      settings = {
        # 3 = Restore previous session
        # 1 = Homepage
        # e
        # 0 = Blank page
        "browser.startup.page" = 3;
        "browser.startup.homepage" = "about:home";
        # auto enable installed extensions
        "extensions.autoDisableScopes" = 0;
        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        # Don't ask for download dir
        "browser.download.useDownloadDir" = true;

        # Disable crappy home activity stream page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.blocked" = lib.genAttrs [
          # Youtube
          "26UbzFJ7qT9/4DhodHKA1Q=="
          # Facebook
          "4gPpjkxgZzXPVtuEoAL9Ig=="
          # Wikipedia
          "eV8/WsSLxHadrTL1gAxhug=="
          # Reddit
          "gLv0ja2RYVgxKdp0I5qwvA=="
          # Amazon
          "K00ILysCaEq8+bEqV/3nuw=="
          # Twitter
          "T9nJot5PurhJSy8n038xGA=="
        ] (_: 1);

        # Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # Disable firefox accounts
        "identity.fxaccounts.enabled" = false;
        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        # wether tabs are drawn inside title bar
        # 0 = no, 1 = yes, 2 = default (leaving default should be smart enough)
        "browser.tabs.inTitlebar" = 2;
        # vertical tabs
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "sidebar.main.tools" = "history,bookmarks";
        #"sidebar.expandOnHover" = true;
        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            unified-extensions-area = [ ];
            widget-overflow-fixed-list = [ ];
            nav-bar = [
              "back-button"
              "forward-button"
              "vertical-spacer"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
              "ublock0_raymondhill_net-browser-action"
              # where this ?
              "_testpilot-containers-browser-action"
              "reset-pbm-toolbar-button"
              "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [ ];
            vertical-tabs = [
              "tabbrowser-tabs"
              # "new-tab-button"
            ];
            PersonalToolbar = [ "personal-bookmarks" ];
          };
          seen = [
            "save-to-pocket-button"
            "developer-button"
            "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
            "ublock0_raymondhill_net-browser-action"
            "_testpilot-containers-browser-action"
            "screenshot-button"
            "sponsorblocker_ajay_app-browser-action"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "PersonalToolbar"
            "toolbar-menubar"
            "TabsToolbar"
            "widget-overflow-fixed-list"
            "vertical-tabs"
          ];
          currentVersion = 23;
          newElementCount = 0;
        };
      };
    };
  };

  # home = {
  #   persistence = {
  #     # Not persisting is safer
  #     # "/persist".directories = [ ".mozilla/firefox" ];
  #   };
  # };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
