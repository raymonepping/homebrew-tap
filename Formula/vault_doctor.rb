class VaultDoctor < Formula
  desc "Quick, pretty, and scriptable health diagnostics for HashiCorp Vault"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.4/vault_doctor_0.2.4_darwin_arm64"
      sha256 "f152c834c5658fb701e1144cf9d263b84033f3500b7f1fae74169fdbeab2acb6"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.4/vault_doctor_0.2.4_darwin_amd64"
      sha256 "d530a13956a7c0dd895b4a7d4d12976c0147b1f6df72d1f84f4bc6e0e6b72e01"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.4/vault_doctor_0.2.4_linux_arm64"
      sha256 "a8e8c286ad6ac81947f67b223c90c70cb02304ded86b40c1cdecf45f98c3a40c"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.4/vault_doctor_0.2.4_linux_amd64"
      sha256 "a01b40788e099cb76ddf494594e0a374e831d14a84ca0f9a9aaf1f9ceb5b783d"
    end
  end

  def install
    target = if OS.mac?
      Hardware::CPU.arm? ? "vault_doctor_0.2.4_darwin_arm64" : "vault_doctor_0.2.4_darwin_amd64"
    else
      Hardware::CPU.arm? ? "vault_doctor_0.2.4_linux_arm64" : "vault_doctor_0.2.4_linux_amd64"
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
