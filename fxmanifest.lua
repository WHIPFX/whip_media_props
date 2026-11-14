fx_version 'cerulean'
game 'gta5'

name 'whip_media_props'
author 'Whippy'
description 'whip\'s prop pictures: the furniture catalog and the object viewer.'
version '1.0.0'
lua54 'yes'

-- A MEDIA PACK: whip's pictures, videos and map live apart from whip_core, one pack per category, so a change to one
-- is downloaded again for that pack alone (whip_media_clothing_male/fxmanifest.lua says why). whip_core's
-- shared/assets_index.lua (whip_core/dev/assets_index.mjs) says which pack holds what.
whip_media_pack 'yes'   -- how whip_core's dev tools find the packs, wherever they are in the resources folder

-- Saves pictures for whip_core (/propsnap): the same file in every media pack. Server only.
server_script 'server.lua'

files {
    -- The furniture catalog's icons, one per model: img/props/<model>.webp (256 px WebP, quality 80), made outside
    -- the game and copied in, or taken in game with /propsnap; whip_core notices new or missing ones each time it
    -- starts. Past 256 MB the props carry on in a second pack (whip_media_props_2), a run of names in each (see
    -- whip_core/dev/assets_index.mjs).
    'img/props/*.webp',
}
