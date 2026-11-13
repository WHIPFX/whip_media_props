-- ============================================
-- whip_media_* — saving pictures for whip_core
-- ============================================
--
-- FXServer lets a resource write files only inside its OWN folder: SaveResourceFile, io.open and
-- os.remove all refuse a path in another resource. whip_core's picture tools — /propsnap for the
-- furniture catalog, the Vehicle Snapshot tool for cars — keep their pictures in a media pack, so
-- the saving has to happen there too. whip_core asks the one that holds the picture
-- (WhipAssets.resourceFor), checks who is asking and what they sent; this checks the name and the
-- file, and writes it. The same file in every media pack.
--
-- Server only: players never download this file.

local ME = GetCurrentResourceName()

--- Where each kind of picture lives, inside this resource.
local FOLDERS = {
    props    = 'img/props/',
    vehicles = 'img/vehicles/',
}

--- The file a picture goes to, or nil and why not.
---@param kind string  'props' | 'vehicles'
---@param name string  the model name
---@return string|nil path, string|nil why
local function pathFor(kind, name)
    -- ONLY whip_core. Anything else that could write here could replace the pictures every player
    -- downloads.
    if GetInvokingResource() ~= 'whip_core' then return nil, 'only whip_core saves pictures here' end
    local dir = FOLDERS[kind]
    if not dir then return nil, 'unknown kind of picture: ' .. tostring(kind) end
    -- A model name: letters, digits, _ and -. Nothing that could climb out of the folder.
    if type(name) ~= 'string' or #name == 0 or #name > 80 or not name:match('^[%w_%-]+$') then
        return nil, 'not a model name: ' .. tostring(name)
    end
    return dir .. name:lower() .. '.webp'
end

--- Save a picture. Returns true, or false and why.
---@param kind string  'props' | 'vehicles'
---@param name string  the model name
---@param data string  the WebP file's bytes
exports('SavePicture', function(kind, name, data)
    local path, why = pathFor(kind, name)
    if not path then return false, why end
    if type(data) ~= 'string' or #data <= 12 or data:sub(1, 4) ~= 'RIFF' or data:sub(9, 12) ~= 'WEBP' then
        return false, 'not a WebP'
    end
    if not SaveResourceFile(ME, path, data, #data) then return false, 'disk write failed' end
    return true
end)

--- Delete a picture. Returns true and whether the file is really gone, or false and why.
---
--- EMPTIED IF IT CANNOT BE REMOVED. There is no native for deleting a file, and os.remove refuses
--- on some server builds. An empty file counts as no picture everywhere whip looks, so the picture
--- is gone either way — the second answer just says whether a 0-byte file was left behind.
---@param kind string  'props' | 'vehicles'
---@param name string  the model name
exports('RemovePicture', function(kind, name)
    local path, why = pathFor(kind, name)
    if not path then return false, why end
    if os.remove(('@%s/%s'):format(ME, path)) then return true, true end
    if os.remove(('%s/%s'):format(GetResourcePath(ME), path)) then return true, true end
    SaveResourceFile(ME, path, '', 0)
    return true, false
end)
