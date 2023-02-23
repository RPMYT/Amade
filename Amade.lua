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
j«ÔUÿ €úÿ€÷t[İ’Åo@)?ëK!éõ‹¯m­@©’ú¿¨ğPÍÿÖZ­  Ej4ÿiT,@éß¾µÖV ¤¤ŞşJ‚(Ûıİm«V Uúÿ+$ˆ¤Têÿ¿µº T_«ª? ¥d÷ÿm«V B ØönU ¨”êâÿokpàO7\ ’&ÿßZ­V ı/JëÔ  ©’şÿ­èH÷½ÕF AJ%Õÿµ6ğ_{­D¨$µ¤ÿÿVR!dûö«µ )I§Uÿ ßMö_ U )»÷ºT‰!Ûÿ[% " •şR÷® ôve÷]SHk öjÛwC€Ú«µÿ¯%! í~¥ J$Õß†äoªö ºU¥ÿ+@Rõıßº*ˆ"¨mRÿ­  e%¤û¿­ú– º[ı/ Bj÷oíNBôõµ·"ˆH
+ê¿Rõ×|%¢ûï«$íîÚJM)@ú½wƒª Ux%Ğ©ˆ~jÿÿÒ– $}kí[p5õÒÿ“*b°jQö[PÒv÷¾DM@µÿ• ZHòïWİ¥	"U"È«MÒ»ÀŞºoR›¨m}#‰$U’îî¯+•\%Û$İ@5¥VQUUW»ª¥”ªªTÕ*5%)«ªÚVUÕVE-ÕµÔJ«R¥¥TW¥I-UU üÿáà8oƒã1<^ Õ³p_	ê¯ÂšüZ@%¥ì`ëş¤ß¨m+ »Aº
ª‚ºÔ¿‰ú†ÔÚ€ÔGò7@ê—¤_…ú­‘*@ıH·‚üˆş­ºV {%µ+ ıÒ*Ğş+io„~Ô_Iİ _Bı‚Ô¿j‹èßuR¿ úN©~‚´7é]ûK Úú/P»’ô+¡~…¼@ÛŠÔ-¿l«ª¿éO@ïõV@¿Ô?Iİê›}©[ ß
°7‘ş©· î
ä?„Ú
Rÿõé_!Õ^¨ì&D/‰ôŸ¨]Bş/B{"õ.@»ŠôÁşŠì*Pÿª ~Ô®Òûè/Ò}Ú7!»Ñ;’º’è¿€¾“ì.ˆzWÀ®€úE¨İş—Ğ½‚ö¢îBt‹¨ßué¾ôVH· èĞİz×ûBêPïD´-Ş"ö–RıEô¤¾)/ÛÙOIî…ò¯„¾¨¾@ÚØ]!ŞÕ¾ˆş¨¯¶Ih»ı«?Iï¢_µK@wAtÔoíO¡ş"º#TµÔ/!oE^/ªş´W Z’ìš@mUÙµ$»QZ·AªIĞ–HkKÕvÑ¶´ª–ªÉUQÖªTk¥ZUkUUMÉV’ªj¥¶*]*µÊµT]Ò*©JUK­Hv•T«VÕ¦tU•õº3ã5ÌüAÑÇ8Î+DÊÏ«+ ¥ÊÿÖVxk	€ío@[(Ieÿo«vW È¿@TW ¤¬ÿ­5ÑÛ oß@[!Qªÿo­Tô7 ©ş— ©.P*Õÿ[­ {C@^_€­’HªşkQÑ} ©¾¯@P[”jÿ_kBı†@v¿€º‰H¥~µB¢~@T~{AH[‚¤êÿ¯ªú€ìıª l„Tıÿª
!÷Hû]¡z”ªÿ·ªè+€¼}« ê–Jû÷¦BöTú}¡ú
(­ÿºRAª+„Pı« Ø’P­´SM"Õ
„ê÷"AzE¿·M‰¶¤mW¥U•¨ê}¯V"ô í­–"úª jë^k‰t+‘Pk«NÒ¶¤´ªZ¿­•
!•¯+’´«J-Ô{K5©JUT«¶”j-UµJíªª•T«HÒVU•ª•ÒªÕ6J«jª«Pµ4µ¤­&¥V›št+Ñ¶H©ZUUÉZ¥jU[ªV©¶ETµZURUKU«ªZ+•ªRU+UµEUUJÕUÕªTj•VUUõiU¥j-•WRUÉªUªê*©ªªJUU»"UUÕ*U«[ªJªªVU-U­JJµ¥ª«RMªªª’ºª¶*IÕªªUµV)¥ªª¶ŠÖ&Uªªª•ªV¥Jk*iU«Z+©¥ê*©¶«Hµ(üÿ·€.H¥äÖÇ¯¥èÒêÿF@Zõ¿vµ QTÿ_¨pø|àûóáá^p0@ú!üøZÿ}î­¶^¿*Q¡¤ˆÍ @(@’¡DBQÉÂ[>¾ÖÕóú¿¿İU]ëş¾¿&½¯ö.¼¬¨n
X JÜˆ’(@ Ğ¤R$„„Šªè ¥‰zõM‰<x½úëõà§ú½¿_¿º¶mÿ»oõ’Ûëõ¥Ó’Õ.m[+tz e	%¹‚l @"Á
ª"&ˆ²D›8É°Ò¢eÉzàg[g®Ô^:ûVùSú¡¯õß4ùKı—ş]AvÑ¾ÛöR¥ƒ­Oÿ4ÑàªjıJhHµ?€WÀÚUÀ/ñEP€ºä #B!Ò*Õ4©¹j!"@“şÖ"LØ®«_+…Ïòåï£OúÚ¡?ı}©­iÿ÷~}Ô‹^ıó÷Í&µSÿ5z[¥:‹{Q/*`•^ÂH–6 Y@K*	4Bt	Ø@ˆ"%VĞõPZ+*º£|>Éô§/¯v­â¿ÖU¿U¡?rûëÓ‹„îwkWk\ÿÑ0ià³•íRmQoú'R ~ÄÒ[Qğÿ¤K¤
õÒ?èğ‚ö²kåm‰^¶½Q¾À–şH/‚èoÉ‚$I¿ĞV<p‰·¶EğÚ¥v«|µú[*¥ßøCµ½Jé?HÀ“›lüJJ©j+7àÕ
à_ÀhI_`ÑBª‘ğuU ÿ€Şªı õÂ=ô+}ıèÆö+i_Ô¥}[àÖ½Ò_ÒW ş¨İüAÉüB—ªà¾’J*I@)I O < PÈ–TÒÄ?pÉ
şˆ}UiéËSõş¢>Ñ·ÕGè·èı©[¡éÚRE¨Úâ
~ğ	ZUì€—
ñßPÑBWN¾€MªèŠú‡\B~E7öB_¡ê½*]ø>ò›6lè/áKÒ]’ôƒlm‘_*ôZQÑ§Ÿ|Vòà?U¯ÜĞ7¡¿`[É"Ö—và\QU<Áà+è
|6¥^ˆ|$©ÊEà¶ øhUCnğÒ„èà•nA«]hOº¯ğ©·Úkú¯àoß¶_ò_Õ¾UEÿ´Uú[©dQXà*À,Ñ*j	øÕUöÂ/ôI[ĞOêmáGÀ_EzÔzÅ*ªwĞ—ÀüU]!Ù¿À+àğ­
luÊjîÉJß¨÷şÿ¥ıı²•ê?è«ì}i•‘¿H«táßèK+tö[ĞiUà-ğt"I[PSÖZ€º"Do]ı şAİõC½ÔR»ĞÔ'ù•€ÿ?€ª×Šÿ÷À«5ôÕP‰}¬¨õ¡Fm}Õ›-U C.Àà/%´ì¯tòŠú „}äRW_Iå¯iÀå°¤úRú¿Ú€~ö°€^ˆTÒ¯Bºëª¸øWü¥@KújÂ+ÿuêÑ/_JğKE’Ú£ªüëO¿z¥À‹ ‚š> èKNX}•"}*=€	E¿Zpä-%*Â-`’ÅTúµ•Šş¾…~zÒ…^pÔİ¯ªüßŞ,úëC¶¼RÉ¶şW…ÿ·m`ïW°ô%©ú®
|ıW_-€‚¾D‘?-hó×&¸ôµŠjuúÚ‹¿®¨h¯Ğ­¤ë‡ünmÚ~­z€Ë/ìå¯"Õª/Ôôƒ!*¿¶ ¥ÿZIä¿T@¡_*úëUıEªôß %7=P)ß^©Ø÷· ô«¸ê‘ªı…ˆİıª W?Èb/	 í¶Jxõ¯(úÓ ·*‘ÿº ¦o/haï	$TÛTúû…
ß~¥ [¯ ­:dË¿ôû«U¿R hı 	M¿z°KTémˆÒ
°ú»¥şİ$RßT B¯.Ğ¿-õß¹«uõ»ÙD¿·IIë/H`éEXıZƒ¼ï«Úö¨ $;	$Ñ¿*©û?QşE$¶jÔş½‰Vÿ¾¤Ğ·
Ğjôí
şûK
]½ ´­ Õ_YámOTõ'Ñº@µı« î¿¶@º_	 ‘] r·CZşßE¤ú•@!|ZABoÛšô÷-z½/HtÑE½ûhRû_Ùo½@­ª`éktï×½ú‹@Ş
Dï+Ğò½^HÛ_PTµTî«¨¿Ş…ª~›$V+ Ê«®(û¾-EüºUBhUé½K¤İ{%Úö½EĞÒ&J¨×«DJÿªšÔŞRÕ­”Ñ®U¤mï’¤ªß%Të¢Dz«šªª'šÊ_›„ÉZ"ÕÚ‰é~UT[m%IÕ¶R$µU­P_»"±m­¤ê![å.¥ªê«J©ş¢R’VU©ª]ª¶­–$İVIª´•¢’º«Ò’}SQÒ¶[­¨ªÕ­E«j•BoUT¥ÔªU©®V%ÒnKUÑ¥•*Uİ©DV\«ªj]Tªd7­ªÔVIU{¥ŠšjW¤ZmKEiµj©¥j•ÔU[’ªR“ªUµ”ÔR«RéVMU¥ZUUUm•ªÔªµ’6U¥IU½¨”š²–¬–UÒ¥mIVÚR²ªVµEªV­TuU©*­j•ZUÕ’ªjUUUY­ªT½ªjÒª•jUµªJ£Ú&5•ºR©ªªª"U5]EU+UU©µÒªTUUYÕZ­ROI­¶•"àx€à~Àô¿ õoĞé‘WĞôDo¢CöD7èêj¤¿ ¾P•úÒÔ¹¥-´B‰šè%/éÔ¯6¢JwĞ}Ğ"öÕ
ı~i7Pé¯ĞØou~Doé"•Ğ?è
ºäÕ }©O´B=ôÒE/´öğĞª­iuş*RZÕ]àA×[%şTüR$éÚ'M…È_~
P»±vBêÿ	”Vú=é
àïJ‰’~ƒş ©ôWK€é'ÄúD:ÒEú'K²']EPuÿ¡
ÒOU—°·l¡ êò­ĞÒ?!^J¿ê •ï+Ò!é/ˆ¾ö"yƒÔ÷ˆô[ÁªdÕ_ê.ÔúU	áßI]·I¿@Jÿ"ªKî[J ½[Dt»û$„ú—.AUêoOHkõµE¥Õ]„¾¤§P	ò­Ñ¦¾ªZ*Ô¿voÄ-´ß
T¥ı©¡{•Ğ¶¶’
Yé¯$•¾ºUê‚ôWU	T{j_PµÔ­@²
m«
$¨VÔ+l•»uIµjÛJ[´êm¥íVU_„tê6Ü¢Ôª…ö—TYei­o¨î¦Šj’únQÔ«*µ&$-[*H·H´« ªnŸ¨UeY¿Un§JU%Uß-PµÕFÚ
BÔ"$­¥Ú%’ûİJÚZ)»Õõ¶Dé¦¤j¿I»’RªŠPÛ
TµVÔÖ*iw[RUÛB·¦Dõ—imªK"¥mJ©*Ir[ÒºURÛU«v%ªÚ®ÔZKRÚj‰vµ¨ª’¤tK$Eµ$WUzU­ÕVÕª^¤ªºUUU¥ÔMµRµ*$MI©ª—D’ªVkkÉêU•´«jÒUÔR­U­ª"­«*©j©T•T•«ª¤\•kÕUE­­RYµ«ª‰ªª[ÊVU¤&UIUª©em«TQoU«ÔªZk©Z«ªZÕJi[U•TQµRjRUZRªª•ªZUÔÖj¥ªÒZÕTµjUcUµª*UUªJÕª”´ÒZ¡ªv©JÕªÚRU­•´²®jUÕJªªªª¥JTUU%WiUU+µªV•V©U­Z)µUZjU]¢ªªTUSU²JªªU©ÒUÉªjËZ¥ªjUµ¦ºTUmªM©KJ5I­ª*¥¥ªªVUKU•ZUKµV•ÒšÖ•ºÒ&­‰ÚR¥ªÔ¤TUUYU¥ÊZ•ªj•ÊRWiUYUUµE½’JÕJUUU²ªRUÕÒRÕJYÕRUUU¥V¥UµV©Zk©•ÚRU©VMU¥ªR«UUM©)µªRUKUUUUm•jU«ÒªªJ­P›ÒJ-U«´•®JUi©ªªZISU©UÕRmJ­R­ZRKUU•ª–ZI«T«ªÊ*U%Õ–ªšb«jUÕZµªª´R§jUU©UZUşàş~øâ/Ğ©/Pş
¤~© ¿ˆÒ×ô…¶İ€_• İè»!Z}í[PÒ/~#*şT¿¤P¿úBê[ ¾ª èÛ
Ò~@¶m‚ô v—Hş©»JĞ¿€´Wú+A÷¶€ı%¨ÛÔÛV{	Ú[HëWş%İCĞ>‰¤¿í­$õW ıŠD½doèİõ½„ê/v'$õÔî
Ô¿Dê]!ôBm„öEdï*ĞßDê¾ÚOHÚˆ¾ÉîÑ¿"Ò·lWíV@ß•Ğ}Ô¿‚Ô·Ú. è[ ¾S¢şKäÛR?ª«@ú7Ş« +ĞkÑ^Ô7!í[Èv_Dû"T~‘ Ş@êÛõ¯¨ş]‚İP{#HwÒï„v¯%ı+„ú…$ZD÷”ï¢zí«Ü6uEûÔwö®!Ú› ‘(é*•~KÕıVµ¶
è6%T¡Ú/Qwê½ª¶UÕÔªªÚ7Uw¿´¶)ĞV	W ‘®ªÚÛšöV)µ%¤JJDU”êk­­zÕ[UIUI’ªYµªÕVmkoZi	‹Z¤
ÑRW«µm«v¥%­”’J*¢I+m½Öª¶ÖUµP¥”ªTB•v©­¶jÛn*¥¦¤Ô¤UZ¥®ÕªõªVUU©RJ))U©®ÚZUW]­U‹””š’R©*kµJkWkU•Ri©*IRkU]«ÔZ«UU%Uª
RU)WµªºUµê¥TU•VU¤Zªj[KíªªÚÔ¤ª”T¥ªXËZUUÕV7UKR%-¥%µR­jUm©·T£Z‘ZªµJ•êJkiµUÖ¨U%W’UµJ[UUõ*µª*Ô*UÉ¥TU[RWuª¶¥¤ZKRU%UmUUUµj5Uµª”JU©ªª*­ªj­ªj«JU¥RU+%mUªÖªÒZÕJµ¢U©Jª•ªVUUUKU[U©­ˆªV%mU)kUUÖ¥ªÕ•­’ªV•tU–Z[Iµ­¤¦&UUUÔZ%mUUU—TÕ•RµJÉjUQW¥Ô¶JÙ¶DÕ–RU-Yi«TµJÕ6UZ—¢ZKJµ©Tm)U­–Ô­’ªUJµZTUUÉj-UÕRUk©TMUUU*m•ªZUUµZI[UÕTiÕ”ªU¥j­TÕ¦”ZU¥jUTk)Ú¶RjmJÕZRµ*eUU©¶U­%ÕnŠª­PµªRÕª”¶JUm•T­U´URU§”jMeUµTm*Uk%ÕªRiUUZU•¶ªTM«Òª%Õª”VU•ZU•ÕJUÕFUKUUK¥UUjUM¥ÖRU­ªÒ¦RUUUUUUµªT«*U[•ÒÔTU5UU5UÕ¦ªZUUU¥T­*UUUUUUU­TUUUUUUUU¶?à
|Ã÷_ğğÉ@êº¾ ¦úúÜÚ*x‘ßP_ +Ñ§ Èö‰kRô#"RJ¥ö ÖßÅNZèG{Coo­ä[DÂ^’×ÿ’~*ıVBïWåïW©ªµ»6   lÍªgñBùïÃgë?ûıÖö hRKµ)').•GÚ¤åÆçè±V~  JJ)5[×îÖ×··÷öö|ïò}ù "RDE‘ÊHcÓ2´*MuÇñ÷:ow\o¯ ¨±U¦é¬VjÄ±×»vŸ¾îËESb‹ÊéñÇ\ø8  @¤XJ1•–•®sÎŞö¾ÛŞıÚ»í~İ{¾{Í¢e  P"JÄPŠÑH)ÙõŞ÷ŞúÎÛùöõöîõîîv ¤Äˆˆ$’D$E)¥´¨XËÎvÎ…ßïzóu´Üùîßı  Uj¬*—×ÔÍ¯»®ëêşò(8²‚ÆH;zRšs£G   QFMiq³xİzû½î]ŸÛõ]×=ëõ—S¡Åœj   IR’ÄH™’ŠG¿ó·ÛîúµïüzÛ»îî®wo{Í  @R¥”TD"Jj()¹İÖu{íZ—­ıîı®wİßvw¯  ÕªíŞ¶Ö¾vo»ïİ­	¡ RU@‘¬mjkí~÷  ¨TÕª¶÷Ş½ß¿Öú¶o»{·
E PQÕU%ˆPÕ:   ”D’ÔvÛöİííŞín×Ûİ½·{İ›m¥PPIDb   ”ªÚ5UU«UİÖV×í¥ï½{m·JiUWÚµÚz÷ ZµÖÚíÖµJI’*‰Uª*¶”Hm«j¯µz×Z£­¶ßu  mï­ÖzÙŞmOJ¢¤ªj«ª$ÈjÑ¶İUµ5Uş j­n÷¾İw­¶o·»»·n!T!¢ ©*»½Ú­î  TJªÛÕ¶ï]o·kÚ²*©¶´’Z•íşõë»»·ûv¯;  )•R¤$"D$©]İWû·Uk]*UYµí}ß}¿÷½mm» VU*"”ª*¥"„ˆPµzUµJ­·*Û¿·wûvï»Ûo hU[µ}·M’€"’Ğ")­ÒªÛ«R«EµªbuoÕşz÷ PUEÉ*ÕÚjÛê¾m½º»wm[Û¾û­m•P))	‘J%  ”ª¦jUm·ªİª¶İ_¿ŞûÖïnÛ¶*ÕJD"IHSR  DDR’J&RÙ–Ú×ßnß{ıİnßİİŞkm{«PBAÁÌ  TRÊJ¢îµªÒªT¶õÖÚmëí»{»»ÕJU*+QU­­ª Pj­ÛjİmÛ¶w¥Z	ÍU©¤ªU­,©*ÑªVoUo½  mÛ¾ŞŞÛÛn_¶•"E•Š””RADAˆUUõeU]U© Ô¶»ÛõîİÛëw×ÚªJJPD’$$%ÕªÛVi«J«T« ¤j[ûíäU•RUªªÔªJ©V³Z[Õêşõõ¾«İÖRR• (Uª*J©­RšªªV¹•ªU»kßŞwïõõnÛ÷v+²R¥*	 ¨RD(BDD’ˆÌT[Õ{¹ÕïuÛßõ{ïöîu÷^7[ PJ)BH$"©¤j­UÕÒZÕİVUÛÖîV[Õ–ªTm%UJªT€”ªV«¬¾­½ív[Û»U­*QU%©’J­ªT*JUj©*­MU@µÚv»v[×{÷İm[¥U­¬HTª))%IRE)¢JIUURi•@•ôénÛïv{ßk¿İ¶UU	IU’d¢J*Uª*’TUIªÖWµPëu­Õj­ZÕUUKQª*UU%ªîªÖUR­U»Õ²ªZ©ª«ª
 Q-’ÖvKUjUªUËªRUí­¶ª­ZUëjk¥¶­j«ªªZ‰( ª¤¢*%•ª¤j¥ÔÖšVªUUuU«İÚ¶íıu»İ­”ªV‘TUPÕJÕª¤*U•´JªV­ª­ZµÖz«ªÖU•´ªZ¥T¤¥¥V¥ª ª–VmZuUUµª©ª®V’º’ZS©ª¦ª*­ªµªR­­V­¶@uUUm©TU«­¥Z­ªVŠ’ªZ%)RÚj•ª[I+UZj­¬ÖÚ. U·®­j«ZµªZ¥’j¥Š¢U©VUµªª¦R¥jU«êÖ¦jåÚªTUUµª¨«TEªVµ¬ÚªZU­¶U­RUU­Šª´VS©ªUUU­€Z¤êVUm«µªR«ªªª-Õn©¥ªªªªªªÖªªªUÕJ*%U¥Pµª–”Zk©¶JÛöªV[kÕV¥ªª*UµJU©¬¥ªªUUU•ª*@ªVUªVÛÚZÕ*UU©ªªZUµªªj«ÔZU©ªUÕZªRUIU¥UU•VµªÒJU­UªZ­J«Uk­ªªªV­jU)U•RimU¥j©Z¥(©­ªZUªV­j¥UUÕJÕT«ªVª*UUUUSµV­ZUKUUjUI@U¬«ÚªjUU­ªÒRµªª*¥ª*µ¥ªªjUU«ª•*U­TUm«µ* VUUUUU¥TUUUj«•TÕRUkµ´TUU«ªjµªV[µV©ªRUª´ªªR•ªTU•¬ªª­­ªªj©VªªÖV«ªUÕRU©J©jEkµR"È*UUUµjUUUªªUªªU«µÕÒZ•êª¥*UUUJ­’*UÕReUP«¥V­ªUuiUÕªªU«¶ªªJ)©ªJ¥TjUµZUUíª•ªª¥ªj ©T­ª%[UU«ªª*Õªj%SUY­ªªª
//SND_CRASH_END

//SND_STARTUP_BEGIN
jUUUUUUUU©ªªªªªU­ªªRUªªªêª*ÕTë¾‹Ô^­½ÛjµÚ*©ï{İv»mêÿôµív÷şï½»îíİûvwwo÷în·ëîí½û¾ï¶+ÔÓ®Új‰BS^ˆ ˆ@E,U­@H"Dˆ$B$Uõ´(U·x) ’T½•ÿ_PJ}(Zuûÿ  F’“$D@ -	à ˆT’DRÈ&?h«R/]À“z Úı£ªR©øÿÿİj…®·úïÖÂº%ÿ¿®úU`ë}ºªX‘¤  
)U­„   !İ'D$%G(u+A„@*AH   U•Ôz!„´Û
lk÷ÿ“ $	U+U  "ë’@%)m­İª*ú5ôßÛíõGT]ZP€úÿWë%©«€şÿÿÿ½U}ßºû»ÛêÚûÿİµ•lU{k´-Õ×[ €"m«®Ü  Q¤W	@¢®[m¥Q]U%z (B @¬R©¾‚ HDuÿÿÿ¾‰¤H[ªM  I©%AÑın}ÿÛïÖ‘*ß®ı¾ ©Vİı¿û*Eµ
õıÿ¯BÛúïV-‰jıÿÿÿÿÕªHk­›êÖş»Û D’º­^ñê ICÔ TÕÕlz½¨ªşÓH  A¤ˆ’•h¹ @D„şİ»ÿ¿Ú6EÛª•Z AMZUÛ­Bbÿ·ÿ¿o»ë–*‚nWğV A‰¤ûåµK ‘èÿ·×ßRBõ{«¯Ğş»ûÿoWÒRu‰ÿ»RÛˆˆ¨zÉ«{‰€v  " ‘êVU®I ¤­N€@(U‘ö …€tµ½÷¿ßJ©¤¶®À@Û.»í
úÿÿÿïw·m«”ªTHHUŞªU«Jû¿€ ´ı~»]«­@`ßNj	‰mÛÿÿİzU¡dúÿû½´U®×W­¯Z@ %¤€  ¥îıµ•JH#ö‹ $ TK€*”  T¥Ş_wo—o“T¥şi`‚RåU oûÿÿo½v­*UiP @+şŠŠªWíô ´õÿÿ_ÑÊ©I½J_ xõÚş½¿v÷Öë¯şo×*šşêÒ[¨¾ë­ $@ Jåİïí„i•J Q¥ ‰ˆˆ‚$’Úí®•ò-I ¿u_B- "êıU©UXiûÿÿª^¤ª %@ )UKØÍW‹ÿÿúÚ¿¿»JM€”­|)€Z4(@ÿßªÿÿ÷»¿ÿ»mmÛlkÛ¶­’ÖÿıUj!•”l uûû/VU ""‘¢HM@JEH P*ƒ¤êÿ“D ¯V!º~{I• Hîúëê¯>	õ×ÿÿ—J(¨–*%  ¨€€ˆvï–ÛªßªŞÿoUP¡I°İ
@ ª>„ˆ~ÿo»·ıÿÿïßm·ÕÖZµm¯JRTuöÿ(©ª  ¨Ö_]¡.@  $I%@"«µ-"EŞôD…ş¶)UÿÔ…À½»n•ë­’
}÷_ùU Z-U €joë¾ReÕöÿok]@›$Uh•€"€şJı¿ïï½»ÿÿÿûm·[«´»}oµ*IŠ¶ÿßjB"¥HD@©  $H„ ‚¬v•TQB€”zß×B	 ˆ¾{½ºHIAJÿÿ¿ªAjW»ÕÿHHèÕC…*Ğ´  äûÿŞ*P¥¤¾ÿŞ*ˆ$E k !‰ª¥ÿÛUÈûÿ®öÿÿïİ¶ûZmÕîİ÷ÖÂJªşÿ[I„ˆ¨_@”TE €A"H’VõmU Ò¾÷­DD»¯ºU}¡ÿ¾ßU!!”&·ı¾¶õ¤w»¤Ê‡íWı^-úÿI@	Õúÿ¯J„@U¯µ @Bµ×'Iªÿ	ª¿ûïûûŞªíßª{_Eİşßûm›jõk"@Td_% ˆ  ¢ª Q¢&D-‰ôO©CPÚşWm ’ªÚ¥ÿVı·»ºÿ/‘ vÿzW BUÿ_¢Õõ¿mõ¯›„@Xµ_W,€ş§Z€ªßªÂRì‹PöWÿÿÖ½»Õí»ïŞßºïû¾ıµ%íoÛ­ˆ„DU•    !R"!)„$‚¤¨TU¯Ôâ
ğÿ_+€„j}Õë_ø{i•5´j  ´ r«¾K  VÛşV5½ş¿bIĞí)€¶*½@!TyëÿWU ßºA©~	Pë#ü¿Û¶µº¤¢ÿÿÿï¶{ßßí¶­İRë¶H¡/’ €@T¥"H$"	‚TUiÿİWníÿ·ªŠºÿßw[¡º»Y`“ ¥"Ñ»Jª/ ¤Ğûÿ+ªÛ{·r[‰K$IQ¤ 
@ZAÔÿWR!H»* êÖöÕ…ÿ»Ú?İÛM÷¾«şÿn¥®ß÷]‘Õö‘UÁÖ/! H   ¨ª„ $B”’Ò¬©­w·¬ßmk»[ëÿ¯¾« ­¿€ˆ´BA  ´"i«Tùİï}­måºİA}¨¨”üO€ UE}uíş›DFª ’®Òv/ êÿ_¥îûÕ{Õú·Õî
¾jÿ__mû-èÿİ&Š%% 	¤¤‚  ˆQBªJ”R¿¶¾Ú¤¿uÿÿ¾UÉµÿ®²©€HAIK•¿ıí–î•Rò* ï/€ª"ºKù ¤¬o“ê§®_— [ ¥ö] lûÿ_¥úowûo+ÛW‘JµzÁß[Jõÿÿ¤bÿÛª
HU  T  €„ªB$I¥íÚVÛmïVşÿw»mˆöş»*¤Ş_+QJHEŠtöBÿÿMPªJ»×$AÚÅÊè¯jK  úß”P©ßlI T¥DTÙ—(H ôÿÿWIûöïÖÖ²ª«°·´êÿHıÿÿHµ¿½µR"‰ˆ"    UU€HJU··VÕ¿î÷¾û}k+	ı÷µ‘êß>‰HD@)%U"Ò‹€²ÿ-% T¤«¾WT­şSéÿwHÙÿ×-‘¤-õ	€H"eY²¢, êÿï»­©~mo×*’(”¤ï}ıß²¶ÿ[Õ.ï¿İ 
D$„   D$+IˆH’ªº}w·ÛÖıİ¾½kQ•Vú_Kê}	D$©¨¤ÿK@ìîUW RZª%¡OòåM¿·î~İµÂÿšA…$HA@½.@K mõÿÿ«RmïnK“¶ZEw÷Ûî×ıÿİª¯MÔÿ_	I Q$ )  DˆRI•mÛöÿÿm÷{ßn«µJªo­ú¶$j[)T Uµıÿ„$Iê†­   R©´í©ÿ[VK÷¥İ­@¤p[ QÚK
 ’,Õ¿ßV%­Ü$¤ú½×ß[û{kjÿÿÿ×şûvÛ¶m[¥D$I¥  €Dj[-IQ·¾ÿÿn÷¶ÿ¾­T¥Q»¢Å®õ^ô_Û ìZo}û¸@ Ô"„¬%  Pmµ»UêşÿŠ¨ªÛ /EH ‘@@€”ªúí€H¯UÊş¿UR¶¸ºõïzÕoÿµşÿÿïîÿİmmÕZ’H B’$   ˆ$"Òw­ªm­ûû½wßîİmUIõÉ¾W7şÿ/I´5m'Òş#@‘ª Ú !HDHÿo¥ªîÛ½$ªRUu½ €  © $Iíı’€"*uYú×6Ê’ 
½ıMéÿ¿Û¶ÿÿÿo÷÷ïİªZ•ÔJ"D $I!ÕıvU©Zïßíşß÷¶Ô¶U¡Š*Ğèïºÿÿ¿T[Ñ¶„öJ H„  J@€¤­êÚ«ªÛîÒ¶ îH îW’  ªºßm—†Ø* j`÷¿kJH"•´şÛÕ}ßş¿ß÷ÿımíş¶T­¥( ED	!"Q½wïªªníÿÿïï­Ruïİ”PmAüïßw­Õ¢jÛ°[%‚  Re DI"€$)KJÕıÖ”ú{»ŞĞª ĞïJ "Ôz•ô¯R
@íR/H'Tş¯J»@¡Èşÿ«÷¯ÿïîı¾÷ªö»­µ*"@Hª„T*é÷µíVíoûn»ö­ZıUê·Hşÿ»w[[‰ m¥!U  iU  É-Iˆ|+ª÷*©¶ ¤ª!÷_µ
ş/‰¤*jíı–ÒˆíUÒåöE Rÿÿ[õ¿¶Û¿ß¶İwÛ¶U¡4  	T’€IDU{ÿûMíßUJÛİ¶Úk¿¾•DûÿMµ/íı* $­H$$õV Du¥½$T  {·­¤@{«(AHôJşİJÿ®@)ˆ’î½ôA-ğnIı
Bûşşíö¿%}¿¿÷¶İ½Ú¶5‘’Ô   ’Š!D©€"õ­Ú÷ë¾ï¾ˆÚïÛİní~oÛ–Úÿ¯¢Ôßöõ½"€H&•BPE$©@{…‘T	zW¼ZE¯„¸ Qb—ôÿ¿ªªş €TU­ X©KWú{ÙoŠ´ÿ¯I¨÷ıßUo»{ßJÙï_Jj TU   ”"	IB@µ÷Rıß½İmK¥’ş¯í¾o—¤¶oı¿­zß¿‹º½)"ĞM! *µQ·$‘^  I]µàk=oB$ª" Jıßÿ­Vê²_  $µ½A”•ªHèï¿T_Úÿ¿•ê~ë¯ı·º÷õ&Mÿÿ­‰”$PRÚ P	D" RÛWíı¿m«ß­Dß÷î~·*j¿U¥õÿo{ïªVÿ-@$ˆPR-  ^@İU@¤¶¤J}’ª "A\€ôÿViï*EÈ @ª¶+ $Ñªˆ´ÿÿjÒ›îû¾·(÷õn/yïÚö«Hİÿ_T‹U© -  „$$U­ê{ß·Û»”Ò~÷}›¤*ØV°úÿ¿Ûw[µm¯‰*u  Ú’HTBª´oõjeŸ[! ÒVdõ¿UûIHZ!U÷§€€!U[ı¯Qíÿû¾[*õÛş··*ißk»Š  Rˆ¶+R " „’DEª{«ÿöïwïí·5êŞ÷o[•Pˆüııw÷İİ¶ªUU	D¤® ˆÚ-¤D
 [ª¯m+é÷’í+ €B’º@Ú¯İ¯U ©ê¾€j		ˆ@JDUıõ_µnÿßöjïÿµí®«"!ÿ·m¿
H‚ "H$R­!”TÕêÿïU«ıÿ·
İ½ö¾J÷ßÚÿë~kSE×ûoU H‰¢Ô¯J¤z»j•š´¿ïJ€$	 ¥ş¿^KVª–ê¯  H’T¶•4 @·m'ıw¥ïßZ¿ßk÷öÖT(+‘ì¾í‚ô	 $!»$!ˆöÕZ  €”ªİŞo5Ô÷ûo«¢üö¿wµ¤•¨ÿo{}û[UU–HV­ ¨±¢@d·@+ˆP"Éº¨¾oQ•¾  @UÛo½U[+U@µ¶mHUeS÷ÿwouëûÛjûÿ·JzG*„²–m…(€
M$µ%DzB  Rªí}E×Zøën¿Ôşÿş¾ßİRKUÿİu¿¶µŠ
v«´)h@ıú@$U‚@@­@¨ZzJo÷@  Bjª½w[ÒJ%‰~  !’ÚVV A*İ_¿vmWÿï·[·¿ÿ[ÕmW ©z¥7 @©
õ}I¶$@¢ÿH!  "Ùv)¤¾‹Pÿ·ï½UÿÿÛİÕÚİZOªVï&,½[ ˆêş·JbÛ  ’‚ @$„¤u	R*hï— € ¡¤jõ/’²ï·•@©Ún!"[ Ò¶îıUı?‘ÚÿıŞ»¿ÿw·µZ+¤[Õ HUÿšv/HêÕş«  ˆ@ÕZÍPú·„äŞŞ~ïÿÿİİ{{«Úö¶[ªú}KHX}P‘ÿÿ¿V%"Uí  €¤D”*UHˆú7 €HÕµ%@wµo D"I]U	U„ Píÿ»m%©vPıÿıVöÿÿ¿[«6)ªİ– Bªÿ[ªJ¢Úê„H@)«ZÈ¥Ò“ jÿïÛ½ÿÿ{ïZÕj½ÿŞZU•Z@ÕV ÊÿÿÿU•RŠˆ¶#  ˆH)B$­Hi%€ $%‘jIÕoïAA„HõU„¤ ”Úÿÿµ%¡´ª îİ[ıÿÿÿU«¶’’Dë
Dô}o« í	ú½V ¨ˆªBt¿
	[ıïn½ÿÿı{[Û­Û}»w[­EPmÚıÿÿ¿MJ©j"tH„$D‰¨´UíºD ‰"BµèûUº @¤%¡€ô_¥şÖİJ(€ôïí÷ÿß«
ª¶­Òıu+Pı]¥ôªõoE €	!©ªûV«ıÿDÕÿÛş¿wo·»mw·o[+%•ï		õÿÿö÷·RRRŠ$¤4  !„ ’Vk*õßŠ ¤T[Õª$-B !ÕÖ ÙVº{!ô»Jö íÿïvï¿V•T¿
ÒŞ¿¤ªİ÷î½«¥J  U[%ıİİ«®¥û½ëûï×JJ[Ij· Yö÷Ş5ÕşÿÛ]»ıwKB AR% ‘‘ÚµšRßİ"’RµõÿM…Ò+ Rªí… ¤D"„Ò¿$%]ûõıêî_ïú¿ÿn©ªª¿DT•Ô¿ö«‚¶’R $ B’´W"İîv÷··«JÖşÿ*•‚”–`ÿ-¢mÿ—şß¶½íìş¿+’D QJ€"*‘Ş×¤ÒRjõ€H ‘ö¥V¥ìËúBDZ¤’€ˆH¤ú?@DÊİmÛvÛöÿİ½µº"!”ìû*²v»şï[’R¿+  ! Uí»%Ò¶ÿÿ{İ6¥”~»í¨îéªÿlo+û÷ïÿíŞ÷mk«H Iª* @Qõn«‘("ë *Õİ‘vëv—"Øª "Bªì# ¤­úÿû¿ßv[«İİ]U‰¦ı¿‚¤Aâÿÿ6µ•Ö¤P  IRWÿ+D²w¿ßß¶I»Òn­ÿ­ï¾
¨½Uí_äÿÿÿß»µªj%! I’”   İ¶VHIU%’"IµHûÕ}}Á®@V¢–½‰H€@P]U@õıÿÿß¶ÖªõİÚ6‰Hí¥…*¤@Üÿûn÷wUDDD„ªş›H©ßnûÿvÛU©ı¿½ïêî
Ôï·Dˆöÿÿÿ·mÛÊR’Šˆ(€@ $i»I	Ij›"I•)Õ¤õRõ*-è«úW„  )!€@$)))Õÿÿ_õşÛÚîvïß*i%¥MIïåı¿û÷¶­U@PUˆj Dt÷[ïW’İïşß»v[UÍ($õÿ+)Ñÿşÿ¿wWU­î‘@ ‰ @H’U•¤ªT·+ ¤W@¤Şû­	Dd]T–¤«Úª Ù „H$µ’ÒßıŞíÿÿvëvÛö»T%‘’]©"Õÿ¿ïí¶­%HUDJèI  jïîo«Şÿ½ï{Ûî¶TUˆH½ë×¤ ˆúÿÿÿÿm«ÖŞ·J€ ‚ „ AH"’VSUU©ê©W@eÿV
 !’*­½ÿ§V*€‚ª
  !’’$"İ½¾ÿÿ¶mW÷ŞV‰TKJ[(©
	éÿßªVBUIE ’®€ B”¤mÿõ{¿ßo·½·»U+”’ú%D_ ôÖÿÿÿ·­µ{¿UŠ€@BˆD‚ˆTª•²­ERZ³( ú_D H„”¤ê×ª4 A»Š   	I‘$­ıÿÿŞïjwû¶RUÅ
QW‘ÿ¶Êş«ÿßm¥@ÒëEZ A $ÕÛıÿıî¾[ÛİÚíÚªê"ˆJ’’¾wÿÿÿÿW»»W•€ ˆˆDB(‰¤jU•’ôí{WQ©* B$ÕWIİV Ñ­PR )   H$Yªîÿÿo·k[Û¶v[%)»ºû[Zµ›ÔÿKR…¬ÿ_mH!H ˆT¿mwßÛÛ~·¶µÖ÷½ I[+u¿ıÿÿÿïİª¶­$ˆ IBB$’”j­Vm[ÿİª@Õ-P   ¤¶kI"Q‰äöm—‚QI    (IJIKûÿ}okk©İ·{Ûª’ö·•Ğÿmèn• éÿ­‚ Ú ¬]B ÈİûnUïûşíî½¥vÿ[Û" $Õıu·•èÿÿß¶U•H‚ˆˆ ‘"RI²[[IªúõJ[ˆê.   €ÔÚªDj­[+(  DTMY•ÔÿÿïV­¶íÿÛÖvßV­dwÿ»è6UÛEZ‰"Rİÿ-@€¨êöÛ¨ÿmUõ^÷ß¶%€híû»U)ıÿÿv©*A"‰$AH"’È+ÕÒ~RıK)€ €©*ıªjö_½• 
; @ ‰RªK×¶ÿßv[UûŞİVêŞJøßmµÿ¾¦RWö.  zß(ÉŞ®€”T@Òÿÿu·ïÖª¶%õÿH¶m!(õú¶ÿÿ[UÿŞÚV ˆ$	‰D”Z"©şnÑ7©*hU @‘"!‘İÿ®"Õµ[I@¤  @$¢ª»­ªüÿİÖ*íºÛî¶eJö}oÚmÿ_
¥-hBE¿é¯ê…@ınüÿ×Ú¶­ûÛŞV»S 4$ ½VUÿÿÿVkW%@ˆTT DIõ*ÿ_B TO©@(A $µ"(H¹¿/)ÛnU–°² €   @H’ªú­J¥÷_Õö&µôŞ®ŞßÖı•ûÿ¿MªBwI ªw«Bôş“Tû[Ûú%í¿o÷¾İÛîŠE“ş•©·ÿÿ_«²¾*Pº	BR©û_í	Bj­@ ¢$BBÔİ”  B¤«İ¥ZÚ­%¥Z  "‚¤ªTßB"ıKÛŞM”ºıŞ][í¿©¶Õö¿­B”
$­èı+©Mº¿·ı•¢ÿoİ­şoïşmµ¢„BÕoI·„öÿUDÚ>R$ IZ €J•ÿWŠº
 ˆTJˆZ $¤B¢´ˆ$ªÿ¯U²MJî] ¨ @"m¥ªz”@şÿ*Õî%iÿ~Uèÿ•ºeï}+D‚¤ˆú_	©Ğ¾¯{ıwÛ~··¢ş{İ¯¯ª HÿİÒş[îÛè¾{w+R(©$ €ú¿w%µª "RÚ’€€  „ DI‰èîÖê‰T©~%ô&  BµÕ¢n"İÿÖ”Öo_+ÔÔÿ¶_»»m¶÷mM EDÿo«€HKíêûÿÿî{Û¶ªê_ßºU[Ô¿Û¨ßµ*­"x÷~»”¤@îf!D JÕß¿m«"E©­@*@  A  "‘"DµİV{[‘*IU· ¤ªj]Ñ€½Uú¿5EZ»ì_kû¢ûÿ¨ÔßEZZ«mû_+@ˆéı¿·}÷^í¶j½ûö¶;©¶›-mAö_¢¹oKIHo%$I"HIèû¿k-©† R‘$!+ $ @ €€@J’’¤ºëªªê½{İ¯´
  €H¤T©]—”'éµÿn­y·Uß¿tWŞÿ­D¶Û‚şmû·v¯z£ @Djÿıî¶½¿w·ÕRûÿŞU÷ÚµŠH©J÷mm©A@¥ê¯  P“‚”(•¯Öÿ›*é¶"•"ˆ€(   I¢*EUûÛªuÕ_÷WJ* @@‰ ¤,ÕÖ]K‚”ı]U¢Ş/õ+‘Tõwíşºì¯6ûÿ¶n­µ] M@¨ïUu÷ûı¾]««ÿ÷ö~wëV·… Rïmwßv[ RRõ_H[ zoµ´ïU5% ²	AR­   ¡ª´ê­û­B«ıßÕª„ B  I„H¤jÿŞªRˆ¨l¿WïM’J RÒß®ıî­ø·VÒş«µ°°ÿ*$Q}«ıÿn»÷UÕÿßÚßßİ¶­H$Rû¯ÛMß‚H„ôW%Ù	DÕ’zRÈëoj	 ¤ˆ‚ "] ‚ @ªWµ]¥úÛBîu7‘¨@ ˆ $$Ò$©ìÿ­RD‰úî+U‚J$@Rÿ[ë¯»ÿV_¿mß»«„Ò[‚‚ @ê½¯ïí~ïvûîn÷¾mïm­«
 í~WIkı©* ûŞUI%D‰I¨N Šì_IP*! „Tº¥"  Hİí·KT®U}KÔH(@B‚HH¬[µ¤şÿ·%! Õ~[	ªN*Á¶öÛ»¾ûßİVº¿o%DÕï@ŠDïßv«õÿïÛnßwkkíÛWKQ¢İÛë.Õÿ¯6%b·ÿß’R J•@#€‰Õ[’ª ˆ„DAU{W   ê¿­¡¶ªª@$yRA ¤DP ¢HÕû+iÿÿE‘ ]»Ñº6$ TİúVÕïıÿ×Şın[%)’Õ‚"µPÿßí¶ÿïİİ÷İµ¶k--IQÑ–Zı]KøÿŞV©(ìÿ¿U!J Š ˆ¨¶V+ "IRAiÿV@*Ñk	@÷¯İ"€D’Hªÿ÷J”Ûş¯¤ê½•RA È½[¡Tûÿÿ«İ¶•TD-’ú—ˆªª´÷oıîÿÿı½ï­ÚîVU#J­İÿV%!¬ ÿÿµŠRÿÿ_U©@’„ˆˆH¥}‰A¤ "ˆÚ÷·%J TR”ôÿ—ˆHH• %E@$H­~ÿ_[‚PRÿ!‘J·¾¤j"¨Šìßê·ÿ¿ïmw­µ%‘ %„ú-$ZHûw¿ıÿÿ×¶µÚ¶VÕ¢€ıİÖ^·´DQşÿZÕ.ıÿ«‚HD‚ $I%"ER D!©¬ÜS_M@HXY;½ş.")	êõŞ÷µú[ª@’¶BH[}»'"õE¾wßÿw•R·½%	º¥ ‘ö"İUTòÿÿ÷ûşı]­U­lïª-+îş·wï­%µ÷·ÕV¡	% 	Q BÖ*‚ „DRV¾Õ¦dIR$UûS•€úÛJDQD¤í¿¢ú¥únwˆ ) "R[)ùµı·Dï½¾»×¾İ¢´´E/A"ªı5BºıoÛÿ¿ïıÛ®­Ò­ª¨»©–€T·¶ïkÚ­Q»{÷Û·"BjÛ‚ €¤TH !‘ÈV«Õ“ªº¢½VìK¨¤ş¦€D)Aêım­Ùªê}kˆ€(EÕ¡f¯ı¶»¿{ÛËŞš„TÿZ(-T@•ZmUIšúÛ¿wÛûŞoÛ¯–voªÔª’R‚ªZuÿnw·îÚŞ†í¾7€ªHIBHˆHˆH$‘$uİ{	"	Òßê] Éå»¦”®BHjkŸd¥ äËšz' AªRˆh·~É«{úÿ»v+¢Òş›$ê–@©vU¡HªŠïÿ÷Şvïİ¶İêjûo¡´»ªUIˆDÿwïŞµm»U+’¨Põ„JªT" ‰´-KU*BD ‘­ê»T*A@jê¯*µ_SR+Su€$’ú·Õ H ‚ˆ²Õ$©şímêºíß¾Ur·ªIkıUUU ­„Jı{÷¿mÛµ}w«´z÷·*¢„–R*ÔİïşßVÚn»‘º¿TÕ’ 
"$	¥U• ‚RB€H÷®D")­vï^	„$u×Zu_!A‰HPRT@ İ·- ‘ ªİj©}oWºë¾Úû}JRõïZ¨õ»­wI "Ûİ6ÕÿSİªU·Tû}[¤*YUëUÿ¯÷ûµİª¶İ"P°ûıÖÚ
 *%”ZE‚¨R%È’ÒmA T"i_Pú­ %ÉİV!Û5­"U"IqU×öEıRI	 A$»Û5Ao%Òo»__÷­ w«ªß"-µM;©@!Õ]Ñÿ¿µªÕV»Õ½ZµJ¡`KBÿş~·í^ßÖìİİÛ²Úÿí*m…
J
D)¥ ¤” UB$ı
‚¨DHênµ÷›@”¾Iô ¢}!Ié¿[I¤o D‚T’]©
é—ÛwéÚÛjõ»»‚¨÷»} şÛ¤6‰úRıÿV}­voSÿÊ’–ZÔRİïÛ·¦¶õîŞ_ÉöWIµİBUª-¡Š $"D "k+„HR¶Ve‚êj¿uKm-km	 $IínI¥Ú>Qß´ªªV%) P[MR“úï¯¤¤¾Ú«ºZ­Úûm›H%µ¾ÛˆHHûÿ¶êşRk-ı[‹T•$µIj·²jQıv«õï½Ûû[÷µÒ^¥^µİ”’ˆ( ’T]Eº«Òî«v«ˆZÛ}«@P”¤¶T„I5©şnBIiÕ~©JR‰$ ¤TWRmíş»Ûªª
"k·ºk“’ôß²R’J­ûÛ’ŠôşÕş·¶Mè–dï-¨Ğ÷»Jµªº»¥ŠÔúİŞõ¿Ûö··»µ»J²ßm )¤DDDˆ„UI½Ô^S_û	)ë}%	¤DBD’VÙm©µöä•Ò½’”
"Y HU]!ùÚwï¥o	H"TûH_•Ùõ÷Š¨×½÷—ŞëŞ_¯­J¢µµZêşnMí¿×¶U©ä{[µj«(UıÿíêİKµÿnED$ ‘„HD	*[P²«öõ—Zˆ´oE H "BRÒ®„¤»TÿÛVµ­’ˆ$U	ˆ$@Jk•@ÚïÖ~·*‰´%A¶JmUUÕMÕ÷õö[Ôÿîmu_µ´„H©*)©*µ÷wß÷ZÉÚî¾­ˆ*EÖ¿ïõ}o»–méÛ­
	 D¤DE"ˆD"¤êµj·İ ½—€Hˆ$!QIj¥º-¢ş¿–‚¤¬JA$¤T[¨¶ª÷U»ÿUUA¤¬¤µVÕªòİõİ¯%(ıÿİUµ÷¿"U	J—J ¢*Òß{ëÿ«R+î[µ*IKêwÛ¶ÿo­
Uí_*"R–RAˆ JIR¯ûô¿$I•~oJ HTE¨İªz•Ú÷MP­+E¢”®-!¥VD„ú®”ú^û­j¥ª!İUm!jo)÷jİVuÿkµKªÿ•D+UÊ
H‘tÕjÿÛî»ª¶·¿kISU#Iº›ªş¿V%ªÖ]*‘"¢ ‰„ @’ºª ¾/RUé^­ö+HU" ‘$IRm÷õIµJÕnµBRU-$ŠTKUÒ÷ZTou«ªºo¥DHJÖ»*‰ˆj{ßn¯Û•­îB"¶ÿ­A‘T’T
BµVı×»Şİoïö¶WSÕ.’V%©ªïÿº­JèV©D ”„H% DDJªº­ê¾VUí­’V[€’„Jõõµ*­*]ı’ŠjEJSD‘»ZRÚ½ëV+©nwm«$R»JªT’JZûkûş®]W¢m«¬¨ÕïO’ª@ÚmB‰Úï·n{o·÷İwW[U•Hšê–êïïZU¢R¶‚J"‘ "‚ˆH”$UÚîË‹HéîVùİÖ*
!%‚Rí»l[³VÊv/©$W!J}‚HQu»m·Jô»Vk—¨ªDQµÚV»µÚ¿¾¶UU}[Uİ÷¾«@BµªŠ) ĞÛo¯Û®ïıú®mï”jR·"TUÔÿ®ªMT‘*	VPB$		QõI€”ªík-»]Ûî—Êª@@J„JB@¨Ö×î6ÕÒµıZI"E%ÉSÕ&©öåöÛUëªİ(É*Ù*AHö­v•º·í¶Ú×Şíß¶DT‹º@B$Ğj¯¿¿Õıöu·ûn»–D„H­$YÕª­DúNÑªJ*ªDˆ %‘DD„RíõUußkkõv·$I„‚HP!"È­U»•ºß‹PUIU	¢zªOHK^½·mİU«¤v·–H	„ª-R½­V»¿–şî{¿«í®R+¬DDR@©"ı»İ{ïîº}Û]««ÚU	¤ekmWÁ¾×¶+	š
!‰$DR©ö¤¾kÙŞvUŠA‘$Iõ^ŸHİ¶²«Zš BM·ˆ$µ´¶ëŞ—|¯÷ºI’’Pµ–¤ª²*ªZÛ½İw÷ßÛm·µ[,BˆJ+…Dû}÷n÷ww{»íZ¡BEU!„„TU­ö»•÷ÚA$…H(‰ˆ „ˆ„²µUû¿]m[µÒJ%¡‚!IR_]k[õV•(B"™’RİTU!@	Êö¯¥êwÕª¢J«HUk­HÉRv«ªÚúëwı{k«‘HD%ˆHRÕ¤DÕ¾ßÿŞ»İİ¶vwKJ$!•!"‰ Òµîw·Õ¿İ­‚¡$T$"ABTí]íûöÚZS{KVB¢ ”ˆD$Yß·ª»&©nU$Š $R¯$
‘P}wW•V»w«RJ*É¶U×&¡ª×T²Õ÷~ûİV©T•Z‰ @DRUª¬T²ıÿİ»m[·İ{SA­ÚAQ*U­ûî–ÚîïU¢@A’*
A” Jª×İ¿Û]KÕÖ¾+E$¡ª"’”Hİ}÷j­¬U•µ´J! Qw‰IUíS{[IÕîjE•ÒZMê¾–T4õ*ªv·í÷Û¾¶$r«*(„ªRU¥Tõ¿÷¶»mÛ}kK•PP$*EE„P­Zõj*µZß»U¢DŠ(	¢B(‘ÜvuïÛU­Úm7	‰„DµªR‚H«joÕÚªuUªµ*QK*¥D©¶Ú6µ7«*¥[Sj[kU¥ª¬Z«µªšµê¯ûõîvÛTmª$’PIEHµ­ªj×ú¯oíîÚªm"%I„J¢‚RW•’V©[ªUUU•T©’HR„H EUIªµ¯OÛZUk­{U¥ª"IEu«D¤Êúİ…¤m)µªVªV‘’TÛV«¤TëRUUÚ*µºZ•µV•]mµªj}k·ı¶uUEU·•µDI%P*UÛªj+ºûow·­T•”RIªRH©’Z¥TRU­kRÕJª4¥*”TE
I­Úªí¶µVkU[m­JRI‰ª’RU•’ÚÖzw«J‘ÔZ­Vªª$©ªTUµUÉ”ÒªUU¥ª]©Zª¥vûVUÕv­Ukµ¶ªµ)%ÕÕ6mQJ©¤Ôz·VkM»®Õ’$µ•¤ªª*ÕVJQµJI­ªjmª”¥”*¥"’B!Õ'U©WkUé]U­©´ªRJITª"©¶¤Jm½İZŠVÕªZ÷õ&IˆTªRí•RRUU«²RU•ÕUm{[kµjkUµ©]U)UUU+µªön¥ªTR©¬÷ÛíV¥¶­*¤J­ªHÛR¥’¤¤R­V©b{µªªJQ%U*%©„¢²ºÖªvkUªjojUŠ¤¦ª*•¤”J©UTÕ¶omJUµj[ûuU”ˆ¤TªZ[­¨ªªJ*µZ©ªUUk­{»ªRU«V[Zëª¢ªRªZUí¶ªZ•*I©mÛ¦hm«­’JÕjRZµ’ªª’ªª´¢J¢şõÖ$‰JR¥TQ™$¥€H’ZmÕŞ.EU½k«¡¨ªV«D©’$¥¬RêkÛÖªRµJµ»»»ˆŠDVU©Ê*UõVJ©V«ZU)RÚÚ®ÕZS©ª[­úİ­JªZ+)­¤¶ï[	‘¤j·VU¥¶»ªª6­ª$ªÔj+•t+ET$©ûşZ…µU‘’RUS*"U«vëª+¥¶ßmR@I·UUDR™RUªİ¶{µ*¥VUÛzÕÚšHªv•*¡Ô¶İ-•”Ö–ª¨ZÛÕª¥TUµµÚîîM%Uë®JEDµîİIRÛÖ*¥ZÕŞ·­Õµ”T%Uu+‘$)µIT‘ªİöV‰D©¶JR•ª*	‰„$Uµ¶¶ÛÕ²öÚ""!ªm­RDRÙª*UUÛ½«JÖjk«ªªªµª‰ê®&)Uİªk)©ZU*‘¤j«ªJJªªmÕÚ®ıî¶Zªª®QJuµªRJUZ•TÕÚ»­–Ú6UµUªU©¢’D’º®¢HUû¶*©ª’ªR)QUª
A ˆ¤•ªº¶ï^*)UÛšˆ¤jUUiU)µ$¥ÕÛ·ªUµªÕªªªªVU
Bõn•RU­mU¥U¢J«ªJU¥Jª$ÕÖ¶ª¶îzßm“"e­JŠª­VUI)ªÚJ©ªí¾ÛÚ¤ÔµJUªTµR’U][¤İ¶Õª*%J«ª”R©„(Dj­JImïİU­HR]U)ªµµT"KIªTUWµ·µªªÖªVUUUUU%RÚn[E%µÕ¶µU’$UUUUU%©VÕ¯J«o·nU•’ÔVUDUÕªU¥R¥”ªJëum·])MU«R­©ZJP¢Tµ­$•jµ¶ªµ’”ªJ•’”‰¨´¥U%Õîn«ªR©¬VURÕV•TŠR•¢Öjë¶mi©ª«¶ªªZÕ*•”j­­ªT©önU-J)QYUUU•R¤ÔnÕV­ºn·U•JUUšŠR¥UU©ªRªRÕ®¶úŞUU•ÖªªªªM*I$¥Rk+©JkµUU¥JJ¥4©RŠ$)%©R«ÚªZÛ·ªT©¬U*URkU)IÊTªRk[»uU¥ªµµª²ªªª’*¥ªµµÔªjuÛ¤ªª’’ªªV¥*¥JµJ«¶Zw«­U’ªÒVVU’JµRÓJ¥¥ÒÚmÕ¶Z¥U¥VU©­TR•*ERUkU«¬ªjUIU•¢*•**"©DI©ªZ­]Ûº¶JªTk©ZK*UUªRRU•VëÖj­*Ukµªªª¦*Uj©”j­µÚªÕ´ªUª*¥TÕª¨RRµTRµjm«]«V+•ªª­ªª"¥ÚÔR*¥Õ–«j×ªVUªªZZU­R©TE)¥ZÕjSiU•ªRU­%%©”¤R©H*¥µª®V·ªVUUU«eKU¥TJ•’ªªªª•¶kµªRUÕÖªªªTUª¢ªÖÖZ«©Z«RUUµR¥Jªj¥ª¤¨ªZÛªªÚµªªRÕªjV«TÕRJ¥ª6­ªªVµµªTUUU­ªªª*•’RUUuU©ªT•ªªJU•ªTIU¥”©ÚV«ªªíªªªªªjµªTU•’’ªªVU¥ªÚV«*«V5­ÔªZU©T¥ZÖÚV¥ª*¥ªZ­”ªªªªª*¥¤ªjµ®ªVµZUµªJU­ªªªRUUU)­ªU[•ªµÒ*U«ªUÕVK•ŠRªª¶Z‘¢T©T«U¥*¥J«*UUJ¥ª¶ª•Vµ–*UU¥ÖZUiU•TRUVUÕÚTUµªªUÕªTU©­ZM•ªªªµ­K¥RI©ª¶ª¤ªªªª*UªªjU«VUUµZU­ªªªjU©ªªTM¥R«j[U¥*Uª´ª­UUµªªªª¨ªªUUR’J¥jUUU©TUµªJ«¤¤­UUUµU•TU•Õº*U•ªTªªªJUµªV[UªªªªUUªZµªÊªªªjÛVUªJR©V«ªJ©ªªJUÕªªTU«ªZmU¥ªVU«µªJUR­ªªJUUkU«*©T©VÕªÕªRUUUÕ”ªªªR•TªJ•ZUU©TU¥jUUUUU•ZU«*¥RU+k­ªª*U¥V©U­J•µV­RUU©VU©ÔªRU­ÖªªªUµµª$¥VUUUU¥ªTUU«ªªªªªZµª*­U«´ZM¥–*UkUU¥TUUk­”Tªªj«­ª”ªVU­V•ª*UªTQ•ªªªªªR©ªªªªZU¥T¥ªUUU¥ÊÊjµjUJUUYUkU•ªªUUUU©ªV-UUe©R­V«ZU«jU­ªTJ©jU¥ªª’JUµZµª,UUµZµVUUUUU«ª”ªªVUUU«ªJUUU5U­Z[ª*U©µªª¥ªª¤R¥*U¥JUªªªªZ¥JUUUUU•TªUUUUµªªªZUUjU«VUUUUªVUªjUVªªªªªªªU«VU­mUUU•JU©ª*•ªJ¥ªªjU¥ªj­ªªÚªUUU¥ªªUUªšªªªªJMU¥jU«ªj­ªªªªRµVµªª*U-U*UJ•ªªšJU-U¥UUª*UU•ªªR«VµªU©ªV«*U«ZUU¥ªª¬TÕJ«ªªTUUªªªZ«Ö*µÖªªªJ¥ªªªªTªJ•ªªªªe¥U«ª²ªVµZUUUªª¦ªªRU«¥RU•ªªªªªªÕT­ª*UUUmUkªTUU©TšªªªªJ©ªªª,µªªªTUU©ªjU«ZµªªjUUUUkU+U©*UUZUUUUU¥ªªª*Uµj­RÕªZ•J¥ªªªªª*U•ªRU­U-U«ªªªUµjUU¥ªUU¥J¥U­*UUU•¦ªª¦ªªªjUU¥jªjÕVU©j•T©ªªªJUiUUUªªUYVµ*UUUUµªªªZUÕªZU•ZjUµRU•ªR•VUUUU©ªªªªªªªjUUU5U©ªªª*UUUUUªJUUÕZUUUµªªjÕªªªRU­JUUU¥šªªªªªRµªªªªªªªªªªªªªVUUUªJUµªªªTÕªªªªªªªªªªªªªªVUUU•
//SND_STARTUP_END]=]
