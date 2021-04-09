class DwMisc < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/dw-misc'
  url      'https://github.com/awseward/dw-misc/archive/0.0.2.tar.gz'
  sha256   'b6d09594189eed7b080322f999dbd12c7b2cd10d878cd619ee7c8df9a4a1126b'

  bottle :unneeded

  def install
    bin.install 'bin/dw_push'
    bin.install 'bin/dw_push_sqlite'
    bin.install 'bin/dw_signal_sqlite'
  end

  test do
    puts 'TODO: test'
  end
end
