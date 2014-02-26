let g:colors_name = 'aiko'
set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
if has('gui_running')
  hi Normal guifg=#EEEEEE guibg=#1E1E1E ctermfg=255 ctermbg=234
endif
if has('gui_running') || &t_Co == 256
  hi Normal guifg=#EEEEEE ctermfg=255
  hi Pmenu guifg=#FFFFFF guibg=#606060 ctermfg=7 ctermbg=241
  hi PmenuSel guifg=#101010 guibg=#EEEEEE ctermfg=233 ctermbg=255
  hi Visual guibg=#444444 ctermbg=238
  hi Cursor guibg=#B0D0F0 ctermbg=153
  hi LineNr guifg=#605958 ctermfg=59
  hi Constant guifg=#CF6A4C ctermfg=167
  hi Special guifg=#799D6A ctermfg=107
  hi Delimiter guifg=#668799 ctermfg=66
  hi String guifg=#99ad6a ctermfg=107
  hi StringDelimiter guifg=#556633 ctermfg=59
  hi Type guifg=#FFb964 ctermfg=215
  hi NonText guifg=#606060 ctermfg=241
  hi Statement guifg=#92A5E0 ctermfg=110
  hi Identifier guifg=#C6B6EE cterm=NONE ctermfg=183
  hi Structure guifg=#8FBFDC ctermfg=110
  hi PreProc guifg=#AFD7FF ctermfg=153
  hi Function guifg=#FAD07A ctermfg=222
  hi Comment guifg=#8A8A8A ctermfg=245
  hi Search guifg=#F0A0C0 guibg=#302028 cterm=underline ctermfg=217 ctermbg=52
  hi IncSearch guifg=#FFDDCC guibg=#330000 ctermfg=224 ctermbg=52
  hi Directory guifg=#DAD085 ctermfg=186
  hi ErrorMsg guibg=#902020 ctermbg=88
  hi! link Error ErrorMsg
  hi Question guifg=#65C254 ctermfg=71
  hi VertSplit guifg=#666666 guibg=#666666 ctermfg=241 ctermbg=241
  hi Folded guifg=#A0A8B0 guibg=#384048 cterm=italic ctermfg=145 ctermbg=59
  hi FoldColumn guifg=#535D66 guibg=#1F1F1F ctermfg=59 ctermbg=234
  hi SignColumn guifg=#777777 guibg=#333333 ctermfg=243 ctermbg=236
  hi ColorColumn guifg=#333333 guibg=#333333 ctermfg=236 ctermbg=236
  hi! link rubySharpBang Comment
  hi rubyClass guifg=#447799 ctermfg=66
  hi rubyIdentifier guifg=#C6B6FE ctermfg=183
  hi! link rubyConstant Type
  hi! link rubyFunction Function
  hi rubyInstanceVariable guifg=#C6B6FE ctermfg=183
  hi rubySymbol guifg=#7697D6 ctermfg=104
  hi! link rubyGlobalVariable rubyInstanceVariable
  hi! link rubyModule rubyClass
  hi rubyControl guifg=#7597C6 ctermfg=104
  hi! link rubyString String
  hi! link rubyStringDelimiter StringDelimiter
  hi! link rubyInterpolationDelimiter Identifier
  hi rubyRegexpDelimiter guifg=#990066 ctermfg=89
  hi rubyRegexp guifg=#EE0099 ctermfg=198
  hi rubyRegexpSpecial guifg=#A40073 ctermfg=125
  hi rubyPredefinedIdentifier guifg=#DE5577 ctermfg=168
  hi! link javaScriptValue Constant
  hi! link javaScriptRegexpString rubyRegexp
  hi! link coffeeRegExp javaScriptRegexpString
  hi! link luaOperator Conditional
  hi! link cFormat Identifier
  hi! link cOperator Constant
  hi! link objcClass Type
  hi! link cocoaClass objcClass
  hi! link objcSubclass objcClass
  hi! link objcSuperclass objcClass
  hi! link objcDirective rubyClass
  hi! link objcStatement Constant
  hi! link cocoaFunction Function
  hi! link objcMethodName Identifier
  hi! link objcMethodArg Normal
  hi! link objcMessageName Identifier
  hi! link vimOper Normal
  hi! link vimVar Identifier
else
  hi Normal guifg=#FFFFFF ctermfg=7
  hi Statement guifg=#0000FF ctermfg=4
endif
