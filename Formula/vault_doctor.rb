class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.3.0"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "541448050396d8b0ce1706881456600c85fd3ffed5e9e46057d64c1b8aa98a2e"
  license "MPL-2.0"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/raymonepping/vault_doctor/internal/version.Version=#{version}
    ].join(" ")
    system "go", "build", "-trimpath", "-ldflags", ldflags, "-o", bin/"vault_doctor", "./cmd/vault_doctor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vault_doctor -V")
  end
end
