cask "certrev" do
  version "1.0.0"
  sha256 "dd974d039e807377dde7960852bad3d38ada9b04aba1fc7f0922f60b7d25158c"

  url "https://github.com/cloudguyus/MacOSCertRev/releases/download/v#{version}/CertRev-#{version}.zip"
  name "CertRev"
  desc "Inspect X.509 certificates without importing them into Keychain"
  homepage "https://github.com/cloudguyus/MacOSCertRev"

  depends_on macos: ">= :sequoia"

  app "CertRev.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/CertRev.app"],
        must_succeed: false
  end

  zap trash: "~/Library/Preferences/com.cloudguyus.MacOSCertRev.plist"

  caveats <<~EOS
    CertRev is ad-hoc signed until a Developer ID is added. If macOS blocks the first open, right-click CertRev in Applications and choose Open.
  EOS
end
