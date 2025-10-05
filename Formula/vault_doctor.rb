class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.3.4"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "45c2e159db120827ef8ba3526ddc5dc6fa9b675d1e9da73ccbe25a2cdea0d012"
  license "MPL-2.0"

  depends_on "go" => :build

  def install
    mod = Utils.safe_popen_read("go", "list", "-m").chomp
    ldflags = [
      "-s -w",
      "-X #{mod}/internal/version.Version=v#{version}",
      "-X main.buildVersion=v#{version}",
    ].join(" ")

    ohai "Module: #{mod}"
    ohai "ldflags: #{ldflags}"

    system "go", "build",
           "-trimpath",
           "-ldflags", ldflags,
           "-o", bin/"vault_doctor",
           "./cmd/vault_doctor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vault_doctor -V")
  end
end
