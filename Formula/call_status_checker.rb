class CallStatusChecker < Formula
  desc     "Checks Zoom to update call status"
  homepage "https://github.com/awseward/call_status"
  url      "https://github.com/awseward/call_status/releases/download/0.2.1/call_status_checker-0.2.1.tar.gz"
  sha256   "968b89dfd60f17243136f67a83d5b33b9e2fba75649cc483abe45e09a8fca844"

  bottle :unneeded

  def install
    bin.install bin_filename
  end

  def bin_filename
    "call_status_checker"
  end

  def plist
    <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>Program</key>
          <string>/usr/local/bin/#{bin_filename}</string>
          <!--
            <key>ProgramArguments</key>
            <array>
              <string>/usr/local/bin/#{bin_filename}</string>
              <string>--help</string>
            </array>
          -->
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
            <string>#{etc}/#{name}/config.json</string>

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
