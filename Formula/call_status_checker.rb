class CallStatusChecker < Formula
  desc     'Checks Zoom to update call status'
  homepage 'https://github.com/awseward/call_status'
  url 'https://github.com/awseward/call_status/releases/download/0.6.3/call_status_checker-0.6.3.tar.gz'
  sha256 '9bf292f0b08f778cc5b295849e078db1e2a92e87cefa66e230fb230e5d73dd90'

  bottle :unneeded

  def install
    log_subdirpath.mkpath
    bin.install bin_filename
  end

  test do
    system bin_abs_path, '--version'
    system bin_abs_path, '--revision'
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
            <string>#{bin_abs_path}</string>
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

      If this is your first time installing this, the application will not know
      who you are until you identify yourself. Do so by running:

        #{bin_filename} config -u <your_username>

    MSG
  end

  private

  def bin_filename
    'call_status_checker'
  end

  def bin_abs_path
    File.join HOMEBREW_PREFIX, 'bin', bin_filename
  end

  def log_filepath
    File.join log_subdirpath, 'watch.log'
  end

  def log_subdirpath
    var + "log/#{name}"
  end
end
