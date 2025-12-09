fx_version 'adamant'

game 'gta5'

description 'ES Extended'

lua54 'yes'
version '1.9.4'

--usage ""
shared_scripts {
	--'locale.lua',
	'shared/fr.lua',
	'gab.lua',
	'shared/config.lua',
	'shared/config.weapons.lua',
	'shared/async.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'shared/fr.lua',
	'shared/config.logs.lua',
	'server/interaction/common.lua',
	'server/modules/callback.lua',
	'server/classes/player.lua',
	'server/classes/overrides/*.lua',
	'server/interaction/functions.lua',
	'server/interaction/onesync.lua',
	'server/interaction/paycheck.lua',

	'server/interaction/main.lua',
	'server/interaction/commands.lua',

	'common/modules/*.lua',
	'common/functions.lua',
	'server/modules/actions.lua',
	'server/modules/npwd.lua',
	'server/interaction/sv_hardcap.lua',
	'fivem/sessionmanager/host_lock.lua',
	'fivem/esx_skin/server/main.lua',
}

client_scripts {
	'shared/fr.lua',
	'client/interaction/common.lua',
	'client/interaction/functions.lua',
	'client/interaction/wrapper.lua',
	'client/modules/callback.lua',
    'client/interaction/main.lua',
	
	'common/modules/*.lua',
	'common/functions.lua',

	'client/modules/actions.lua',
	'client/modules/death.lua',
	'client/modules/npwd.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',
	'fivem/spawn/spawnmanager.lua',
	'fivem/skinchanger/client/main.lua',
	'fivem/esx_skin/client/main.lua',


}

files {
	'imports.lua',
}

dependencies {
	'/native:0x6AE51D4B',
	'oxmysql',
	--'spawnmanager',
}
