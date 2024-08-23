fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
author 'Fiv3Devs'
description 'Cockpit'
version '1.0'
lua54 'yes'


shared_script 'config.lua'

client_script 'client.lua'

files {		
	'audio/*.dat151.rel'
}

data_file 'AUDIO_GAMEDATA' 'audio/cockpit_game.dat'

escrow_ignore {
  'client.lua', 
  'config.lua',    
  'stream/fiv3devs_cockpit_shell.ydr',   
  'stream/fiv3devs_cockpitsky_day.ydr',   
  'stream/fiv3devs_cockpitsky_night.ydr',   
  'stream/fiv3devs_cockpitsky_sunset.ydr',   
  'stream/fiv3devs_cockpit_sit.ydr',
  'stream/fiv3devs_plane.ydr'
}