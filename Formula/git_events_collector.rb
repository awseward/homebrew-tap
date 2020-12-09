class GitEventsCollector < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/git_events_collector'
  url 'https://github.com/awseward/git-events-collector/releases/download/0.0.5/git_events_collector-0.0.5.tar.gz'
  sha256 '94e1f5704043bb6dfeb3da4fdc95d27a59f2b04d47b443375bd7c27c2a2345a2'

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
      gec_run
    ]
  end
end
