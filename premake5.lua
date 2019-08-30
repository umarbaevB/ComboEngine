workspace "Combo"
    architecture "x86_64"
    startproject "App"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

--IncludeDir = {}
--IncludeDir["SDL2"] = "libs/SDL2/include"
--IncludeDir["GLAD"] = "libs/glad/include"
--IncludeDir["ImGui"] = "libs/imgui"
--IncludeDir["GLM"] = "libs/glm"


--group "Dependencies"
--    include "libs/glad"
--    include "libs/imgui"
     

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


project "Combo"
    location "src/Combo"
    kind "StaticLib" --StaticLib/SharedLib
    language "C++"
    cppdialect "C++11" --C++11/14/17
    staticruntime "on"
    systemversion "latest"

    targetdir ("build/" .. outputdir .. "/%{prj.name}")
    objdir ("build-interm/" .. outputdir .. "/%{prj.name}")

    pchheader "combopch.h"
    pchsource "src/Combo/combopch.cpp"

    files
    {
        "src/%{prj.name}/**.h",
        "src/%{prj.name}/**.cpp",
    }
    
    removefiles("src/%{prj.name}/not_used/**")
    
    includedirs
    {
        "src/%{prj.name}/",
        "libs/spdlog/include/",
        "libs/"
    }
    --links {"Glad" , "ImGui"}
    filter {"system:linux"}
        buildoptions{
            "-lSDL2", "-lSDL2main"
            --"-lGLEW", "-lGLU", "-lGL"
        }
        linkoptions{
            "-lSDL2",
            "-lSDL2main"
            --"-lGLEW", "-lGLU", "-lGL"
        }

   filter "system:windows" --includedirs {"%{IncludeDir.SDL2}"} libdirs {"%{LibDir.SDL2}"}
        links{
            "opengl32.lib"
        }

  
    filter "configurations:Debug"
		defines "COMBO_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "COMBO_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "COMBO_DIST"
		runtime "Release"
		optimize "on"
        
        
project "Application"
    location "src/Application"    
    kind "ConsoleApp" --StaticLib/SharedLib
    language "C++"
    cppdialect "C++11" --C++11/14/17
    staticruntime "on"
    systemversion "latest"

    targetdir ("build/" .. outputdir .. "/%{prj.name}")
    objdir ("build-interm/" .. outputdir .. "/%{prj.name}")

    files
    {
        "src/%{prj.name}/**.h",
        "src/%{prj.name}/**.cpp"
    }

    includedirs
    {
        "src/%{prj.name}/",
        "src/",
        "libs/spdlog/include/"
    }

    links
    {
        "Combo"
    }
    filter {"system:linux"}
        buildoptions{
            "-lSDL2", "-lSDL2main"
            --"-lGLEW", "-lGLU", "-lGL"
        }
        linkoptions{
            "-lSDL2",
            "-lSDL2main"
            --"-lGLEW", "-lGLU", "-lGL"
        }

    filter "configurations:Debug"
		defines "COMBO_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "COMBO_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "COMBO_DIST"
		runtime "Release"
		optimize "on"
        