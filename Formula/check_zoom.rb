class CheckZoom < Formula
  desc     "Checks zoom to update call status"
  homepage "https://github.com/awseward/call_status"
  url      "https://github.com/awseward/call_status/releases/download/0.2.1/check_zoom-0.2.1.tar.gz"
  sha256   "241b0f2586350d82f38a3d3a8f23fedb7c8e45cadd63123369d23e3ac0a7e6d1"

  bottle :unneeded

  def install
    bin.install "check_zoom"
  end

  test do
    system "#{bin}/check_zoom", "--version"
  end
end
