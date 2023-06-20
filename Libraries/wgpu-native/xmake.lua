add_requires("python 3.x", {kind = "binary", host = true})

target("wgpu-native")

set_kind("headeronly")
add_includedirs("include", {public = true})
on_load(function (target)
    local xmake_dir = target:scriptdir()

    os.runv("python", {xmake_dir .. "/fetch_default_values.py", "-s", xmake_dir .. "/spec.json", "-d", xmake_dir .. "/defaults.txt"})
    os.runv("python", { xmake_dir .. "/generate.py", "-u", "https://raw.githubusercontent.com/webgpu-native/webgpu-headers/main/webgpu.h", "-t", xmake_dir .. "/webgpu.template.hpp", "-o", xmake_dir .. "/include/wgpu.hpp" })
end)
