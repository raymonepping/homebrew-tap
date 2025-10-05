class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.3.5"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "86da6fd49a06a904c9823e4db5eca5884ba2c50fb7a0ca2f3730c290ed29ce11"
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
