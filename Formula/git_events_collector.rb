class GitEventsCollector < Formula
  desc 'Collects accumulated git events'
  homepage 'https://github.com/awseward/git_events_collector'
  url 'https://github.com/awseward/git-events-collector/releases/download/0.3.2/git_events_collector-0.3.2.tar.gz'
  sha256 '6c408550c2613f279aa82c98e43c0c349984b3b2a4ab695b0599114a191e63e8'

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

          <key>StartCalendarInterval</key>
          #{every_two_hours}

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

  def every_two_hours(minute: 15)
    dicts = [0, 2, 4, 6, 8, 10].map do |hour|
      <<~PDICT
        <dict>
            <key>Hour</key>
            <integer>0</integer>
            <key>Minute</key>
            <integer>#{minute}</integer>
        </dict>
      PDICT
    end

    <<~PARR
      <array>
        #{dicts}
      </array>
    PARR
  end

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
      gec_path_active
      gec_path_data_dir
      gec_rotate
      gec_run
      gec_tsv-to-sqlite
    ]
  end
end
