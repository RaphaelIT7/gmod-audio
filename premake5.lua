-- Defines which version of the project generator to use, by default
-- (can be overriden by the environment variable PROJECT_GENERATOR_VERSION)
PROJECT_GENERATOR_VERSION = 3

newoption({
	trigger = "gmcommon",
	description = "Sets the path to the garrysmod_common (https://github.com/danielga/garrysmod_common) directory",
	default = "garrysmod_common"
})

local gmcommon = assert(_OPTIONS.gmcommon or os.getenv("GARRYSMOD_COMMON"),
	"you didn't provide a path to your garrysmod_common (https://github.com/danielga/garrysmod_common) directory")
include(gmcommon)
include("overrides.lua")

local current_dir = _SCRIPT_DIR
CreateWorkspace({name = "gmod_audio", abi_compatible = false})
	-- Serverside module (gmsv prefix)
	-- Can define "source_path", where the source files are located
	-- Can define "manual_files", which allows you to manually add files to the project,
	-- instead of automatically including them from the "source_path"
	-- Can also define "abi_compatible", for project specific compatibility
	CreateProject({serverside = false, manual_files = false})
		-- Remove some or all of these includes if they're not needed
		IncludeHelpersExtended()
		--IncludeLuaShared()
		--IncludeSDKEngine()
		--IncludeBootil()
		IncludeSDKCommon()
		IncludeSDKTier0()
		IncludeSDKTier1()
		--IncludeSDKTier2()
		IncludeSDKTier3()
		--IncludeSDKMathlib()
		--IncludeSDKRaytrace()
		--IncludeSDKBitmap()
		--IncludeSDKVTF()
		--IncludeSteamAPI()
		--IncludeDetouring()
		--IncludeScanning()

		targetsuffix("")
		filter("system:windows")
			files({"source/win32/*.cpp", "source/win32/*.hpp"})

		filter("system:windows", "platforms:x86_64")
			libdirs(current_dir .. "/libs/win64")
			links({"bass.lib"})

		filter("system:windows", "platforms:x86")
			libdirs(current_dir .. "/libs/win32")
			links({"bass.lib"})

		filter({"system:linux", "platforms:x86_64"})
			libdirs(current_dir .. "/libs/linux64")
			links("bass")

		filter({"system:linux", "platforms:x86"})
			libdirs(current_dir .. "/libs/linux32")
			links("bass")

		filter("system:linux or macosx")
			files({"source/posix/*.cpp", "source/posix/*.hpp"})
			targetextension(".so")