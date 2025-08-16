local action = _ACTION or ""

workspace "libtess2"
    location "Build"
    configurations { "Debug", "Release" }
    platforms { "native", "x64", "x32" }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"
        warnings "Extra"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"
        warnings "Extra"

    -- Reset filter
    filter {}

project "tess2"
    language "C"
    kind "StaticLib"
    includedirs { "Include", "Source" }
    files { "Source/*.c" }
    targetdir "Build"

project "example"
    kind "ConsoleApp"
    language "C"
    links { "tess2" }
    files { "Example/example.c", "Contrib/*.c" }
    includedirs { "Include", "Contrib" }
    targetdir "Build"

    filter "system:bsd"
        linkoptions { "`pkg-config --libs glfw3`" }
        includedirs { "/usr/local/include" }
        links { "GL", "GLU", "m", "GLEW" }
        defines { "NANOVG_GLEW" }
    filter "system:linux"
        linkoptions { "`pkg-config --libs glfw3`" }
        links { "GL", "GLU", "m", "GLEW" }
        defines { "NANOVG_GLEW" }

    filter "system:windows"
        links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32", "opengl32" }
        defines { "NANOVG_GLEW" }

    filter "system:macosx"
        links { "glfw3" }
        linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }

    -- Reset filter
    filter {}

