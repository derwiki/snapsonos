class SnapSonos
  def play; speaker.play; end
  def pause; speaker.pause; end
  def next; speaker.next; end
  def previous; speaker.previous; end

  def speaker
    fail 'Missing ENV[SPEAKER_IP]!' unless ENV['SPEAKER_IP']

    return @speaker unless @speaker.nil?
    system = Sonos::System.new
    @speaker = system.speakers.find {|spk| spk.ip == ENV['SPEAKER_IP'] }
    fail 'No speaker found' unless @speaker
    @speaker
  end

  def format_now_playing
    data = speaker.now_playing
    <<-EOS.gsub(/(\n| +)/, ' ')
      #{data[:artist]} - #{data[:title]},
      #{data[:current_position]}/#{data[:track_duration]}
    EOS
  end
end
