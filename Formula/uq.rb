class Uq < Formula
  desc 'Like `jq`, but for URLs.'
  homepage 'https://github.com/awseward/uq'
  url 'https://github.com/awseward/uq/releases/download/0.1.10/uq--macos.tar.gz'
  sha256 '40ac52cd5e947bca1241c3b1ac21eba750c4ce3064365bf3e708ad8ceebf85c3'

  bottle :unneeded

  def install
    all_bin.each { |f| bin.install f }
  end

  test do
    bin_full_path = "/usr/local/bin/#{nim_bin}"

    system bin_full_path, '--version'
    system bin_full_path, '--revision'
  end

  private

  def all_bin
    [nim_bin]
  end

  def nim_bin
    'uq'
  end
end
