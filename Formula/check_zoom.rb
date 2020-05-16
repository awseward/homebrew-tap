class CheckZoom < Formula
  desc     "Checks zoom to update call status"
  homepage "https://github.com/awseward/call_status"
  url      "https://github.com/awseward/call_status/releases/download/0.2.0/check_zoom-0.2.0.tar.gz"
  sha256   "51ab8438bc34870b5bf7bd00cedd9fdba792f98428ff63ff4f78814c3fe1d90b"

  bottle :unneeded

  def install
    bin.install "check_zoom"
  end

  test do
    system "#{bin}/check_zoom", "--version"
  end
end
