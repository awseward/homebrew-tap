class GitEventsCollector < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/git_events_collector'
  url 'https://github.com/awseward/git-events-collector/releases/download/0.0.3/git_events_collector-0.0.3.tar.gz'
  sha256 'd1081152b5e4c31614fec5710932dfec10649e096d3966bbebc21f9db463d5ad'

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
    [
      nim_bin,
      *shell_bin
    ]
  end

  def nim_bin
    'git_events_collector'
  end

  def shell_bin
    %w[
      gec_rotate
      gec_tsv-to-sqlite
      gec_push
    ]
  end
end
