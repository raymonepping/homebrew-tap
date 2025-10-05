class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.2.6"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.2.6.tar.gz"
  sha256 "6778ed74695ec1667d386f5cd836cc0f295f26764d5e1551d41e3828500051e4"
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
