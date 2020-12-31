class GitEventsCollector < Formula
  desc     'TODO'
  homepage 'https://github.com/awseward/git_events_collector'
  url 'https://github.com/awseward/git-events-collector/releases/download/0.2.3/git_events_collector-0.2.3.tar.gz'
  sha256 '4d90cd9f8fbb569d981dcf7afea287803f5cd8f082fc1aabb40bdae422547db2'

  bottle :unneeded
  depends_on 'dw_misc'

  def install
    all_bin.each { |f| bin.install f }
  end

  test do
    bin_full_path = "/usr/local/bin/#{nim_bin}"

    system bin_full_path, '--version'
    system bin_full_path, '--revision'
  end

  def plist
    <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>

          <key>ProgramArguments</key>
          <array>
            <string>/usr/local/bin/gec_run</string>
          </array>

          <key>RunAtLoad</key>
          <true/>

          <key>KeepAlive</key>
          <false/>

          <key>StartInterval</key>
          <integer>7200</integer> <!-- Runs every 2 hours -->

          <key>EnvironmentVariables</key>
          <dict>
            <key>PATH</key>
            <string>/run/current-system/sw/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:</string>

            <key>DW_INGEST_URL</key>
            <string>https://seward-datawarehouse.herokuapp.com</string>
          </dict>

          <key>StandardOutPath</key>
          <string>/tmp/log/gec_run.log</string>

          <key>StandardErrorPath</key>
          <string>/tmp/log/gec_run.log</string>
        </dict>
      </plist>
    XML
  end

  def  caveats
    <<~CVTS
    You will need the tardigrade.io CLI, uplink. You can set that up here by
    following the instructions here:

      https://documentation.tardigrade.io/getting-started/uploading-your-first-object/set-up-uplink-cli

    CVTS
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
      gec_run
    ]
  end
end
