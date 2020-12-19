class DwMisc < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/dw-misc'
  url      'https://github.com/awseward/dw-misc/archive/0.0.1.tar.gz'
  sha256   '752fd4383af9c195d7ea7bf0532f06a62bc7c6fe9008a044a9233cc4ea37a842'

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
