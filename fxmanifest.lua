game 'common'
fx_version 'cerulean'

dependencies {
    'HPRPC-menus'

}

server_script {
    'server.lua'

}



client_script {
    '@HPRPC-menus/client/menus.lua',
    'client.lua',
    'tracking.lua'
    
}