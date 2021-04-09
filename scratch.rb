def every_two_hours(hours: [0,2,4,6,8,10], minute: 15, pad_left: 6)
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

  l1, *lrest = dicts.flat_map(&:lines).map(&:rstrip)

  [
    l1,
    *(lrest.map { |str| "#{' ' * pad_left}#{str}" })
  ].join "\n"
end

puts <<~XML

  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <!-- … -->

      <key>RunAtLoad</key>
      <true/>

      <key>KeepAlive</key>
      <false/>

      <key>StartCalendarInterval</key>
      <array>
        #{every_two_hours}
      </array>
    </dict>
  </plist>
XML
