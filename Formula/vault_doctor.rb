class VaultDoctor < Formula
  desc "Quick, pretty, and scriptable health diagnostics for HashiCorp Vault"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.2/vault_doctor_0.1.2_darwin_arm64"
      sha256 "ef11e9cf19d69aeefc2ad86f64e7222607b8f9a6a337e60b251e79f52837b38c"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.2/vault_doctor_0.1.2_darwin_amd64"
      sha256 "aeaedfa0c738dadf48aecc956c2d3a3ebf247b8d2e3ae46b2a344a31d2255802"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.2/vault_doctor_0.1.2_linux_arm64"
      sha256 "db4f8e12dafd8a61c047bbec926ae7443faaee2ac608f4764f6b2956c44f2f91"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.1.2/vault_doctor_0.1.2_linux_amd64"
      sha256 "c9755b76491679e89642240462fd119a4a5a48d5ecf9ceba3f60a778e4ecf8fb"
    end
  end

  def install
    target = if OS.mac?
      Hardware::CPU.arm? ? "vault_doctor_0.1.2_darwin_arm64" : "vault_doctor_0.1.2_darwin_amd64"
    else
      Hardware::CPU.arm? ? "vault_doctor_0.1.2_linux_arm64" : "vault_doctor_0.1.2_linux_amd64"
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
