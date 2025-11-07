-- lua/kickstart/health.lua
local M = {}

-- Compat: Neovim 0.9 uses report_*, 0.10+ uses new names
local H = vim.health or {}
local start = H.start or H.report_start
local info = H.info or H.report_info
local warn = H.warn or H.report_warn
local ok = H.ok or H.report_ok
local error = H.error or H.report_error

local function check_version()
  local v = vim.version()
  local verstr = string.format('%d.%d.%d', v.major, v.minor, v.patch)

  if not vim.version.cmp then
    error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vim.version.cmp(v, { 0, 9, 4 }) >= 0 then
    ok(string.format("Neovim version is: '%s'", verstr))
  else
    error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
  end
end

local function check_external_reqs()
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    if vim.fn.executable(exe) == 1 then
      ok(string.format("Found executable: '%s'", exe))
    else
      warn(string.format("Could not find executable: '%s'", exe))
    end
  end
end

function M.check()
  start 'kickstart.nvim'

  info [[
NOTE: Not every warning in :checkhealth is a must-fix.
Fix only the tools you actually use. Mason may warn about languages you haven't installed.]]

  local uv = vim.uv or vim.loop
  local uname = uv and uv.os_uname and uv.os_uname() or {}
  info('System Information: ' .. vim.inspect(uname))

  check_version()
  check_external_reqs()
end

return M
