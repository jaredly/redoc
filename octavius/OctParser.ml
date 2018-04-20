
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | Version of (
# 132 "octavius/octParser.mly"
       (string)
# 11 "octavius/octParser.ml"
  )
    | Verb of (
# 157 "octavius/octParser.mly"
       (string)
# 16 "octavius/octParser.ml"
  )
    | Title of (
# 146 "octavius/octParser.mly"
       (int * string option)
# 21 "octavius/octParser.ml"
  )
    | Target of (
# 158 "octavius/octParser.mly"
       (string option * string)
# 26 "octavius/octParser.ml"
  )
    | Style of (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 31 "octavius/octParser.ml"
  )
    | Special_Ref of (
# 153 "octavius/octParser.mly"
       (Octavius_types.special_ref_kind)
# 36 "octavius/octParser.ml"
  )
    | Since of (
# 134 "octavius/octParser.mly"
       (string)
# 41 "octavius/octParser.ml"
  )
    | See of (
# 133 "octavius/octParser.mly"
       (Octavius_types.see_ref)
# 46 "octavius/octParser.ml"
  )
    | Ref_part of (
# 188 "octavius/octParser.mly"
       (string)
# 51 "octavius/octParser.ml"
  )
    | Ref of (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 56 "octavius/octParser.ml"
  )
    | Raise of (
# 137 "octavius/octParser.mly"
       (string)
# 61 "octavius/octParser.ml"
  )
    | RETURN
    | Pre_Code of (
# 156 "octavius/octParser.mly"
       (string)
# 67 "octavius/octParser.ml"
  )
    | Param of (
# 130 "octavius/octParser.mly"
       (string)
# 72 "octavius/octParser.ml"
  )
    | PLUS
    | NEWLINE
    | MINUS
    | LIST
    | Item of (
# 150 "octavius/octParser.mly"
       (bool)
# 81 "octavius/octParser.ml"
  )
    | INLINE
    | HTML_Title of (
# 170 "octavius/octParser.mly"
       (string * int)
# 87 "octavius/octParser.ml"
  )
    | HTML_Right of (
# 166 "octavius/octParser.mly"
       (string)
# 92 "octavius/octParser.ml"
  )
    | HTML_List of (
# 172 "octavius/octParser.mly"
       (string)
# 97 "octavius/octParser.ml"
  )
    | HTML_Left of (
# 164 "octavius/octParser.mly"
       (string)
# 102 "octavius/octParser.ml"
  )
    | HTML_Item of (
# 176 "octavius/octParser.mly"
       (string)
# 107 "octavius/octParser.ml"
  )
    | HTML_Italic of (
# 168 "octavius/octParser.mly"
       (string)
# 112 "octavius/octParser.ml"
  )
    | HTML_Enum of (
# 174 "octavius/octParser.mly"
       (string)
# 117 "octavius/octParser.ml"
  )
    | HTML_END_Title of (
# 171 "octavius/octParser.mly"
       (int)
# 122 "octavius/octParser.ml"
  )
    | HTML_END_RIGHT
    | HTML_END_LIST
    | HTML_END_LEFT
    | HTML_END_ITEM
    | HTML_END_ITALIC
    | HTML_END_ENUM
    | HTML_END_CENTER
    | HTML_END_BOLD
    | HTML_Center of (
# 162 "octavius/octParser.mly"
       (string)
# 135 "octavius/octParser.ml"
  )
    | HTML_Bold of (
# 160 "octavius/octParser.mly"
       (string)
# 140 "octavius/octParser.ml"
  )
    | EOF
    | ENUM
    | END
    | DOT
    | DEPRECATED
    | Custom of (
# 140 "octavius/octParser.mly"
       (string)
# 150 "octavius/octParser.ml"
  )
    | Code of (
# 155 "octavius/octParser.mly"
       (string)
# 155 "octavius/octParser.ml"
  )
    | Char of (
# 185 "octavius/octParser.mly"
       (string)
# 160 "octavius/octParser.ml"
  )
    | Canonical of (
# 141 "octavius/octParser.mly"
       (string)
# 165 "octavius/octParser.ml"
  )
    | Before of (
# 135 "octavius/octParser.mly"
       (string)
# 170 "octavius/octParser.ml"
  )
    | BLANK
    | BEGIN
    | AUTHOR
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState352
  | MenhirState347
  | MenhirState343
  | MenhirState340
  | MenhirState338
  | MenhirState334
  | MenhirState332
  | MenhirState330
  | MenhirState327
  | MenhirState319
  | MenhirState317
  | MenhirState314
  | MenhirState312
  | MenhirState310
  | MenhirState308
  | MenhirState306
  | MenhirState304
  | MenhirState303
  | MenhirState301
  | MenhirState300
  | MenhirState298
  | MenhirState295
  | MenhirState294
  | MenhirState292
  | MenhirState291
  | MenhirState288
  | MenhirState284
  | MenhirState282
  | MenhirState281
  | MenhirState279
  | MenhirState278
  | MenhirState276
  | MenhirState274
  | MenhirState273
  | MenhirState271
  | MenhirState268
  | MenhirState267
  | MenhirState265
  | MenhirState257
  | MenhirState256
  | MenhirState253
  | MenhirState250
  | MenhirState249
  | MenhirState242
  | MenhirState237
  | MenhirState235
  | MenhirState233
  | MenhirState232
  | MenhirState228
  | MenhirState224
  | MenhirState222
  | MenhirState220
  | MenhirState218
  | MenhirState217
  | MenhirState213
  | MenhirState209
  | MenhirState207
  | MenhirState205
  | MenhirState203
  | MenhirState202
  | MenhirState198
  | MenhirState194
  | MenhirState192
  | MenhirState190
  | MenhirState188
  | MenhirState187
  | MenhirState178
  | MenhirState166
  | MenhirState164
  | MenhirState153
  | MenhirState151
  | MenhirState135
  | MenhirState133
  | MenhirState132
  | MenhirState128
  | MenhirState126
  | MenhirState125
  | MenhirState122
  | MenhirState116
  | MenhirState113
  | MenhirState112
  | MenhirState109
  | MenhirState108
  | MenhirState106
  | MenhirState103
  | MenhirState102
  | MenhirState100
  | MenhirState96
  | MenhirState95
  | MenhirState93
  | MenhirState84
  | MenhirState83
  | MenhirState80
  | MenhirState76
  | MenhirState75
  | MenhirState71
  | MenhirState64
  | MenhirState62
  | MenhirState60
  | MenhirState59
  | MenhirState58
  | MenhirState57
  | MenhirState54
  | MenhirState51
  | MenhirState48
  | MenhirState44
  | MenhirState41
  | MenhirState38
  | MenhirState35
  | MenhirState31
  | MenhirState29
  | MenhirState28
  | MenhirState27
  | MenhirState26
  | MenhirState25
  | MenhirState23
  | MenhirState22
  | MenhirState21
  | MenhirState20
  | MenhirState19
  | MenhirState17
  | MenhirState15
  | MenhirState8
  | MenhirState6
  | MenhirState3
  | MenhirState0

# 1 "octavius/octParser.mly"
  
open Common
open Octavius_types
open Errors

(* Convert lexing position into error position *)
let position p =
  { line = p.Lexing.pos_lnum;
    column = p.Lexing.pos_cnum - p.Lexing.pos_bol; }

(* Get the location of the symbol at a given position *)
let rhs_loc n =
  { start = position (Parsing.rhs_start_pos n);
    finish = position (Parsing.rhs_end_pos n); }

(* Useful strings *)

let sempty = ""

let sspace = " "

let snewline = "\n"

let sblank_line = "\n\n"

let sminus = "-"

let splus = "+"

(* Accumulators for text elements *)

type text_item =
    Blank
  | Newline
  | Blank_line
  | String of string
  | Element of text_element

let iminus = String sminus

let iplus = String splus

let skip_blank_or_newline = function
  | Blank :: rest -> rest
  | Newline :: rest -> rest
  | til -> til

let rec skip_whitespace = function
  | Blank :: rest -> skip_whitespace rest
  | Newline :: rest -> skip_whitespace rest
  | Blank_line :: rest -> skip_whitespace rest
  | til -> til

let rec convert acc stracc = function
  | [] ->
        if stracc = [] then acc
        else (Raw (String.concat sempty stracc)) :: acc
  | ti :: rest ->
      let acc, stracc =
        match ti with
        | Blank -> acc, (sspace :: stracc)
        | Newline -> acc, (snewline :: stracc)
        | String s -> acc, (s :: stracc)
        | Blank_line ->
            let acc =
              if stracc = [] then acc
              else (Raw (String.concat sempty stracc)) :: acc
            in
              (Newline :: acc), []
        | Element e ->
            let acc =
              if stracc = [] then acc
              else (Raw (String.concat sempty stracc)) :: acc
            in
              (e :: acc), []
      in
        convert acc stracc rest

let text til =
  let til = skip_whitespace til in
  let til = skip_whitespace (List.rev til) in
    convert [] [] til

let inner til =
  let til = skip_blank_or_newline til in
  let til = skip_blank_or_newline (List.rev til) in
    convert [] [] til

(* Error messages *)

let unclosed opening_name opening_num items closing_name closing_num =
  let error =
    let opening_loc = rhs_loc opening_num in
    let opening = opening_name in
    let closing = closing_name in
    Unclosed { opening_loc; opening; items; closing }
  in
  let loc = rhs_loc closing_num in
    raise (ParserError(loc, error))

let expecting num nonterm =
  let error = Expecting nonterm in
  let loc = rhs_loc num in
    raise (ParserError(loc, error))

(* Utilities for error messages *)

let title_to_string (i, _) =
  let i = string_of_int i in
    "{" ^ i

let style_to_string = function
  | SK_bold -> "{b"
  | SK_italic -> "{i"
  | SK_emphasize -> "{e"
  | SK_center -> "{C"
  | SK_left -> "{L"
  | SK_right -> "{R"
  | SK_superscript -> "{^"
  | SK_subscript -> "{_"
  | SK_custom s -> "{" ^ s

let item_to_string i = if i then "{-" else "{li"

let html_open_to_string t = "<" ^ t ^ ">"
let html_close_to_string t = "</" ^ t ^ ">"


# 447 "octavius/octParser.ml"

let rec _menhir_reduce4 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blank_line)) = _menhir_stack in
    let _2 = () in
    let _v : 'tv_blank_line = 
# 265 "octavius/octParser.mly"
                     ( () )
# 456 "octavius/octParser.ml"
     in
    _menhir_goto_blank_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce3 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blank_line)) = _menhir_stack in
    let _2 = () in
    let _v : 'tv_blank_line = 
# 264 "octavius/octParser.mly"
                     ( () )
# 467 "octavius/octParser.ml"
     in
    _menhir_goto_blank_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce97 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blank_line)) = _menhir_stack in
    let _v : 'tv_text_body_with_line = 
# 320 "octavius/octParser.mly"
                                             ( [Blank_line] )
# 477 "octavius/octParser.ml"
     in
    _menhir_goto_text_body_with_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce99 : _menhir_env -> ('ttv_tail * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : 'tv_text_body)), _, (_2 : 'tv_blank_line)) = _menhir_stack in
    let _v : 'tv_text_body_with_line = 
# 322 "octavius/octParser.mly"
                                              ( Blank_line :: _1 )
# 487 "octavius/octParser.ml"
     in
    _menhir_goto_text_body_with_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce51 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_blank_line)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_list = 
# 356 "octavius/octParser.mly"
                                                    ( [[]] )
# 498 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_list _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce52 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_blank_line)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_list = 
# 357 "octavius/octParser.mly"
                                                    ( [inner (List.rev _2)] )
# 509 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_list _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce42 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_blank_line)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_enum = 
# 364 "octavius/octParser.mly"
                                                    ( [[]] )
# 520 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_enum _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce43 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_blank_line)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_enum = 
# 365 "octavius/octParser.mly"
                                                    ( [inner (List.rev _2)] )
# 531 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_enum _menhir_env _menhir_stack _menhir_s _v

and _menhir_run55 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce4 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run56 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce3 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run45 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce4 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run46 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce3 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_string_body : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_string_body -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv885 * _menhir_state * 'tv_string_body) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState327
    | Char _v ->
        _menhir_run323 _menhir_env (Obj.magic _menhir_stack) MenhirState327 _v
    | MINUS ->
        _menhir_run322 _menhir_env (Obj.magic _menhir_stack) MenhirState327
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState327
    | PLUS ->
        _menhir_run321 _menhir_env (Obj.magic _menhir_stack) MenhirState327
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState327
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState327) : 'freshtv886)

and _menhir_goto_blank_line : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState343 | MenhirState340 | MenhirState310 | MenhirState235 | MenhirState220 | MenhirState205 | MenhirState190 | MenhirState164 | MenhirState151 | MenhirState62 | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv855 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState44
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState44
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState44
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | END | HTML_END_ENUM | HTML_END_LIST | HTML_Item _ | INLINE | Item _ | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState44)) : 'freshtv856)
    | MenhirState232 | MenhirState217 | MenhirState202 | MenhirState187 | MenhirState15 | MenhirState22 | MenhirState59 | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv857 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState54
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState54
          | NEWLINE ->
              _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState54
          | HTML_Item _ | Item _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState54)) : 'freshtv858)
    | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv859 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState95
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState95
          | NEWLINE ->
              _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState95
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce43 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState95)) : 'freshtv860)
    | MenhirState76 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv861 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState102
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState102
          | NEWLINE ->
              _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState102
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce42 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState102)) : 'freshtv862)
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv863 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState112
          | NEWLINE ->
              _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState112
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce52 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112)) : 'freshtv864)
    | MenhirState103 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv865 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState116
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState116
          | NEWLINE ->
              _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState116
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce51 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState116)) : 'freshtv866)
    | MenhirState122 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv867 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState128
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState128
          | NEWLINE ->
              _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState128
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce99 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState128)) : 'freshtv868)
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv869 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState135
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState135
          | NEWLINE ->
              _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState135
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce97 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState135)) : 'freshtv870)
    | MenhirState253 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv871 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState267
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState267
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState267
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce43 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState267)) : 'freshtv872)
    | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv873 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState273
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState273
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState273
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce42 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState273)) : 'freshtv874)
    | MenhirState276 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv875 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState281
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState281
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState281
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce52 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState281)) : 'freshtv876)
    | MenhirState274 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv877 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState284
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState284
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState284
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce51 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState284)) : 'freshtv878)
    | MenhirState288 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv879 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState294
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState294
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState294
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce99 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState294)) : 'freshtv880)
    | MenhirState0 | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState298 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv881 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState303
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState303
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState303
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce97 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState303)) : 'freshtv882)
    | MenhirState319 | MenhirState327 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv883 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState334
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState334
          | Char _v ->
              _menhir_run323 _menhir_env (Obj.magic _menhir_stack) MenhirState334 _v
          | MINUS ->
              _menhir_run322 _menhir_env (Obj.magic _menhir_stack) MenhirState334
          | NEWLINE ->
              _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState334
          | PLUS ->
              _menhir_run321 _menhir_env (Obj.magic _menhir_stack) MenhirState334
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce142 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState334)) : 'freshtv884)
    | _ ->
        _menhir_fail ()

and _menhir_reduce95 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_text_body_with_line -> _menhir_state -> 'tv_text_item_after_line -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item_after_line) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_text_body_with_line)) = _menhir_stack in
    let _v : 'tv_text_body = 
# 315 "octavius/octParser.mly"
                                             ( List.rev_append _2 _1 )
# 893 "octavius/octParser.ml"
     in
    _menhir_goto_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce61 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> _menhir_state -> 'tv_text_item_after_line -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item_after_line) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_newline)) = _menhir_stack in
    let _v : 'tv_shortcut_text_body = 
# 347 "octavius/octParser.mly"
                                                    ( List.rev_append _2 [Newline] )
# 903 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce64 : _menhir_env -> ('ttv_tail * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline -> _menhir_state -> 'tv_text_item_after_line -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_3 : 'tv_text_item_after_line) ->
    let ((_menhir_stack, _menhir_s, (_1 : 'tv_shortcut_text_body)), _, (_2 : 'tv_newline)) = _menhir_stack in
    let _v : 'tv_shortcut_text_body = 
# 350 "octavius/octParser.mly"
                                                    ( List.rev_append _3 (Newline :: _1) )
# 913 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce103 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 920 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 146 "octavius/octParser.mly"
       (int * string option)
# 926 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_text_element = 
# 394 "octavius/octParser.mly"
    ( unclosed (title_to_string _1) 1 "text" "}" 3 )
# 932 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce105 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 939 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 945 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_text_element = 
# 398 "octavius/octParser.mly"
    ( unclosed (style_to_string _1) 1 "text" "}" 3 )
# 951 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_octavius_octParser_list : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_octavius_octParser_list -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState60 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv847 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState62
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState62
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState62
          | END | Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState62
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState62)) : 'freshtv848)
    | MenhirState17 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv849 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState164
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState164
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState164
          | END | Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState164
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState164)) : 'freshtv850)
    | MenhirState188 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv851 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState190
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState190
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState190
          | END | Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState190
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState190)) : 'freshtv852)
    | MenhirState233 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv853 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState235
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState235
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState235
          | END | Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState235
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState235)) : 'freshtv854)
    | _ ->
        _menhir_fail ()

and _menhir_reduce12 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 1037 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 170 "octavius/octParser.mly"
       (string * int)
# 1043 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 452 "octavius/octParser.mly"
    ( let tag, _ = _1 in
      unclosed (html_open_to_string tag) 1
        "text" (html_close_to_string tag) 3 )
# 1051 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce22 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 1058 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 166 "octavius/octParser.mly"
       (string)
# 1064 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 478 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
        "text" (html_close_to_string _1) 3 )
# 1071 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_html_list : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_html_list -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState29 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv839 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 1084 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState31
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState31
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState31
          | HTML_END_ENUM | HTML_Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState31
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState31)) : 'freshtv840)
    | MenhirState23 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv841 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 1106 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState151
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState151
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState151
          | HTML_END_LIST | HTML_Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState151
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState151)) : 'freshtv842)
    | MenhirState203 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv843 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 1128 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState205
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState205
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState205
          | HTML_END_LIST | HTML_Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState205
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState205)) : 'freshtv844)
    | MenhirState218 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv845 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 1150 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState220
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState220
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState220
          | HTML_END_ENUM | HTML_Item _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState220
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState220)) : 'freshtv846)
    | _ ->
        _menhir_fail ()

and _menhir_reduce20 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 1173 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 164 "octavius/octParser.mly"
       (string)
# 1179 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 473 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
        "text" (html_close_to_string _1) 3 )
# 1186 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce16 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 1193 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 168 "octavius/octParser.mly"
       (string)
# 1199 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 463 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
        "text" (html_close_to_string _1) 3 )
# 1206 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce18 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 1213 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 162 "octavius/octParser.mly"
       (string)
# 1219 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 468 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
        "text" (html_close_to_string _1) 3 )
# 1226 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce14 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 1233 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 160 "octavius/octParser.mly"
       (string)
# 1239 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 458 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
        "text" (html_close_to_string _1) 3 )
# 1246 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce114 : _menhir_env -> (('ttv_tail * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 1253 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _menhir_s), (_2 : (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 1259 "octavius/octParser.ml"
    ))), _, (_3 : 'tv_text)) = _menhir_stack in
    let _4 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 418 "octavius/octParser.mly"
    ( unclosed "{" 1 "text" "}" 3 )
# 1266 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_string_item : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_string_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState319 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv833) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_string_item) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv831) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_string_item) : 'tv_string_item) = _v in
        ((let _v : 'tv_string_body = 
# 284 "octavius/octParser.mly"
                                   ( [snd _1] )
# 1285 "octavius/octParser.ml"
         in
        _menhir_goto_string_body _menhir_env _menhir_stack _menhir_s _v) : 'freshtv832)) : 'freshtv834)
    | MenhirState327 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv837 * _menhir_state * 'tv_string_body) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_string_item) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv835 * _menhir_state * 'tv_string_body) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_string_item) : 'tv_string_item) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_string_body)) = _menhir_stack in
        let _v : 'tv_string_body = 
# 285 "octavius/octParser.mly"
                                   ( (snd _2) :: (fst _2) :: _1 )
# 1301 "octavius/octParser.ml"
         in
        _menhir_goto_string_body _menhir_env _menhir_stack _menhir_s _v) : 'freshtv836)) : 'freshtv838)
    | _ ->
        _menhir_fail ()

and _menhir_reduce89 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_text_body_with_line -> _menhir_state -> 'tv_shortcut_list_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_shortcut_list_final) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_text_body_with_line)) = _menhir_stack in
    let _v : 'tv_text = 
# 306 "octavius/octParser.mly"
                                             ( List.rev_append _1 [Element (List _2)] )
# 1313 "octavius/octParser.ml"
     in
    _menhir_goto_text _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce58 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_newline -> _menhir_state -> 'tv_shortcut_list_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_3 : 'tv_shortcut_list_final) ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_newline)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_list_final = 
# 376 "octavius/octParser.mly"
                                                        ( [] :: _3 )
# 1324 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_list_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce59 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline -> _menhir_state -> 'tv_shortcut_list_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_4 : 'tv_shortcut_list_final) ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_newline)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_list_final = 
# 377 "octavius/octParser.mly"
                                                        ( (inner (List.rev _2)) :: _4 )
# 1335 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_list_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce90 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_text_body_with_line -> _menhir_state -> 'tv_shortcut_enum_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_shortcut_enum_final) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_text_body_with_line)) = _menhir_stack in
    let _v : 'tv_text = 
# 307 "octavius/octParser.mly"
                                             ( List.rev_append _1 [Element (Enum _2)] )
# 1345 "octavius/octParser.ml"
     in
    _menhir_goto_text _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce49 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_newline -> _menhir_state -> 'tv_shortcut_enum_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_3 : 'tv_shortcut_enum_final) ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_newline)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_enum_final = 
# 383 "octavius/octParser.mly"
                                                        ( [] :: _3 )
# 1356 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_enum_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce50 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline -> _menhir_state -> 'tv_shortcut_enum_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_4 : 'tv_shortcut_enum_final) ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_newline)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_enum_final = 
# 384 "octavius/octParser.mly"
                                                        ( (inner (List.rev _2)) :: _4 )
# 1367 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_enum_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce129 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 185 "octavius/octParser.mly"
       (string)
# 1374 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 185 "octavius/octParser.mly"
       (string)
# 1379 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_item_after_line = 
# 340 "octavius/octParser.mly"
                             ( [String _1] )
# 1384 "octavius/octParser.ml"
     in
    _menhir_goto_text_item_after_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce2 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_newline)) = _menhir_stack in
    let _2 = () in
    let _v : 'tv_blank_line = 
# 263 "octavius/octParser.mly"
                    ( () )
# 1395 "octavius/octParser.ml"
     in
    _menhir_goto_blank_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce35 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_newline)) = _menhir_stack in
    let _2 = () in
    let _v : 'tv_newline = 
# 259 "octavius/octParser.mly"
                    ( () )
# 1406 "octavius/octParser.ml"
     in
    _menhir_goto_newline _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_shortcut_text_body : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_shortcut_text_body -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState76 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv823 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState80
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | BLANK ->
              _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | Char _v ->
              _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | MINUS ->
              _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | NEWLINE ->
              _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | PLUS ->
              _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState80
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState80)) : 'freshtv824)
    | MenhirState103 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv825 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState106
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | BLANK ->
              _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | Char _v ->
              _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | MINUS ->
              _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | NEWLINE ->
              _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | PLUS ->
              _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState106
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState106)) : 'freshtv826)
    | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv827 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState253
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | Char _v ->
              _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | MINUS ->
              _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | PLUS ->
              _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState253 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState253
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState253)) : 'freshtv828)
    | MenhirState274 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv829 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState276
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | Char _v ->
              _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | MINUS ->
              _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | PLUS ->
              _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState276
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState276)) : 'freshtv830)
    | _ ->
        _menhir_fail ()

and _menhir_goto_text_body : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_body -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv819 * _menhir_state * 'tv_text_body) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState122
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | BLANK ->
              _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | Char _v ->
              _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | MINUS ->
              _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | NEWLINE ->
              _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | PLUS ->
              _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState122
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState122)) : 'freshtv820)
    | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState298 | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv821 * _menhir_state * 'tv_text_body) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState288
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | Char _v ->
              _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | MINUS ->
              _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | PLUS ->
              _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState288 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState288
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState288)) : 'freshtv822)
    | _ ->
        _menhir_fail ()

and _menhir_reduce34 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blanks)) = _menhir_stack in
    let _2 = () in
    let _v : 'tv_newline = 
# 258 "octavius/octParser.mly"
                    ( () )
# 1803 "octavius/octParser.ml"
     in
    _menhir_goto_newline _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce6 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blanks)) = _menhir_stack in
    let _2 = () in
    let _v : 'tv_blanks = 
# 253 "octavius/octParser.mly"
                    ( () )
# 1814 "octavius/octParser.ml"
     in
    _menhir_goto_blanks _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_text_item_after_line : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_item_after_line -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState108 | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv807 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item_after_line) = _v in
        (_menhir_reduce64 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv808)
    | MenhirState113 | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv809 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item_after_line) = _v in
        (_menhir_reduce61 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv810)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv811 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item_after_line) = _v in
        (_menhir_reduce95 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv812)
    | MenhirState278 | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv813 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item_after_line) = _v in
        (_menhir_reduce64 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv814)
    | MenhirState282 | MenhirState268 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv815 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item_after_line) = _v in
        (_menhir_reduce61 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv816)
    | MenhirState249 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv817 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item_after_line) = _v in
        (_menhir_reduce95 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv818)
    | _ ->
        _menhir_fail ()

and _menhir_error243 : _menhir_env -> (('ttv_tail * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 1863 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv805 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 1870 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce114 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv806)

and _menhir_error229 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 1878 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv803 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 1885 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce14 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv804)

and _menhir_error225 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 1893 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv801 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 1900 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce18 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv802)

and _menhir_error214 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 1908 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv799 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 1915 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce16 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv800)

and _menhir_error210 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 1923 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv797 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 1930 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce20 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv798)

and _menhir_error199 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 1938 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv795 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 1945 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce22 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv796)

and _menhir_error195 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 1953 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv793 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 1960 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce12 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv794)

and _menhir_error179 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 1968 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv791 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 1975 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce105 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv792)

and _menhir_error174 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 1983 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv789 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 1990 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce103 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv790)

and _menhir_reduce102 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 1998 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 146 "octavius/octParser.mly"
       (int * string option)
# 2004 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_text_element = 
# 391 "octavius/octParser.mly"
    ( let n, l = _1 in
        Title (n, l, (inner _2)) )
# 2011 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error171 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 2018 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv787 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 2025 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce103 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv788)

and _menhir_reduce104 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 2033 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 2039 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_text_element = 
# 396 "octavius/octParser.mly"
    ( Style(_1, (inner _2)) )
# 2045 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error168 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 2052 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv785 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 2059 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce105 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv786)

and _menhir_goto_item : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState237 | MenhirState192 | MenhirState166 | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv779 * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_item) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv777 * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_item) : 'tv_item) = _v in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_octavius_octParser_list)), _, (_2 : 'tv_whitespace)) = _menhir_stack in
        let _v : 'tv_octavius_octParser_list = 
# 436 "octavius/octParser.mly"
                         ( _3 :: _1 )
# 2080 "octavius/octParser.ml"
         in
        _menhir_goto_octavius_octParser_list _menhir_env _menhir_stack _menhir_s _v) : 'freshtv778)) : 'freshtv780)
    | MenhirState233 | MenhirState188 | MenhirState17 | MenhirState60 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv783) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_item) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv781) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_item) : 'tv_item) = _v in
        ((let _v : 'tv_octavius_octParser_list = 
# 435 "octavius/octParser.mly"
                         ( [ _1 ] )
# 2095 "octavius/octParser.ml"
         in
        _menhir_goto_octavius_octParser_list _menhir_env _menhir_stack _menhir_s _v) : 'freshtv782)) : 'freshtv784)
    | _ ->
        _menhir_fail ()

and _menhir_error161 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 150 "octavius/octParser.mly"
       (bool)
# 2104 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv775 * _menhir_state * (
# 150 "octavius/octParser.mly"
       (bool)
# 2111 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv773 * _menhir_state * (
# 150 "octavius/octParser.mly"
       (bool)
# 2118 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let ((_menhir_stack, _menhir_s, (_1 : (
# 150 "octavius/octParser.mly"
       (bool)
# 2123 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_item = 
# 441 "octavius/octParser.mly"
                      ( unclosed (item_to_string _1) 1 "text" "}" 3 )
# 2129 "octavius/octParser.ml"
     in
    _menhir_goto_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv774)) : 'freshtv776)

and _menhir_reduce11 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 2136 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> (
# 171 "octavius/octParser.mly"
       (int)
# 2140 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack (_3 : (
# 171 "octavius/octParser.mly"
       (int)
# 2145 "octavius/octParser.ml"
  )) ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 170 "octavius/octParser.mly"
       (string * int)
# 2150 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _v : 'tv_html_text_element = 
# 448 "octavius/octParser.mly"
    ( let _, n = _1 in
      if n <> _3 then raise (Failure "wat");
      Title(n, None, (inner _2)) )
# 2157 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error158 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 2164 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv771 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 2171 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce12 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv772)

and _menhir_reduce21 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 2179 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 166 "octavius/octParser.mly"
       (string)
# 2185 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 476 "octavius/octParser.mly"
    ( Style(SK_right, (inner _2)) )
# 2191 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error155 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 2198 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv769 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 2205 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce22 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv770)

and _menhir_goto_html_item : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_html_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState222 | MenhirState207 | MenhirState153 | MenhirState35 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv763 * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_html_item) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv761 * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_html_item) : 'tv_html_item) = _v in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_html_list)), _, (_2 : 'tv_whitespace)) = _menhir_stack in
        let _v : 'tv_html_list = 
# 500 "octavius/octParser.mly"
                                     ( _3 :: _1 )
# 2226 "octavius/octParser.ml"
         in
        _menhir_goto_html_list _menhir_env _menhir_stack _menhir_s _v) : 'freshtv762)) : 'freshtv764)
    | MenhirState218 | MenhirState203 | MenhirState23 | MenhirState29 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv767) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_html_item) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv765) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_html_item) : 'tv_html_item) = _v in
        ((let _v : 'tv_html_list = 
# 499 "octavius/octParser.mly"
                                     ( [ _1 ] )
# 2241 "octavius/octParser.ml"
         in
        _menhir_goto_html_list _menhir_env _menhir_stack _menhir_s _v) : 'freshtv766)) : 'freshtv768)
    | _ ->
        _menhir_fail ()

and _menhir_error148 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 176 "octavius/octParser.mly"
       (string)
# 2250 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv759 * _menhir_state * (
# 176 "octavius/octParser.mly"
       (string)
# 2257 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv757 * _menhir_state * (
# 176 "octavius/octParser.mly"
       (string)
# 2264 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let ((_menhir_stack, _menhir_s, (_1 : (
# 176 "octavius/octParser.mly"
       (string)
# 2269 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_item = 
# 507 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
        "text" (html_close_to_string _1) 3 )
# 2276 "octavius/octParser.ml"
     in
    _menhir_goto_html_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv758)) : 'freshtv760)

and _menhir_reduce19 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 2283 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 164 "octavius/octParser.mly"
       (string)
# 2289 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 471 "octavius/octParser.mly"
    ( Style(SK_left, (inner _2)) )
# 2295 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error145 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 2302 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv755 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 2309 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce20 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv756)

and _menhir_reduce15 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 2317 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 168 "octavius/octParser.mly"
       (string)
# 2323 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 461 "octavius/octParser.mly"
    ( Style(SK_italic, (inner _2)) )
# 2329 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error142 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 2336 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv753 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 2343 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce16 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv754)

and _menhir_reduce17 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 2351 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 162 "octavius/octParser.mly"
       (string)
# 2357 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 466 "octavius/octParser.mly"
    ( Style(SK_center, (inner _2)) )
# 2363 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error139 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 2370 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv751 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 2377 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce18 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv752)

and _menhir_reduce13 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 2385 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 160 "octavius/octParser.mly"
       (string)
# 2391 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_text)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 456 "octavius/octParser.mly"
    ( Style(SK_bold, (inner _2)) )
# 2397 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error136 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 2404 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv749 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 2411 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce14 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv750)

and _menhir_reduce113 : _menhir_env -> (('ttv_tail * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 2419 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _menhir_s), (_2 : (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 2425 "octavius/octParser.ml"
    ))), _, (_3 : 'tv_text)) = _menhir_stack in
    let _4 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 415 "octavius/octParser.mly"
    ( let k, n = _2 in
        Ref (k, n, Some (inner _3)) )
# 2433 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_error129 : _menhir_env -> (('ttv_tail * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 2440 "octavius/octParser.ml"
)) * _menhir_state * 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv747 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 2447 "octavius/octParser.ml"
    )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
    ((let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce114 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv748)

and _menhir_goto_string_char : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_string_char -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState327 | MenhirState319 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv733) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_string_char) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv731) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_string_char) : 'tv_string_char) = _v in
        ((let _v : 'tv_string_item = 
# 289 "octavius/octParser.mly"
                              ( (sempty, _1) )
# 2467 "octavius/octParser.ml"
         in
        _menhir_goto_string_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv732)) : 'freshtv734)
    | MenhirState330 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv737 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_string_char) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv735 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_string_char) : 'tv_string_char) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_newline)) = _menhir_stack in
        let _v : 'tv_string_item = 
# 291 "octavius/octParser.mly"
                              ( (snewline, _2) )
# 2483 "octavius/octParser.ml"
         in
        _menhir_goto_string_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv736)) : 'freshtv738)
    | MenhirState332 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv741 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_string_char) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv739 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_string_char) : 'tv_string_char) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_blanks)) = _menhir_stack in
        let _v : 'tv_string_item = 
# 290 "octavius/octParser.mly"
                              ( (sspace, _2) )
# 2499 "octavius/octParser.ml"
         in
        _menhir_goto_string_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv740)) : 'freshtv742)
    | MenhirState334 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv745 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_string_char) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv743 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_string_char) : 'tv_string_char) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_blank_line)) = _menhir_stack in
        let _v : 'tv_string_item = 
# 292 "octavius/octParser.mly"
                              ( (sblank_line, _2) )
# 2515 "octavius/octParser.ml"
         in
        _menhir_goto_string_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv744)) : 'freshtv746)
    | _ ->
        _menhir_fail ()

and _menhir_goto_shortcut_list_final : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_shortcut_list_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState108 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv719 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list_final) = _v in
        (_menhir_reduce59 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv720)
    | MenhirState113 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv721 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list_final) = _v in
        (_menhir_reduce58 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv722)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv723 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list_final) = _v in
        (_menhir_reduce89 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv724)
    | MenhirState278 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv725 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list_final) = _v in
        (_menhir_reduce59 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv726)
    | MenhirState282 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv727 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list_final) = _v in
        (_menhir_reduce58 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv728)
    | MenhirState249 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv729 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list_final) = _v in
        (_menhir_reduce89 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv730)
    | _ ->
        _menhir_fail ()

and _menhir_goto_shortcut_enum_final : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_shortcut_enum_final -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv707 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum_final) = _v in
        (_menhir_reduce50 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv708)
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv709 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum_final) = _v in
        (_menhir_reduce49 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv710)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv711 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum_final) = _v in
        (_menhir_reduce90 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv712)
    | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv713 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum_final) = _v in
        (_menhir_reduce50 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv714)
    | MenhirState268 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv715 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum_final) = _v in
        (_menhir_reduce49 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv716)
    | MenhirState249 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv717 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum_final) = _v in
        (_menhir_reduce90 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv718)
    | _ ->
        _menhir_fail ()

and _menhir_run279 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState279
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState279
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState279
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState279
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState279
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState279

and _menhir_run274 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState274 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState274
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState274

and _menhir_run250 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState250
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState250

and _menhir_run257 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState257
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState257
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState257
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState257
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState257
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState257 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState257

and _menhir_run260 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 185 "octavius/octParser.mly"
       (string)
# 2840 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce129 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_reduce96 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_newline)) = _menhir_stack in
    let _v : 'tv_text_body_with_line = 
# 319 "octavius/octParser.mly"
                                             ( [Newline] )
# 2852 "octavius/octParser.ml"
     in
    _menhir_goto_text_body_with_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce98 : _menhir_env -> ('ttv_tail * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_newline -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : 'tv_text_body)), _, (_2 : 'tv_newline)) = _menhir_stack in
    let _v : 'tv_text_body_with_line = 
# 321 "octavius/octParser.mly"
                                             ( Newline :: _1 )
# 2862 "octavius/octParser.ml"
     in
    _menhir_goto_text_body_with_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_run109 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState109
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState109
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState109
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState109
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState109
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState109

and _menhir_run103 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState103 _v
    | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState103

and _menhir_run76 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState76 _v
    | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState76
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState76

and _menhir_run84 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState84
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState84
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState84
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState84
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState84
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState84

and _menhir_run87 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 185 "octavius/octParser.mly"
       (string)
# 3101 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce129 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run49 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce2 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run50 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce35 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run39 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce2 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run40 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce35 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_reduce92 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blanks)) = _menhir_stack in
    let _v : 'tv_text_body = 
# 312 "octavius/octParser.mly"
                                             ( [_2; Blank] )
# 3133 "octavius/octParser.ml"
     in
    _menhir_goto_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce94 : _menhir_env -> ('ttv_tail * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blanks -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_3 : 'tv_text_item) ->
    let ((_menhir_stack, _menhir_s, (_1 : 'tv_text_body)), _, (_2 : 'tv_blanks)) = _menhir_stack in
    let _v : 'tv_text_body = 
# 314 "octavius/octParser.mly"
                                             ( _3 :: Blank :: _1 )
# 3143 "octavius/octParser.ml"
     in
    _menhir_goto_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce93 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_text_body -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_text_body)) = _menhir_stack in
    let _v : 'tv_text_body = 
# 313 "octavius/octParser.mly"
                                             ( _2 :: _1 )
# 3153 "octavius/octParser.ml"
     in
    _menhir_goto_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce60 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blanks)) = _menhir_stack in
    let _v : 'tv_shortcut_text_body = 
# 346 "octavius/octParser.mly"
                                                    ( [_2; Blank] )
# 3163 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce63 : _menhir_env -> ('ttv_tail * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blanks -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_3 : 'tv_text_item) ->
    let ((_menhir_stack, _menhir_s, (_1 : 'tv_shortcut_text_body)), _, (_2 : 'tv_blanks)) = _menhir_stack in
    let _v : 'tv_shortcut_text_body = 
# 349 "octavius/octParser.mly"
                                                    ( _3 :: Blank :: _1 )
# 3173 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce125 : _menhir_env -> 'ttv_tail * _menhir_state -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item) ->
    let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_text_item_after_line = 
# 336 "octavius/octParser.mly"
                             ( [iminus; _2] )
# 3184 "octavius/octParser.ml"
     in
    _menhir_goto_text_item_after_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce62 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_shortcut_text_body -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item) ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_shortcut_text_body)) = _menhir_stack in
    let _v : 'tv_shortcut_text_body = 
# 348 "octavius/octParser.mly"
                                                    ( _2 :: _1 )
# 3194 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce126 : _menhir_env -> 'ttv_tail * _menhir_state -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _ (_2 : 'tv_text_item) ->
    let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_text_item_after_line = 
# 337 "octavius/octParser.mly"
                             ( [iplus; _2] )
# 3205 "octavius/octParser.ml"
     in
    _menhir_goto_text_item_after_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce91 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : 'tv_text_item) ->
    let _v : 'tv_text_body = 
# 311 "octavius/octParser.mly"
                                             ( [_1] )
# 3214 "octavius/octParser.ml"
     in
    _menhir_goto_text_body _menhir_env _menhir_stack _menhir_s _v

and _menhir_run52 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce34 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run53 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce6 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run42 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce34 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run43 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce6 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_reduce128 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_html_text_element -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : 'tv_html_text_element) ->
    let _v : 'tv_text_item_after_line = 
# 339 "octavius/octParser.mly"
                             ( [Element _1] )
# 3243 "octavius/octParser.ml"
     in
    _menhir_goto_text_item_after_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce123 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_html_text_element -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : 'tv_html_text_element) ->
    let _v : 'tv_text_item = 
# 331 "octavius/octParser.mly"
                                     ( Element _1 )
# 3252 "octavius/octParser.ml"
     in
    _menhir_goto_text_item _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce127 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_element -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : 'tv_text_element) ->
    let _v : 'tv_text_item_after_line = 
# 338 "octavius/octParser.mly"
                             ( [Element _1] )
# 3261 "octavius/octParser.ml"
     in
    _menhir_goto_text_item_after_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce122 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_element -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : 'tv_text_element) ->
    let _v : 'tv_text_item = 
# 330 "octavius/octParser.mly"
                                     ( Element _1 )
# 3270 "octavius/octParser.ml"
     in
    _menhir_goto_text_item _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_text_body_with_line : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_body_with_line -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv703 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BEGIN ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState75
        | Char _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | Code _v ->
            _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | ENUM ->
            _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState75
        | HTML_Bold _v ->
            _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | HTML_Center _v ->
            _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | HTML_Enum _v ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | HTML_Italic _v ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | HTML_Left _v ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | HTML_List _v ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | HTML_Right _v ->
            _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | HTML_Title _v ->
            _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | LIST ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState75
        | MINUS ->
            _menhir_run103 _menhir_env (Obj.magic _menhir_stack) MenhirState75
        | PLUS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState75
        | Pre_Code _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | Ref _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | Special_Ref _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | Style _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | Target _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | Title _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | Verb _v ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState75) : 'freshtv704)
    | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState298 | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv705 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BEGIN ->
            _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | Char _v ->
            _menhir_run260 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | Code _v ->
            _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | ENUM ->
            _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | HTML_Bold _v ->
            _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | HTML_Center _v ->
            _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | HTML_Enum _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | HTML_Italic _v ->
            _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | HTML_Left _v ->
            _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | HTML_List _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | HTML_Right _v ->
            _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | HTML_Title _v ->
            _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | LIST ->
            _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | MINUS ->
            _menhir_run274 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | PLUS ->
            _menhir_run250 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | Pre_Code _v ->
            _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | Ref _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | Special_Ref _v ->
            _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | Style _v ->
            _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | Target _v ->
            _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | Title _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | Verb _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState249) : 'freshtv706)
    | _ ->
        _menhir_fail ()

and _menhir_goto_text : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv591 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 3398 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error129 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : (('freshtv589 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 3410 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce113 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv590)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error129 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv592)
    | MenhirState58 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv595 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 3423 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error136 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_BOLD ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv593 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 3435 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce13 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv594)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error136 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv596)
    | MenhirState57 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv599 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 3448 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error139 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_CENTER ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv597 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 3460 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce17 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv598)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error139 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv600)
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv603 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 3473 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error142 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_ITALIC ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv601 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 3485 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce15 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv602)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error142 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv604)
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv607 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 3498 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error145 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_LEFT ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv605 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 3510 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce19 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv606)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error145 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv608)
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv613 * _menhir_state * (
# 176 "octavius/octParser.mly"
       (string)
# 3523 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error148 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_ITEM ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv611 * _menhir_state * (
# 176 "octavius/octParser.mly"
       (string)
# 3535 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv609 * _menhir_state * (
# 176 "octavius/octParser.mly"
       (string)
# 3542 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let ((_menhir_stack, _menhir_s, (_1 : (
# 176 "octavius/octParser.mly"
       (string)
# 3547 "octavius/octParser.ml"
              ))), _, (_2 : 'tv_text)) = _menhir_stack in
              let _3 = () in
              let _v : 'tv_html_item = 
# 505 "octavius/octParser.mly"
    ( inner _2 )
# 3553 "octavius/octParser.ml"
               in
              _menhir_goto_html_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv610)) : 'freshtv612)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error148 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv614)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv617 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 3565 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error155 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_RIGHT ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv615 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 3577 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce21 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv616)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error155 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv618)
    | MenhirState20 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv621 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 3590 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error158 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_Title _v ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv619 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 3602 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              let (_v : (
# 171 "octavius/octParser.mly"
       (int)
# 3607 "octavius/octParser.ml"
              )) = _v in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce11 _menhir_env (Obj.magic _menhir_stack) _v) : 'freshtv620)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error158 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv622)
    | MenhirState19 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv627 * _menhir_state * (
# 150 "octavius/octParser.mly"
       (bool)
# 3620 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error161 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv625 * _menhir_state * (
# 150 "octavius/octParser.mly"
       (bool)
# 3632 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv623 * _menhir_state * (
# 150 "octavius/octParser.mly"
       (bool)
# 3639 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let ((_menhir_stack, _menhir_s, (_1 : (
# 150 "octavius/octParser.mly"
       (bool)
# 3644 "octavius/octParser.ml"
              ))), _, (_2 : 'tv_text)) = _menhir_stack in
              let _3 = () in
              let _v : 'tv_item = 
# 440 "octavius/octParser.mly"
                      ( inner _2 )
# 3650 "octavius/octParser.ml"
               in
              _menhir_goto_item _menhir_env _menhir_stack _menhir_s _v) : 'freshtv624)) : 'freshtv626)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error161 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv628)
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv631 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 3662 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error168 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv629 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 3674 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce104 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv630)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error168 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv632)
    | MenhirState6 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv635 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 3687 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error171 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv633 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 3699 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce102 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv634)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error171 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv636)
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv639 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 3712 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error174 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv637 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 3724 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce102 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv638)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error174 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv640)
    | MenhirState178 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv643 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 3737 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error179 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv641 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 3749 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce104 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv642)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error179 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv644)
    | MenhirState194 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv647 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 3762 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error195 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_Title _v ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv645 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 3774 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              let (_v : (
# 171 "octavius/octParser.mly"
       (int)
# 3779 "octavius/octParser.ml"
              )) = _v in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce11 _menhir_env (Obj.magic _menhir_stack) _v) : 'freshtv646)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error195 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv648)
    | MenhirState198 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv651 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 3792 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error199 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_RIGHT ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv649 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 3804 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce21 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv650)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error199 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv652)
    | MenhirState209 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv655 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 3817 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error210 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_LEFT ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv653 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 3829 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce19 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv654)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error210 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv656)
    | MenhirState213 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv659 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 3842 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error214 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_ITALIC ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv657 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 3854 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce15 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv658)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error214 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv660)
    | MenhirState224 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv663 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 3867 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error225 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_CENTER ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv661 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 3879 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce17 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv662)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error225 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv664)
    | MenhirState228 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv667 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 3892 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error229 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_BOLD ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ('freshtv665 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 3904 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce13 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv666)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error229 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv668)
    | MenhirState242 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv671 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 3917 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_error243 _menhir_env (Obj.magic _menhir_stack)
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : (('freshtv669 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 3929 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce113 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv670)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_error243 _menhir_env (Obj.magic _menhir_stack))) : 'freshtv672)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv673 * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState295
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | AUTHOR ->
              _menhir_run319 _menhir_env (Obj.magic _menhir_stack) MenhirState295
          | Before _v ->
              _menhir_run317 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | Canonical _v ->
              _menhir_run316 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | Custom _v ->
              _menhir_run314 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | DEPRECATED ->
              _menhir_run312 _menhir_env (Obj.magic _menhir_stack) MenhirState295
          | INLINE ->
              _menhir_run310 _menhir_env (Obj.magic _menhir_stack) MenhirState295
          | Param _v ->
              _menhir_run308 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | RETURN ->
              _menhir_run306 _menhir_env (Obj.magic _menhir_stack) MenhirState295
          | Raise _v ->
              _menhir_run304 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | See _v ->
              _menhir_run298 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | Since _v ->
              _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | Version _v ->
              _menhir_run296 _menhir_env (Obj.magic _menhir_stack) MenhirState295 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState295)) : 'freshtv674)
    | MenhirState298 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv677 * _menhir_state * (
# 133 "octavius/octParser.mly"
       (Octavius_types.see_ref)
# 3978 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv675 * _menhir_state * (
# 133 "octavius/octParser.mly"
       (Octavius_types.see_ref)
# 3984 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : (
# 133 "octavius/octParser.mly"
       (Octavius_types.see_ref)
# 3989 "octavius/octParser.ml"
        ))), _, (_2 : 'tv_text)) = _menhir_stack in
        let _v : 'tv_text_tag = 
# 239 "octavius/octParser.mly"
                         ( See(_1, (text _2)) )
# 3994 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv676)) : 'freshtv678)
    | MenhirState304 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv681 * _menhir_state * (
# 137 "octavius/octParser.mly"
       (string)
# 4002 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv679 * _menhir_state * (
# 137 "octavius/octParser.mly"
       (string)
# 4008 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : (
# 137 "octavius/octParser.mly"
       (string)
# 4013 "octavius/octParser.ml"
        ))), _, (_2 : 'tv_text)) = _menhir_stack in
        let _v : 'tv_text_tag = 
# 243 "octavius/octParser.mly"
                         ( Raised_exception(_1, (text _2)) )
# 4018 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv680)) : 'freshtv682)
    | MenhirState306 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv685 * _menhir_state) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv683 * _menhir_state) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_text)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_text_tag = 
# 244 "octavius/octParser.mly"
                         ( Return_value (text _2) )
# 4031 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv684)) : 'freshtv686)
    | MenhirState308 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv689 * _menhir_state * (
# 130 "octavius/octParser.mly"
       (string)
# 4039 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv687 * _menhir_state * (
# 130 "octavius/octParser.mly"
       (string)
# 4045 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : (
# 130 "octavius/octParser.mly"
       (string)
# 4050 "octavius/octParser.ml"
        ))), _, (_2 : 'tv_text)) = _menhir_stack in
        let _v : 'tv_text_tag = 
# 242 "octavius/octParser.mly"
                         ( Param(_1, (text _2)) )
# 4055 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv688)) : 'freshtv690)
    | MenhirState312 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv693 * _menhir_state) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv691 * _menhir_state) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_text)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_text_tag = 
# 241 "octavius/octParser.mly"
                         ( Deprecated (text _2) )
# 4068 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv692)) : 'freshtv694)
    | MenhirState314 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv697 * _menhir_state * (
# 140 "octavius/octParser.mly"
       (string)
# 4076 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv695 * _menhir_state * (
# 140 "octavius/octParser.mly"
       (string)
# 4082 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : (
# 140 "octavius/octParser.mly"
       (string)
# 4087 "octavius/octParser.ml"
        ))), _, (_2 : 'tv_text)) = _menhir_stack in
        let _v : 'tv_text_tag = 
# 246 "octavius/octParser.mly"
                         ( Custom(_1, (text _2)) )
# 4092 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv696)) : 'freshtv698)
    | MenhirState317 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv701 * _menhir_state * (
# 135 "octavius/octParser.mly"
       (string)
# 4100 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv699 * _menhir_state * (
# 135 "octavius/octParser.mly"
       (string)
# 4106 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : (
# 135 "octavius/octParser.mly"
       (string)
# 4111 "octavius/octParser.ml"
        ))), _, (_2 : 'tv_text)) = _menhir_stack in
        let _v : 'tv_text_tag = 
# 240 "octavius/octParser.mly"
                         ( Before(_1, (text _2)) )
# 4116 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv700)) : 'freshtv702)
    | _ ->
        _menhir_fail ()

and _menhir_goto_simple_tag : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_simple_tag -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState338 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv585 * _menhir_state * 'tv_tags) * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState340
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState340
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState340
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState340
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState340)) : 'freshtv586)
    | MenhirState295 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv587 * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState343
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState343
          | NEWLINE ->
              _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState343
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState343
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState343)) : 'freshtv588)
    | _ ->
        _menhir_fail ()

and _menhir_run321 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv583) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_string_char = 
# 298 "octavius/octParser.mly"
                              ( splus )
# 4175 "octavius/octParser.ml"
     in
    _menhir_goto_string_char _menhir_env _menhir_stack _menhir_s _v) : 'freshtv584)

and _menhir_run322 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv581) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_string_char = 
# 297 "octavius/octParser.mly"
                              ( sminus )
# 4189 "octavius/octParser.ml"
     in
    _menhir_goto_string_char _menhir_env _menhir_stack _menhir_s _v) : 'freshtv582)

and _menhir_run323 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 185 "octavius/octParser.mly"
       (string)
# 4196 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv579) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 185 "octavius/octParser.mly"
       (string)
# 4206 "octavius/octParser.ml"
    )) : (
# 185 "octavius/octParser.mly"
       (string)
# 4210 "octavius/octParser.ml"
    )) = _v in
    ((let _v : 'tv_string_char = 
# 296 "octavius/octParser.mly"
                              ( _1 )
# 4215 "octavius/octParser.ml"
     in
    _menhir_goto_string_char _menhir_env _menhir_stack _menhir_s _v) : 'freshtv580)

and _menhir_reduce106 : _menhir_env -> ((('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_octavius_octParser_list)), _, (_4 : 'tv_whitespace)) = _menhir_stack in
    let _5 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 400 "octavius/octParser.mly"
    ( List (List.rev _3) )
# 4227 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce23 : _menhir_env -> ((('ttv_tail * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 4234 "octavius/octParser.ml"
)) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((((_menhir_stack, _menhir_s, (_1 : (
# 172 "octavius/octParser.mly"
       (string)
# 4240 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_html_list)), _, (_4 : 'tv_whitespace)) = _menhir_stack in
    let _5 = () in
    let _v : 'tv_html_text_element = 
# 481 "octavius/octParser.mly"
    ( List (List.rev _3) )
# 4246 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce88 : _menhir_env -> ('ttv_tail * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_whitespace -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s, (_1 : 'tv_text_body)), _, (_2 : 'tv_whitespace)) = _menhir_stack in
    let _v : 'tv_text = 
# 305 "octavius/octParser.mly"
                                             ( List.rev_append _1 _2 )
# 4256 "octavius/octParser.ml"
     in
    _menhir_goto_text _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce57 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_whitespace -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_whitespace)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_list_final = 
# 375 "octavius/octParser.mly"
                                                        ( [inner (List.rev _2)] )
# 4267 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_list_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce56 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_list_final = 
# 374 "octavius/octParser.mly"
                                                        ( [[]] )
# 4278 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_list_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce48 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_whitespace -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_whitespace)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_enum_final = 
# 382 "octavius/octParser.mly"
                                                        ( [inner (List.rev _2)] )
# 4289 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_enum_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce47 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_shortcut_enum_final = 
# 381 "octavius/octParser.mly"
                                                        ( [[]] )
# 4300 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_enum_final _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce86 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_whitespace -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_whitespace)) = _menhir_stack in
    let _v : 'tv_text = 
# 303 "octavius/octParser.mly"
                                             ( _1 )
# 4310 "octavius/octParser.ml"
     in
    _menhir_goto_text _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce109 : _menhir_env -> ((('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_octavius_octParser_list)), _, (_4 : 'tv_whitespace)) = _menhir_stack in
    let _5 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 406 "octavius/octParser.mly"
    ( Enum (List.rev _3) )
# 4322 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce26 : _menhir_env -> ((('ttv_tail * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 4329 "octavius/octParser.ml"
)) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((((_menhir_stack, _menhir_s, (_1 : (
# 174 "octavius/octParser.mly"
       (string)
# 4335 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_html_list)), _, (_4 : 'tv_whitespace)) = _menhir_stack in
    let _5 = () in
    let _v : 'tv_html_text_element = 
# 488 "octavius/octParser.mly"
    ( Enum (List.rev _3) )
# 4341 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_run25 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 176 "octavius/octParser.mly"
       (string)
# 4348 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | HTML_END_ITEM ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState25

and _menhir_run19 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 150 "octavius/octParser.mly"
       (bool)
# 4413 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
    | END ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState19

and _menhir_goto_newline : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_newline -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState343 | MenhirState340 | MenhirState310 | MenhirState235 | MenhirState220 | MenhirState205 | MenhirState190 | MenhirState164 | MenhirState151 | MenhirState62 | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv549 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState38
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState38
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState38
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | END | HTML_END_ENUM | HTML_END_LIST | HTML_Item _ | INLINE | Item _ | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState38)) : 'freshtv550)
    | MenhirState232 | MenhirState217 | MenhirState202 | MenhirState187 | MenhirState15 | MenhirState22 | MenhirState59 | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv551 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState48
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState48
          | NEWLINE ->
              _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState48
          | HTML_Item _ | Item _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState48)) : 'freshtv552)
    | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv553 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState83
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState83
          | BLANK ->
              _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState83
          | Char _v ->
              _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState83
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState83
          | MINUS ->
              _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState83
          | NEWLINE ->
              _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState83
          | PLUS ->
              _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState83
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState83)) : 'freshtv554)
    | MenhirState76 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv555 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState96
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState96
          | BLANK ->
              _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState96
          | Char _v ->
              _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState96
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState96
          | MINUS ->
              _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState96
          | NEWLINE ->
              _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState96
          | PLUS ->
              _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState96
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState96)) : 'freshtv556)
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv557 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState108
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState108
          | BLANK ->
              _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState108
          | Char _v ->
              _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState108
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState108
          | MINUS ->
              _menhir_run103 _menhir_env (Obj.magic _menhir_stack) MenhirState108
          | NEWLINE ->
              _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState108
          | PLUS ->
              _menhir_run109 _menhir_env (Obj.magic _menhir_stack) MenhirState108
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState108)) : 'freshtv558)
    | MenhirState103 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv559 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState113
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState113
          | BLANK ->
              _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState113
          | Char _v ->
              _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState113
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState113
          | MINUS ->
              _menhir_run103 _menhir_env (Obj.magic _menhir_stack) MenhirState113
          | NEWLINE ->
              _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState113
          | PLUS ->
              _menhir_run109 _menhir_env (Obj.magic _menhir_stack) MenhirState113
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState113)) : 'freshtv560)
    | MenhirState122 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv561 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState125
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState125
          | NEWLINE ->
              _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState125
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce98 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState125)) : 'freshtv562)
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv563 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState132
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState132
          | NEWLINE ->
              _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState132
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce96 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState132)) : 'freshtv564)
    | MenhirState253 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv565 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState256
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState256
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState256
          | Char _v ->
              _menhir_run260 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState256
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState256
          | MINUS ->
              _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState256
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState256
          | PLUS ->
              _menhir_run250 _menhir_env (Obj.magic _menhir_stack) MenhirState256
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState256)) : 'freshtv566)
    | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv567 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState268
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState268
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState268
          | Char _v ->
              _menhir_run260 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState268
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState268
          | MINUS ->
              _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState268
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState268
          | PLUS ->
              _menhir_run250 _menhir_env (Obj.magic _menhir_stack) MenhirState268
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState268 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState268)) : 'freshtv568)
    | MenhirState276 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv569 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState278
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState278
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState278
          | Char _v ->
              _menhir_run260 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState278
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState278
          | MINUS ->
              _menhir_run274 _menhir_env (Obj.magic _menhir_stack) MenhirState278
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState278
          | PLUS ->
              _menhir_run279 _menhir_env (Obj.magic _menhir_stack) MenhirState278
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState278)) : 'freshtv570)
    | MenhirState274 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv571 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState282
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState282
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState282
          | Char _v ->
              _menhir_run260 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState282
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState282
          | MINUS ->
              _menhir_run274 _menhir_env (Obj.magic _menhir_stack) MenhirState282
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState282
          | PLUS ->
              _menhir_run279 _menhir_env (Obj.magic _menhir_stack) MenhirState282
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState282)) : 'freshtv572)
    | MenhirState288 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv573 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState291
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState291
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState291
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce98 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState291)) : 'freshtv574)
    | MenhirState0 | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState298 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv575 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState300
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState300
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState300
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | BEGIN | Char _ | Code _ | ENUM | HTML_Bold _ | HTML_Center _ | HTML_Enum _ | HTML_Italic _ | HTML_Left _ | HTML_List _ | HTML_Right _ | HTML_Title _ | LIST | MINUS | PLUS | Pre_Code _ | Ref _ | Special_Ref _ | Style _ | Target _ | Title _ | Verb _ ->
              _menhir_reduce96 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState300)) : 'freshtv576)
    | MenhirState319 | MenhirState327 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv577 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState330
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState330
          | Char _v ->
              _menhir_run323 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _v
          | MINUS ->
              _menhir_run322 _menhir_env (Obj.magic _menhir_stack) MenhirState330
          | NEWLINE ->
              _menhir_run39 _menhir_env (Obj.magic _menhir_stack) MenhirState330
          | PLUS ->
              _menhir_run321 _menhir_env (Obj.magic _menhir_stack) MenhirState330
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce141 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState330)) : 'freshtv578)
    | _ ->
        _menhir_fail ()

and _menhir_goto_text_item : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_item -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv513) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce91 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv514)
    | MenhirState109 | MenhirState76 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv515 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce126 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv516)
    | MenhirState106 | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv517 * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce62 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv518)
    | MenhirState103 | MenhirState84 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv519 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce125 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv520)
    | MenhirState93 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv521 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce63 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv522)
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv523 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce60 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv524)
    | MenhirState122 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv525 * _menhir_state * 'tv_text_body) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce93 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv526)
    | MenhirState126 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv527 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce94 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv528)
    | MenhirState133 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv529 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce92 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv530)
    | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState298 | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv531) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce91 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv532)
    | MenhirState279 | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv533 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce126 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv534)
    | MenhirState276 | MenhirState253 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv535 * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce62 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv536)
    | MenhirState274 | MenhirState257 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv537 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce125 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv538)
    | MenhirState265 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv539 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce63 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv540)
    | MenhirState271 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv541 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce60 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv542)
    | MenhirState288 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv543 * _menhir_state * 'tv_text_body) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce93 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv544)
    | MenhirState292 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv545 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce94 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv546)
    | MenhirState301 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv547 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_item) = _v in
        (_menhir_reduce92 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv548)
    | _ ->
        _menhir_fail ()

and _menhir_goto_blanks : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_blanks -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState343 | MenhirState340 | MenhirState310 | MenhirState235 | MenhirState220 | MenhirState205 | MenhirState190 | MenhirState164 | MenhirState151 | MenhirState62 | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv491 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState41
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState41
          | NEWLINE ->
              _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState41
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | END | HTML_END_ENUM | HTML_END_LIST | HTML_Item _ | INLINE | Item _ | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState41)) : 'freshtv492)
    | MenhirState232 | MenhirState217 | MenhirState202 | MenhirState187 | MenhirState15 | MenhirState22 | MenhirState59 | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv493 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState51
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState51
          | NEWLINE ->
              _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState51
          | HTML_Item _ | Item _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState51)) : 'freshtv494)
    | MenhirState106 | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv495 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState93
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState93
          | BLANK ->
              _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState93
          | Char _v ->
              _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState93
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState93
          | MINUS ->
              _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState93
          | NEWLINE ->
              _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState93
          | PLUS ->
              _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState93
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState93)) : 'freshtv496)
    | MenhirState103 | MenhirState76 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv497 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState100
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState100
          | BLANK ->
              _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState100
          | Char _v ->
              _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState100
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState100
          | MINUS ->
              _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState100
          | NEWLINE ->
              _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState100
          | PLUS ->
              _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState100
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState100)) : 'freshtv498)
    | MenhirState122 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv499 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState126
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState126
          | BLANK ->
              _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState126
          | Char _v ->
              _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState126
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState126
          | MINUS ->
              _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState126
          | NEWLINE ->
              _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState126
          | PLUS ->
              _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState126
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState126)) : 'freshtv500)
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv501 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState133
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState133
          | BLANK ->
              _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState133
          | Char _v ->
              _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | Code _v ->
              _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | ENUM ->
              _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState133
          | HTML_Bold _v ->
              _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | HTML_Center _v ->
              _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | HTML_Enum _v ->
              _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | HTML_Italic _v ->
              _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | HTML_Left _v ->
              _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | HTML_List _v ->
              _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | HTML_Right _v ->
              _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | HTML_Title _v ->
              _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | LIST ->
              _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState133
          | MINUS ->
              _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState133
          | NEWLINE ->
              _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState133
          | PLUS ->
              _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState133
          | Pre_Code _v ->
              _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | Ref _v ->
              _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | Special_Ref _v ->
              _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | Style _v ->
              _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | Target _v ->
              _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | Title _v ->
              _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | Verb _v ->
              _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
          | END | HTML_END_BOLD | HTML_END_CENTER | HTML_END_ITALIC | HTML_END_ITEM | HTML_END_LEFT | HTML_END_RIGHT | HTML_END_Title _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState133)) : 'freshtv502)
    | MenhirState276 | MenhirState253 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv503 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState265
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState265
          | BLANK ->
              _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState265
          | Char _v ->
              _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState265
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState265
          | MINUS ->
              _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState265
          | NEWLINE ->
              _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState265
          | PLUS ->
              _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState265
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState265)) : 'freshtv504)
    | MenhirState274 | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv505 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState271
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState271
          | BLANK ->
              _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState271
          | Char _v ->
              _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState271
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState271
          | MINUS ->
              _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState271
          | NEWLINE ->
              _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState271
          | PLUS ->
              _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState271
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState271)) : 'freshtv506)
    | MenhirState288 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv507 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState292
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState292
          | BLANK ->
              _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState292
          | Char _v ->
              _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState292
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState292
          | MINUS ->
              _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState292
          | NEWLINE ->
              _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState292
          | PLUS ->
              _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState292
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState292 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState292)) : 'freshtv508)
    | MenhirState0 | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState298 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv509 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState301
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BEGIN ->
              _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState301
          | BLANK ->
              _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState301
          | Char _v ->
              _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | Code _v ->
              _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | ENUM ->
              _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState301
          | HTML_Bold _v ->
              _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | HTML_Center _v ->
              _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | HTML_Enum _v ->
              _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | HTML_Italic _v ->
              _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | HTML_Left _v ->
              _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | HTML_List _v ->
              _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | HTML_Right _v ->
              _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | HTML_Title _v ->
              _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | LIST ->
              _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState301
          | MINUS ->
              _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState301
          | NEWLINE ->
              _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState301
          | PLUS ->
              _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState301
          | Pre_Code _v ->
              _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | Ref _v ->
              _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | Special_Ref _v ->
              _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | Style _v ->
              _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | Target _v ->
              _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | Title _v ->
              _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | Verb _v ->
              _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _v
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState301)) : 'freshtv510)
    | MenhirState319 | MenhirState327 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv511 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState332
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | BLANK ->
              _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState332
          | Char _v ->
              _menhir_run323 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _v
          | MINUS ->
              _menhir_run322 _menhir_env (Obj.magic _menhir_stack) MenhirState332
          | NEWLINE ->
              _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState332
          | PLUS ->
              _menhir_run321 _menhir_env (Obj.magic _menhir_stack) MenhirState332
          | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
              _menhir_reduce140 _menhir_env (Obj.magic _menhir_stack)
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState332)) : 'freshtv512)
    | _ ->
        _menhir_fail ()

and _menhir_goto_html_text_element : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_html_text_element -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState133 | MenhirState71 | MenhirState126 | MenhirState122 | MenhirState103 | MenhirState106 | MenhirState109 | MenhirState100 | MenhirState76 | MenhirState93 | MenhirState80 | MenhirState84 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv483) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_html_text_element) = _v in
        (_menhir_reduce123 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv484)
    | MenhirState75 | MenhirState113 | MenhirState108 | MenhirState96 | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv485) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_html_text_element) = _v in
        (_menhir_reduce128 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv486)
    | MenhirState0 | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState301 | MenhirState298 | MenhirState292 | MenhirState288 | MenhirState274 | MenhirState276 | MenhirState279 | MenhirState271 | MenhirState250 | MenhirState265 | MenhirState253 | MenhirState257 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv487) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_html_text_element) = _v in
        (_menhir_reduce123 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv488)
    | MenhirState249 | MenhirState282 | MenhirState278 | MenhirState268 | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv489) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_html_text_element) = _v in
        (_menhir_reduce128 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv490)
    | _ ->
        _menhir_fail ()

and _menhir_goto_text_element : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_element -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState133 | MenhirState126 | MenhirState122 | MenhirState109 | MenhirState106 | MenhirState103 | MenhirState100 | MenhirState93 | MenhirState84 | MenhirState80 | MenhirState76 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv475) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_element) = _v in
        (_menhir_reduce122 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv476)
    | MenhirState75 | MenhirState113 | MenhirState108 | MenhirState96 | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv477) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_element) = _v in
        (_menhir_reduce127 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv478)
    | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState301 | MenhirState298 | MenhirState292 | MenhirState288 | MenhirState279 | MenhirState276 | MenhirState274 | MenhirState271 | MenhirState265 | MenhirState257 | MenhirState253 | MenhirState250 | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv479) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_element) = _v in
        (_menhir_reduce122 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv480)
    | MenhirState249 | MenhirState282 | MenhirState278 | MenhirState268 | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv481) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_element) = _v in
        (_menhir_reduce127 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v : 'freshtv482)
    | _ ->
        _menhir_fail ()

and _menhir_goto_shortcut_enum : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_shortcut_enum -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState256 | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv465 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv463 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_4 : 'tv_shortcut_enum) : 'tv_shortcut_enum) = _v in
        ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_newline)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_shortcut_enum = 
# 367 "octavius/octParser.mly"
                                                    ( (inner (List.rev _2)) :: _4 )
# 5872 "octavius/octParser.ml"
         in
        _menhir_goto_shortcut_enum _menhir_env _menhir_stack _menhir_s _v) : 'freshtv464)) : 'freshtv466)
    | MenhirState268 | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv469 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv467 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_shortcut_enum) : 'tv_shortcut_enum) = _v in
        ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_newline)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_shortcut_enum = 
# 366 "octavius/octParser.mly"
                                                    ( [] :: _3 )
# 5889 "octavius/octParser.ml"
         in
        _menhir_goto_shortcut_enum _menhir_env _menhir_stack _menhir_s _v) : 'freshtv468)) : 'freshtv470)
    | MenhirState249 | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv473 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_enum) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv471 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_shortcut_enum) : 'tv_shortcut_enum) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_text_body_with_line)) = _menhir_stack in
        let _v : 'tv_text_body_with_line = 
# 324 "octavius/octParser.mly"
                                             ( (Element (Enum _2)) :: _1 )
# 5905 "octavius/octParser.ml"
         in
        _menhir_goto_text_body_with_line _menhir_env _menhir_stack _menhir_s _v) : 'freshtv472)) : 'freshtv474)
    | _ ->
        _menhir_fail ()

and _menhir_goto_shortcut_list : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_shortcut_list -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState278 | MenhirState108 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv453 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv451 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_4 : 'tv_shortcut_list) : 'tv_shortcut_list) = _v in
        ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_shortcut_text_body)), _, (_3 : 'tv_newline)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_shortcut_list = 
# 359 "octavius/octParser.mly"
                                                    ( (inner (List.rev _2)) :: _4 )
# 5928 "octavius/octParser.ml"
         in
        _menhir_goto_shortcut_list _menhir_env _menhir_stack _menhir_s _v) : 'freshtv452)) : 'freshtv454)
    | MenhirState282 | MenhirState113 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv457 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv455 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_shortcut_list) : 'tv_shortcut_list) = _v in
        ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_newline)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_shortcut_list = 
# 358 "octavius/octParser.mly"
                                                    ( [] :: _3 )
# 5945 "octavius/octParser.ml"
         in
        _menhir_goto_shortcut_list _menhir_env _menhir_stack _menhir_s _v) : 'freshtv456)) : 'freshtv458)
    | MenhirState249 | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv461 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_shortcut_list) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv459 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_shortcut_list) : 'tv_shortcut_list) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_text_body_with_line)) = _menhir_stack in
        let _v : 'tv_text_body_with_line = 
# 323 "octavius/octParser.mly"
                                             ( (Element (List _2)) :: _1 )
# 5961 "octavius/octParser.ml"
         in
        _menhir_goto_text_body_with_line _menhir_env _menhir_stack _menhir_s _v) : 'freshtv460)) : 'freshtv462)
    | _ ->
        _menhir_fail ()

and _menhir_reduce87 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _1 = () in
    let _v : 'tv_text = 
# 304 "octavius/octParser.mly"
                                             ( expecting 1 "text" )
# 5973 "octavius/octParser.ml"
     in
    _menhir_goto_text _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_text_tag : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_text_tag -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState295 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv445) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_tag) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv443) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_text_tag) : 'tv_text_tag) = _v in
        ((let _v : 'tv_tags = 
# 225 "octavius/octParser.mly"
                                   ( [_1] )
# 5992 "octavius/octParser.ml"
         in
        _menhir_goto_tags _menhir_env _menhir_stack _menhir_s _v) : 'freshtv444)) : 'freshtv446)
    | MenhirState338 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv449 * _menhir_state * 'tv_tags) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_text_tag) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv447 * _menhir_state * 'tv_tags) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_text_tag) : 'tv_text_tag) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_tags)) = _menhir_stack in
        let _v : 'tv_tags = 
# 228 "octavius/octParser.mly"
                                   ( _2 :: _1 )
# 6008 "octavius/octParser.ml"
         in
        _menhir_goto_tags _menhir_env _menhir_stack _menhir_s _v) : 'freshtv448)) : 'freshtv450)
    | _ ->
        _menhir_fail ()

and _menhir_run296 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 132 "octavius/octParser.mly"
       (string)
# 6017 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv441) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 132 "octavius/octParser.mly"
       (string)
# 6027 "octavius/octParser.ml"
    )) : (
# 132 "octavius/octParser.mly"
       (string)
# 6031 "octavius/octParser.ml"
    )) = _v in
    ((let _v : 'tv_simple_tag = 
# 232 "octavius/octParser.mly"
                    ( Version _1 )
# 6036 "octavius/octParser.ml"
     in
    _menhir_goto_simple_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv442)

and _menhir_run297 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 134 "octavius/octParser.mly"
       (string)
# 6043 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv439) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 134 "octavius/octParser.mly"
       (string)
# 6053 "octavius/octParser.ml"
    )) : (
# 134 "octavius/octParser.mly"
       (string)
# 6057 "octavius/octParser.ml"
    )) = _v in
    ((let _v : 'tv_simple_tag = 
# 233 "octavius/octParser.mly"
                    ( Since _1 )
# 6062 "octavius/octParser.ml"
     in
    _menhir_goto_simple_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv440)

and _menhir_run298 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 133 "octavius/octParser.mly"
       (Octavius_types.see_ref)
# 6069 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState298 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState298
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState298

and _menhir_run304 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 137 "octavius/octParser.mly"
       (string)
# 6134 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState304
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState304

and _menhir_run306 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState306
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState306

and _menhir_run308 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 130 "octavius/octParser.mly"
       (string)
# 6260 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState308
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState308

and _menhir_run310 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState310
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState310
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState310
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState310

and _menhir_run312 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState312
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState312

and _menhir_run314 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 140 "octavius/octParser.mly"
       (string)
# 6403 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState314 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState314
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState314

and _menhir_run316 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 141 "octavius/octParser.mly"
       (string)
# 6468 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv437) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 141 "octavius/octParser.mly"
       (string)
# 6478 "octavius/octParser.ml"
    )) : (
# 141 "octavius/octParser.mly"
       (string)
# 6482 "octavius/octParser.ml"
    )) = _v in
    ((let _v : 'tv_simple_tag = 
# 234 "octavius/octParser.mly"
                    ( Canonical _1 )
# 6487 "octavius/octParser.ml"
     in
    _menhir_goto_simple_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv438)

and _menhir_run317 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 135 "octavius/octParser.mly"
       (string)
# 6494 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState317
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState317

and _menhir_run319 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState319
    | Char _v ->
        _menhir_run323 _menhir_env (Obj.magic _menhir_stack) MenhirState319 _v
    | MINUS ->
        _menhir_run322 _menhir_env (Obj.magic _menhir_stack) MenhirState319
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState319
    | PLUS ->
        _menhir_run321 _menhir_env (Obj.magic _menhir_stack) MenhirState319
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState319
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState319

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf Pervasives.stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_reference_parts : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 6587 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv435 * _menhir_state * (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 6595 "octavius/octParser.ml"
    )) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv431 * _menhir_state * (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 6605 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | Ref_part _v ->
            _menhir_run348 _menhir_env (Obj.magic _menhir_stack) MenhirState352 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState352) : 'freshtv432)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv433 * _menhir_state * (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 6623 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv434)) : 'freshtv436)

and _menhir_goto_whitespace : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_whitespace -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState15 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv339 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState17
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState17 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState17)) : 'freshtv340)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv341 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 6651 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState23
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState23 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState23)) : 'freshtv342)
    | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv343 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 6669 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState29
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState29)) : 'freshtv344)
    | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv347 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 6687 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState35
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_ENUM ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv345 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 6699 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState35 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce26 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv346)
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState35)) : 'freshtv348)
    | MenhirState59 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv349 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState60
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState60 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState60)) : 'freshtv350)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv353 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv351 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState64 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce109 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv352)
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64)) : 'freshtv354)
    | MenhirState242 | MenhirState228 | MenhirState224 | MenhirState213 | MenhirState209 | MenhirState198 | MenhirState194 | MenhirState178 | MenhirState3 | MenhirState6 | MenhirState8 | MenhirState19 | MenhirState20 | MenhirState21 | MenhirState25 | MenhirState26 | MenhirState27 | MenhirState57 | MenhirState58 | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv355 * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce86 _menhir_env (Obj.magic _menhir_stack) : 'freshtv356)
    | MenhirState76 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv357 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce47 _menhir_env (Obj.magic _menhir_stack) : 'freshtv358)
    | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv359 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce48 _menhir_env (Obj.magic _menhir_stack) : 'freshtv360)
    | MenhirState103 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv361 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce56 _menhir_env (Obj.magic _menhir_stack) : 'freshtv362)
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv363 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce57 _menhir_env (Obj.magic _menhir_stack) : 'freshtv364)
    | MenhirState122 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv365 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce88 _menhir_env (Obj.magic _menhir_stack) : 'freshtv366)
    | MenhirState151 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv369 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 6773 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState153
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_LIST ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv367 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 6785 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState153 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce23 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv368)
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState153 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState153)) : 'freshtv370)
    | MenhirState164 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv373 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState166
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv371 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState166 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce106 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv372)
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState166)) : 'freshtv374)
    | MenhirState187 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv375 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState188
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState188)) : 'freshtv376)
    | MenhirState190 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv379 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState192
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv377 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState192 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce106 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv378)
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState192 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState192)) : 'freshtv380)
    | MenhirState202 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv381 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 6855 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState203
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState203 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState203)) : 'freshtv382)
    | MenhirState205 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv385 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 6873 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState207
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_LIST ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv383 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 6885 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState207 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce23 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv384)
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState207 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState207)) : 'freshtv386)
    | MenhirState217 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv387 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 6901 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState218
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState218 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState218)) : 'freshtv388)
    | MenhirState220 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv391 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 6919 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState222
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | HTML_END_ENUM ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv389 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 6931 "octavius/octParser.ml"
              )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState222 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce26 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv390)
          | HTML_Item _v ->
              _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState222 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState222)) : 'freshtv392)
    | MenhirState232 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv393 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState233
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState233)) : 'freshtv394)
    | MenhirState235 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv397 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((if _menhir_env._menhir_error then
          _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState237
        else
          let _tok = _menhir_env._menhir_token in
          match _tok with
          | END ->
              let (_menhir_env : _menhir_env) = _menhir_env in
              let (_menhir_stack : ((('freshtv395 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
              let (_menhir_s : _menhir_state) = MenhirState237 in
              ((let _menhir_env = _menhir_discard _menhir_env in
              _menhir_reduce109 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv396)
          | Item _v ->
              _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _v
          | _ ->
              (assert (not _menhir_env._menhir_error);
              _menhir_env._menhir_error <- true;
              _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState237)) : 'freshtv398)
    | MenhirState317 | MenhirState314 | MenhirState312 | MenhirState308 | MenhirState306 | MenhirState304 | MenhirState298 | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv399 * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce86 _menhir_env (Obj.magic _menhir_stack) : 'freshtv400)
    | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv401 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce47 _menhir_env (Obj.magic _menhir_stack) : 'freshtv402)
    | MenhirState253 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv403 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce48 _menhir_env (Obj.magic _menhir_stack) : 'freshtv404)
    | MenhirState274 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv405 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce56 _menhir_env (Obj.magic _menhir_stack) : 'freshtv406)
    | MenhirState276 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv407 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce57 _menhir_env (Obj.magic _menhir_stack) : 'freshtv408)
    | MenhirState288 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv409 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        (_menhir_reduce88 _menhir_env (Obj.magic _menhir_stack) : 'freshtv410)
    | MenhirState310 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv413 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv411 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_text_tag = 
# 245 "octavius/octParser.mly"
                         ( Inline )
# 7010 "octavius/octParser.ml"
         in
        _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv412)) : 'freshtv414)
    | MenhirState319 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv417 * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv415 * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_whitespace)) = _menhir_stack in
        let _v : 'tv_string = 
# 278 "octavius/octParser.mly"
                                                  ( [] )
# 7022 "octavius/octParser.ml"
         in
        _menhir_goto_string _menhir_env _menhir_stack _menhir_s _v) : 'freshtv416)) : 'freshtv418)
    | MenhirState327 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv421 * _menhir_state * 'tv_string_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv419 * _menhir_state * 'tv_string_body) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_string_body)), _, (_2 : 'tv_whitespace)) = _menhir_stack in
        let _v : 'tv_string = 
# 280 "octavius/octParser.mly"
                                                  ( List.rev _1 )
# 7034 "octavius/octParser.ml"
         in
        _menhir_goto_string _menhir_env _menhir_stack _menhir_s _v) : 'freshtv420)) : 'freshtv422)
    | MenhirState340 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv425 * _menhir_state * 'tv_tags) * _menhir_state * 'tv_simple_tag) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv423 * _menhir_state * 'tv_tags) * _menhir_state * 'tv_simple_tag) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_tags)), _, (_2 : 'tv_simple_tag)), _, (_3 : 'tv_whitespace)) = _menhir_stack in
        let _v : 'tv_tags = 
# 226 "octavius/octParser.mly"
                                   ( _2 :: _1 )
# 7046 "octavius/octParser.ml"
         in
        _menhir_goto_tags _menhir_env _menhir_stack _menhir_s _v) : 'freshtv424)) : 'freshtv426)
    | MenhirState343 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv429 * _menhir_state * 'tv_simple_tag) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv427 * _menhir_state * 'tv_simple_tag) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_simple_tag)), _, (_2 : 'tv_whitespace)) = _menhir_stack in
        let _v : 'tv_tags = 
# 223 "octavius/octParser.mly"
                                   ( [_1] )
# 7058 "octavius/octParser.ml"
         in
        _menhir_goto_tags _menhir_env _menhir_stack _menhir_s _v) : 'freshtv428)) : 'freshtv430)
    | _ ->
        _menhir_fail ()

and _menhir_reduce118 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 157 "octavius/octParser.mly"
       (string)
# 7067 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 157 "octavius/octParser.mly"
       (string)
# 7072 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_element = 
# 426 "octavius/octParser.mly"
    ( Verbatim _1 )
# 7077 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce119 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 158 "octavius/octParser.mly"
       (string option * string)
# 7084 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 158 "octavius/octParser.mly"
       (string option * string)
# 7089 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_element = 
# 428 "octavius/octParser.mly"
    ( let t, s = _1 in
        Target (t, s) )
# 7095 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce115 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 153 "octavius/octParser.mly"
       (Octavius_types.special_ref_kind)
# 7102 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 153 "octavius/octParser.mly"
       (Octavius_types.special_ref_kind)
# 7107 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_element = 
# 420 "octavius/octParser.mly"
    ( Special_ref _1 )
# 7112 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce112 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 7119 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 7124 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_element = 
# 412 "octavius/octParser.mly"
    ( let k, n = _1 in
        Ref (k, n, None) )
# 7130 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce117 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 156 "octavius/octParser.mly"
       (string)
# 7137 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 156 "octavius/octParser.mly"
       (string)
# 7142 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_element = 
# 424 "octavius/octParser.mly"
    ( PreCode _1 )
# 7147 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce121 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _1 = () in
    let _v : 'tv_text_item = 
# 329 "octavius/octParser.mly"
                                     ( iplus )
# 7157 "octavius/octParser.ml"
     in
    _menhir_goto_text_item _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce33 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _1 = () in
    let _v : 'tv_newline = 
# 257 "octavius/octParser.mly"
                    ( () )
# 7167 "octavius/octParser.ml"
     in
    _menhir_goto_newline _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce120 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _1 = () in
    let _v : 'tv_text_item = 
# 328 "octavius/octParser.mly"
                                     ( iminus )
# 7177 "octavius/octParser.ml"
     in
    _menhir_goto_text_item _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce116 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 155 "octavius/octParser.mly"
       (string)
# 7184 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 155 "octavius/octParser.mly"
       (string)
# 7189 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_element = 
# 422 "octavius/octParser.mly"
    ( Code _1 )
# 7194 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce124 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 185 "octavius/octParser.mly"
       (string)
# 7201 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s (_1 : (
# 185 "octavius/octParser.mly"
       (string)
# 7206 "octavius/octParser.ml"
  )) ->
    let _v : 'tv_text_item = 
# 332 "octavius/octParser.mly"
                                     ( String _1 )
# 7211 "octavius/octParser.ml"
     in
    _menhir_goto_text_item _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce5 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _1 = () in
    let _v : 'tv_blanks = 
# 252 "octavius/octParser.mly"
                    ( () )
# 7221 "octavius/octParser.ml"
     in
    _menhir_goto_blanks _menhir_env _menhir_stack _menhir_s _v

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 157 "octavius/octParser.mly"
       (string)
# 7228 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce118 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 146 "octavius/octParser.mly"
       (int * string option)
# 7237 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | END ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState6

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 158 "octavius/octParser.mly"
       (string option * string)
# 7302 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce119 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run8 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 7311 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | END ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 153 "octavius/octParser.mly"
       (Octavius_types.special_ref_kind)
# 7376 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce115 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run10 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 7385 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce112 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run11 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 156 "octavius/octParser.mly"
       (string)
# 7394 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce117 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run12 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce121 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run13 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce33 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run14 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce120 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run15 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState15
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState15
    | Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState15
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState15

and _menhir_run20 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 170 "octavius/octParser.mly"
       (string * int)
# 7435 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | HTML_END_Title _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState20

and _menhir_run21 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 166 "octavius/octParser.mly"
       (string)
# 7500 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
    | HTML_END_RIGHT ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState21

and _menhir_run22 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 172 "octavius/octParser.mly"
       (string)
# 7565 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | HTML_Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState22

and _menhir_run26 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 164 "octavius/octParser.mly"
       (string)
# 7586 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | HTML_END_LEFT ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26

and _menhir_run27 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 168 "octavius/octParser.mly"
       (string)
# 7651 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | HTML_END_ITALIC ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27

and _menhir_run28 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 174 "octavius/octParser.mly"
       (string)
# 7716 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | HTML_Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState28

and _menhir_run57 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 162 "octavius/octParser.mly"
       (string)
# 7737 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
    | HTML_END_CENTER ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState57
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState57

and _menhir_run58 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 160 "octavius/octParser.mly"
       (string)
# 7802 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
    | HTML_END_BOLD ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState58
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState58

and _menhir_run59 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState59
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState59
    | Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState59
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState59

and _menhir_run68 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 155 "octavius/octParser.mly"
       (string)
# 7884 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce116 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run69 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 185 "octavius/octParser.mly"
       (string)
# 7893 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce124 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run16 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce5 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run70 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | Ref _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv335 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 7916 "octavius/octParser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BEGIN ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | BLANK ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | Char _v ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | Code _v ->
            _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | ENUM ->
            _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | HTML_Bold _v ->
            _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | HTML_Center _v ->
            _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | HTML_Enum _v ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | HTML_Italic _v ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | HTML_Left _v ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | HTML_List _v ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | HTML_Right _v ->
            _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | HTML_Title _v ->
            _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | LIST ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | MINUS ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | NEWLINE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | PLUS ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | Pre_Code _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | Ref _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | Special_Ref _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | Style _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | Target _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | Title _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | Verb _v ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
        | END ->
            _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState71
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState71) : 'freshtv336)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv337 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv338)

and _menhir_reduce141 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_newline -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_newline)) = _menhir_stack in
    let _v : 'tv_whitespace = 
# 271 "octavius/octParser.mly"
                        ( [Newline] )
# 7990 "octavius/octParser.ml"
     in
    _menhir_goto_whitespace _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce140 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blanks -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blanks)) = _menhir_stack in
    let _v : 'tv_whitespace = 
# 270 "octavius/octParser.mly"
                        ( [Blank] )
# 8000 "octavius/octParser.ml"
     in
    _menhir_goto_whitespace _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce142 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_blank_line -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_blank_line)) = _menhir_stack in
    let _v : 'tv_whitespace = 
# 272 "octavius/octParser.mly"
                        ( [Blank_line] )
# 8010 "octavius/octParser.ml"
     in
    _menhir_goto_whitespace _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce108 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)) = _menhir_stack in
    let _3 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 404 "octavius/octParser.mly"
    ( expecting 3 "list item" )
# 8022 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce107 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_octavius_octParser_list)) = _menhir_stack in
    let _4 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 402 "octavius/octParser.mly"
    ( unclosed "{ul" 1 "list item" "}" 4 )
# 8034 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce25 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 8041 "octavius/octParser.ml"
)) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 172 "octavius/octParser.mly"
       (string)
# 8047 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_whitespace)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 486 "octavius/octParser.mly"
    ( expecting 2 "HTML list item" )
# 8053 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce24 : _menhir_env -> (('ttv_tail * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 8060 "octavius/octParser.ml"
)) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (((_menhir_stack, _menhir_s, (_1 : (
# 172 "octavius/octParser.mly"
       (string)
# 8066 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_html_list)) = _menhir_stack in
    let _4 = () in
    let _v : 'tv_html_text_element = 
# 483 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
         "HTML list item" (html_close_to_string _1) 4 )
# 8073 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce28 : _menhir_env -> ('ttv_tail * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 8080 "octavius/octParser.ml"
)) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((_menhir_stack, _menhir_s, (_1 : (
# 174 "octavius/octParser.mly"
       (string)
# 8086 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_whitespace)) = _menhir_stack in
    let _3 = () in
    let _v : 'tv_html_text_element = 
# 493 "octavius/octParser.mly"
    ( expecting 3 "HTML list item" )
# 8092 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce27 : _menhir_env -> (('ttv_tail * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 8099 "octavius/octParser.ml"
)) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (((_menhir_stack, _menhir_s, (_1 : (
# 174 "octavius/octParser.mly"
       (string)
# 8105 "octavius/octParser.ml"
    ))), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_html_list)) = _menhir_stack in
    let _4 = () in
    let _v : 'tv_html_text_element = 
# 490 "octavius/octParser.mly"
    ( unclosed (html_open_to_string _1) 1
        "HTML list item" (html_close_to_string _1) 4 )
# 8112 "octavius/octParser.ml"
     in
    _menhir_goto_html_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce111 : _menhir_env -> ('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)) = _menhir_stack in
    let _3 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 410 "octavius/octParser.mly"
    ( expecting 3 "enumerated list item" )
# 8124 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce110 : _menhir_env -> (('ttv_tail * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _ ->
    let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_whitespace)), _, (_3 : 'tv_octavius_octParser_list)) = _menhir_stack in
    let _4 = () in
    let _1 = () in
    let _v : 'tv_text_element = 
# 408 "octavius/octParser.mly"
    ( unclosed "{ol" 1 "list item" "}" 4 )
# 8136 "octavius/octParser.ml"
     in
    _menhir_goto_text_element _menhir_env _menhir_stack _menhir_s _v

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce87 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run77 : _menhir_env -> 'ttv_tail * _menhir_state -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv333 * _menhir_state) = Obj.magic _menhir_stack in
    let (_ : _menhir_state) = _menhir_s in
    ((let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _2 = () in
    let _1 = () in
    let _v : 'tv_shortcut_enum = 
# 368 "octavius/octParser.mly"
                                                    ( expecting 2 "enumerated list item" )
# 8157 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_enum _menhir_env _menhir_stack _menhir_s _v) : 'freshtv334)

and _menhir_run104 : _menhir_env -> 'ttv_tail * _menhir_state -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv331 * _menhir_state) = Obj.magic _menhir_stack in
    let (_ : _menhir_state) = _menhir_s in
    ((let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _2 = () in
    let _1 = () in
    let _v : 'tv_shortcut_list = 
# 360 "octavius/octParser.mly"
                                                    ( expecting 2 "list item" )
# 8173 "octavius/octParser.ml"
     in
    _menhir_goto_shortcut_list _menhir_env _menhir_stack _menhir_s _v) : 'freshtv332)

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce87 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_string : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_string -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv329 * _menhir_state) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_string) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv327 * _menhir_state) = Obj.magic _menhir_stack in
    let (_ : _menhir_state) = _menhir_s in
    let ((_2 : 'tv_string) : 'tv_string) = _v in
    ((let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_text_tag = 
# 238 "octavius/octParser.mly"
                         ( Author (String.concat sempty _2) )
# 8197 "octavius/octParser.ml"
     in
    _menhir_goto_text_tag _menhir_env _menhir_stack _menhir_s _v) : 'freshtv328)) : 'freshtv330)

and _menhir_goto_tags : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_tags -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv325 * _menhir_state * 'tv_text) * _menhir_state * 'tv_tags) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | AUTHOR ->
        _menhir_run319 _menhir_env (Obj.magic _menhir_stack) MenhirState338
    | Before _v ->
        _menhir_run317 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | Canonical _v ->
        _menhir_run316 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | Custom _v ->
        _menhir_run314 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | DEPRECATED ->
        _menhir_run312 _menhir_env (Obj.magic _menhir_stack) MenhirState338
    | INLINE ->
        _menhir_run310 _menhir_env (Obj.magic _menhir_stack) MenhirState338
    | Param _v ->
        _menhir_run308 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | RETURN ->
        _menhir_run306 _menhir_env (Obj.magic _menhir_stack) MenhirState338
    | Raise _v ->
        _menhir_run304 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | See _v ->
        _menhir_run298 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | Since _v ->
        _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | Version _v ->
        _menhir_run296 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState338) : 'freshtv326)

and _menhir_goto_reference_part : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_reference_part -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState352 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv319 * _menhir_state * (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 8246 "octavius/octParser.ml"
        ))) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_reference_part) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv317 * _menhir_state * (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 8254 "octavius/octParser.ml"
        ))) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_reference_part) : 'tv_reference_part) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 8261 "octavius/octParser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 8267 "octavius/octParser.ml"
        ) = 
# 212 "octavius/octParser.mly"
                                     ( _3 :: _1 )
# 8271 "octavius/octParser.ml"
         in
        _menhir_goto_reference_parts _menhir_env _menhir_stack _menhir_s _v) : 'freshtv318)) : 'freshtv320)
    | MenhirState347 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv323) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_reference_part) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv321) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_reference_part) : 'tv_reference_part) = _v in
        ((let _v : (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 8286 "octavius/octParser.ml"
        ) = 
# 211 "octavius/octParser.mly"
                 ( [_1] )
# 8290 "octavius/octParser.ml"
         in
        _menhir_goto_reference_parts _menhir_env _menhir_stack _menhir_s _v) : 'freshtv322)) : 'freshtv324)
    | _ ->
        _menhir_fail ()

and _menhir_reduce139 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_whitespace = 
# 269 "octavius/octParser.mly"
                        ( [] )
# 8301 "octavius/octParser.ml"
     in
    _menhir_goto_whitespace _menhir_env _menhir_stack _menhir_s _v

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 157 "octavius/octParser.mly"
       (string)
# 8308 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce118 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 146 "octavius/octParser.mly"
       (int * string option)
# 8317 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | END ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3

and _menhir_run177 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 158 "octavius/octParser.mly"
       (string option * string)
# 8382 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce119 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run178 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 8391 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
    | END ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState178
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState178

and _menhir_run182 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 153 "octavius/octParser.mly"
       (Octavius_types.special_ref_kind)
# 8456 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce115 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run183 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 8465 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce112 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run184 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 156 "octavius/octParser.mly"
       (string)
# 8474 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce117 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run185 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce121 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run33 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce33 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run186 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce120 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run187 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState187
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState187
    | Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState187
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState187

and _menhir_run194 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 170 "octavius/octParser.mly"
       (string * int)
# 8515 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState194 _v
    | HTML_END_Title _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState194
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState194

and _menhir_run198 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 166 "octavius/octParser.mly"
       (string)
# 8580 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _v
    | HTML_END_RIGHT ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState198
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState198

and _menhir_run202 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 172 "octavius/octParser.mly"
       (string)
# 8645 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState202
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState202
    | HTML_Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState202
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState202

and _menhir_run209 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 164 "octavius/octParser.mly"
       (string)
# 8666 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState209 _v
    | HTML_END_LEFT ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState209
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState209

and _menhir_run213 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 168 "octavius/octParser.mly"
       (string)
# 8731 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState213 _v
    | HTML_END_ITALIC ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState213
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState213

and _menhir_run217 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 174 "octavius/octParser.mly"
       (string)
# 8796 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState217
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState217
    | HTML_Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState217
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState217

and _menhir_run224 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 162 "octavius/octParser.mly"
       (string)
# 8817 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
    | HTML_END_CENTER ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState224
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState224

and _menhir_run228 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 160 "octavius/octParser.mly"
       (string)
# 8882 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | Char _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | Code _v ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | ENUM ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | HTML_Bold _v ->
        _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_Center _v ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_Enum _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_Italic _v ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_Left _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_List _v ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_Right _v ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_Title _v ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | LIST ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | MINUS ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | PLUS ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | Pre_Code _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | Ref _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | Special_Ref _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | Style _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | Target _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | Title _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | Verb _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
    | HTML_END_BOLD ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState228
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState228

and _menhir_run232 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BLANK ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState232
    | NEWLINE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState232
    | Item _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState232
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState232

and _menhir_run239 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 155 "octavius/octParser.mly"
       (string)
# 8964 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce116 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run240 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 185 "octavius/octParser.mly"
       (string)
# 8973 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce124 _menhir_env (Obj.magic _menhir_stack) _menhir_s _v

and _menhir_run34 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce5 _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run241 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | Ref _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv313 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 8996 "octavius/octParser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BEGIN ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | BLANK ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | Char _v ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | Code _v ->
            _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | ENUM ->
            _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | HTML_Bold _v ->
            _menhir_run58 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | HTML_Center _v ->
            _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | HTML_Enum _v ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | HTML_Italic _v ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | HTML_Left _v ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | HTML_List _v ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | HTML_Right _v ->
            _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | HTML_Title _v ->
            _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | LIST ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | MINUS ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | NEWLINE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | PLUS ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | Pre_Code _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | Ref _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | Special_Ref _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | Style _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | Target _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | Title _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | Verb _v ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState242 _v
        | END ->
            _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState242
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState242) : 'freshtv314)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv315 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv316)

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState352 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv17 * _menhir_state * (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 9072 "octavius/octParser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv18)
    | MenhirState347 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv19) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv20)
    | MenhirState343 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv25 * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv23 * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState343 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv21 * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_simple_tag)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_tags = 
# 224 "octavius/octParser.mly"
                                   ( expecting 2 "tag" )
# 9095 "octavius/octParser.ml"
         in
        _menhir_goto_tags _menhir_env _menhir_stack _menhir_s _v) : 'freshtv22)) : 'freshtv24)) : 'freshtv26)
    | MenhirState340 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv31 * _menhir_state * 'tv_tags) * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv29 * _menhir_state * 'tv_tags) * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState340 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv27 * _menhir_state * 'tv_tags) * _menhir_state * 'tv_simple_tag) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_tags)), _, (_2 : 'tv_simple_tag)) = _menhir_stack in
        let _3 = () in
        let _v : 'tv_tags = 
# 227 "octavius/octParser.mly"
                                   ( expecting 3 "tag" )
# 9113 "octavius/octParser.ml"
         in
        _menhir_goto_tags _menhir_env _menhir_stack _menhir_s _v) : 'freshtv28)) : 'freshtv30)) : 'freshtv32)
    | MenhirState338 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv33 * _menhir_state * 'tv_text) * _menhir_state * 'tv_tags) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv34)
    | MenhirState334 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv35 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv36)
    | MenhirState332 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv37 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv38)
    | MenhirState330 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv39 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv40)
    | MenhirState327 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv41 * _menhir_state * 'tv_string_body) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv42)
    | MenhirState319 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv47 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv45) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState319 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv43) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        ((let _1 = () in
        let _v : 'tv_string = 
# 279 "octavius/octParser.mly"
                                                  ( expecting 1 "string" )
# 9155 "octavius/octParser.ml"
         in
        _menhir_goto_string _menhir_env _menhir_stack _menhir_s _v) : 'freshtv44)) : 'freshtv46)) : 'freshtv48)
    | MenhirState317 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv49 * _menhir_state * (
# 135 "octavius/octParser.mly"
       (string)
# 9163 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState317 : 'freshtv50)
    | MenhirState314 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv51 * _menhir_state * (
# 140 "octavius/octParser.mly"
       (string)
# 9171 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState314 : 'freshtv52)
    | MenhirState312 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv53 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState312 : 'freshtv54)
    | MenhirState310 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv55 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv56)
    | MenhirState308 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv57 * _menhir_state * (
# 130 "octavius/octParser.mly"
       (string)
# 9188 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState308 : 'freshtv58)
    | MenhirState306 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv59 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState306 : 'freshtv60)
    | MenhirState304 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv61 * _menhir_state * (
# 137 "octavius/octParser.mly"
       (string)
# 9200 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState304 : 'freshtv62)
    | MenhirState303 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv63 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv64)
    | MenhirState301 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv65 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv66)
    | MenhirState300 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv67 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv68)
    | MenhirState298 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv69 * _menhir_state * (
# 133 "octavius/octParser.mly"
       (Octavius_types.see_ref)
# 9223 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState298 : 'freshtv70)
    | MenhirState295 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv71 * _menhir_state * 'tv_text) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv72)
    | MenhirState294 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv73 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv74)
    | MenhirState292 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv75 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv76)
    | MenhirState291 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv77 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv78)
    | MenhirState288 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv79 * _menhir_state * 'tv_text_body) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv80)
    | MenhirState284 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv81 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv82)
    | MenhirState282 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv83 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv84)
    | MenhirState281 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv85 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv86)
    | MenhirState279 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv87 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv88)
    | MenhirState278 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv89 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv90)
    | MenhirState276 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv91 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv92)
    | MenhirState274 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv93 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_run104 _menhir_env (Obj.magic _menhir_stack) MenhirState274 : 'freshtv94)
    | MenhirState273 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv95 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv96)
    | MenhirState271 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv97 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv98)
    | MenhirState268 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv99 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv100)
    | MenhirState267 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv101 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv102)
    | MenhirState265 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv103 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv104)
    | MenhirState257 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv105 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv106)
    | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv107 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv108)
    | MenhirState253 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv109 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv110)
    | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv111 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState250 : 'freshtv112)
    | MenhirState249 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv113 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv114)
    | MenhirState242 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv115 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 9339 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState242 : 'freshtv116)
    | MenhirState237 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv117 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv118)
    | MenhirState235 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv121 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv119 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState235 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce110 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv120)) : 'freshtv122)
    | MenhirState233 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv125 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv123 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState233 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce111 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv124)) : 'freshtv126)
    | MenhirState232 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv127 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState232 : 'freshtv128)
    | MenhirState228 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv129 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 9372 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState228 : 'freshtv130)
    | MenhirState224 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv131 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 9380 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState224 : 'freshtv132)
    | MenhirState222 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv133 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9388 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv134)
    | MenhirState220 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv137 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9397 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv135 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9403 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState220 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce27 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv136)) : 'freshtv138)
    | MenhirState218 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv141 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9413 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv139 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9419 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState218 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce28 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv140)) : 'freshtv142)
    | MenhirState217 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv143 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9429 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState217 : 'freshtv144)
    | MenhirState213 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv145 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 9437 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState213 : 'freshtv146)
    | MenhirState209 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv147 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 9445 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState209 : 'freshtv148)
    | MenhirState207 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv149 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9453 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv150)
    | MenhirState205 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv153 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9462 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv151 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9468 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState205 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce24 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv152)) : 'freshtv154)
    | MenhirState203 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv157 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9478 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv155 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9484 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState203 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce25 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv156)) : 'freshtv158)
    | MenhirState202 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv159 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9494 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState202 : 'freshtv160)
    | MenhirState198 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv161 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 9502 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState198 : 'freshtv162)
    | MenhirState194 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv163 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 9510 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState194 : 'freshtv164)
    | MenhirState192 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv165 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv166)
    | MenhirState190 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv169 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv167 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState190 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce107 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv168)) : 'freshtv170)
    | MenhirState188 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv173 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv171 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState188 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce108 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv172)) : 'freshtv174)
    | MenhirState187 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv175 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState187 : 'freshtv176)
    | MenhirState178 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv177 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 9543 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState178 : 'freshtv178)
    | MenhirState166 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv179 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv180)
    | MenhirState164 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv183 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv181 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState164 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce107 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv182)) : 'freshtv184)
    | MenhirState153 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv185 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9564 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv186)
    | MenhirState151 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv189 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9573 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv187 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9579 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState151 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce24 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv188)) : 'freshtv190)
    | MenhirState135 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv191 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        (_menhir_reduce142 _menhir_env (Obj.magic _menhir_stack) : 'freshtv192)
    | MenhirState133 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv193 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        (_menhir_reduce140 _menhir_env (Obj.magic _menhir_stack) : 'freshtv194)
    | MenhirState132 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv195 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        (_menhir_reduce141 _menhir_env (Obj.magic _menhir_stack) : 'freshtv196)
    | MenhirState128 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv197 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        (_menhir_reduce142 _menhir_env (Obj.magic _menhir_stack) : 'freshtv198)
    | MenhirState126 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv199 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        (_menhir_reduce140 _menhir_env (Obj.magic _menhir_stack) : 'freshtv200)
    | MenhirState125 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv201 * _menhir_state * 'tv_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        (_menhir_reduce141 _menhir_env (Obj.magic _menhir_stack) : 'freshtv202)
    | MenhirState122 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv203 * _menhir_state * 'tv_text_body) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState122 : 'freshtv204)
    | MenhirState116 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv205 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        (_menhir_reduce142 _menhir_env (Obj.magic _menhir_stack) : 'freshtv206)
    | MenhirState113 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv207 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        (_menhir_reduce141 _menhir_env (Obj.magic _menhir_stack) : 'freshtv208)
    | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv209 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        (_menhir_reduce142 _menhir_env (Obj.magic _menhir_stack) : 'freshtv210)
    | MenhirState109 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv211 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv212)
    | MenhirState108 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv213 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        (_menhir_reduce141 _menhir_env (Obj.magic _menhir_stack) : 'freshtv214)
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv215 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState106 : 'freshtv216)
    | MenhirState103 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv217 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_run104 _menhir_env (Obj.magic _menhir_stack) MenhirState103 : 'freshtv218)
    | MenhirState102 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv219 * _menhir_state) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        (_menhir_reduce142 _menhir_env (Obj.magic _menhir_stack) : 'freshtv220)
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv221 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        (_menhir_reduce140 _menhir_env (Obj.magic _menhir_stack) : 'freshtv222)
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv223 * _menhir_state) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        (_menhir_reduce141 _menhir_env (Obj.magic _menhir_stack) : 'freshtv224)
    | MenhirState95 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv225 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        (_menhir_reduce142 _menhir_env (Obj.magic _menhir_stack) : 'freshtv226)
    | MenhirState93 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv227 * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        (_menhir_reduce140 _menhir_env (Obj.magic _menhir_stack) : 'freshtv228)
    | MenhirState84 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv229 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv230)
    | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv231 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        (_menhir_reduce141 _menhir_env (Obj.magic _menhir_stack) : 'freshtv232)
    | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv233 * _menhir_state) * _menhir_state * 'tv_shortcut_text_body) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState80 : 'freshtv234)
    | MenhirState76 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv235 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState76 : 'freshtv236)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv237 * _menhir_state * 'tv_text_body_with_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv238)
    | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv239 * _menhir_state) * (
# 152 "octavius/octParser.mly"
       (Octavius_types.ref_kind * string)
# 9688 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState71 : 'freshtv240)
    | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv241 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv242)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv245 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv243 * _menhir_state) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_octavius_octParser_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState62 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce110 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv244)) : 'freshtv246)
    | MenhirState60 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv249 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv247 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState60 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce111 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv248)) : 'freshtv250)
    | MenhirState59 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv251 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState59 : 'freshtv252)
    | MenhirState58 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv253 * _menhir_state * (
# 160 "octavius/octParser.mly"
       (string)
# 9721 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState58 : 'freshtv254)
    | MenhirState57 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv255 * _menhir_state * (
# 162 "octavius/octParser.mly"
       (string)
# 9729 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState57 : 'freshtv256)
    | MenhirState54 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv257 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        (_menhir_reduce142 _menhir_env (Obj.magic _menhir_stack) : 'freshtv258)
    | MenhirState51 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv259 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        (_menhir_reduce140 _menhir_env (Obj.magic _menhir_stack) : 'freshtv260)
    | MenhirState48 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv261 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        (_menhir_reduce141 _menhir_env (Obj.magic _menhir_stack) : 'freshtv262)
    | MenhirState44 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv263 * _menhir_state * 'tv_blank_line) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv264)
    | MenhirState41 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv265 * _menhir_state * 'tv_blanks) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv266)
    | MenhirState38 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv267 * _menhir_state * 'tv_newline) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv268)
    | MenhirState35 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv269 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9764 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv270)
    | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv273 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9773 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv271 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9779 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) * _menhir_state * 'tv_html_list) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState31 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce27 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv272)) : 'freshtv274)
    | MenhirState29 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv277 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9789 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv275 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9795 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState29 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce28 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv276)) : 'freshtv278)
    | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv279 * _menhir_state * (
# 174 "octavius/octParser.mly"
       (string)
# 9805 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState28 : 'freshtv280)
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv281 * _menhir_state * (
# 168 "octavius/octParser.mly"
       (string)
# 9813 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState27 : 'freshtv282)
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv283 * _menhir_state * (
# 164 "octavius/octParser.mly"
       (string)
# 9821 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState26 : 'freshtv284)
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv285 * _menhir_state * (
# 176 "octavius/octParser.mly"
       (string)
# 9829 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState25 : 'freshtv286)
    | MenhirState23 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv289 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9837 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv287 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9843 "octavius/octParser.ml"
        )) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState23 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce25 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv288)) : 'freshtv290)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv291 * _menhir_state * (
# 172 "octavius/octParser.mly"
       (string)
# 9853 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState22 : 'freshtv292)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv293 * _menhir_state * (
# 166 "octavius/octParser.mly"
       (string)
# 9861 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState21 : 'freshtv294)
    | MenhirState20 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv295 * _menhir_state * (
# 170 "octavius/octParser.mly"
       (string * int)
# 9869 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState20 : 'freshtv296)
    | MenhirState19 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv297 * _menhir_state * (
# 150 "octavius/octParser.mly"
       (bool)
# 9877 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState19 : 'freshtv298)
    | MenhirState17 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv301 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv299 * _menhir_state) * _menhir_state * 'tv_whitespace) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState17 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce108 _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv300)) : 'freshtv302)
    | MenhirState15 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv303 * _menhir_state) = Obj.magic _menhir_stack in
        (_menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState15 : 'freshtv304)
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv305 * _menhir_state * (
# 147 "octavius/octParser.mly"
       (Octavius_types.style_kind)
# 9897 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState8 : 'freshtv306)
    | MenhirState6 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv307 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 9905 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState6 : 'freshtv308)
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv309 * _menhir_state * (
# 146 "octavius/octParser.mly"
       (int * string option)
# 9913 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        (_menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState3 : 'freshtv310)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv311) = Obj.magic _menhir_stack in
        (_menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0 : 'freshtv312)

and _menhir_run348 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 188 "octavius/octParser.mly"
       (string)
# 9924 "octavius/octParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | MINUS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv11 * _menhir_state * (
# 188 "octavius/octParser.mly"
       (string)
# 9936 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | Ref_part _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv7 * _menhir_state * (
# 188 "octavius/octParser.mly"
       (string)
# 9946 "octavius/octParser.ml"
            ))) = Obj.magic _menhir_stack in
            let (_v : (
# 188 "octavius/octParser.mly"
       (string)
# 9951 "octavius/octParser.ml"
            )) = _v in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv5 * _menhir_state * (
# 188 "octavius/octParser.mly"
       (string)
# 9958 "octavius/octParser.ml"
            ))) = Obj.magic _menhir_stack in
            let ((_3 : (
# 188 "octavius/octParser.mly"
       (string)
# 9963 "octavius/octParser.ml"
            )) : (
# 188 "octavius/octParser.mly"
       (string)
# 9967 "octavius/octParser.ml"
            )) = _v in
            ((let (_menhir_stack, _menhir_s, (_1 : (
# 188 "octavius/octParser.mly"
       (string)
# 9972 "octavius/octParser.ml"
            ))) = _menhir_stack in
            let _2 = () in
            let _v : 'tv_reference_part = 
# 217 "octavius/octParser.mly"
                          ( (Some _1, _3) )
# 9978 "octavius/octParser.ml"
             in
            _menhir_goto_reference_part _menhir_env _menhir_stack _menhir_s _v) : 'freshtv6)) : 'freshtv8)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv9 * _menhir_state * (
# 188 "octavius/octParser.mly"
       (string)
# 9988 "octavius/octParser.ml"
            ))) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv10)) : 'freshtv12)
    | DOT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv13 * _menhir_state * (
# 188 "octavius/octParser.mly"
       (string)
# 9997 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : (
# 188 "octavius/octParser.mly"
       (string)
# 10002 "octavius/octParser.ml"
        ))) = _menhir_stack in
        let _v : 'tv_reference_part = 
# 216 "octavius/octParser.mly"
           ( (None, _1) )
# 10007 "octavius/octParser.ml"
         in
        _menhir_goto_reference_part _menhir_env _menhir_stack _menhir_s _v) : 'freshtv14)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv15 * _menhir_state * (
# 188 "octavius/octParser.mly"
       (string)
# 10017 "octavius/octParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv16)

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and _menhir_init : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> _menhir_env =
  fun lexer lexbuf ->
    let _tok = Obj.magic () in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 191 "octavius/octParser.mly"
      (Octavius_types.t)
# 10047 "octavius/octParser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env = _menhir_init lexer lexbuf in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv3) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BEGIN ->
        _menhir_run241 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | BLANK ->
        _menhir_run34 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | Char _v ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | Code _v ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ENUM ->
        _menhir_run232 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | HTML_Bold _v ->
        _menhir_run228 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | HTML_Center _v ->
        _menhir_run224 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | HTML_Enum _v ->
        _menhir_run217 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | HTML_Italic _v ->
        _menhir_run213 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | HTML_Left _v ->
        _menhir_run209 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | HTML_List _v ->
        _menhir_run202 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | HTML_Right _v ->
        _menhir_run198 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | HTML_Title _v ->
        _menhir_run194 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | LIST ->
        _menhir_run187 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | MINUS ->
        _menhir_run186 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | NEWLINE ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | PLUS ->
        _menhir_run185 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | Pre_Code _v ->
        _menhir_run184 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | Ref _v ->
        _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | Special_Ref _v ->
        _menhir_run182 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | Style _v ->
        _menhir_run178 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | Target _v ->
        _menhir_run177 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | Title _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | Verb _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | AUTHOR | Before _ | Canonical _ | Custom _ | DEPRECATED | INLINE | Param _ | RETURN | Raise _ | See _ | Since _ | Version _ ->
        _menhir_reduce139 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv4))

and reference_parts : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 194 "octavius/octParser.mly"
      ((string option * string) list)
# 10114 "octavius/octParser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env = _menhir_init lexer lexbuf in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | Ref_part _v ->
        _menhir_run348 _menhir_env (Obj.magic _menhir_stack) MenhirState347 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState347) : 'freshtv2))

# 511 "octavius/octParser.mly"
  

# 10133 "octavius/octParser.ml"

# 219 "/Users/jared/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
  


# 10139 "octavius/octParser.ml"
