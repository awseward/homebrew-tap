class Uq < Formula
  desc 'Like `jq`, but for URLs.'
  homepage 'https://github.com/awseward/uq'
  url 'https://github.com/awseward/uq/releases/download/0.1.12/uq-0.1.12-macos.tar.gz'
  sha256 'c9edf255366ce5933f252718f96dc984db7d4d0a3694736ce21b599b0e684645'

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
