add_rules("mode.debug", "mode.release")

add_repositories("local-repo Libraries/xmake-repo")

add_requires("boost ~1.81", {
    configs = {
        all = true,
        multi = true,
    }
})

includes("Source/**/xmake.lua")
includes("Libraries/**/xmake.lua")
includes("Programs/**/xmake.lua")

