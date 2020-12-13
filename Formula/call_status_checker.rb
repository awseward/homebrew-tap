class CallStatusChecker < Formula
  desc     'Checks Zoom to update call status'
  homepage 'https://github.com/awseward/call_status'
  url 'https://github.com/awseward/call_status/releases/download/0.4.1/call_status_checker-0.4.1.tar.gz'
  sha256 'c0d41f2e7dac729710a932f41d19f4ab9a999f0c226832d680edb216d70be7f3'

  bottle :unneeded

  def install
    [
      etc_subdirpath,
      var_subdirpath,
      log_subdirpath,
    ].each { |dir| system "mkdir -p \"#{dir}\"" }

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

      If this is your first time installing this, the application will not know
      who you are until you identify yourself. Do so by running:

        #{bin_filename} config -u <your_username>

    MSG
  end

  private

  def bin_filename
    "call_status_checker"
  end

  def bin_abs_path
    "/usr/local/bin/#{bin_filename}"
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
end
