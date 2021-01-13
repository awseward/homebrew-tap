class Uq < Formula
  desc 'Like `jq`, but for URLs.'
  homepage 'https://github.com/awseward/uq'
  url 'https://github.com/awseward/uq/releases/download/0.1.6/uq-0.1.6-macos.tar.gz'
  sha256 'e527b40f6c9a52bdd234ad21bd27961dd85105b08a56c3dba8d0281132938d36'

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
