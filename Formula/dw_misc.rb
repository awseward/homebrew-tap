class DwMisc < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/dw-misc'
  url      'https://github.com/awseward/dw-misc/archive/0.0.2.tar.gz'
  sha256   '68ed3d6bca107361df6d5f20b75d9dcc0bc64b1a81a5a9dcef349f0097227af8'

  def install
    bin.install 'bin/dw_push'
    bin.install 'bin/dw_push_sqlite'
    bin.install 'bin/dw_signal_sqlite'
  end

  test do
    puts 'TODO: test'
  end
end
