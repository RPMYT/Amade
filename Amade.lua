local dfpwm = require("cc.audio.dfpwm") _G.raw = ({}) _G.rawset(package.preload, "lua-utf8", function() do return _G.utf8 end end) _G.require = require local metatable = ({}) metatable.__index = _G.string _G.setmetatable(_G.utf8, metatable)

local _hx_hidden = {__id__=true, hx__closures=true, super=true, prototype=true, __fields__=true, __ifields__=true, __class__=true, __properties__=true, __fields__=true, __name__=true}

_hx_array_mt = {
    __newindex = function(t,k,v)
        local len = t.length
        t.length =  k >= len and (k + 1) or len
        rawset(t,k,v)
    end
}

function _hx_is_array(o)
    return type(o) == "table"
        and o.__enum__ == nil
        and getmetatable(o) == _hx_array_mt
end



function _hx_tab_array(tab, length)
    tab.length = length
    return setmetatable(tab, _hx_array_mt)
end



function _hx_print_class(obj, depth)
    local first = true
    local result = ''
    for k,v in pairs(obj) do
        if _hx_hidden[k] == nil then
            if first then
                first = false
            else
                result = result .. ', '
            end
            if _hx_hidden[k] == nil then
                result = result .. k .. ':' .. _hx_tostring(v, depth+1)
            end
        end
    end
    return '{ ' .. result .. ' }'
end

function _hx_print_enum(o, depth)
    if o.length == 2 then
        return o[0]
    else
        local str = o[0] .. "("
        for i = 2, (o.length-1) do
            if i ~= 2 then
                str = str .. "," .. _hx_tostring(o[i], depth+1)
            else
                str = str .. _hx_tostring(o[i], depth+1)
            end
        end
        return str .. ")"
    end
end

function _hx_tostring(obj, depth)
    if depth == nil then
        depth = 0
    elseif depth > 5 then
        return "<...>"
    end

    local tstr = _G.type(obj)
    if tstr == "string" then return obj
    elseif tstr == "nil" then return "null"
    elseif tstr == "number" then
        if obj == _G.math.POSITIVE_INFINITY then return "Infinity"
        elseif obj == _G.math.NEGATIVE_INFINITY then return "-Infinity"
        elseif obj == 0 then return "0"
        elseif obj ~= obj then return "NaN"
        else return _G.tostring(obj)
        end
    elseif tstr == "boolean" then return _G.tostring(obj)
    elseif tstr == "userdata" then
        local mt = _G.getmetatable(obj)
        if mt ~= nil and mt.__tostring ~= nil then
            return _G.tostring(obj)
        else
            return "<userdata>"
        end
    elseif tstr == "function" then return "<function>"
    elseif tstr == "thread" then return "<thread>"
    elseif tstr == "table" then
        if obj.__enum__ ~= nil then
            return _hx_print_enum(obj, depth)
        elseif obj.toString ~= nil and not _hx_is_array(obj) then return obj:toString()
        elseif _hx_is_array(obj) then
            if obj.length > 5 then
                return "[...]"
            else
                local str = ""
                for i=0, (obj.length-1) do
                    if i == 0 then
                        str = str .. _hx_tostring(obj[i], depth+1)
                    else
                        str = str .. "," .. _hx_tostring(obj[i], depth+1)
                    end
                end
                return "[" .. str .. "]"
            end
        elseif obj.__class__ ~= nil then
            return _hx_print_class(obj, depth)
        else
            local buffer = {}
            local ref = obj
            if obj.__fields__ ~= nil then
                ref = obj.__fields__
            end
            for k,v in pairs(ref) do
                if _hx_hidden[k] == nil then
                    _G.table.insert(buffer, _hx_tostring(k, depth+1) .. ' : ' .. _hx_tostring(obj[k], depth+1))
                end
            end

            return "{ " .. table.concat(buffer, ", ") .. " }"
        end
    else
        _G.error("Unknown Lua type", 0)
        return ""
    end
end

function _hx_error(obj)
    if obj.value then
        _G.print("runtime error:\n " .. _hx_tostring(obj.value));
    else
        _G.print("runtime error:\n " .. tostring(obj));
    end

    if _G.debug and _G.debug.traceback then
        _G.print(debug.traceback());
    end
end


local function _hx_obj_newindex(t,k,v)
    t.__fields__[k] = true
    rawset(t,k,v)
end

local _hx_obj_mt = {__newindex=_hx_obj_newindex, __tostring=_hx_tostring}

local function _hx_a(...)
  local __fields__ = {};
  local ret = {__fields__ = __fields__};
  local max = select('#',...);
  local tab = {...};
  local cur = 1;
  while cur < max do
    local v = tab[cur];
    __fields__[v] = true;
    ret[v] = tab[cur+1];
    cur = cur + 2
  end
  return setmetatable(ret, _hx_obj_mt)
end

local function _hx_e()
  return setmetatable({__fields__ = {}}, _hx_obj_mt)
end

local function _hx_o(obj)
  return setmetatable(obj, _hx_obj_mt)
end

local function _hx_new(prototype)
  return setmetatable({__fields__ = {}}, {__newindex=_hx_obj_newindex, __index=prototype, __tostring=_hx_tostring})
end

function _hx_field_arr(obj)
    res = {}
    idx = 0
    if obj.__fields__ ~= nil then
        obj = obj.__fields__
    end
    for k,v in pairs(obj) do
        if _hx_hidden[k] == nil then
            res[idx] = k
            idx = idx + 1
        end
    end
    return _hx_tab_array(res, idx)
end

local _hxClasses = {}
local Int = _hx_e();
local Dynamic = _hx_e();
local Float = _hx_e();
local Bool = _hx_e();
local Class = _hx_e();
local Enum = _hx_e();

local Array = _hx_e()
__lua_lib_luautf8_Utf8 = _G.require("lua-utf8")
local Math = _hx_e()
local String = _hx_e()
local Std = _hx_e()
__amade_data_AmadeResourceData = _hx_e()
__amade_system_boot_AmadeSystemFSLV = _hx_e()
__amade_system_boot_AmadeSystemSSLV = _hx_e()
__amade_system_shell_AmadeShell = _hx_e()
__haxe_iterators_ArrayIterator = _hx_e()
__haxe_iterators_ArrayKeyValueIterator = _hx_e()
__lua_PairTools = _hx_e()

local _hx_bind, _hx_bit, _hx_staticToInstance, _hx_funcToField, _hx_maxn, _hx_print, _hx_apply_self, _hx_box_mr, _hx_bit_clamp, _hx_table, _hx_bit_raw
local _hx_pcall_default = {};
local _hx_pcall_break = {};

Array.new = function() 
  local self = _hx_new(Array.prototype)
  Array.super(self)
  return self
end
Array.super = function(self) 
  _hx_tab_array(self, 0);
end
Array.prototype = _hx_e();
Array.prototype.concat = function(self,a) 
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  while (_g1 < self.length) do 
    local i = self[_g1];
    _g1 = _g1 + 1;
    _g:push(i);
  end;
  local _g1 = 0;
  while (_g1 < a.length) do 
    local i = a[_g1];
    _g1 = _g1 + 1;
    _g:push(i);
  end;
  do return _g end
end
Array.prototype.join = function(self,sep) 
  local tbl = ({});
  local _g_current = 0;
  while (_g_current < self.length) do 
    _g_current = _g_current + 1;
    _G.table.insert(tbl, Std.string(self[_g_current - 1]));
  end;
  do return _G.table.concat(tbl, sep) end
end
Array.prototype.pop = function(self) 
  if (self.length == 0) then 
    do return nil end;
  end;
  local ret = self[self.length - 1];
  self[self.length - 1] = nil;
  self.length = self.length - 1;
  do return ret end
end
Array.prototype.push = function(self,x) 
  self[self.length] = x;
  do return self.length end
end
Array.prototype.reverse = function(self) 
  local tmp;
  local i = 0;
  while (i < Std.int(self.length / 2)) do 
    tmp = self[i];
    self[i] = self[(self.length - i) - 1];
    self[(self.length - i) - 1] = tmp;
    i = i + 1;
  end;
end
Array.prototype.shift = function(self) 
  if (self.length == 0) then 
    do return nil end;
  end;
  local ret = self[0];
  if (self.length == 1) then 
    self[0] = nil;
  else
    if (self.length > 1) then 
      self[0] = self[1];
      _G.table.remove(self, 1);
    end;
  end;
  local tmp = self;
  tmp.length = tmp.length - 1;
  do return ret end
end
Array.prototype.slice = function(self,pos,_end) 
  if ((_end == nil) or (_end > self.length)) then 
    _end = self.length;
  else
    if (_end < 0) then 
      _end = _G.math.fmod((self.length - (_G.math.fmod(-_end, self.length))), self.length);
    end;
  end;
  if (pos < 0) then 
    pos = _G.math.fmod((self.length - (_G.math.fmod(-pos, self.length))), self.length);
  end;
  if ((pos > _end) or (pos > self.length)) then 
    do return _hx_tab_array({}, 0) end;
  end;
  local ret = _hx_tab_array({}, 0);
  local _g = pos;
  local _g1 = _end;
  while (_g < _g1) do 
    _g = _g + 1;
    ret:push(self[_g - 1]);
  end;
  do return ret end
end
Array.prototype.sort = function(self,f) 
  local i = 0;
  local l = self.length;
  while (i < l) do 
    local swap = false;
    local j = 0;
    local max = (l - i) - 1;
    while (j < max) do 
      if (f(self[j], self[j + 1]) > 0) then 
        local tmp = self[j + 1];
        self[j + 1] = self[j];
        self[j] = tmp;
        swap = true;
      end;
      j = j + 1;
    end;
    if (not swap) then 
      break;
    end;
    i = i + 1;
  end;
end
Array.prototype.splice = function(self,pos,len) 
  if ((len < 0) or (pos > self.length)) then 
    do return _hx_tab_array({}, 0) end;
  else
    if (pos < 0) then 
      pos = self.length - (_G.math.fmod(-pos, self.length));
    end;
  end;
  len = Math.min(len, self.length - pos);
  local ret = _hx_tab_array({}, 0);
  local _g = pos;
  local _g1 = pos + len;
  while (_g < _g1) do 
    _g = _g + 1;
    local i = _g - 1;
    ret:push(self[i]);
    self[i] = self[i + len];
  end;
  local _g = pos + len;
  local _g1 = self.length;
  while (_g < _g1) do 
    _g = _g + 1;
    local i = _g - 1;
    self[i] = self[i + len];
  end;
  self.length = self.length - len;
  do return ret end
end
Array.prototype.toString = function(self) 
  local tbl = ({});
  _G.table.insert(tbl, "[");
  _G.table.insert(tbl, self:join(","));
  _G.table.insert(tbl, "]");
  do return _G.table.concat(tbl, "") end
end
Array.prototype.unshift = function(self,x) 
  local len = self.length;
  local _g = 0;
  while (_g < len) do 
    _g = _g + 1;
    local i = _g - 1;
    self[len - i] = self[(len - i) - 1];
  end;
  self[0] = x;
end
Array.prototype.insert = function(self,pos,x) 
  if (pos > self.length) then 
    pos = self.length;
  end;
  if (pos < 0) then 
    pos = self.length + pos;
    if (pos < 0) then 
      pos = 0;
    end;
  end;
  local cur_len = self.length;
  while (cur_len > pos) do 
    self[cur_len] = self[cur_len - 1];
    cur_len = cur_len - 1;
  end;
  self[pos] = x;
end
Array.prototype.remove = function(self,x) 
  local _g = 0;
  local _g1 = self.length;
  while (_g < _g1) do 
    _g = _g + 1;
    local i = _g - 1;
    if (self[i] == x) then 
      local _g = i;
      local _g1 = self.length - 1;
      while (_g < _g1) do 
        _g = _g + 1;
        local j = _g - 1;
        self[j] = self[j + 1];
      end;
      self[self.length - 1] = nil;
      self.length = self.length - 1;
      do return true end;
    end;
  end;
  do return false end
end
Array.prototype.contains = function(self,x) 
  local _g = 0;
  local _g1 = self.length;
  while (_g < _g1) do 
    _g = _g + 1;
    if (self[_g - 1] == x) then 
      do return true end;
    end;
  end;
  do return false end
end
Array.prototype.indexOf = function(self,x,fromIndex) 
  local _end = self.length;
  if (fromIndex == nil) then 
    fromIndex = 0;
  else
    if (fromIndex < 0) then 
      fromIndex = self.length + fromIndex;
      if (fromIndex < 0) then 
        fromIndex = 0;
      end;
    end;
  end;
  local _g = fromIndex;
  while (_g < _end) do 
    _g = _g + 1;
    local i = _g - 1;
    if (x == self[i]) then 
      do return i end;
    end;
  end;
  do return -1 end
end
Array.prototype.lastIndexOf = function(self,x,fromIndex) 
  if ((fromIndex == nil) or (fromIndex >= self.length)) then 
    fromIndex = self.length - 1;
  else
    if (fromIndex < 0) then 
      fromIndex = self.length + fromIndex;
      if (fromIndex < 0) then 
        do return -1 end;
      end;
    end;
  end;
  local i = fromIndex;
  while (i >= 0) do 
    if (self[i] == x) then 
      do return i end;
    else
      i = i - 1;
    end;
  end;
  do return -1 end
end
Array.prototype.copy = function(self) 
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  while (_g1 < self.length) do 
    local i = self[_g1];
    _g1 = _g1 + 1;
    _g:push(i);
  end;
  do return _g end
end
Array.prototype.map = function(self,f) 
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  while (_g1 < self.length) do 
    local i = self[_g1];
    _g1 = _g1 + 1;
    _g:push(f(i));
  end;
  do return _g end
end
Array.prototype.filter = function(self,f) 
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  while (_g1 < self.length) do 
    local i = self[_g1];
    _g1 = _g1 + 1;
    if (f(i)) then 
      _g:push(i);
    end;
  end;
  do return _g end
end
Array.prototype.iterator = function(self) 
  do return __haxe_iterators_ArrayIterator.new(self) end
end
Array.prototype.keyValueIterator = function(self) 
  do return __haxe_iterators_ArrayKeyValueIterator.new(self) end
end
Array.prototype.resize = function(self,len) 
  if (self.length < len) then 
    self.length = len;
  else
    if (self.length > len) then 
      local _g = len;
      local _g1 = self.length;
      while (_g < _g1) do 
        _g = _g + 1;
        self[_g - 1] = nil;
      end;
      self.length = len;
    end;
  end;
end

Math.new = {}
Math.isNaN = function(f) 
  do return f ~= f end;
end
Math.isFinite = function(f) 
  if (f > -_G.math.huge) then 
    do return f < _G.math.huge end;
  else
    do return false end;
  end;
end
Math.min = function(a,b) 
  if (Math.isNaN(a) or Math.isNaN(b)) then 
    do return (0/0) end;
  else
    do return _G.math.min(a, b) end;
  end;
end

String.new = function(string) 
  local self = _hx_new(String.prototype)
  String.super(self,string)
  self = string
  return self
end
String.super = function(self,string) 
end
String.__index = function(s,k) 
  if (k == "length") then 
    do return __lua_lib_luautf8_Utf8.len(s) end;
  else
    local o = String.prototype;
    local field = k;
    if ((function() 
      local _hx_1
      if ((_G.type(o) == "string") and ((String.prototype[field] ~= nil) or (field == "length"))) then 
      _hx_1 = true; elseif (o.__fields__ ~= nil) then 
      _hx_1 = o.__fields__[field] ~= nil; else 
      _hx_1 = o[field] ~= nil; end
      return _hx_1
    end )()) then 
      do return String.prototype[k] end;
    else
      if (String.__oldindex ~= nil) then 
        if (_G.type(String.__oldindex) == "function") then 
          do return String.__oldindex(s, k) end;
        else
          if (_G.type(String.__oldindex) == "table") then 
            do return String.__oldindex[k] end;
          end;
        end;
        do return nil end;
      else
        do return nil end;
      end;
    end;
  end;
end
String.indexOfEmpty = function(s,startIndex) 
  local length = __lua_lib_luautf8_Utf8.len(s);
  if (startIndex < 0) then 
    startIndex = length + startIndex;
    if (startIndex < 0) then 
      startIndex = 0;
    end;
  end;
  if (startIndex > length) then 
    do return length end;
  else
    do return startIndex end;
  end;
end
String.fromCharCode = function(code) 
  do return __lua_lib_luautf8_Utf8.char(code) end;
end
String.prototype = _hx_e();
String.prototype.toUpperCase = function(self) 
  do return __lua_lib_luautf8_Utf8.upper(self) end
end
String.prototype.toLowerCase = function(self) 
  do return __lua_lib_luautf8_Utf8.lower(self) end
end
String.prototype.indexOf = function(self,str,startIndex) 
  if (startIndex == nil) then 
    startIndex = 1;
  else
    startIndex = startIndex + 1;
  end;
  if (str == "") then 
    do return String.indexOfEmpty(self, startIndex - 1) end;
  end;
  local r = __lua_lib_luautf8_Utf8.find(self, str, startIndex, true);
  if ((r ~= nil) and (r > 0)) then 
    do return r - 1 end;
  else
    do return -1 end;
  end;
end
String.prototype.lastIndexOf = function(self,str,startIndex) 
  local ret = -1;
  if (startIndex == nil) then 
    startIndex = __lua_lib_luautf8_Utf8.len(self);
  end;
  while (true) do 
    local startIndex1 = ret + 1;
    if (startIndex1 == nil) then 
      startIndex1 = 1;
    else
      startIndex1 = startIndex1 + 1;
    end;
    local p;
    if (str == "") then 
      p = String.indexOfEmpty(self, startIndex1 - 1);
    else
      local r = __lua_lib_luautf8_Utf8.find(self, str, startIndex1, true);
      p = (function() 
        local _hx_1
        if ((r ~= nil) and (r > 0)) then 
        _hx_1 = r - 1; else 
        _hx_1 = -1; end
        return _hx_1
      end )();
    end;
    if (((p == -1) or (p > startIndex)) or (p == ret)) then 
      break;
    end;
    ret = p;
  end;
  do return ret end
end
String.prototype.split = function(self,delimiter) 
  local idx = 1;
  local ret = _hx_tab_array({}, 0);
  while (idx ~= nil) do 
    local newidx = 0;
    if (__lua_lib_luautf8_Utf8.len(delimiter) > 0) then 
      newidx = __lua_lib_luautf8_Utf8.find(self, delimiter, idx, true);
    else
      if (idx >= __lua_lib_luautf8_Utf8.len(self)) then 
        newidx = nil;
      else
        newidx = idx + 1;
      end;
    end;
    if (newidx ~= nil) then 
      ret:push(__lua_lib_luautf8_Utf8.sub(self, idx, newidx - 1));
      idx = newidx + __lua_lib_luautf8_Utf8.len(delimiter);
    else
      ret:push(__lua_lib_luautf8_Utf8.sub(self, idx, __lua_lib_luautf8_Utf8.len(self)));
      idx = nil;
    end;
  end;
  do return ret end
end
String.prototype.toString = function(self) 
  do return self end
end
String.prototype.substring = function(self,startIndex,endIndex) 
  if (endIndex == nil) then 
    endIndex = __lua_lib_luautf8_Utf8.len(self);
  end;
  if (endIndex < 0) then 
    endIndex = 0;
  end;
  if (startIndex < 0) then 
    startIndex = 0;
  end;
  if (endIndex < startIndex) then 
    do return __lua_lib_luautf8_Utf8.sub(self, endIndex + 1, startIndex) end;
  else
    do return __lua_lib_luautf8_Utf8.sub(self, startIndex + 1, endIndex) end;
  end;
end
String.prototype.charAt = function(self,index) 
  do return __lua_lib_luautf8_Utf8.sub(self, index + 1, index + 1) end
end
String.prototype.charCodeAt = function(self,index) 
  do return __lua_lib_luautf8_Utf8.byte(self, index + 1) end
end
String.prototype.substr = function(self,pos,len) 
  if ((len == nil) or (len > (pos + __lua_lib_luautf8_Utf8.len(self)))) then 
    len = __lua_lib_luautf8_Utf8.len(self);
  else
    if (len < 0) then 
      len = __lua_lib_luautf8_Utf8.len(self) + len;
    end;
  end;
  if (pos < 0) then 
    pos = __lua_lib_luautf8_Utf8.len(self) + pos;
  end;
  if (pos < 0) then 
    pos = 0;
  end;
  do return __lua_lib_luautf8_Utf8.sub(self, pos + 1, pos + len) end
end

Std.new = {}
Std.string = function(s) 
  do return _hx_tostring(s, 0) end;
end
Std.int = function(x) 
  if (not Math.isFinite(x) or Math.isNaN(x)) then 
    do return 0 end;
  else
    do return _hx_bit_clamp(x) end;
  end;
end

__amade_data_AmadeResourceData.new = {}

__amade_system_boot_AmadeSystemFSLV.new = {}
__amade_system_boot_AmadeSystemFSLV.main = function() 
  _G.raw = ({});
  _G.rawset(package.preload, "lua-utf8", function() 
    do return _G.utf8 end;
  end);
  _G.require = _G.require;
  local metatable = ({});
  metatable.__index = _G.string;
  _G.setmetatable(_G.utf8, metatable);
  _G.rawset(_G.raw, "printError", _G.load(_G.string.dump(_G.printError)));
  _G.rawset(_G.raw, "os.run", _G.load(_G.string.dump(os.run)));
  os.run = nil;
  _G.printError = function(message) 
    _G.print("--- LOADING THE AMADE OPERATING SYSTEM ---");
    if (fs.exists("/Amade/System/init.lua")) then 
      local handle = fs.open("/Amade/System/init.lua", "r");
      local source = "";
      if (handle ~= nil) then 
        source = handle.readAll();
      end;
      local _hx_1_result_func, _hx_1_result_message = _G.load(source, "/Amade/System/init.lua");
      if (_hx_1_result_func ~= nil) then 
        local _hx_2_result_status, _hx_2_result_value = _G.pcall(_G.load(source, "/Amade/System/init.lua"));
        if (_hx_2_result_status == false) then 
          _G.print(_hx_2_result_value);
        end;
      else
        if (peripheral.find("speaker")) then 
          local speaker = peripheral.find("speaker");
          local tmp = dfpwm.make_decoder()(__amade_data_AmadeResourceData.Sounds.System.Crash.data.match);
          speaker.playAudio(tmp);
        end;
        io.stderr:write("Failed to load Amade :(");
        io.stderr:write(Std.string("Reason: ") .. Std.string(_hx_1_result_message));
        io.write("\n\nPress any key to continue.");
        _hx_table.pack(os.pullEvent("key"));
        os.shutdown();
      end;
    end;
    __amade_system_boot_AmadeSystemSSLV.RunSecondStage();
  end;
  local r = __lua_lib_luautf8_Utf8.find(_G._HOST, "CraftOS-", 1, true);
  if ((function() 
    local _hx_3
    if ((r ~= nil) and (r > 0)) then 
    _hx_3 = r - 1; else 
    _hx_3 = -1; end
    return _hx_3
  end )() == -1) then 
    _G.print("Not running on CraftOS-PC, crashing Lua VM automatically via OOM.");
    _G.string.rep("AMADE FSLV", 2^31-1);
  end;
end

__amade_system_boot_AmadeSystemSSLV.new = {}
__amade_system_boot_AmadeSystemSSLV.RunSecondStage = function() 
  _G.print("Loading Amade...");
  io.write("\nUnreplacing `printError`... ");
  _G.printError = function(message) 
    io.stderr:write(Std.string(message) .. Std.string("\n"));
  end;
  io.write("done\n");
  _G.print("TODO: improve shell [Lilirine]");
  _G.print("TODO: device files [Lilirine]");
  _G.print("TODO: replace `io` and `fs` [Lilirine]");
  _G.print("TODO: multiple processes at once [graypinkfurball]");
  _G.print("TODO: multiuser [graypinkfurball]");
  if (peripheral.find("speaker")) then 
    local speaker = peripheral.find("speaker");
    local tmp = dfpwm.make_decoder()(__amade_data_AmadeResourceData.Sounds.System.StartupComplete.data.match);
    speaker.playAudio(tmp);
  end;
  __amade_system_shell_AmadeShell.run();
  if (peripheral.find("speaker")) then 
    local speaker = peripheral.find("speaker");
    local tmp = dfpwm.make_decoder()(__amade_data_AmadeResourceData.Sounds.System.Crash.data.match);
    speaker.playAudio(tmp);
  end;
  io.stderr:write("Amade crashed :(");
  io.write("\n\nPress any key to continue.");
  _hx_table.pack(os.pullEvent("key"));
  os.shutdown();
end

__amade_system_shell_AmadeShell.new = {}
__amade_system_shell_AmadeShell.run = function() 
  local length = nil;
  local tab = __lua_PairTools.copy(__amade_system_shell_AmadeShell.SearchPaths);
  local length = length;
  local tmp;
  if (length == nil) then 
    length = _hx_table.maxn(tab);
    if (length > 0) then 
      local head = tab[1];
      _G.table.remove(tab, 1);
      tab[0] = head;
      tmp = _hx_tab_array(tab, length);
    else
      tmp = _hx_tab_array({}, 0);
    end;
  else
    tmp = _hx_tab_array(tab, length);
  end;
  if (tmp.length == 0) then 
    __amade_system_shell_AmadeShell.SearchPaths[1] = "/Library/Programs/?.apb";
  end;
  local length = nil;
  local tab = __lua_PairTools.copy(__amade_system_shell_AmadeShell.BuiltinCMDs);
  local length = length;
  local tmp;
  if (length == nil) then 
    length = _hx_table.maxn(tab);
    if (length > 0) then 
      local head = tab[1];
      _G.table.remove(tab, 1);
      tab[0] = head;
      tmp = _hx_tab_array(tab, length);
    else
      tmp = _hx_tab_array({}, 0);
    end;
  else
    tmp = _hx_tab_array(tab, length);
  end;
  if (tmp.length == 0) then 
    __amade_system_shell_AmadeShell.BuiltinCMDs[1] = "cd";
    __amade_system_shell_AmadeShell.BuiltinCMDs[2] = "exit";
    __amade_system_shell_AmadeShell.BuiltinCMDs[3] = "ls";
  end;
  local currentDir = "/";
  local running = true;
  local _hx_continue_1 = false;
  while (true) do repeat 
    io.write("> ");
    local command = _hx_tab_array({[0]=io.read()}, 1);
    local _this = _G.string.gsub(command[0], ".*:%s", "");
    local idx = 1;
    local ret = _hx_tab_array({}, 0);
    while (idx ~= nil) do 
      local newidx = 0;
      if (__lua_lib_luautf8_Utf8.len(", ") > 0) then 
        newidx = __lua_lib_luautf8_Utf8.find(_this, ", ", idx, true);
      else
        if (idx >= __lua_lib_luautf8_Utf8.len(_this)) then 
          newidx = nil;
        else
          newidx = idx + 1;
        end;
      end;
      if (newidx ~= nil) then 
        ret:push(__lua_lib_luautf8_Utf8.sub(_this, idx, newidx - 1));
        idx = newidx + __lua_lib_luautf8_Utf8.len(", ");
      else
        ret:push(__lua_lib_luautf8_Utf8.sub(_this, idx, __lua_lib_luautf8_Utf8.len(_this)));
        idx = nil;
      end;
    end;
    local params = ret;
    command[0] = _G.string.gsub(command[0], ":%s.*", "");
    if ((params.length == 1) and (params[0] == command[0])) then 
      params:remove(command[0]);
    end;
    local options = ({});
    local _g = 0;
    while (_g < params.length) do 
      local parameter = params[_g];
      _g = _g + 1;
      local startIndex = nil;
      if (startIndex == nil) then 
        startIndex = 1;
      else
        startIndex = startIndex + 1;
      end;
      local r = __lua_lib_luautf8_Utf8.find(parameter, " as ", startIndex, true);
      if ((function() 
        local _hx_1
        if ((r ~= nil) and (r > 0)) then 
        _hx_1 = r - 1; else 
        _hx_1 = -1; end
        return _hx_1
      end )() ~= -1) then 
        _G.rawset(options, _G.string.gsub(parameter, "%sas%s.*", ""), _G.string.gsub(parameter, ".*%sas%s", ""));
        params:remove(parameter);
      end;
    end;
    local length = nil;
    local tab = __lua_PairTools.copy(__amade_system_shell_AmadeShell.BuiltinCMDs);
    local length = length;
    local tmp;
    if (length == nil) then 
      length = _hx_table.maxn(tab);
      if (length > 0) then 
        local head = tab[1];
        _G.table.remove(tab, 1);
        tab[0] = head;
        tmp = _hx_tab_array(tab, length);
      else
        tmp = _hx_tab_array({}, 0);
      end;
    else
      tmp = _hx_tab_array(tab, length);
    end;
    if (tmp:contains(command[0])) then 
      _G.print(Std.string(params.length));
      local command = command[0];
      if (command) == "cd" then 
        if (params.length >= 0) then 
          if (params[1] == "") then 
            if (not running) then 
              _hx_continue_1 = true;break;
            else
              break;
            end;
          end;
          currentDir = params[0];
          if (not running) then 
            _hx_continue_1 = true;break;
          else
            break;
          end;
        end;
      elseif (command) == "exit" then 
        running = false;
        _hx_continue_1 = true;break;
      elseif (command) == "ls" then 
        local directory = currentDir;
        if (params.length >= 1) then 
          directory = params[0];
        end;
        local list = _hx_tab_array({[0]=""}, 1);
        __lua_PairTools.pairsEach(fs.list(Std.string(currentDir) .. Std.string(directory)), (function(list) 
          do return function(index,path) 
            list[0] = Std.string(Std.string(list[0]) .. Std.string(path)) .. Std.string(" ");
          end end;
        end)(list));
        io.write(Std.string(list[0]) .. Std.string("\n"));
        if (not running) then 
          _hx_continue_1 = true;break;
        else
          break;
        end; end;
    end;
    local found = _hx_tab_array({[0]=false}, 1);
    __lua_PairTools.pairsEach(fs.list(currentDir), (function(found,command) 
      do return function(index,path) 
        if (path == command[0]) then 
          found[0] = true;
          local handle = io.open(Std.string(currentDir) .. Std.string(path));
          local source = "";
          if (handle ~= nil) then 
            source = handle:read("*a");
          end;
          local _hx_2_result_func, _hx_2_result_message = _G.load(source, Std.string(currentDir) .. Std.string(path));
          if (_hx_2_result_func ~= nil) then 
            local _hx_3_result_status, _hx_3_result_value = _G.pcall(_G.load(source));
            if (_hx_3_result_status == false) then 
              _G.print(_hx_3_result_value);
            end;
          else
            io.stderr:write(Std.string(_hx_2_result_message) .. Std.string("\n"));
          end;
        end;
      end end;
    end)(found, command));
    if (not found[0]) then 
      if (fs.exists(command[0])) then 
        found[0] = true;
        local handle = io.open(command[0]);
        local source = "";
        if (handle ~= nil) then 
          source = handle:read("*a");
        end;
        local _hx_4_result_func, _hx_4_result_message = _G.load(source, command[0]);
        if (_hx_4_result_func ~= nil) then 
          local _hx_5_returned_status, _hx_5_returned_value = _G.pcall(_G.load(source));
          if (_hx_5_returned_status == false) then 
            io.stderr:write(Std.string(_G.string.gsub(_G.string.gsub(_hx_5_returned_value, "string [\"", ""), "]\"", "")) .. Std.string("\n"));
          end;
        else
          io.stderr:write(Std.string(_hx_4_result_message) .. Std.string("\n"));
        end;
      end;
    end;
    if (not found[0]) then 
      __lua_PairTools.pairsEach(__amade_system_shell_AmadeShell.SearchPaths, (function(command) 
        do return function(index,path) 
          if (fs.exists(_G.string.gsub(path, "?", command[0]))) then 
            io.open(_G.string.gsub(path, "?", command[0]));
          end;
        end end;
      end)(command));
    end;
    if (not found[0]) then 
      io.stderr:write(Std.string(Std.string("Command not found: ") .. Std.string(command[0])) .. Std.string("\n"));
    end;
    if (not running) then 
      _hx_continue_1 = true;break;
    end;until true
    if _hx_continue_1 then 
    _hx_continue_1 = false;
    break;
    end;
    
  end;
end

__haxe_iterators_ArrayIterator.new = function(array) 
  local self = _hx_new(__haxe_iterators_ArrayIterator.prototype)
  __haxe_iterators_ArrayIterator.super(self,array)
  return self
end
__haxe_iterators_ArrayIterator.super = function(self,array) 
  self.current = 0;
  self.array = array;
end
__haxe_iterators_ArrayIterator.prototype = _hx_e();
__haxe_iterators_ArrayIterator.prototype.hasNext = function(self) 
  do return self.current < self.array.length end
end
__haxe_iterators_ArrayIterator.prototype.next = function(self) 
  do return self.array[(function() 
  local _hx_obj = self;
  local _hx_fld = 'current';
  local _ = _hx_obj[_hx_fld];
  _hx_obj[_hx_fld] = _hx_obj[_hx_fld]  + 1;
   return _;
   end)()] end
end

__haxe_iterators_ArrayKeyValueIterator.new = function(array) 
  local self = _hx_new()
  __haxe_iterators_ArrayKeyValueIterator.super(self,array)
  return self
end
__haxe_iterators_ArrayKeyValueIterator.super = function(self,array) 
  self.array = array;
end

__lua_PairTools.new = {}
__lua_PairTools.pairsEach = function(table,func) 
  for k,v in _G.pairs(table) do func(k,v) end;
end
__lua_PairTools.copy = function(table1) 
  local ret = ({});
  for k,v in _G.pairs(table1) do ret[k] = v end;
  do return ret end;
end
if _hx_bit_raw then
    _hx_bit_clamp = function(v)
    if v <= 2147483647 and v >= -2147483648 then
        if v > 0 then return _G.math.floor(v)
        else return _G.math.ceil(v)
        end
    end
    if v > 2251798999999999 then v = v*2 end;
    if (v ~= v or math.abs(v) == _G.math.huge) then return nil end
    return _hx_bit_raw.band(v, 2147483647 ) - math.abs(_hx_bit_raw.band(v, 2147483648))
    end
else
    _hx_bit_clamp = function(v)
        if v < -2147483648 then
            return -2147483648
        elseif v > 2147483647 then
            return 2147483647
        elseif v > 0 then
            return _G.math.floor(v)
        else
            return _G.math.ceil(v)
        end
    end
end;



_hx_array_mt.__index = Array.prototype

local _hx_static_init = function()
  __amade_data_AmadeResourceData = {} __amade_data_AmadeResourceData.System = {} __amade_data_AmadeResourceData.System.SystemFile = {} __amade_data_AmadeResourceData.System.SystemFile.handle = io.open("/Amade/Amade.lua") __amade_data_AmadeResourceData.System.SystemFile.data = __amade_data_AmadeResourceData.System.SystemFile.handle:read("*a")

  
  __amade_data_AmadeResourceData.Sounds = _hx_o({__fields__={System=true},System=_hx_o({__fields__={Crash=true,StartupComplete=true},Crash=_hx_o({__fields__={name=true,data=true},name="SND_CRASH",data=_hx_box_mr(_hx_table.pack(_G.string.sub(__amade_data_AmadeResourceData.System.SystemFile.data, _G.select(2, _G.string.find(__amade_data_AmadeResourceData.System.SystemFile.data, "//SND_CRASH_BEGIN\n.")), _G.string.find(__amade_data_AmadeResourceData.System.SystemFile.data, ".\n//SND_CRASH_END"))), {"match", "count"})}),StartupComplete=_hx_o({__fields__={name=true,data=true},name="SND_STARTUP",data=_hx_box_mr(_hx_table.pack(_G.string.sub(__amade_data_AmadeResourceData.System.SystemFile.data, _G.select(2, _G.string.find(__amade_data_AmadeResourceData.System.SystemFile.data, "//SND_STARTUP_BEGIN\n.")), _G.string.find(__amade_data_AmadeResourceData.System.SystemFile.data, ".\n//SND_STARTUP_END"))), {"match", "count"})})})});
  
  __amade_system_shell_AmadeShell.SearchPaths = ({});
  
  __amade_system_shell_AmadeShell.BuiltinCMDs = ({});
  
  
end

_hx_box_mr = function(x,nt)
    res = _hx_o({__fields__={}})
    for i,v in ipairs(nt) do
      res[v] = x[i]
    end
    return res
end

_hx_table = {}
_hx_table.pack = _G.table.pack or function(...)
    return {...}
end
_hx_table.unpack = _G.table.unpack or _G.unpack
_hx_table.maxn = _G.table.maxn or function(t)
  local maxn=0;
  for i in pairs(t) do
    maxn=type(i)=='number'and i>maxn and i or maxn
  end
  return maxn
end;

_hx_static_init();
__amade_system_boot_AmadeSystemFSLV.main()
local OopsAllDFPWM = [=[
//SND_CRASH_BEGIN
j��U� �����t[ݒ�o@)?�K!����m�@������P���Z� �Ej4�iT,@�߾��V ����J�(���m�V U��+$��T����� T_��? �d��m�V�B ��nU �����okp�O7\��&��Z�V �/J��  ������H���F AJ%���6��_{�D�$����VR!d���� )I�U���M��_ U )���T�!��[%�" ��R�� �ve�]SHk ��j�wC�ګ���%! �~��J$�߆�o�� �U��+@R��ߺ*�"�mR��  e%������ �[�/ Bj�o�NB�����"�H
+�R��|%���$���JM)@��w�� Ux%���~j��Җ $}k�[p5����*b�jQ�[P�v��DM@��� ZH��Wݥ	"U"ȫMһ�޺oR��m}#�$U���+�\%�$�@5�VQUUW������T�*5%)���VU�VE-յ�J�R��TW�I-UU ����8o��1<^ ճp_	����Z@%��`���ߨm+ �A�
���Կ����ڀ�G�7@ꗤ_����*@�H�������V�{%�+ ��*��+io�~�_I��_B��Կj���uR� �N�~��7�]�K���/P���+�~��@ۊ�-��l����O@��V@��?I��}�[ �
�7������
�?��
R���_!�^��&D/����]B�/B{"�.@�������*P���~Ԯ���/�}�7!��;���迀���.�zW����E�ݐ��н����Bt���u��VH� ���z��B�P�D�-�"��R�E���)/��OI�򯄾��@��]!�վ�����Ih����?I��_�K@wAt��o�O��"�#T��/!oE^/���W�Z��@mUٵ$�QZ�A�IЖHkK�vѶ������UQ֪Tk�ZUkUUM�V��j��*]*�ʵT]�*�JUK�Hv�T�VզtU���3�5��A��8�+D���+ ����Vxk	��o@[(Ie�o�vW ȿ@TW�����5�� o�@[!Q��o�T�7 ��� �.P*��[��{C@^_���H��kQ�} ���@P[��j�_kB��@v����H�~�B�~@T~{AH[����������� l��T���
!�H�]�z�������+��}� �J���B�T�}��
(���RA�+�P�� ؒP��SM"�
���"AzE��M���mW�U���}�V"� �"�� j�^k�t+�Pk�NҶ���Z���
!��+���J-�{K5�JUT���j-U�J��T�H�VU���Ҫ�6J�j��P�4���&�V��t+ѶH�ZUU�Z�jU[�V��ET�ZURUKU��Z+��RU+U�EUUJ�UժTj�VUU�iU�j-�WRUɪU��*���JUU�"UU�*U�[�J��VU-U�JJ����RM�������*Iժ�U�V)������&U�����V�Jk*iU�Z+���*���H�(����.H���ǯ�����F@Z��v� QT�_�p�|�����^p0@��!��Z�}^�*Q���͠@(@��DBQ��[>��������U]����&���.����n
X J܈�(@�ФR$����� ��z�M�<x��������_���m��o������Ӓ�.m[+�tz�e�	%��l�@"�
�"&��D�8��Ңe�z�g[g��^:�V�S�����4�K���]AvѾ��R���O�4��j�J�hH�?�W��U�/�EP���#B!�*�4��j!"@���"Lخ�_+�����O�ڡ?�}��i��~}ԋ^����&�S�5z[�:�{Q/*`�^�H�6 Y@K*	4Bt	�@�"%�V��PZ+*��|�>���/�v���U�U�?r��Ӌ��wkWk\��0iೕ�RmQo�'R ~��[Q���K�
��?�����k�m�^��Q����H/���oɂ$I��V<p���E�ڥv�|��[*���C��J�?H���l�JJ�j+7��
�_�hI_`�B���uU ��ު����=�+}����+i_ԥ}[����_�W�����A��B�����J*I@)I�O <��PȖT��?p�
��}Ui��S���>ѷ�G����[���RE���
~��	ZU쀗
��P�BWN��M����\B~E7�B_���*]�>��6l�/�K�]���lm�_*�ZQѧ�|�V��?U���7��`[�"֗v�\QU<��+�
|�6�^�|$��Eච�hUCn�҄���nA�]hO����k���o߶_�_վUE��U�[�dQX�*�,�*j	��U��/�I[�O�m�G�_Ez�z�*�wЗ��U]!���+��
lu�j��Jߨ����������?��}i���H�t���K+t�[�iU�-�t"I[PS�Z��"Do]� �A��C��R���'����?��׊����5��P�}����Fm}��-U C.��/%��t�����}�RW_I�i�����R��ڀ~���^�TүB�����W��@K�j�+�u��/_J�KE�ڣ���O�z������>��K�NX}�"}*=�	E�Zp�-%*�-`��T�������~z҅^p�ݯ����,��C��Rɶ�W���m`�W��%���
|�W_-���D�?-h��&����ju�������h�Э����nm�~�z���/��"ժ/��!*�����ZI�T@�_*��U�E��� %7=P)�^���� ������������ W?�b/	��Jx��(�� �*�����o/ha�	$T�T���
�~��[� ��:�d˿���U�R h� 	M�z�KT�m�ҏ
������$R�T B�.�п-����u����D��II�/H`�EX�Z������ $;	$ѿ*��?Q�E$�j����V���з
�j���
��K
]���� ��_Y�mOT�'Ѻ@����@�_	 �]�r�CZ��E���@!|ZABoۚ��-z�/Ht�E��hR�_�o�@��`�k�t�����@�
�D�+��^H�_PT�T���ޅ�~�$�V+ ʫ�(��-E��UBhU�K��{%���E��&J�׫DJ�����Rխ�ѮU�m��%T�Dz����'��_���Z"�ډ�~UT[m%IնR$�U�P_�"�m���![�.���J���R�VU��]����$�VI�������Ғ}SQҶ[���խE�j�BoUT�ԪU��V%�nKUѥ�*UݩDV\��j]T�d7���VIU{���jW�ZmKEi�j��j��U[��R��U���R�R�VMU�ZUUUm��Ԫ��6U�IU��������UҥmIV�R��V�E�V�TuU�*�j�ZUՒ�jUUUY��T��jҪ�jU��J��&5��R����"U5]EU+UU��ҪTUUY�Z�ROI���"�x��~������o��W��Do�C�D7��j����P������-�B���%/�ԯ6�Jw�}�"��
�~i7P���ou~Do�"��?�
��� }�O�B=��E/���Ъ�iu��*RZ�]�A�[%�T�R$��'M��_~
P��v�B��	�V�=�
��J��~�� ��WK��'Ğ�D:�E�'K�']EPu��
�OU���l������?!^J�� ��+�!�/���"y�����[��d�_�.��U	��I]�I�@J�"�K�[J �[Dt��$���.AU�oOHk��E��]�����P	�Ѧ��Z*Կvo�-��
T����{�ж��
Y�$���U��WU	T{j_P�ԭ@�
m�
$�V�+l��uI�j�J[��m��VU_�t�6�ܢԪ���TYei�o�j��nQԫ*�&$-[*H�H�� �n��UeY�U�n�JU%U�-P��F�
B�"$���%���J�Z)����D馤j�I��R��P�
T�V��*iw[RU�B��D��im�K"�mJ�*Ir[ҺUR�U�v%�ڮ�ZKR�j�v�����tK$E�$WUzU��Vժ^���UUU��M�R�*$MI���D��Vkk��U���j�U�R�U��"��*�j�T�T����\�k�UE��RY������[�VU�&UIU��em�TQoU�ԪZk�Z��Z�Ji[U�TQ�RjRUZR����ZU��j���Z�T�jUcU��*UU�Jժ���Z��v�Jժ�RU�����jU�J�����JTUU%WiUU+��V�V�U�Z)�UZjU]���TUSU�J��U��Uɪj�Z��jU���TUm�M�KJ5I��*����VUKU�ZUK�V�Қ֕��&���R��ԤTUUYU��Z��j��RWiUYUU�E��J�JUUU��RU��R�JY�RUUU�V�U�V�Zk���RU�VMU��R�UUM�)��RUKUUUUm�jU�Ҫ�J�P��J-U����JUi���ZISU�U�RmJ�R�ZRKUU���ZI�T���*U%Ֆ��b�jU�Z����R�jUU�UZU�����~���/Щ/P�
�~���������݀_����!Z}�[P�/�~#*�T��P���B�[��� ��
�~@�m����v�H���Jп��W�+A����%����V{	�[H�W��%�C�>����$�W ��D�do������/�v'$���
ԿD�]!�Bm��Ed�*��D��OH�����ѿ"ҷlW�V@ߕ�}Կ�Է�.��[��S��K��R?��@�7�ޫ�+�k�^�7!�[�v_D�"T~���@������]��P{#Hw���v�%�+���$ZD���z��6uE���w���!ڛ �(�*�~K��V��
�6%T��/Qw����U�Ԫ��7Uw���)�V	W ����ۚ�V)�%�JJDU��k��z�[UIUI��Y���VmkoZi	�Z�
�RW��m�v�%���J*�I+m�֪��U�P���TB�v���j�n*���ԤUZ��ժ��VUU�RJ))U���ZUW]�U�����R�*k�JkWkU�Ri�*IRkU]��Z�UU%U�
RU)W���U��TU�VU�Z�j[K��Ԥ��T��X�ZUU�V7UKR%-�%�R�jUm��T�Z�Z��J��Jki�U֨U%W�U�J[UU�*��*�*UɥTU[RWu����ZKRU%UmUUU�j5U���JU���*��j��j�JU�RU+%mU�֪�Z�J��U�J���VUUUKU[U����V%mU)kUU֥������V�tU�Z[I����&UUU�Z%mUUU�TՕR�J�jUQW�ԶJٶDՖRU-Yi�T�J�6UZ��ZKJ��Tm)U��ԭ��UJ�ZTUU�j-U�RUk�TMUUU*m��ZUU�ZI[U�TiՔ�U�j�Tզ�ZU�jUTk)ڶRjmJ�ZR�*eUU��U�%�n���P��Rժ��JUm�T�U�URU��jMeU�Tm*Uk%ժRiUUZU���TM�Ҫ%ժ�VU�ZU��JU�FUKUUK�UUjUM��RU��ҦRUUUUUU��T�*U[���TU5UU5Uզ�ZUUU�T�*UUUUUUU�TUUUUUUUU�?�
|��_���@꺾������*x��P_��+ѧ����kR�#"RJ�� ���NZ�G{Coo��[D�^����~*�VB�W��W����6   lͪg�B���g�?���� hRK�)').�Gڤ����V~  J�J)5[���׷����|��}� "RDE��Hc�2�*Mu���:ow\o� ��U��Vjı׻v�����ESb�����\�8  @�XJ1����s�������ڻ�~�{�{��e  P"J�P��H)����������������v �Ĉ�$�D$E)���X��v΅��z�u������  Uj�*���ͯ������(8���H�;zR�s�G   QFMiq�x�z���]���]�=���S��Ŝj   IR��H���G��������zۻ��wo{�  @R��TD"Jj()���u{�Z������w��vw�  ժ�޶־vo��ݭ	��RU@��mjk�~�  �Tժ��޽߿���o�{�
E�PQ�U%�P�:   �D��v�������n��ݽ�{ݛm�PPIDb  ����5UU�U��V���{m�JiUWڵ�z� Z����ֵJI�*�U�*��Hm�j��z�Z����u �m��z��mOJ���j��$�jѶ�U�5U� j�n���w��o����n!T!� �*��ڭ�  TJ��ն�]o�kڲ*����Z����뻻��v�;  )�R�$"D$�]�W��Uk]*UY��}�}���mm� VU*"��*�"���P�zU�J��*ۿ�w�v��o hU[�}�M��"���")�Ҫ۫R�E��buo��z� PUE�*��j��m���wm[۾��m�P))	�J%  ���jUm��ݪ��_�����n۶*�JD"IHSR  �DDR�J&Rٖ���n�{��n����km{�PBA��  TR�J�ҪT����m��{���JU*+QU��� Pj��j�m۶w�Z	�U���U�,�*ѪVoUo�� �m۾����n_��"E����RADA�UU�eU]U� Զ�������w�ڪJJPD�$$%ժ�Vi�J�T� �j[���U�RU��ԪJ�V�Z[���������RR� (U�*J��R���V���U�k��w���n��v+�R�*	 �RD(BDD���T[�{���u���{���u�^7[ PJ)BH$"��j�U��Z��VU���V[Ֆ�Tm%UJ�T���V������v[ۻU�*QU%��J��T*JUj�*�MU@��v�v[�{��m[�U��HT�))%IRE)�JIUURi�@���n��v{�k�ݶUU	IU�d�J*U�*�TUI��W�P�u��j�Z�UUKQ�*UU%���UR�U�ղ�Z����
 Q-��vKUjU�U˪RU���ZU�jk���j���Z�( ���*%���j��֚V�UUuU��ڶ��u�ݭ��V�TUP�Jժ�*U��J�V���Z��z���U���Z�T���V�� ��Vm�ZuUU�����V���ZS����*����R��V��@uUUm�TU���Z��V���Z%)R�j��[I+UZj����. U���j�Z��Z��j���U�VU����R�jU��֦j�ڪTUU����TE�V��ڪZU��U�RUU����VS��UUU��Z��VUm���R����-�n��������֪��U�J*%U�P����Zk��J���V[k�V���*U�JU�����UUU��*@�VU�V��Z�*UU���ZU���j��ZU��U�Z�RUIU�UU�V���JU�U�Z�J�Uk����V�jU)U�RimU�j�Z�(���ZU�V�j�UU�J�T��V�*UUUUS�V�ZUKUUjUI@U��ڪjUU���R���*��*����jUU���*U�TUm��*�VUUUUU�TUUUj��T�RUk��TUU��j��V[�V��RU����R��TU��������j�V���V��U�RU�J�jEk�R"�*UUU�jUUU��U��U����Z�ꪥ*UUUJ��*U�ReUP��V��UuiUժ�U����J)��J�TjU�ZUU�����j �T��%[UU���*ժj%SUY����
//SND_CRASH_END

//SND_STARTUP_BEGIN
jUUUUUUUU������U���RU����*�T뾋�^���j��*��{�v�m�����v��ｻ����vwwo��n�������+�Ӯ�j�BS^� �@E,U�@H"D�$B$U��(U�x)� �T���_PJ}(Zu�� �F��$D@ -	ࠈT�DR��&?h�R/]��z�����R�����j������º%����U`�}��X��  
)U��   !�'D$%G(u+A�@*AH   U��z!���
lk��� $	U+U  "�@�%)m�ݪ*�5�����GT]ZP���W�%��������U}ߺ�������ݵ�lU{k�-��[ �"m���  Q�W	@��[m�Q]U�%z (B @�R���� HDu������H[�M  I�%A��n}�����*߮�� �V����*E�
����B���V-�j�����ժHk������� D���^��� IC� T��lz�����H  A����h� @D��ݻ���6E۪�Z AMZUۭBb����o��*�nW�V A����K ������RB�{�������oW�Ru���Rۈ��zɫ{���v  " ��VU�I ��N�@(U��� ���t�����J������@�.��
�����w�m���THHUުU�J��� ��~�]��@`�Nj	�m����zU�d�����U��W��Z@ %��  �����JH#�� $�TK�*�  T��_wo�o�T��i`�R�U�o���o�v�*Ui�P @+����W�� ����_���I�J_ x�����v����o�*����[��� �$@ J�����i�J Q� ����$����-I��u_B- "��U�UXi����^�� %@ )UK��W����ڿ��JM���|)�Z4(@�ߪ�������mm�lk۶�����Uj!��l �u��/VU ""��HM@JEH P*�����D��V!�~{I� H�����>	�����J(��*%  ����v۪ߪ��oUP�I��
@��>��~�o�������m���Z�m�JR�Tu��(��  ��_]��.@  $I%@"��-"E��D���)U�ԅ���n����
}�_�U Z-U �jo�Re���ok]@��$Uh��"��J���ｻ����m�[���}o�*I����jB"�HD@�  $H� ��v�TQB��z��B	���{��HIAJ����AjW���HH��C�*�� �����*P�����*�$E� k !�����U��������ݶ�Zm������J���[I���_@��TE ��A"H�V�mU Ҿ���D�D���U}����U!!�&������w��ʇ�W�^-��I@	����J�@U�� @B��'I��	������ު�ߪ{_E����m�j�k"@Td_% �  �� Q��&D-��O�CP��Wm ��ڥ�V�����/��v�zW BU�_����m����@�X�_W,���Z��ߪ�R�P�W��ֽ�����ߺ�����%�oۭ��DU�    !R"!)�$���TU���
��_+��j}��_�{i�5�j �� r��K  V��V5���bI��)��*�@!Ty��WU ߺA�~	P�#��۶��������{����R�H�/� �@T�"H$"	�TUi��W�n��������w[���Y`� �"ѻJ�/ ����+��{�r[�K$IQ� 
@ZA��WR!H�* ���Յ���?��M�����n����]����U��/! H   ��� $B��Ҭ��w���mk�[�����������BA  ��"i�T���}�m��A}����O� UE�}u���DF� ���v/ ��_����{�����
�j�__m�-���&��%% 	���  �QB�J�R���ڤ�u���Uɵ�����HAIK�����R�*��/��"�K� ��o�ꧮ_��[ ��] l��_��ow�o+�W�J�z��[J����b�۪
HU  T  ���B$I���V�m�V��w�m����*��_+Q�JHE�t��B��MP�J��$A����jK  �ߔP��lI T�DTٗ(H ���WI����ֲ�������H���H����R"��"    UU�HJU��Vտ����}k+	������>�HD@)%U"ҋ���-% T���WT��S��wH���-��-�	�H"eY��, ��ﻭ�~mo�*�(���}�߲��[�.�� 
D$�   D$+I�H���}w����ݾ�kQ�V�_K�}	D$����K@��UW �RZ�%�O��M���~ݵ���A�$HA@�.@K m����Rm�nK��ZEw������ݪ�M��_	I Q$ )  D�RI�m����m�{�n��J�o���$j[)T U����$Iꆐ�   R�����[VK��ݭ@��p[ Q�K
 �,տ�V%��$�����[�{kj������v۶m[�D$I�  �Dj[-IQ����n�����T�Q��Ů�^�_� �Zo}��@ �"��%  Pm��U��������/EH� �@@������H�U���UR�����z�o���������mm�Z�H B�$   �$"�w��m����w���mUI�ɾW7��/I�5m'��#@�� �� !HDH�o���۽$�RUu� �  � $I����"*uY��6ʒ 
��M���۶���o���ݪZ��J"D $I!��vU�Z�������ԶU��*�������T[Ѷ��J �H� �J@����ګ���Ҷ��H��W�  �����m���* j`��kJH"�����}�������m���T��( ED	!"Q�w着n�����Ru�ݔPmA���w�բj��[%�  Re DI"�$)KJ��֔�{��Ъ ��J "�z���R
@�R/H'T��J�@������������������*"@H��T*����V�o�n���Z�U�H���w[[��m�!U  iU  �-I�|+���*��� ��!�_�
�/��*j���҈�U���E R��[�����߶�w۶U�4  	��T��I�DU{��M��UJ�ݶ�k���D��M�/��* $�H$$�V Du��$T  {���@{�(AH�J��J��@)����A-�nI�
B�������%}����ݽڶ5���   ��!D��"�����ﾈ����n�~oۖ���������"�H&�BPE$�@{��T	zW�ZE��� Qb������� �TU�� X�KW�{�o����I����Uo�{�J��_Jj �TU  ��"	IB@��R�߽�mK�����o���o���z߿���)"�M! *�Q�$�^  I]��k=oB$�" J����V�_  $��A���H��T_�����~������&M�����$PR�� P	D" R�W���m�߭D���~�*j�U���o{�V�-@$�PR- �^@�U@���J}�� "A\���Vi�*E� @��+ $Ѫ����jқ����(��n/y����H��_�T�U� -  �$$U��{߷ۻ��~�}��*�V�����w[�m��*u  ڒHTB���o�je�[! �Vd��U�IHZ!U����!U[��Q����[*�����*i�k�� �R���+R " ���DE�{����w��5���o[�P����w��ݶ�UU	D�� ��-��D
 [��m+����+ �B��@گݯU ���j		�@J�DU��_�n���j����"!��m�
H�� "H$R�!��T����U����
ݽ��J�����~kSE��oU H���ԯ�J��z�j�����J�$	 ���^KV���  H�T��4 @�m'�w���Z��k���T(+�����	 $!�$!���Z  �����o5���o�����w�����o{}�[UU�HV� ���@d�@+�P"ɺ��oQ��  @U�o�U[+U@��mHUeS��wou���j���JzG*���m�(�
M$�%DzB  R��}E�Z��n��������RKU��u����
v��)h@��@$U�@@�@�ZzJo�@  Bj��w[�J%�~  !��VV A*�_�vmW��[���[�mW �z�7 @�
�}I�$@��H! �"�v)���P���U�������ZO�V�&,�[ ����Jb� ��� @$��u	R*h� � ��j�/��﷕@��n!"[ Ҷ��U�?����޻��w��Z+�[� HU��v/�H����  �@�Z�P������~�����{{����[��}KHX}P����V%"U�  ��D�*UH��7 �Hյ%@w�o D"I]U	U� P���m%�vP���V����[�6)�ݖ B��[�J����H@)�Zȥғ j��۽��{�Z�j���ZU�Z@�V ����U�R���#  �H)B$�Hi%� $%�jI�o�AA�H�U�� �����%��� ��[����U����D�
D�}o���	��V ���Bt�
	[��n����{[ۭ�}�w[�EPm������MJ�j"tH�$D���U�D �"B���U� @�%����_����J(������߫
�����u+P�]����oE �	!���V���D�����wo��mw�o[+%��		������RRR�$�4 �!� �Vk*�ߊ ��T[��$-B !�� �V��{!��J�����v�V�T�
�޿�����J  U[%��ݫ��������JJ[Ij� Y���5����]��wKB AR% ��ڵ��R��"�R���M��+ R�� �D"�ҿ$%]�����_����n����DT�Կ�����R $ B��W"��v����J���*����`�-�m���߶�����+�D QJ�"*�����Rj��H ���V����BDZ����H���?@D��m�v���ݽ��"!���*�v���[�R�+  ! U�%Ҷ��{�6��~�퍨���lo+�������mk�H I�* @Q�n��("� *���v�v�"�ت "B��# �������v[���]U������A���6��֤P  IRW�+D�w��߶I��n����
��U�_����߻��j%! I��   ݶV�HIU%�"I�H��}}��@V����H�@P]U�@����߶֪���6�H�*�@���n�wUDDD����H��n��v�U�������
���﷝D������m��R���(�@� $i�I	Ij�"I�)���R�*-��W�  )!�@$)))���_�����v��*i%�MI��������U@PU�j Dt�[�W����߻v[U�($��+)�����wWU���@ � @H�U���T�+ �W@����	Dd]T���ڪ � �H$���������v�v���T%��]��"�����%HUDJ�I  j��o�����{��TU�H��פ ������m��޷J� � � AH"�VSUU���W@e�V
 !�*����V*���
  !��$"ݽ����mW��V�TKJ[(�
	��ߪVBUIE ��� B��m��{��o����U+���%D_ ��������{�U��@B�D��T����ERZ�(��_D H����ת4 A��   	I�$������jw��RU�
QW��������m�@��E�Z A $������[����ڪ�"�J���w����W��W�� ��DB(��jU����{WQ�* B$�WI�V ѭPR )  � H$Y����o�k[۶v[%)���[Z����KR���_mH!H �T�mw���~������ I[+u������ݪ��$� IBB$��j�Vm[�ݪ@�-P   ��kI"Q���m��QI    (IJIK��}okk�ݷ{۪������m�n�������� �]B ���nU����v�[�" $��u�����߶U�H��� �"RI�[[I���J[��.   ��ڪDj�[+�(�  DTMY�����V������v�V�dw���6U�EZ�"R��-@����ۨ�mU�^�߶%�h���U)���v�*A"�$AH"��+��~R�K)�� ��*��j�_��� 
; @ �R�K׶��v[U���V��J��m����RW�. �z�(�ޮ��T@���u��֪�%��H�m!(�����[U���V �$	�D�Z"��n�7�*hU @�"!����"յ[I@�� � @$���������*���eJ�}o�m�_
�-h�BE���@�n���ڶ����V�S�4$ �VU���VkW%@�TT DI�*��_B�TO�@(A �$�"(H��/)�nU���� �   @H����J��_��&��ޮ��������M�BwI �w�B���T�[��%�o�����E�������_���*P�	BR��_�	Bj�@ �$BB�ݔ  B��ݥZڭ%�Z  "���T�B"�K��M����][������B�
$���+�M�������oݭ�o��m���B�oI����UD�>R$ IZ �J��W��
 �TJ�Z $�B���$���U�MJ�] � @"m��z�@��*��%i�~U����e�}+D����_	�о�{�w�~����{ݯ���H����[���{w+R(�$ �����w%�� "R����  � DI������T�~%�& � B�բn"���֔�o_+����_��m��mM ED�o��HK������{۶��_ߺU[Կۨߵ*�"x�~���@�f!D J�߿m�"E��@*@  A  "�"D��V{[�*IU� ��j]���U��5EZ��_k�������EZZ�m�_+@�����}�^�j����;���-mA�_��oKIHo%$I"HI���k-�� R�$!+ $ @ ��@J����몪�{ݯ�
  ��H�T�]��'��n�y�U߿tW���D�ۂ�m��v�z� @Dj���w��R���U�ڵ�H�J��mm�A@��  P���(�����*�"�"��(   I�*EU�۪u�_�WJ* @@� �,��]K���]U��/�+�T�w����6���n��] M@��Uu����]�����~w�V�� R�mw�v[ RR�_H[�zo���U5% �	AR�   ������B���ժ� B  I�H�j�ުR��l�W�M�J R�߮����V�������*$Q}���n��U������ݶ�H$R���M��H��W%�	DՒzR��oj	 ���� "] � @�W�]���B�u7��@ � $$�$����RD���+U�J$@R�[믻�V_�m߻���[�� @꽯��~�v��n��m�m��
 �~WIk��* ��UI%D�I�N ��_IP*! �T��"  H��KT�U}K�H(@B�HH�[�����%! �~[	��N*���ۻ����V��o%D��@�D��v�����n�wkk��WKQ����.���6%b��ߒR J�@#���[�� ��DAU{W   꿭����@$yRA �DP �H��+i��E� ]�Ѻ6$ T��V�������n[%)�՞�"�P��������ݵ�k--IQіZ�]K���V�(���U!J�� ���V+ "IRAi�V@*�k	@���"�D��H���J������꽕RA�Ƚ[�T����ݶ�TD-��������o���������VU#J���V%!������R��_U�@����H�}�A���"����%�J TR�����HH� %E@$H�~�_[�PR�!�J���j"��������mw��%� %��-$ZH�w����׶�ڶVբ����^��DQ��Z�.����HD� $I%"ER D!����S_M@HXY;��.")	������[�@��BH[}��'"�E�w��w�R��%	�� ��"�UT�������]�U�l�-+����w�%����V�	%�	Q B�*� �DRV�զdIR$U�S����JDQD�����nw�� ) "R[)����Dｾ�׾ݢ��E/A�"��5B��o�����ۮ�ҭ������T���kڭQ�{�۷"Bj�� ���TH� !��V�Փ����V�K������D)A��m�٪�}k��(E��f�����{��ޚ�T�Z(-T@�ZmUI��ۿw���oۯ�vo�Ԫ�R��Zu�nw���ކ�7��H�IBH�H�H$�$u�{	"	���] �廦��BHjk�d� �˚z'� A�R�h�~ɫ{���v+����$�@�vU�H������v�ݶ��j�o����UI�D�w�޵m�U+��P���J��T" ��-KU*BD ���T*A@j�*�_SR+Su�$�����H ����$���m��߾Ur��Ik�UUU ��J�{��m۵}w��z��*���R*�����V�n����TՒ 
"$	�U� �RB�H��D")�v�^	�$u�Zu_!A�HPRT@�ݷ- � ��j�}oW����}JR��Z����wI�"��6��SݪU�T�}[�*YU�U�����ݪ��"P�����
 *%�ZE��R%Ȓ�mA�T"i_P���%��V!�5�"U"IqU��E�RI	 A$��5Ao%�o�__�� w���"-�M;�@!�]������V�սZ�J�`KB��~��^�����۲���*m�
J
D)� �� UB$�
��DH�n���@��I���}!I�[I�o D�T��]�
��w���j�������}��ۤ6��R��V}�voS�ʒ�Z�R���۷�����_��WI��BU�-�� �$"�D "k+�HR�Ve��j�uKm-km	�$I�nI��>Qߴ��V%) P[MR��ﯤ��ګ�Z���m�H%��ۈHH�����Rk-�[�T�$�Ij��jQ�v�����[���^�^�����( �T]E����v��Z�}�@P���T�I5��nBIi�~�JR�$ �TWRm���۪�
"k��k���߲R�J��ے�������M�d�-����J�������������������J��m )�DDD��UI��^S_�	)�}%	�DBD�V�m�����ҽ��
"Y HU]!��w�o	H"T�H_�������������_��J���Z���nM�׶U��{[�j�(U�����K��nED$ ��HD	*[P�����Z��oE H "BRҮ���T��V����$U	�$@Jk�@���~�*��%A�JmUU�M����[���mu_����H�*)�*��w��Z���*Eֿ��}o��m�ۭ
	 D�DE"�D"��j�� ���H�$!QIj��-�������JA$�T[����U��UUA����Vժ���ݯ%(���U���"U	J�J �*��{���R+�[�*IK�w۶�o�
U�_*"R�RA� JIR����$I�~oJ� HTE�ݪz���MP�+E���-!�VD�����^��j��!�Um!jo)�j�Vu�k�K���D+U�
H�t�j�����kISU#I�����V%��]�*�"� �� @�����/RU�^��+HU" �$IRm��I�J�n�BRU-$�TKU��ZTou���o�DHJֻ*��j{�n�ە��B"���A�T�T
B�V�׻��o���WS�.�V%������J�V�D ��H% DDJ����VU�V[����J���*�*]���jEJSD��ZRڽ�V+�nwm�$R�J�T�JZ�k���]W�m�����O��@�mB���n{o���wW[U�H�����ZU�R��J"� "��H�$U��ˋH��V���*
!%�R�l[�V�v/�$W!�J}�HQu�m�J��Vk���DQ��V��ڿ��UU}[U����@B���)���o�ۮ����m��jR�"TU����MT�*	VPB$		Q�I����k-�]��ʪ@@J�JB@����6�ҵ�ZI"E%�S�&�����U��(�*�*AH��v��������߶DT��@B$�j������u��n��D�H�$Yժ�D�NѪJ*�D� %�DD�R��Uu�kk�v�$I��HP!"ȭU���ߋPUIU	�z�OHK^��m�U��v��H	��-R��V�����{���R+�DDR@�"���{��}�]���U	�ekmW��׶+	�
!�$DR����k��vU�A�$�I�^�Hݶ��Z� BM��$����ޗ|���I��P�����*�Z۽�w���m��[,B�J+�D�}�n�ww{��Z�BEU!��TU������A$�H(�� �����U��]m[��J%��!IR_]k[�V�(B"��R�TU!@	�����wժ�J�HUk�H�Rv�����w�{k��HD%�HRդDվ��޻�ݶvwKJ$!�!"� ҵ�w�տݭ��$T$"ABT�]����ZS{KVB� ��D$Y߷��&�nU$� $R�$
�P}wW�V�w�RJ*ɶU�&���T���~��V�T�Z��@DRU��T���ݻm[��{SA��AQ*U������U�@A�*
A�� J��ݿ�]K�־+E$��"��H�}�j��U���J! Qw�IU�S{[I��jE��ZM꾖T4�*�v���۾�$r�*(���RU�T�����m�}kK�PP$*EE�P�Z�j*�Z߻U�D�(	�B(��vu��U��m7	��D��R�H�jo�ڪuU��*QK*�D���6�7�*�[Sj[kU���Z���������v�Tm�$�PIEH���j���o��ڪm"%I�J��RW��V�[�UUU�T��HR�H EUI���O�ZUk�{U��"IEu�D���݅�m)��V�V��T�V��T�RUU�*��Z��V�]m��j}k���uUEU���DI%P*U۪j+��ow��T��RI�RH��Z�TRU�kR�J�4�*�TE
I�ڪ�VkU[m�JRI���RU����zw�J��Z�V��$��TU�UɔҪUU��]�Z��v�VU�v�Uk����)%��6mQJ���z�VkM��Ւ$�����*�VJQ�JI��jm����*�"�B!�'U�WkU�]U����RJIT�"���Jm��Z�VժZ��&I�T�R�RRUU��RU��Um{[k�jkU��]U)UUU+���n��TR�����V���*�J��H�R����R�V�b{���JQ%U*%�����֪vkU�jojU����*���J�UTնomJU�j[�uU���T�Z[����J*�Z��UUk�{��RU�V[Z몢�R�ZU�Z�*I�mۦhm���J�jRZ���������J����$�JR�TQ�$���H�Zm��.EU�k����V�D��$��R�k�֪R�J������DVU��*U�VJ�V�ZU)R�ڮ�ZS��[��ݭJ�Z+)����[	��j�VU�����6��$��j+�t+ET$���Z��U��RUS�*"U�v�+���mR@I�UUDR�RU�ݶ{�*�VU�z�ښ�H�v�*�Զ�-��֖��Z�ժ�TU�����M%U�JED���IR��*�Z�޷�յ�T%Uu+�$)�IT����V�D��JR��*	��$U����ղ��""!�m�RDR٪*UU۽�J�jk��������&)Uݪk)�ZU*��j��JJ��m�ڮ��Z���QJu��RJUZ�T�ڻ���6U�U�U���D����HU��*����R)QU�
A��������^*)Uۚ��jUUiU)�$��۷�U��ժ���VU
B�n�RU�mU�U�J��JU�J�$�ֶ���z�m�"e�J���VUI)��J����ڤԵJU�T�R�U][�ݶժ*%J���R��(Dj�JIm��U�HR]U)���T"KI�TUW�����֪VUUUUU%R�n[E%�ն�U�$UUUUU%�VկJ�o�nU���VUDUժU�R���J�um�])MU�R��ZJP�T��$�j�������J��������U%��n��R��VUR�V�T�R���j�mi������Z�*��j���T��nU-J)QYUUU�R��n�V��n�U�JUU��R�UU��R�Rծ���UU�֪���M*I$�Rk+�Jk�UU�JJ�4�R�$)%�R�ڪZ۷�T��U*URkU)I�T�Rk[�uU����������*����Ԫjuۤ������V�*�J�J��Zw��U���VVU�J�R�J����mնZ�U�VU��TR�*ERUkU���jUIU��*�**"�DI��Z�]ۺ�J�Tk�ZK*UU�RRU�V��j�*Uk�����*Uj��j��ڪմ�U�*�Tժ�RR�TR�jm�]�V+������"���R*�Ֆ�jתVU��ZZU�R�TE)�Z�jSiU��RU�%%���R�H*����V��VUUU�eKU�TJ��������k��RU�֪��TU�����Z��Z�RUU�R�J�j�����Z۪�ڵ��RժjV�T�RJ��6���V���TUUU����*��RUUuU��T���JU��TIU����V�������j��TU�����VU���V�*�V5�ԪZU�T�Z��V��*��Z�������*���j���V�ZU��JU����RUUU)��U[����*U��U�VK��R���Z��T�T�U�*�J�*UUJ�����V��*UU��ZUiU�TRUVU��TU���UժTU��ZM������K�RI���������*U��jU�VUU�ZU����jU���TM�R�j[U�*U����UU��������UUR�J�jUUU�TU��J����UUU�U�TU�պ*U��T���JU��V[U����UU�Z��ʪ��j�VU�JR�V��J���JUժ�TU��ZmU��VU���JUR���JUUkU�*�T�VժժRUUUՔ���R�T�J�ZUU�TU�jUUUUU�ZU�*�RU+k���*U�V�U�J��V�RUU�VU�ԪRU�֪��U���$�VUUUU��TUU������Z��*�U��ZM��*UkUU�TUUk��T��j�����VU�V��*U�TQ������R�����ZU�T��UUU���j�jUJUUYUkU���UUUU��V-UUe�R�V�ZU�jU��TJ�jU����JU�Z��,UU�Z�VUUUUU�����VUUU��JUUU5U�Z[�*U��������R�*U�JU����Z�JUUUUU�T�UUUU����ZUUjU�VUUUU�VU�jUV�������U�VU�mUUU�JU��*��J���jU��j���ڪUUU���UU������JMU�jU��j�����R�V���*U-U*UJ����JU-U�UU�*UU���R�V��U��V�*U�ZUU����T�J���TUU���Z��*�֪��J�����T�J�����e�U����V�ZUUU�����RU��RU��������T��*UUUmUk�TUU�T�����J����,����TUU��jU�Z���jUUUUkU+U�*UUZUUUUU����*U�j�RժZ�J������*U��RU�U-U����U�jUU��UU�J�U�*UUU��������jUU�j�j�VU�j�T����JUiUUU��UYV�*UUUU����ZUժZU�ZjU�RU��R�VUUUU��������jUUU5U����*UUUUU�JUU�ZUUU���jժ��RU�JUUU�������R��������������VUUU�JU����Tժ�������������VUUU�
//SND_STARTUP_END]=]
