class CallStatusChecker < Formula
  desc     "Checks Zoom to update call status"
  homepage "https://github.com/awseward/call_status"
  url "https://github.com/awseward/call_status/releases/download/0.4.0/call_status_checker-0.4.0.tar.gz"
  sha256 "df03a2c7be3bc7f2030b7eb9a51f3066c50e489e194b9d493e4f9d0cabbc2ff8"

  bottle :unneeded

  def install
    system "mkdir -p \"#{etc_subdirpath}\""
    system "mkdir -p \"#{var_subdirpath}\""
    system "mkdir -p \"#{log_subdirpath}\""
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
    File.join log_subdirpath, 'watch.log'
  end

  def var_subdirpath
    File.join var, name
  end

  def etc_subdirpath
    File.join etc, name
  end

  def log_subdirpath
    File.join '/usr/local/var/log/', name
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

  test do
    bin_full_path = "/usr/local/bin/#{bin_filename}"

    system bin_full_path, "--version"
    system bin_full_path, "--revision"
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
end
