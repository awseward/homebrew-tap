class CheckZoom < Formula
  desc     "Checks zoom to update call status"
  homepage "https://github.com/awseward/call_status"
  url      "https://github.com/awseward/call_status/releases/download/0.2.1/check_zoom-0.2.1.tar.gz"
  sha256   "241b0f2586350d82f38a3d3a8f23fedb7c8e45cadd63123369d23e3ac0a7e6d1"

  bottle :unneeded

  def install
    bin.install "check_zoom"
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
          <string>#{bin}/check_zoom</string>
          <key>ProgramArguments</key>
          <array>
            <string>--help</string>
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
            <string>#{bin}:/usr/bin:/bin:/usr/sbin:/sbin:</string>

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
    system "#{bin}/check_zoom", "--version"
    system "#{bin}/check_zoom", "--revision"
  end
end
