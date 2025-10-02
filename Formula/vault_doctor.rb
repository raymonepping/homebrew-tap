class VaultDoctor < Formula
  desc "Quick, pretty, and scriptable health diagnostics for HashiCorp Vault"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.0/vault_doctor_0.2.0_darwin_arm64"
      sha256 "311b6451070443cc021f6a1a13872e0800bc18215602012c6114f92789430b9e"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.0/vault_doctor_0.2.0_darwin_amd64"
      sha256 "7f0405457bdd7d98f83fecf120531c9aa8cdd812ad7d64131d14e08f416a5e74"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.0/vault_doctor_0.2.0_linux_arm64"
      sha256 "370cf520897a84f43fe9241e2087e831678af00817cadc05b8b7790619fb1d52"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.0/vault_doctor_0.2.0_linux_amd64"
      sha256 "db1d4687655ec5b6ae8428e3800662a181be2a1d1795d9fe43ef3a36b6877994"
    end
  end

  def install
    target = if OS.mac?
      Hardware::CPU.arm? ? "vault_doctor_0.2.0_darwin_arm64" : "vault_doctor_0.2.0_darwin_amd64"
    else
      Hardware::CPU.arm? ? "vault_doctor_0.2.0_linux_arm64" : "vault_doctor_0.2.0_linux_amd64"
    end
    bin.install target => "vault_doctor"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  test do
    # Check version prints and binary runs
    assert_match version.to_s, shell_output("#{bin}/vault_doctor -V")
  end
end
