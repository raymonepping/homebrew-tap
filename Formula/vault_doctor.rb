class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.3.9"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.3.9.tar.gz"
  sha256 "20a6c596c47fe91852e37b974330430fe62a00714ac0160847fb3c28ed3a12da"
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
