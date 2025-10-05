class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.2.8"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.2.8.tar.gz"
  sha256 "f74a2434c551d53ad141416d282c326f8be800ab7b57c72c4691f21a89309267"
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
