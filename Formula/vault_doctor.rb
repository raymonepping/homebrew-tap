class VaultDoctor < Formula
  desc "Quick, pretty, and scriptable health diagnostics for HashiCorp Vault"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.0/vault_doctor_0.1.0_darwin_arm64"
      sha256 "5dae9643fa05182253975ca6ca7c9e44e309f0396da361b8bbcaafa45c9fa98b"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.0/vault_doctor_0.1.0_darwin_amd64"
      sha256 "b70c7afa187a4b2bb9e1a11ea3b756eebda686f155782e322f4ecff904162b98"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.0/vault_doctor_0.1.0_linux_arm64"
      sha256 "1ec6dcb6ffe3adc23fa2ad5f3f20872283556b197bef5cd593f4b1a50eff8060"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.0/vault_doctor_0.1.0_linux_amd64"
      sha256 "d49c14fcf567f435f165d8a51f4517225c07ca36945f7a8675ef8f7d5507f278"
    end
  end

  def install
    target = if OS.mac?
      Hardware::CPU.arm? ? "vault_doctor_0.1.0_darwin_arm64" : "vault_doctor_0.1.0_darwin_amd64"
    else
      Hardware::CPU.arm? ? "vault_doctor_0.1.0_linux_arm64" : "vault_doctor_0.1.0_linux_amd64"
    end
    bin.install target => "vault_doctor"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/vault_doctor -h")
  end
end
