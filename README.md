# whip_media_props

Prop pictures for [WHIP](https://github.com/WHIPFX/txAdmin-recipe)'s furniture catalog and prop pickers: 14,637
pictures, one per model.

It's one of WHIP's five media packs, which hold the pictures, videos and map that `whip_core` shows. They're kept apart
from whip_core so its updates stay small: a player downloads each pack once, and again only when that pack changes.

## Installation

WHIP's txAdmin recipe installs it in `resources/[assets]/[media]`.

By hand, put the `whip_media_props` folder in `resources/[assets]/[media]` and make sure `server.cfg` has
`ensure [assets]`. The packs start in any order, before or after `whip_core`. If one is missing or not started,
whip_core's setup report says so: type `whipsetup` in the server console.

On GTA V Enhanced, `set sv_resourceFileDownloadTimeout 600000` gives players on slow connections time to download
the packs. WHIP's Enhanced recipe writes it.

## Adding pictures

A prop's picture is `img/props/<model>.webp`, a 256 px WebP. Restart this pack to send new pictures to players, and
`whip_core` to show them in the catalog: whip_core checks which props have a picture when it starts.

When you update the pack, copy out any pictures you added before you replace the folder.

## License

The pictures are made from Grand Theft Auto V and are Rockstar Games' material, used under the Cfx.re Creator
Platform License Agreement. WHIP's licence doesn't cover them. The code (`fxmanifest.lua`, `server.lua`) is WHIP's,
under the GNU LGPL 3.0 (whip_core's `LICENSE`). See `NOTICE.md`, and whip_core's `NOTICE.md` for the full notice.

WHIP is not affiliated with, endorsed or sponsored by Rockstar Games or Take-Two Interactive.
