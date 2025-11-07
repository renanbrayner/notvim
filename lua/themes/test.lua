-- Theme testing script
-- Validates that all themes load correctly and apply highlights properly

local theme_manager = require('themes.colors')

local M = {}

-- List of themes to test
local themes_to_test = {
  'dracula',
  'gruvbox',
  'solarized',
  'nord'
}

-- Test theme loading
local function test_theme_loading(theme_name)
  print('Testing theme: ' .. theme_name)

  local theme = theme_manager.get_theme(theme_name)
  if not theme then
    print('  ❌ Failed to load theme')
    return false
  end

  print('  ✅ Theme loaded successfully')
  print('  📝 Theme name: ' .. theme.name)
  return true
end

-- Test theme structure
local function test_theme_structure(theme_name)
  local theme = theme_manager.get_theme(theme_name)

  local required_sections = {
    'semantic',
    'ui',
    'git',
    'extensions',
    'legacy'
  }

  local all_good = true
  for _, section in ipairs(required_sections) do
    if not theme[section] then
      print('  ❌ Missing section: ' .. section)
      all_good = false
    end
  end

  if all_good then
    print('  ✅ Theme structure is valid')
  end

  return all_good
end

-- Test legacy compatibility
local function test_legacy_compatibility(theme_name)
  local theme = theme_manager.get_theme(theme_name)
  local legacy_colors = theme_manager.get_legacy_colors(theme)

  local required_legacy_colors = {
    'fr', 'cmt', 'cya', 'grn', 'org', 'pnk', 'pur', 'red', 'ylw',
    'bg', 'curli', 'ntxt', 'dark', 'darker'
  }

  local all_good = true
  for _, color_name in ipairs(required_legacy_colors) do
    if not legacy_colors[color_name] then
      print('  ❌ Missing legacy color: ' .. color_name)
      all_good = false
    end
  end

  if all_good then
    print('  ✅ Legacy compatibility verified')
  end

  return all_good
end

-- Test highlight application (dry run)
local function test_highlight_application(theme_name)
  local theme = theme_manager.get_theme(theme_name)

  -- Test applying highlights without actually setting them
  local success, err = pcall(function()
    theme_manager.apply_base_highlights(theme)
    theme_manager.apply_plugin_highlights(theme)
  end)

  if success then
    print('  ✅ Highlight application successful')
    return true
  else
    print('  ❌ Highlight application failed: ' .. err)
    return false
  end
end

-- Run comprehensive test suite
M.test_all_themes = function()
  print('🧪 Starting theme validation test suite...\n')

  local total_tests = 0
  local passed_tests = 0

  for _, theme_name in ipairs(themes_to_test) do
    print('=' .. string.rep('=', 50))
    print('Theme: ' .. theme_name:upper())
    print('=' .. string.rep('=', 50))

    -- Test loading
    total_tests = total_tests + 1
    if test_theme_loading(theme_name) then
      passed_tests = passed_tests + 1
    end

    -- Test structure
    total_tests = total_tests + 1
    if test_theme_structure(theme_name) then
      passed_tests = passed_tests + 1
    end

    -- Test legacy compatibility
    total_tests = total_tests + 1
    if test_legacy_compatibility(theme_name) then
      passed_tests = passed_tests + 1
    end

    -- Test highlight application
    total_tests = total_tests + 1
    if test_highlight_application(theme_name) then
      passed_tests = passed_tests + 1
    end

    print('')
  end

  -- Summary
  print('=' .. string.rep('=', 50))
  print('TEST SUMMARY')
  print('=' .. string.rep('=', 50))
  print('Total tests: ' .. total_tests)
  print('Passed: ' .. passed_tests)
  print('Failed: ' .. (total_tests - passed_tests))

  if passed_tests == total_tests then
    print('🎉 All tests passed! Theme system is working correctly.')
    return true
  else
    print('❌ Some tests failed. Please check the errors above.')
    return false
  end
end

-- Test individual theme
M.test_theme = function(theme_name)
  if not vim.tbl_contains(themes_to_test, theme_name) then
    print('Unknown theme: ' .. theme_name)
    print('Available themes: ' .. table.concat(themes_to_test, ', '))
    return false
  end

  print('Testing theme: ' .. theme_name)

  local results = {
    loading = test_theme_loading(theme_name),
    structure = test_theme_structure(theme_name),
    legacy = test_legacy_compatibility(theme_name),
    highlights = test_highlight_application(theme_name)
  }

  local all_passed = vim.tbl_values(results)
  local success = true
  for _, passed in ipairs(all_passed) do
    if not passed then
      success = false
      break
    end
  end

  return success
end

-- Interactive theme switcher for testing
M.interactive_test = function()
  vim.ui.select(themes_to_test, {
    prompt = 'Select a theme to test:',
    format_item = function(item)
      return item:upper() .. ' theme'
    end
  }, function(choice)
    if choice then
      vim.cmd('colorscheme ' .. choice)
      print('Switched to ' .. choice .. ' theme')

      -- Test after switching
      vim.defer_fn(function()
        M.test_theme(choice)
      end, 1000)
    end
  end)
end

return M