{ lock-false, lock-true, ... }:


{
  # Disable Telemetry
  # The telemetry feature
  # (https://support.mozilla.org/kb/share-telemetry-data-mozilla-help-improve-firefox)
  # sends data about the performance and responsiveness of Firefox to Mozilla.
  "toolkit.telemetry.enabled" = lock-false;
  "toolkit.telemetry.archive.enabled" = lock-false;
  "toolkit.telemetry.rejected" = lock-true;
  "toolkit.telemetry.unified" = lock-false;
  "toolkit.telemetry.unifiedIsOptIn" = lock-false;
  "toolkit.telemetry.prompted" = 2;
  "toolkit.telemetry.server" = "";
  "toolkit.telemetry.cachedClientID" = "";
  "toolkit.telemetry.newProfilePing.enabled" = lock-false;
  "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
  "toolkit.telemetry.updatePing.enabled" = lock-false;
  "toolkit.telemetry.bhrPing.enabled" = lock-false;
  "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
  "toolkit.telemetry.hybridContent.enabled" = lock-false;
  "toolkit.telemetry.reportingpolicy.firstRun" = lock-false;
  # Disable health report
  # Disable sending Firefox health reports
  # (https://www.mozilla.org/privacy/firefox/#health-report) to Mozilla
  "datareporting.healthreport.uploadEnabled" = lock-false;
  "datareporting.policy.dataSubmissionEnabled" = lock-false;
  "datareporting.healthreport.service.enabled" = lock-false;
  # Disable shield studies
  # Mozilla shield studies (https://wiki.mozilla.org/Firefox/Shield) is a feature
  # which allows mozilla to remotely install experimental addons.
  "app.normandy.enabled" = lock-false;
  "app.normandy.api_url" = "";
  "app.shield.optoutstudies.enabled" = lock-false;
  "extensions.shield-recipe-client.enabled" = lock-false;
  "extensions.shield-recipe-client.api_url" = "";
  # Disable experiments
  # Telemetry Experiments (https://wiki.mozilla.org/Telemetry/Experiments) is a
  # feature that allows Firefox to automatically download and run specially-designed
  # restartless addons based on certain conditions.
  "experiments.enabled" = lock-false;
  "experiments.manifest.uri" = "";
  "experiments.supported" = lock-false;
  "experiments.activeExperiment" = lock-false;
  "network.allow-experiments" = lock-false;
  # Disable Crash Reports
  # The crash report (https://www.mozilla.org/privacy/firefox/#crash-reporter) may
  # contain data that identifies you or is otherwise sensitive to you.
  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = lock-false;
  "browser.crashReports.unsubmittedCheck.enabled" = lock-false;
  "browser.crashReports.unsubmittedCheck.autoSubmit" = lock-false;
  "browser.crashReports.unsubmittedCheck.autoSubmit2" = lock-false;
  # Opt out metadata updates
  # Firefox sends data about installed addons as metadata updates
  # (https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/), so
  # Mozilla is able to recommend you other addons.
  "extensions.getAddons.cache.enabled" = lock-false;
  # Disable google safebrowsing
  # Google safebrowsing can detect phishing and malware but it also sends
  # informations to google together with an unique id called wrkey
  # (http://electroholiker.de/?p=1594).
  "browser.safebrowsing.enabled" = lock-false;
  "browser.safebrowsing.downloads.remote.url" = "";
  "browser.safebrowsing.phishing.enabled" = lock-false;
  "browser.safebrowsing.blockedURIs.enabled" = lock-false;
  "browser.safebrowsing.downloads.enabled" = lock-false;
  "browser.safebrowsing.downloads.remote.enabled" = lock-false;
  "browser.safebrowsing.appRepURL" = "";
  "browser.safebrowsing.malware.enabled" = lock-false;
  # Disable malware scan
  # The malware scan sends an unique identifier for each downloaded file to Google.
  # "browser.safebrowsing.appRepURL" = ""; (Repeated from google safebrowsing)
  # "browser.safebrowsing.malware.enabled" = lock-false; (Repeated from google safebrowsing)
  # Disable DNS over HTTPS
  # DNS over HTTP (DoH), aka. Trusted Recursive Resolver (TRR)
  # (https://wiki.mozilla.org/Trusted_Recursive_Resolver), uses a server run by
  # Cloudflare to resolve hostnames, even when the system uses another (normal) DNS
  # server. This setting disables it and sets the mode to explicit opt-out (5).
  "network.trr.mode" = 5;
  # Disable preloading of the new tab page.
  # By default Firefox preloads the new tab page (with website thumbnails) in the
  # background before it is even opened.
  "browser.newtab.preload" = lock-false;
  # Disable about:addons' Get Add-ons panel
  # The start page with recommended addons uses google analytics.
  "extensions.getAddons.showPane" = lock-false;
  "extensions.webservice.discoverURL" = "";
  # Disable check for captive portal.
  # By default, Firefox checks for the presence of a captive portal on every
  # startup.  This involves traffic to Akamai
  # (https://support.mozilla.org/questions/1169302).
  "network.captive-portal-service.enabled" = lock-false;
  # Disables playback of DRM-controlled HTML5 content
  # if enabled, automatically downloads the Widevine Content Decryption Module
  # provided by Google Inc. Details
  # (https://support.mozilla.org/en-US/kb/enable-drm#w_opt-out-of-cdm-playback-uninstall-cdms-and-stop-all-cdm-downloads)
  "media.eme.enabled" = lock-false;
  # Disables the Widevine Content Decryption Module provided by Google Inc.
  # Used for the playback of DRM-controlled HTML5 content Details
  # (https://support.mozilla.org/en-US/kb/enable-drm#w_disable-the-google-widevine-cdm-without-uninstalling)
  "media.gmp-widevinecdm.enabled" = lock-false;
  # Disable access to device sensor data
  # Disallow websites to access sensor data (ambient light, motion, device
  # orientation and proximity data).
  "device.sensors.ambientLight.enabled" = lock-false;
  "device.sensors.enabled" = lock-false;
  "device.sensors.motion.enabled" = lock-false;
  "device.sensors.orientation.enabled" = lock-false;
  "device.sensors.proximity.enabled" = lock-false;
  # Disable Firefox Suggest
  # The Firefox Suggest
  # (https://support.mozilla.org/en-US/kb/navigate-web-faster-firefox-suggest)
  # feature allows Mozilla to provide search suggestions in the US, which uses your
  # city location and search keywords to send suggestions. This is also used to
  # serve advertisements.
  "browser.urlbar.groupLabels.enabled" = lock-false;
  "browser.urlbar.quicksuggest.enabled" = lock-false;
  # Disable Javascript in PDF viewer
  # Disables executing of JavaScript in the PDF form viewer. It is possible that
  # some PDFs are not rendered correctly due to missing functions.
  "pdfjs.enableScripting" = lock-true;
}
