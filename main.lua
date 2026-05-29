local foldersByExtension = {
    [".txt"] = "text",
    [".md"] = "text\\markdown",
    [".markdown"] = "text\\markdown",
    [".rtf"] = "text",
    [".log"] = "text\\logs",
    [".csv"] = "data\\csv",
    [".tsv"] = "data\\tsv",
    [".json"] = "data\\json",
    [".xml"] = "data\\xml",
    [".yaml"] = "data\\yaml",
    [".yml"] = "data\\yaml",
    [".toml"] = "data\\toml",
    [".ini"] = "config",
    [".cfg"] = "config",
    [".conf"] = "config",
    [".env"] = "config\\env",

    [".pdf"] = "documents\\pdf",
    [".doc"] = "documents\\word",
    [".docx"] = "documents\\word",
    [".xls"] = "documents\\excel",
    [".xlsx"] = "documents\\excel",
    [".ppt"] = "documents\\powerpoint",
    [".pptx"] = "documents\\powerpoint",
    [".odt"] = "documents\\open_document",
    [".ods"] = "documents\\open_document",
    [".odp"] = "documents\\open_document",

    [".png"] = "images\\png",
    [".jpg"] = "images\\jpg",
    [".jpeg"] = "images\\jpg",
    [".gif"] = "images\\gif",
    [".webp"] = "images\\webp",
    [".bmp"] = "images\\bmp",
    [".tiff"] = "images\\tiff",
    [".tif"] = "images\\tiff",
    [".svg"] = "images\\svg",
    [".ico"] = "images\\icons",
    [".psd"] = "images\\photoshop",
    [".ai"] = "images\\illustrator",
    [".eps"] = "images\\vector",
    [".raw"] = "images\\raw",

    [".mp3"] = "audio\\mp3",
    [".wav"] = "audio\\wav",
    [".ogg"] = "audio\\ogg",
    [".flac"] = "audio\\flac",
    [".aac"] = "audio\\aac",
    [".m4a"] = "audio\\m4a",
    [".wma"] = "audio\\wma",
    [".mid"] = "audio\\midi",
    [".midi"] = "audio\\midi",

    [".mp4"] = "video\\mp4",
    [".mkv"] = "video\\mkv",
    [".mov"] = "video\\mov",
    [".avi"] = "video\\avi",
    [".wmv"] = "video\\wmv",
    [".flv"] = "video\\flv",
    [".webm"] = "video\\webm",
    [".mpeg"] = "video\\mpeg",
    [".mpg"] = "video\\mpeg",

    [".zip"] = "archives\\zip",
    [".rar"] = "archives\\rar",
    [".7z"] = "archives\\7z",
    [".tar"] = "archives\\tar",
    [".gz"] = "archives\\gz",
    [".bz2"] = "archives\\bz2",
    [".xz"] = "archives\\xz",
    [".iso"] = "archives\\iso",

    [".c"] = "code\\c",
    [".h"] = "code\\c",
    [".cpp"] = "code\\cpp",
    [".cc"] = "code\\cpp",
    [".cxx"] = "code\\cpp",
    [".hpp"] = "code\\cpp",
    [".hh"] = "code\\cpp",
    [".hxx"] = "code\\cpp",

    [".html"] = "code\\web\\html",
    [".htm"] = "code\\web\\html",
    [".css"] = "code\\web\\css",
    [".scss"] = "code\\web\\scss",
    [".sass"] = "code\\web\\sass",
    [".js"] = "code\\web\\javascript",
    [".jsx"] = "code\\web\\javascript",
    [".ts"] = "code\\web\\typescript",
    [".tsx"] = "code\\web\\typescript",
    [".vue"] = "code\\web\\vue",
    [".svelte"] = "code\\web\\svelte",

    [".py"] = "code\\python",
    [".lua"] = "code\\lua",
    [".rb"] = "code\\ruby",
    [".php"] = "code\\php",
    [".go"] = "code\\go",
    [".rs"] = "code\\rust",
    [".zig"] = "code\\zig",
    [".java"] = "code\\java",
    [".kt"] = "code\\kotlin",
    [".kts"] = "code\\kotlin",
    [".cs"] = "code\\csharp",
    [".fs"] = "code\\fsharp",
    [".swift"] = "code\\swift",
    [".dart"] = "code\\dart",
    [".scala"] = "code\\scala",
    [".ex"] = "code\\elixir",
    [".exs"] = "code\\elixir",
    [".erl"] = "code\\erlang",
    [".hrl"] = "code\\erlang",

    [".sh"] = "code\\shell",
    [".bash"] = "code\\shell",
    [".zsh"] = "code\\shell",
    [".fish"] = "code\\shell",
    [".bat"] = "code\\batch",
    [".cmd"] = "code\\batch",
    [".ps1"] = "code\\powershell",
    [".make"] = "code\\build",
    [".mk"] = "code\\build",
    [".cmake"] = "code\\build",
    [".gradle"] = "code\\build",

    [".sql"] = "database\\sql",
    [".db"] = "database\\sqlite",
    [".sqlite"] = "database\\sqlite",
    [".sqlite3"] = "database\\sqlite",

    [".ttf"] = "fonts\\ttf",
    [".otf"] = "fonts\\otf",
    [".woff"] = "fonts\\woff",
    [".woff2"] = "fonts\\woff2",

    [".exe"] = "apps\\exe",
    [".msi"] = "apps\\msi",
    [".apk"] = "apps\\android",
    [".appx"] = "apps\\windows",
    [".deb"] = "apps\\linux",
    [".rpm"] = "apps\\linux",

    [".obj"] = "assets\\3d\\obj",
    [".fbx"] = "assets\\3d\\fbx",
    [".gltf"] = "assets\\3d\\gltf",
    [".glb"] = "assets\\3d\\gltf",
    [".blend"] = "assets\\3d\\blender",
    [".dae"] = "assets\\3d\\collada",
    [".stl"] = "assets\\3d\\stl",
    [".mtl"] = "assets\\3d\\materials",

    [".unity"] = "game\\unity",
    [".prefab"] = "game\\unity",
    [".mat"] = "game\\materials",
    [".shader"] = "game\\shaders",
    [".hlsl"] = "game\\shaders",
    [".glsl"] = "game\\shaders",
    [".spv"] = "game\\shaders",
    [".pak"] = "game\\packages",
}

local function quote(path)
    return "'" .. path:gsub("'", "''") .. "'"
end

local function run(command)
    local handle = io.popen(command)
    if not handle then
        return ""
    end

    local result = handle:read("*a")
    handle:close()

    return result
end

local function clear()
    os.execute("cls")
end

local function getFiles(folder)
    local command =
        "powershell.exe -NoProfile -Command " ..
        [["Get-ChildItem -Path ]] ..
        quote(folder) ..
        [[ -File | ForEach-Object { $_.FullName + '|' + $_.Name + '|' + $_.Extension.ToLower() }"]]

    local output = run(command)
    local files = {}

    for line in output:gmatch("[^\r\n]+") do
        local path, name, ext = line:match("^(.-)|(.-)|(.+)$")

        if path and name and ext then
            table.insert(files, {
                path = path,
                name = name,
                extension = ext,
            })
        end
    end

    return files
end

local function ensureFolder(path)
    local command =
        "powershell.exe -NoProfile -Command " ..
        [["New-Item -Path ]] ..
        quote(path) ..
        [[ -ItemType Directory -Force | Out-Null"]]

    run(command)
end

local function moveFile(filePath, targetFolder)
    local command =
        "powershell.exe -NoProfile -Command " ..
        [["Move-Item -Path ]] ..
        quote(filePath) ..
        [[ -Destination ]] ..
        quote(targetFolder) ..
        [[ -Force"]]

    run(command)
end

local function organize(folderTarget, files)
    local moved = 0
    local skipped = 0

    for _, file in ipairs(files) do
        local targetSubFolder = foldersByExtension[file.extension]

        if targetSubFolder then
            local destination = folderTarget .. "\\" .. targetSubFolder

            ensureFolder(destination)
            moveFile(file.path, destination)

            moved = moved + 1
        else
            skipped = skipped + 1
        end
    end

    return moved, skipped
end

clear()

print("================================")
print("        ASSET ORGANIZER")
print("================================")
print("")
io.write("Masukan folder target: ")

local folderTarget = io.read()

if not folderTarget or folderTarget == "" then
    print("Folder tidak valid.")
    os.exit(1)
end

local files = getFiles(folderTarget)

clear()

print("================================")
print("        ORGANIZE PREVIEW")
print("================================")
print("")
print("Folder : " .. folderTarget)
print("Files  : " .. #files)
print("")

local movable = 0
local skipped = 0

for _, file in ipairs(files) do
    if foldersByExtension[file.extension] then
        movable = movable + 1
    else
        skipped = skipped + 1
    end
end

print("Akan dipindahkan : " .. movable)
print("Akan dilewati    : " .. skipped)
print("")

io.write("Yakin mau organize? (y/n): ")
local confirm = io.read()

if confirm ~= "y" and confirm ~= "Y" then
    print("Dibatalkan.")
    os.exit(0)
end

local movedCount, skippedCount = organize(folderTarget, files)

print("")
print("Selesai.")
print("Moved   : " .. movedCount)
print("Skipped : " .. skippedCount)
