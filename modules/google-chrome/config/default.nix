{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  environment.systemPackages = with inputs.browser-previews.packages.${pkgs.system}; [
    (google-chrome.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=VaapiVideoDecoder"
        "--use-gl=egl"
      ];
    })
    # google-chrome # Stable Release
    google-chrome-beta # Beta Release
    google-chrome-dev # Dev Release
  ];
}
