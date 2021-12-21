class DwMisc < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/dw-misc'
  url      'https://github.com/awseward/dw-misc/archive/0.1.0.tar.gz'
  sha256   'ade12fa89d147c08073a68a37d8a690ac27f6d5b4bf43fe6bee23214a3b62fe1'

  def install
    bin.install 'bin/dw'
    bin.install 'bin/dw_push'
    bin.install 'bin/dw_push_sqlite'
    bin.install 'bin/dw_signal_sqlite'
  end

  test do
    puts 'TODO: test'
  end
end
