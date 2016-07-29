require 'dotenv'
Dotenv.load

require 'sonos'
require 'slack-ruby-client'

require_relative 'lib/snap_sonos'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new
snap_sonos = SnapSonos.new

client.on :message do |data|
  channel = data['channel']
  puts data
  case data['text']
  when /sonos what is this\?*/i
    client.message channel: channel, text: "#{snap_sonos.format_now_playing}"
  when 'sonos play'
    snap_sonos.play
  when 'sonos pause'
    snap_sonos.pause
  when 'sonos next'
    snap_sonos.next
    client.message channel: channel, text: "Now playing: #{snap_sonos.format_now_playing}"
  when 'sonos previous'
    snap_sonos.previous
    client.message channel: channel, text: "Now playing: #{snap_sonos.format_now_playing}"
  when /^sonos/
    client.message channel: channel, text: "Sorry <@#{data['user']}>, what?"
  end
end

puts "Connected to Sonos on #{ENV['SPEAKER_IP']}"
client.start!
