
add_requires("glfw 3.3.*")

target("huhu-core")
    set_kind("shared")
    add_files("*.cpp")
    add_includedirs(".", {public = true})
    add_deps("wgpu-native")
    add_packages("glfw")
