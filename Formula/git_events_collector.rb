class GitEventsCollector < Formula
  desc 'Collects accumulated git events'
  homepage 'https://github.com/awseward/git_events_collector'
  url 'https://github.com/awseward/git-events-collector/releases/download/0.5.0/git_events_collector-0.5.0.tar.gz'
  sha256 '71635715acc1290cd88183955fbc4b8c2697993b91d375c216867512608f2055'

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
          <array>
            #{every_two_hours}
          </array>

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

  def every_two_hours(hours: (0..23).step(2), minute: 15, pad_left: 6)
    dicts = hours.map do |hour|
      <<~PDICT
        <dict>
          <key>Hour</key>
          <integer>#{hour}</integer>
          <key>Minute</key>
          <integer>#{minute}</integer>
        </dict>
      PDICT
    end

    line_1, *lines_rest = dicts.flat_map(&:lines).map(&:rstrip)

    [
      line_1,
      *( lines_rest.map { |str| ' ' * pad_left + str } )
    ].join "\n"
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
      gec
      gec_path
      gec_path_active
      gec_path_data_dir
      gec_rotate
      gec_run
      gec_tsv-to-sqlite
    ]
  end
end
