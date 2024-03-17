{
  lock-false,
  lock-true,
  ...
}: {
  # Disable firefox intro tabs on the first start
  # Disable the first run tabs with advertisements for the latest firefox features.
  "browser.startup.homepage_override.mstone" = "ignore";
  # Disable new tab page intro
  # Disable the intro to the newtab page on the first run
  "browser.newtabpage.introShown" = lock-false;
  # Pocket Reading List
  # No details
  "extensions.pocket.enabled" = lock-false;
  "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
  # Disable Sponsored Top Sites
  # Firefox 83 introduced sponsored top sites
  # (https://support.mozilla.org/en-US/kb/sponsor-privacy), which are sponsored ads
  # displayed as suggestions in the URL bar.
  "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" =
    lock-false;
  # Disable about:config warning.
  # No details
  "browser.aboutConfig.showWarning" = lock-false;
  # Do not trim URLs in navigation bar
  # By default Firefox trims many URLs (hiding the http:// prefix and trailing slash
  # /).
  "browser.urlbar.trimURLs" = lock-false;
  # Disable checking if Firefox is the default browser
  # No details
  "browser.shell.checkDefaultBrowser" = lock-false;
  # Disable reset prompt.
  # When Firefox is not used for a while, it displays a prompt asking if the user
  # wants to reset the profile. (see Bug #955950
  # (https://bugzilla.mozilla.org/show_bug.cgi?id=955950)).
  "browser.disableResetPrompt" = lock-true;
  # Disable Heartbeat Userrating
  # With Firefox 37, Mozilla integrated the Heartbeat
  # (https://wiki.mozilla.org/Advocacy/heartbeat) system to ask users from time to
  # time about their experience with Firefox.
  "browser.selfsupport.url" = "";
  # Content of the new tab page
  #
  "browser.newtabpage.enhanced" = lock-false;
  # Disable autoplay of <code>&lt;video&gt;</code> tags.
  # Per default, <code>&lt;video&gt;</code> tags are allowed to start automatically.
  # Note: When disabling autoplay, you will have to click pause and play again on
  # some video sites.
  "media.autoplay.enabled" = lock-true;
  "media.autoplay.default" = 0;
}
