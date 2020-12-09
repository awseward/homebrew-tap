class GitEventsCollector < Formula
  desc     "TODO"
  homepage "https://github.com/awseward/git_events_collector"
  url "https://github.com/awseward/git-events-collector/releases/download/0.0.1/git_events_collector-0.0.1.tar.gz"
  sha256 "485d5433e1c9a6781275b6a595227618739a5a0597a72f17e2193beebf402fec"

  bottle :unneeded

  def install
    all_bin.each { |f| bin.install f }
  end

  test do
    bin_full_path = "/usr/local/bin/#{nim_bin}"

    system bin_full_path, "--version"
    system bin_full_path, "--revision"
  end

  private

  def all_bin
    [
      nim_bin,
      *shell_bin
    ]
  end

  def nim_bin
    "git_events_collector"
  end

  def shell_bin
    %w[
      rotate.sh
      to_sqlite.sh
      push.sh
    ]
  end
end
