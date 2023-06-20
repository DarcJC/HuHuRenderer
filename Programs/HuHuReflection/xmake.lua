add_requires("llvm-local", {
    kind = "library",
    configs = {
        clang = true,
    },
    alias = "llvm"
})

local generated_code_path = "$(buildir)/.refl"

target("huhu-reflection-parser")
    set_kind("binary")
    add_files("Source/*.cpp")
    add_packages("llvm", { components = {"clang"} })
    add_packages("boost")
    set_languages("c++latest")
    on_config(
        function (target)
            os.mkdir(generated_code_path)
            -- Disable the warning about the empty directory.
            io.writefile(generated_code_path .. "/Placeholder.cpp", "// This file is a placeholder for the generated code.\n")
        end
    )
    after_build(
        function (target)
            os.exec("\"%s\" --generate --intermediate=" .. generated_code_path .. " --path=${projectdir}", target:targetfile())
        end
    )


target("huhu-reflection")
    set_kind("static")
    add_includedirs("Public", {public = true})
    add_deps("huhu-reflection-parser")
    add_files("../../" .. generated_code_path .. "/*.cpp")
