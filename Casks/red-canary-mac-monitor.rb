cask "red-canary-mac-monitor" do
  version "1.0.4"
  sha256 "5c368ddd2f09e2e1ec5052d4ef8a2c2f53894c566a1581c9a8723faf4233ba75"

  url "https://github.com/redcanaryco/mac-monitor/releases/download/v#{version}/Red-Canary-Mac-Monitor-GoldCardinal-#{version.tr(".", "-")}.pkg",
      verified: "github.com/redcanaryco/mac-monitor/"
  name "Red Canary Mac Monitor"
  desc "Analysis tool for security research and malware triage"
  homepage "https://redcanary.com/mac-threat-analysis-tool/"

  auto_updates true
  depends_on macos: ">= :ventura"

  pkg "Red-Canary-Mac-Monitor-GoldCardinal-#{version.tr(".", "-")}.pkg"

  # The uninstall script requires user input to remove an installed system
  # extension. It is expected that the uninstall CI will time out and fail.
  uninstall pkgutil: "com.redcanary.agent",
            script:  {
              executable:   "#{appdir}/Red Canary Mac Monitor.app/Contents/SharedSupport/uninstall.sh",
              must_succeed: false,
              sudo:         true,
            }

  zap trash: [
    "~/Library/Application Support/Red Canary Mac Monitor",
    "~/Library/Preferences/com.redcanary.agent.plist",
    "~/Library/Saved Application State/com.redcanary.agent.savedState",
  ]
end
