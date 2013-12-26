" Vim syntax file
" Language: snort.conf
" Maintainer: Victor Roemer
" Last Change: 2012 Oct 24

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

setlocal iskeyword-=:
setlocal iskeyword+=-
syn case ignore

" Snort ruletype crap
syn keyword     SnortRuleType       ruletype nextgroup=SnortRuleTypeName skipwhite
syn match       SnortRuleTypeName   "[[:alnum:]_]\+" contained nextgroup=SnortRuleTypeBody skipwhite
syn region      SnortRuleTypeBody   start="{" end="}" contained contains=SnortRuleTypeType,SnortOutput fold
syn keyword     SnortRuleTypeType   type contained

" Snort Configurables
syn keyword     SnortPreproc    preprocessor nextgroup=SnortConfigName skipwhite
syn keyword     SnortConfig     config nextgroup=SnortConfigName skipwhite
syn keyword     SnortOutput     output nextgroup=SnortConfigName skipwhite
syn match       SnortConfigName "[[:alnum:]_-]\+" contained nextgroup=SnortConfigOpts skipwhite
syn region      SnortConfigOpts start=":" skip="\\.\{-}$\|^\s*#.\{-}$\|^\s*$" end="$" fold keepend contained contains=SnortSpecial,SnortNumber,SnortIPAddr,SnortVar,SnortComment

" Event filter's and threshold's
syn region      SnortEvFilter         start="event_filter\|threshold" skip="\\.\{-}$\|^\s*#.\{-}$\|^\s*$" end="$" fold transparent keepend contains=SnortEvFilterKeyword,SnortEvFilterOptions,SnortComment
syn keyword     SnortEvFilterKeyword  skipwhite event_filter threshold
syn keyword     SnortEvFilterOptions  skipwhite type nextgroup=SnortEvFilterTypes
syn keyword     SnortEvFilterTypes    skipwhite limit threshold both contained
syn keyword     SnortEvFilterOptions  skipwhite track nextgroup=SnortEvFilterTrack
syn keyword     SnortEvFilterTrack    skipwhite by_src by_dst contained
syn keyword     SnortEvFilterOptions  skipwhite gen_id sig_id count seconds nextgroup=SnortNumber

" Suppressions
syn region      SnortEvFilter         start="suppress" skip="\\.\{-}$\|^\s*#.\{-}$\|^\s*$" end="$" fold transparent keepend contains=SnortSuppressKeyword,SnortComment
syn keyword     SnortSuppressKeyword  skipwhite suppress
syn keyword     SnortSuppressOptions  skipwhite gen_id sig_id nextgroup=SnortNumber
syn keyword     SnortSuppressOptions  skipwhite track nextgroup=SnortEvFilterTrack
syn keyword     SnortSuppressOptions  skipwhite ip nextgroup=SnortIPAddr

" Attribute table
syn keyword     SnortAttribute        attribute_table nextgroup=SnortAttributeFile
syn match       SnortAttributeFile    contained ".*$" contains=SnortVar,SnortAttributeType,SnortComment
syn keyword     SnortAttributeType    filename

" Snort includes
syn keyword     SnortInclude    include nextgroup=SnortIncludeFile skipwhite
syn match       SnortIncludeFile ".*$" contained contains=SnortVar,SnortComment

" Snort dynamic libraries
syn keyword     SnortDylib      dynamicpreprocessor dynamicengine dynamicdetection nextgroup=SnortDylibFile skipwhite
syn match       SnortDylibFile  "\s.*$" contained contains=SnortVar,SnortDylibType,SnortComment
syn keyword     SnortDylibType  directory file contained

" Variable dereferenced with '$'
syn match       SnortVar        "\$[[:alnum:]_]\+"

", Variables declared with 'var'
syn keyword     SnortVarType    var nextgroup=SnortVarSet skipwhite
syn match       SnortVarSet     "[[:alnum:]_]\+" display contained nextgroup=SnortVarValue skipwhite
syn match       SnortVarValue   ".*$" contained contains=SnortString,SnortNumber,SnortVar,SnortComment

" Variables declared with 'ipvar'
syn keyword     SnortIPVarType  ipvar nextgroup=SnortIPVarSet skipwhite
syn match       SnortIPVarSet   "[[:alnum:]_]\+" display contained nextgroup=SnortIPVarList,SnortSpecial skipwhite
syn region      SnortIPVarList  start="\[" end="]" contains=SnortIPVarList,SnortIPAddr,SnortVar,SnortOpNot

" Variables declared with 'portvar'
syn keyword     SnortPortVarType portvar nextgroup=SnortPortVarSet skipwhite
syn match       SnortPortVarSet "[[:alnum:]_]\+" display contained nextgroup=SnortPortVarList,SnortPort,SnortOpRange,SnortOpNot,SnortSpecial skipwhite
syn region      SnortPortVarList start="\[" end="]" contains=SnortPortVarList,SnortVar,SnortOpNot,SnortPort,SnortOpRange,SnortOpNot
syn match       SnortPort       "\<\%(\d\+\|any\)\>" display contains=SnortOpRange nextgroup=SnortOpRange

" Generic stuff
syn match       SnortIPAddr     contained "\<\%(\d\{1,3}\(\.\d\{1,3}\)\{3}\|any\)\>" nextgroup=SnortIPCidr
syn match       SnortIPAddr     contained "\<\d\{1,3}\(\.\d\{1,3}\)\{3}\>" nextgroup=SnortIPCidr
syn match       SnortIPCidr     contained "\/\([0-2][0-9]\=\|3[0-2]\=\)"
syn region      SnortHexEsc     contained start='|' end='|' oneline
syn region      SnortString     contained start='"' end='"' extend oneline contains=SnortHexEsc
syn match       SnortNumber     contained display "\<\d\+\>"
syn match       SnortNumber     contained display "\<\d\+\>"
syn match       SnortNumber     contained display "0x\x\+\>"
syn keyword     SnortSpecial    contained true false yes no default all any
syn keyword     SnortSpecialAny contained any
syn match       SnortOpNot      "!" contained
syn match       SnortOpRange    ":" contained

" Rules
"syn keyword     SnortRuleAction activate    skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction alert       skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction drop        skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction block       skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction dynamic     skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction log         skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction pass        skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction reject      skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction sdrop       skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleAction sblock      skipwhite nextgroup=SnortRuleProto,SnortRuleBody
"syn keyword     SnortRuleProto  ip          skipwhite contained nextgroup=SnortRuleSrcAddr
"syn keyword     SnortRuleProto  icmp        skipwhite contained nextgroup=SnortRuleSrcAddr
"syn keyword     SnortRuleProto  tcp         skipwhite contained nextgroup=SnortRuleSrcAddr
"syn keyword     SnortRuleProto  udp         skipwhite contained nextgroup=SnortRuleSrcAddr
"
"syn match       SnortRuleSrcAddr "\S\+"     skipwhite contained nextgroup=SnortRuleSrcPort contains=SnortIPVarList,SnortIPAddr,SnortVar,SnortOpNot
"syn match       SnortRuleSrcPort "\S\+"     skipwhite contained nextgroup=SnortRuleDirection contains=SnortPortVarList,SnortVar,SnortOpNot,SnortPort,SnortOpRange,SnortOpNot
"syn match       SnortRuleDirection "->\|<>" skipwhite contained nextgroup=SnortRuleDstAddr
"syn match       SnortRuleDstAddr "\S\+"     skipwhite contained nextgroup=SnortRuleDstPort contains=SnortIPVarList,SnortIPAddr,SnortVar,SnortOpNot
"syn match       SnortRuleDstPort "\S\+"     skipwhite contained nextgroup=SnortRuleBody,SnortVar contains=SnortPortVarList,SnortVar,SnortOpNot,SnortPort,SnortOpRange,SnortOpNot
"syn region      SnortRuleBody               start="("  end=")" contained contains=SnortRuleOptions keepend fold
"
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody msg reference gid sid rev classtype priority metadata content nocase rawbytes
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody depth offset distance within http_client_body http_cookie http_raw_cookie http_header
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody http_raw_header http_method http_uri http_raw_uri http_stat_code http_stat_msg
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody fast_pattern uricontent urilen isdataat pcre pkt_data file_data base64_decode base64_data
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody byte_test byte_jump byte_extract ftpbounce asn1 cvs dce_iface dce_opnum dce_stub_data
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody sip_method sip_stat_code sip_header sip_body gtp_type gtp_info gtp_version ssl_version
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody ssl_state fragoffset ttl tos id ipopts fragbits dsize flags flow flowbits seq ack window
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody itype icode icmp_id icmp_seq rpc ip_proto sameip stream_reassemble stream_size
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody logto session resp react tag activates activated_by count replace detection_filter
"syn keyword     SnortRuleOptions   skipwhite contained nextgroup=SnortRuleOptionBody threshold

syn keyword     SnortRuleAction     activate alert drop block dynamic log pass reject sdrop sblock skipwhite nextgroup=SnortRuleProto,SnortRuleBlock
syn keyword     SnortRuleProto      ip tcp udp icmp skipwhite contained nextgroup=SnortRuleSrcIP
syn match       SnortRuleSrcIP      "\S\+" transparent skipwhite contained contains=SnortIPVarList,SnortIPAddr,SnortVar,SnortOpNot nextgroup=SnortRuleSrcPort
syn match       SnortRuleSrcPort    "\S\+" transparent skipwhite contained contains=SnortPortVarList,SnortVar,SnortPort,SnortOpRange,SnortOpNot nextgroup=SnortRuleDir
syn match       SnortRuleDir        "->\|<>" skipwhite contained nextgroup=SnortRuleDstIP
syn match       SnortRuleDstIP      "\S\+" transparent skipwhite contained contains=SnortIPVarList,SnortIPAddr,SnortVar,SnortOpNot nextgroup=SnortRuleDstPort
syn match       SnortRuleDstPort    "\S\+" transparent skipwhite contained contains=SnortPortVarList,SnortVar,SnortPort,SnortOpRange,SnortOpNot nextgroup=SnortRuleBlock
syn region      SnortRuleBlock      start="(" end=")" transparent skipwhite contained contains=SnortRuleOption,SnortComment fold
",SnortString,SnortComment,SnortVar,SnortOptNot
"syn region      SnortRuleOption     start="\<gid\|sid\|rev\|depth\|offset\|distance\|within\>" end="\ze;" skipwhite contained contains=SnortNumber
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP msg gid sid rev classtype priority metadata content nocase rawbytes
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP depth offset distance within http_client_body http_cookie http_raw_cookie http_header
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP http_raw_header http_method http_uri http_raw_uri http_stat_code http_stat_msg
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP fast_pattern uricontent urilen isdataat pcre pkt_data file_data base64_decode base64_data
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP byte_test byte_jump byte_extract ftpbounce asn1 cvs dce_iface dce_opnum dce_stub_data
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP sip_method sip_stat_code sip_header sip_body gtp_type gtp_info gtp_version ssl_version
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP ssl_state fragoffset ttl tos id ipopts fragbits dsize flags flow flowbits seq ack window
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP itype icode icmp_id icmp_seq rpc ip_proto sameip stream_reassemble stream_size
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP logto session resp react tag activates activated_by count replace detection_filter
syn keyword     SnortRuleOption   skipwhite contained nextgroup=SnortRuleSROP threshold reference sd_pattern file_type file_group

syn region      SnortRuleSROP     start=':' end=";" transparent keepend contained contains=SnortRuleChars,SnortString,SnortNumber
syn match       SnortRuleChars    "\%(\k\|\.\|?\|=\|/\|%\|&\)\+" contained
syn match       SnortURLChars     "\%(\.\|?\|=\)\+" contained

" Comments
syn keyword SnortTodo   XXX TODO NOTE contained
syn match   SnortTodo   "Step\s\+#\=\d\+" contained
syn region SnortComment start="#" end="$" contains=SnortTodo,@Spell

syn case match

if !exists("snort_minlines")
    let snort_minlines = 100
endif
exec "syn sync minlines=" . snort_minlines

hi link SnortRuleType           Statement
hi link SnortRuleTypeName       Type
hi link SnortRuleTypeType       Keyword

hi link SnortPreproc            Statement
hi link SnortConfig             Statement
hi link SnortOutput             Statement
hi link SnortConfigName         Type

"hi link SnortEvFilter
hi link SnortEvFilterKeyword    Statement
hi link SnortSuppressKeyword    Statement
hi link SnortEvFilterTypes      Constant
hi link SnortEvFilterTrack      Constant

hi link SnortAttribute          Statement
hi link SnortAttributeFile      String
hi link SnortAttributeType      Statement

hi link SnortInclude            Statement
hi link SnortIncludeFile        String

hi link SnortDylib              Statement
hi link SnortDylibType          Statement
hi link SnortDylibFile          String

" Variables
" var
hi link SnortVar                Identifier
hi link SnortVarType            Keyword
hi link SnortVarSet             Identifier
hi link SnortVarValue           String
" ipvar
hi link SnortIPVarType          Keyword
hi link SnortIPVarSet           Identifier
" portvar
hi link SnortPortVarType         Keyword
hi link SnortPortVarSet          Identifier
hi link SnortPort                Constant

hi link SnortTodo               Todo
hi link SnortComment            Comment
hi link SnortString             String
hi link SnortHexEsc             PreProc
hi link SnortNumber             Number
hi link SnortSpecial            Constant
hi link SnortSpecialAny         Constant
hi link SnortIPAddr             Constant
hi link SnortIPCidr             Constant
hi link SnortOpNot              Operator
hi link SnortOpRange            Operator

"hi link SnortRuleAction         Statement
"hi link SnortRuleProto          Identifier
"hi link SnortRuleOptions        Keyword
""hi link SnortRuleOptionBody     String
"hi link SnortRuleOptionValue     String
"hi link SnortRuleDirection      Operator

hi link SnortRuleAction         Statement
hi link SnortRuleProto          Identifier
"hi link SnortRuleSrcIP
"hi link SnortRuleSrcPort
hi link SnortRuleDir            Operator
"hi link SnortRuleDstIP
"hi link SnortRuleDstPort
"hi link SnortRuleBlock
hi link SnortRuleOption         Keyword
hi link SnortRuleChars           String 

let b:current_syntax = "hog"
