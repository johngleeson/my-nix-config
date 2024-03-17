{
  config,
  pkgs,
  lib,
  ...
}: let
  merge = lib.foldr (a: b: a // b) {};
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;
          # add policies here...

          # ---- EXTENSIONS ----
          ExtensionSettings = {
            /*
             "*".installation_mode =
            "blocked"; # blocks all addons except the ones specified below
            */
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # Search by image
            "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/search_by_image/latest.xpi";
              installation_mode = "force_installed";
            };
            # Enhancer for Youtube
            "enhancerforyoutube@maximerf.addons.mozilla.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer_for_youtube/latest.xpi";
              installation_mode = "force_installed";
            };
            # Old reddit redirect
            "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/old_reddit_redirect/latest.xpi";
              installation_mode = "force_installed";
            };
            # Reddit Enhancement Suite
            "jid1-xUfzOsOFlzSOXg@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/reddit_enhancement_suite/latest.xpi";
              installation_mode = "force_installed";
            };
            # Sponsorblock
            "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              installation_mode = "force_installed";
            };
            # Bypass Paywalls Clean
            "magnolia_limited_permissions_d@12.34" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bypass_paywalls_clean_d/latest.xpi";
              installation_mode = "force_installed";
            };
            # ClearURLs
            "{74145f27-f039-47ce-a470-a662b129930a}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
              installation_mode = "force_installed";
            };
            # Continers Helper
            "{800215d6-eff0-4a62-9268-09857c048030}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/continers_helper/latest.xpi";
              installation_mode = "force_installed";
            };
            # Dark Background and Light Text
            "jid1-QoFqdK4qzUfGWQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark_background_light_text/latest.xpi";
              installation_mode = "force_installed";
            };
            # Don't Fuck With Paste
            "DontFuckWithPaste@raim.ist" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/don_t_fuck_with_paste/latest.xpi";
              installation_mode = "force_installed";
            };
            # Firefox Multi-Account Containers
            "@testpilot-containers" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi_account_containers/latest.xpi";
              installation_mode = "force_installed";
            };
            # OCR - Image Reader
            "{e4c6eef1-8b3b-4daa-8757-707702e7528d}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ocr_iamge_reader/latest.xpi";
              installation_mode = "force_installed";
            };
            # Sidebery
            "{3c078156-979c-498b-8990-85f7987dd929}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
              installation_mode = "force_installed";
            };
            # User-Agent Switcher and Manager
            "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/user_agent_string_switcher/latest.xpi";
              installation_mode = "force_installed";
            };
            # Web Archives
            "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/view_page_archive/latest.xpi";
              installation_mode = "force_installed";
            };
            # Bitwarden
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden_password_manager/latest.xpi";
              installation_mode = "force_installed";
            };
          };

          # ---- PREFERENCES ----
          # Set preferences shared by all profiles.
          Preferences = merge [
            (import ./config/annoyances.nix {inherit lock-false lock-true;})
            (import ./config/browser-features.nix {inherit lock-false lock-true;})
            (import ./config/privacy.nix {inherit lock-false lock-true;})
            (import ./config/tracking.nix {inherit lock-false lock-true;})
            (import ./config/security.nix {inherit lock-false lock-true;})
          ];
        };
      };

      # ---- PROFILES ----
      # Switch profiles via about:profiles page.
      # For options that are available in Home-Manager see
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      profiles = {
        profile_0 = {
          # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
          id = 0; # 0 is the default profile; see also option "isDefault"
          name = "profile_0"; # name as listed in about:profiles
          isDefault = true; # can be omitted; true if profile ID is 0
          settings = {
            # specify profile-specific preferences here; check about:config for options
            "browser.newtabpage.activity-stream.feeds.section.highlights" =
              false;
            "browser.startup.homepage" = "https://nixos.org";
            "browser.newtabpage.pinned" = [
              {
                title = "NixOS";
                url = "https://nixos.org";
              }
            ];
            # add preferences for profile_0 here...
          };
        };
        profile_1 = {
          id = 1;
          name = "profile_1";
          isDefault = false;
          settings = {
            "browser.newtabpage.activity-stream.feeds.section.highlights" =
              true;
            "browser.startup.homepage" = "https://ecosia.org";
            # add preferences for profile_1 here...
          };
        };
        # add profiles here...
      };
    };
  };
}
