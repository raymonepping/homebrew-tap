class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.3.6"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.3.6.tar.gz"
  sha256 "845b85f1e5e7ccd3b7cdcfe88f106b61a7b01233b62dd674c3d60d1b19f2dad9"
  license "MPL-2.0"

  depends_on "go" => :build

  def install
    mod = Utils.safe_popen_read("go", "list", "-m").chomp
    ldflags = [
      "-s -w",
      "-X \#{mod}/internal/version.Version=v\#{version}",
      "-X main.buildVersion=v\#{version}",
    ].join(" ")
    ohai "Module: \#{mod}"
    ohai "ldflags: \#{ldflags}"
    system "go", "build", "-trimpath", "-ldflags", ldflags, "-o", bin/"vault_doctor", "./cmd/vault_doctor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vault_doctor -V")
  end
end
