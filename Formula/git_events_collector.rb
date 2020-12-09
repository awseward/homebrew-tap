class GitEventsCollector < Formula
  desc     "TODO"
  homepage "https://github.com/awseward/git_events_collector"
  url "https://github.com/awseward/git-events-collector/releases/download/0.0.2/git_events_collector-0.0.2.tar.gz"
  sha256 "68ebb8e2a61aad2bdd57e7a81da1da1cd4f83c3b07b073e302722878328fbe74"

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
      gec_rotate
      gec_tsv-to-sqlite
      gec_push
    ]
  end
end
