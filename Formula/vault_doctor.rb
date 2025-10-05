class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.2.7"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.2.7.tar.gz"
  sha256 "b6e7285d7100f954a8c184612f83edc10f97cf77e54f73b1faeea3441da5f639"
  license "MPL-2.0"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/raymonepping/vault_doctor/internal/version.Version=\#{version}
    ].join(" ")
    system "go", "build", "-trimpath", "-ldflags", ldflags, "-o", bin/"vault_doctor", "./cmd/vault_doctor"
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/vault_doctor -V")
  end
end
