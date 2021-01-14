class Uq < Formula
  desc 'Like `jq`, but for URLs.'
  homepage 'https://github.com/awseward/uq'
  url 'https://github.com/awseward/uq/releases/download/0.1.9/uq--macos.tar.gz'
  sha256 '7ad3962ca401f517cc594be37f3f54f7e9982b6bd291ab1a9f661d082099ac43'

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
