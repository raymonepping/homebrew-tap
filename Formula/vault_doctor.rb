class VaultDoctor < Formula
  desc "Quick, pretty, and scriptable health diagnostics for HashiCorp Vault"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.2/vault_doctor_0.2.2_darwin_arm64"
      sha256 "95881b1792f48c7756794045be8d196be184b1cfc3e3e72f07c988b822becd50"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.2/vault_doctor_0.2.2_darwin_amd64"
      sha256 "153e578b3ea9f1a32fef6ce420ab79d77979c8a701ebcf439daf4e179bc2f616"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.2/vault_doctor_0.2.2_linux_arm64"
      sha256 "5b01b630b9f1a628565b5aae42a4afb7ed345ec8c0b79b030cadfbe14452f7cf"
    else
      url "https://github.com/raymonepping/vault_doctor/releases/download/v0.2.2/vault_doctor_0.2.2_linux_amd64"
      sha256 "8ea71f71207a6144c9c318f4b48b64679630e841e3dca7d4fe554f201aab199f"
    end
  end

  def install
    target = if OS.mac?
      Hardware::CPU.arm? ? "vault_doctor_0.2.2_darwin_arm64" : "vault_doctor_0.2.2_darwin_amd64"
    else
      Hardware::CPU.arm? ? "vault_doctor_0.2.2_linux_arm64" : "vault_doctor_0.2.2_linux_amd64"
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
