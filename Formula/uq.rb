class Uq < Formula
  desc 'Like `jq`, but for URLs.'
  homepage 'https://github.com/awseward/uq'
  url 'https://github.com/awseward/uq/releases/download/0.1.0/uq-0.1.0.tar.gz'
  sha256 '532bb34302aa8b9d2839e61b29da15af1e160044961512da66bd993a9a479717'

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
