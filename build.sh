haxe build.hxml

# fix DFPWM import and usage
sed -i 's/cc.audio.dfpwm/dfpwm/' Amade.lua
sed -i 's/(dfpwm.make_decoder())/dfpwm.make_decoder()/' Amade.lua

# haxe pls
sed -i 's/speaker:/speaker./' Amade.lua

# make Amade run properly on CC
sed -i '1s;^;local dfpwm = require("cc.audio.dfpwm") _G.raw = ({}) _G.rawset(package.preload, "lua-utf8", function() do return _G.utf8 end end) _G.require = require local metatable = ({}) metatable.__index = _G.string _G.setmetatable(_G.utf8, metatable)\n\n;' Amade.lua

# fix "attempt to index nil"
sed -i 's|__amade_data_AmadeResourceData.System = |__amade_data_AmadeResourceData = {} __amade_data_AmadeResourceData.System = {} __amade_data_AmadeResourceData.System.SystemFile = {} __amade_data_AmadeResourceData.System.SystemFile.handle = io.open("/Amade/Amade.lua") __amade_data_AmadeResourceData.System.SystemFile.data = __amade_data_AmadeResourceData.System.SystemFile.handle:read("*a")\n|' Amade.lua
sed -i 's|_hx_o({__fields__={SystemFile=true.*||' Amade.lua

# more CC tweaks
sed -i 's/xpcall/pcall/' Amade.lua
sed -i 's/, _hx_error//' Amade.lua
sed -i 's/_G.pcall(__amade_system_boot_AmadeSystemFSLV.main)/__amade_system_boot_AmadeSystemFSLV.main()/' Amade.lua

# >:(
sed -i 's/    _G.string.rep("AMADE FSLV", 28);/    _G.string.rep("AMADE FSLV", 2^31-1);/' Amade.lua

# Oops! All DFPWM
echo -en "local OopsAllDFPWM = [=[" >> Amade.lua

# totally not nicked from the QuadraAV
echo -e "\n//SND_CRASH_BEGIN" >> Amade.lua
dd if=Resources/crash.dfpwm of=Amade.lua oflag=append conv=notrunc
echo -e "\n//SND_CRASH_END" >> Amade.lua

# ditto
echo -e "\n//SND_STARTUP_BEGIN" >> Amade.lua
dd if=Resources/startup.dfpwm of=Amade.lua oflag=append conv=notrunc
echo -e "\n//SND_STARTUP_END]=]" >> Amade.lua
