class VaultDoctor < Formula
  desc "Medic for HashiCorp Vault: health, caps, KV, transit"
  homepage "https://github.com/raymonepping/vault_doctor"
  version "0.3.3"
  url "https://github.com/raymonepping/vault_doctor/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "906dcbafd5dde6e7da3bfdf0893d527208a7b3d7649590a3d29cbfc0c1def5eb"
  license "MPL-2.0"

  depends_on "go" => :build

  def install
    mod = Utils.safe_popen_read("go", "list", "-m").chomp
    # Inject *with* leading v so the stored var is v0.x.y; your -V strips it.
    ldflags = "-s -w -X #{mod}/internal/version.Version=v#{version}"

    ohai "Module: #{mod}"
    ohai "ldflags: #{ldflags}"
    system "go", "build", "-trimpath", "-ldflags", ldflags, "-o", bin/"vault_doctor", "./cmd/vault_doctor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vault_doctor -V")
  end
end
