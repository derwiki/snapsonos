# snapsonos
Control Sonos via this Slackbot

## Usage
This server must be running on the same subnet as your Sonos server
```
SLACK_API_TOKEN=xxx SPEAKER_IP=xxx ruby server.rb
```

## Bot Commands
`sonos what is this` - current track information
`sonos play` - start playing music
`sonos pause` - pause currently playing music
`sonos next` - skip to the next track
`sonos previous` - play the previous track
