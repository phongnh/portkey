"
" This file was automatically generated by riml 0.3.3
" Modify with care!
"
function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

if exists('g:portkey_plugin_loaded')
  finish
endif
" included: 'buffer.riml'
function! s:BufferConstructor(path)
  let bufferObj = {}
  let bufferObj.root_marker = 'portkey.json'
  let bufferObj.path = a:path
  let bufferObj.root = ''
  let bufferObj.did_search = 0
  let bufferObj.enrolled = 0
  let bufferObj.configured = 0
  let bufferObj.has_root = function('<SNR>' . s:SID() . '_s:Buffer_has_root')
  let bufferObj.find_root = function('<SNR>' . s:SID() . '_s:Buffer_find_root')
  let bufferObj.get_path = function('<SNR>' . s:SID() . '_s:Buffer_get_path')
  let bufferObj.get_portkey_path = function('<SNR>' . s:SID() . '_s:Buffer_get_portkey_path')
  let bufferObj.get_portkey_display_path = function('<SNR>' . s:SID() . '_s:Buffer_get_portkey_display_path')
  let bufferObj.get_abs_portkey_path = function('<SNR>' . s:SID() . '_s:Buffer_get_abs_portkey_path')
  let bufferObj.get_root = function('<SNR>' . s:SID() . '_s:Buffer_get_root')
  let bufferObj.get_abs_root = function('<SNR>' . s:SID() . '_s:Buffer_get_abs_root')
  let bufferObj.get_abs_path = function('<SNR>' . s:SID() . '_s:Buffer_get_abs_path')
  let bufferObj.get_rel_path = function('<SNR>' . s:SID() . '_s:Buffer_get_rel_path')
  let bufferObj.get_rootname = function('<SNR>' . s:SID() . '_s:Buffer_get_rootname')
  let bufferObj.get_filename = function('<SNR>' . s:SID() . '_s:Buffer_get_filename')
  let bufferObj.reset = function('<SNR>' . s:SID() . '_s:Buffer_reset')
  let bufferObj.set_match = function('<SNR>' . s:SID() . '_s:Buffer_set_match')
  let bufferObj.get_match = function('<SNR>' . s:SID() . '_s:Buffer_get_match')
  let bufferObj.has_projection = function('<SNR>' . s:SID() . '_s:Buffer_has_projection')
  let bufferObj.get_projection = function('<SNR>' . s:SID() . '_s:Buffer_get_projection')
  let bufferObj.get_source = function('<SNR>' . s:SID() . '_s:Buffer_get_source')
  let bufferObj.get_pattern = function('<SNR>' . s:SID() . '_s:Buffer_get_pattern')
  let bufferObj.set_enrolled = function('<SNR>' . s:SID() . '_s:Buffer_set_enrolled')
  let bufferObj.get_enrolled = function('<SNR>' . s:SID() . '_s:Buffer_get_enrolled')
  let bufferObj.set_configured = function('<SNR>' . s:SID() . '_s:Buffer_set_configured')
  let bufferObj.get_configured = function('<SNR>' . s:SID() . '_s:Buffer_get_configured')
  return bufferObj
endfunction

function! <SID>s:Buffer_has_root() dict
  if self.did_search
    return self.root !=# ''
  else
    return self.find_root()
  endif
endfunction

function! <SID>s:Buffer_find_root() dict
  let parent_dir = fnamemodify(self.path, ':p:h')
  let portkey_json = findfile(self.root_marker, parent_dir . ";")
  let self.did_search = 1
  if portkey_json !=# ''
    let self.root = fnamemodify(portkey_json, ':h')
    return 1
  endif
  return 0
endfunction

function! <SID>s:Buffer_get_path() dict
  return self.path
endfunction

function! <SID>s:Buffer_get_portkey_path() dict
  let path = self.get_abs_root() . "portkey.json"
  return fnamemodify(path, ':.')
endfunction

function! <SID>s:Buffer_get_portkey_display_path(...) dict
  if len(a:000) ==# 0
    let portkey_path = self.get_portkey_path()
  else
    let portkey_path = a:000[0]
  endif
  let parent_dir = fnamemodify(portkey_path, ':p:h:t')
  let portkey_name = fnamemodify(portkey_path, ':t')
  return parent_dir . "/" . portkey_name
endfunction

function! <SID>s:Buffer_get_abs_portkey_path() dict
  return fnamemodify(self.get_portkey_path(), ':p')
endfunction

function! <SID>s:Buffer_get_root() dict
  if !(self.did_search)
    let result = self.find_root()
    if !(result)
      throw 'Portkey not found for #{self.path}, use has_root before get_root'
    endif
  endif
  return self.root
endfunction

function! <SID>s:Buffer_get_abs_root() dict
  if !(has_key(self, 'abs_root'))
    let self.abs_root = fnamemodify(self.root, ':p')
  endif
  return self.abs_root
endfunction

function! <SID>s:Buffer_get_abs_path() dict
  if !(has_key(self, 'abs_path'))
    let self.abs_path = fnamemodify(self.path, ':p')
  endif
  return self.abs_path
endfunction

function! <SID>s:Buffer_get_rel_path() dict
  if !(has_key(self, 'rel_path'))
    let self.rel_path = substitute(self.get_abs_path(), self.get_abs_root(), '', '')
  endif
  return self.rel_path
endfunction

function! <SID>s:Buffer_get_rootname() dict
  return fnamemodify(self.get_path(), ':t:r')
endfunction

function! <SID>s:Buffer_get_filename() dict
  return fnamemodify(self.get_path(), ':t')
endfunction

function! <SID>s:Buffer_reset() dict
  if has_key(self, 'match')
    unlet self.match
  endif
  let self.enrolled = 0
  let self.configured = 0
endfunction

function! <SID>s:Buffer_set_match(match) dict
  let self.match = a:match
  let self.configured = 1
endfunction

function! <SID>s:Buffer_get_match() dict
  return self.match
endfunction

function! <SID>s:Buffer_has_projection() dict
  return has_key(self, 'match')
endfunction

function! <SID>s:Buffer_get_projection() dict
  return self.get_match().get_pattern().get_projection()
endfunction

function! <SID>s:Buffer_get_source() dict
  return self.get_match().source
endfunction

function! <SID>s:Buffer_get_pattern() dict
  return self.get_match().pattern
endfunction

function! <SID>s:Buffer_set_enrolled(enrolled) dict
  let self.enrolled = a:enrolled
endfunction

function! <SID>s:Buffer_get_enrolled() dict
  return self.enrolled
endfunction

function! <SID>s:Buffer_set_configured(configured) dict
  let self.configured = a:configured
endfunction

function! <SID>s:Buffer_get_configured() dict
  return self.configured
endfunction

" included: 'autocmd_loader.riml'
function! s:AutocmdLoaderConstructor()
  let autocmdLoaderObj = {}
  let autocmdLoaderObj.cmds = []
  let autocmdLoaderObj.set_group_name = function('<SNR>' . s:SID() . '_s:AutocmdLoader_set_group_name')
  let autocmdLoaderObj.get_group_name = function('<SNR>' . s:SID() . '_s:AutocmdLoader_get_group_name')
  let autocmdLoaderObj.load = function('<SNR>' . s:SID() . '_s:AutocmdLoader_load')
  let autocmdLoaderObj.unload = function('<SNR>' . s:SID() . '_s:AutocmdLoader_unload')
  let autocmdLoaderObj.cmd = function('<SNR>' . s:SID() . '_s:AutocmdLoader_cmd')
  let autocmdLoaderObj.size = function('<SNR>' . s:SID() . '_s:AutocmdLoader_size')
  return autocmdLoaderObj
endfunction

function! <SID>s:AutocmdLoader_set_group_name(group_name) dict
  let self.group_name = a:group_name
endfunction

function! <SID>s:AutocmdLoader_get_group_name() dict
  return self.group_name
endfunction

function! <SID>s:AutocmdLoader_load() dict
  execute ":augroup " . self.get_group_name()
  execute ":autocmd!"
  for cmd in self.cmds
    execute ":autocmd " . cmd
  endfor
  execute ":augroup END"
endfunction

function! <SID>s:AutocmdLoader_unload() dict
  execute ":augroup " . self.group_name
  execute ":autocmd!"
  execute ":augroup END"
endfunction

function! <SID>s:AutocmdLoader_cmd(ex_cmd) dict
  call add(self.cmds, a:ex_cmd)
endfunction

function! <SID>s:AutocmdLoader_size() dict
  return len(self.cmds)
endfunction

function! s:PluginConstructor()
  let pluginObj = {}
  let pluginObj.get_app = function('<SNR>' . s:SID() . '_s:Plugin_get_app')
  let pluginObj.loaded = function('<SNR>' . s:SID() . '_s:Plugin_loaded')
  let pluginObj.start = function('<SNR>' . s:SID() . '_s:Plugin_start')
  let pluginObj.on_buffer_open = function('<SNR>' . s:SID() . '_s:Plugin_on_buffer_open')
  let pluginObj.on_buffer_enter = function('<SNR>' . s:SID() . '_s:Plugin_on_buffer_enter')
  let pluginObj.on_buffer_leave = function('<SNR>' . s:SID() . '_s:Plugin_on_buffer_leave')
  let pluginObj.on_vim_enter = function('<SNR>' . s:SID() . '_s:Plugin_on_vim_enter')
  let pluginObj.can_autostart = function('<SNR>' . s:SID() . '_s:Plugin_can_autostart')
  let pluginObj.has_portkey_json = function('<SNR>' . s:SID() . '_s:Plugin_has_portkey_json')
  return pluginObj
endfunction

function! <SID>s:Plugin_get_app() dict
  if !self.loaded()
    let self.app = portkey#app()
  endif
  return self.app
endfunction

function! <SID>s:Plugin_loaded() dict
  return has_key(self, 'app')
endfunction

function! <SID>s:Plugin_start() dict
  let loader = s:AutocmdLoaderConstructor()
  call loader.set_group_name('portkey_plugin_group')
  call loader.cmd("BufNewFile,BufRead * call s:plugin.on_buffer_open(expand('<afile>'))")
  call loader.cmd("BufEnter * call s:plugin.on_buffer_enter(expand('<afile>'))")
  call loader.cmd("BufLeave * call s:plugin.on_buffer_leave(expand('<afile>'))")
  call loader.cmd("VimEnter * call s:plugin.on_vim_enter()")
  call loader.load()
endfunction

function! <SID>s:Plugin_on_buffer_open(path) dict
  if type(a:path) ==# type('string')
    let buffer = s:BufferConstructor(a:path)
  else
    let buffer = a:path
  endif
  if buffer.has_root()
    if !(self.loaded())
      redraw
      echomsg "Portkey: Loading (" . buffer.get_portkey_display_path() . ") ..."
    endif
    let b:portkey_buffer = buffer
    call self.get_app().on_buffer_open(buffer)
  endif
endfunction

function! <SID>s:Plugin_on_buffer_enter(path) dict
  if exists('b:portkey_buffer')
    let buffer = b:portkey_buffer
    let app = self.get_app()
    if !(buffer.get_configured())
      call app.on_buffer_open(buffer)
    endif
    call app.on_buffer_enter(buffer)
  endif
endfunction

function! <SID>s:Plugin_on_buffer_leave(path) dict
  if exists('b:portkey_buffer')
    call self.get_app().on_buffer_leave(b:portkey_buffer)
  endif
endfunction

function! <SID>s:Plugin_on_vim_enter() dict
  if self.can_autostart()
    let buffer = s:BufferConstructor("portkey.json")
    call self.on_buffer_open(buffer)
    call self.on_buffer_enter(buffer)
  endif
endfunction

function! <SID>s:Plugin_can_autostart() dict
  if !self.loaded() && argc() ==# 0 && exists('g:portkey_autostart') && g:portkey_autostart && self.has_portkey_json()
    return 1
  else
    return 0
  endif
endfunction

function! <SID>s:Plugin_has_portkey_json() dict
  let portkey_path = fnamemodify('portkey.json', ':p')
  return filereadable(portkey_path)
endfunction

function! s:main()
  let s:plugin = s:PluginConstructor()
  call s:plugin.start()
  let g:portkey_plugin_loaded = 1
endfunction

if !exists('g:speckle_mode')
  call s:main()
endif