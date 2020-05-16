class CallStatusChecker < Formula
  desc     "Checks Zoom to update call status"
  homepage "https://github.com/awseward/call_status"
  url      "https://github.com/awseward/call_status/releases/download/0.2.1/call_status_checker-0.2.1.tar.gz"
  sha256   "6de6fcdd415d06151ce0219593bfb8466697e9df7eb9dd489b4af6e114129c21"

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
          <string>/tmp/log/#{name}/watch.log</string>
          <key>StandardErrorPath</key>
          <string>/tmp/log/#{name}/watch.log</string>
        </dict>
      </plist>
    XML
  end

  test do
    system "/usr/local/bin/#{bin_filename}", "--version"
    system "/usr/local/bin/#{bin_filename}", "--revision"
  end
end
