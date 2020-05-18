class CallStatusChecker < Formula
  desc     "Checks Zoom to update call status"
  homepage "https://github.com/awseward/call_status"
  url "https://github.com/awseward/call_status/releases/download/0.3.2/call_status_checker-0.3.2.tar.gz"
  sha256 "dcdd06dd724ccb6668c1ffb1a08b2a434c7e43944a3bd4977bcfc3ee4a4ddb0a"

  bottle :unneeded

  def install
    system "mkdir -p \"#{etc_subdirpath}\""
    system "mkdir -p \"#{var_subdirpath}\""
    bin.install bin_filename
  end

  def bin_filename
    "call_status_checker"
  end

  def database_filename
    "#{name}.db"
  end

  def config_filename
    'config.json'
  end

  def log_filepath
    "/tmp/log/#{name}/watch.log"
  end

  def var_subdirpath
    File.join var, name
  end

  def etc_subdirpath
    File.join etc, name
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
            <string>/usr/local/bin/#{bin_filename}</string>
            <string>check</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <false/>
          <key>StartInterval</key>
          <integer>10</integer>
          <key>EnvironmentVariables</key>
          <dict>
            <key>PATH</key>
            <string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:</string>

            <key>CONFIG_FILEPATH</key>
            <string>#{File.join etc_subdirpath, config_filename}</string>

            <key>DATABASE_FILEPATH</key>
            <string>#{File.join var_subdirpath, database_filename}</string>

            <!--
              <key>LOG_LEVEL</key>
              <string>DEBUG</string>
            -->
          </dict>
          <key>StandardOutPath</key>
          <string>#{log_filepath}</string>
          <key>StandardErrorPath</key>
          <string>#{log_filepath}</string>
        </dict>
      </plist>
    XML
  end

  def caveats
    <<~MSG

      To tail logs, run:

        tail -f #{log_filepath}

      ---

      If this is your first time installing this, the application won't know
      who you are until you identify yourself. Do so by running:

        #{bin_filename} config -u <your_username>

    MSG
  end

  test do
    system "/usr/local/bin/#{bin_filename}", "--version"
    system "/usr/local/bin/#{bin_filename}", "--revision"
  end
end
