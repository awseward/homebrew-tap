class DwMisc < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/dw-misc'
  url      'https://github.com/awseward/dw-misc/archive/0.0.4.tar.gz'
  sha256   '407f7d4cf310c972df84909a09e94de011e1473b19e9bda42c2c6b6af3fe0b33'

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
