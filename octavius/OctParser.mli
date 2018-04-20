
(* The type of tokens. *)

type token = 
  | Version of (string)
  | Verb of (string)
  | Title of (int * string option)
  | Target of (string option * string)
  | Style of (Octavius_types.style_kind)
  | Special_Ref of (Octavius_types.special_ref_kind)
  | Since of (string)
  | See of (Octavius_types.see_ref)
  | Ref_part of (string)
  | Ref of (Octavius_types.ref_kind * string)
  | Raise of (string)
  | RETURN
  | Pre_Code of (string)
  | Param of (string)
  | PLUS
  | NEWLINE
  | MINUS
  | LIST
  | Item of (bool)
  | INLINE
  | HTML_Title of (string * int)
  | HTML_Right of (string)
  | HTML_List of (string)
  | HTML_Left of (string)
  | HTML_Item of (string)
  | HTML_Italic of (string)
  | HTML_Enum of (string)
  | HTML_END_Title of (int)
  | HTML_END_RIGHT
  | HTML_END_LIST
  | HTML_END_LEFT
  | HTML_END_ITEM
  | HTML_END_ITALIC
  | HTML_END_ENUM
  | HTML_END_CENTER
  | HTML_END_BOLD
  | HTML_Center of (string)
  | HTML_Bold of (string)
  | EOF
  | ENUM
  | END
  | DOT
  | DEPRECATED
  | Custom of (string)
  | Code of (string)
  | Char of (string)
  | Canonical of (string)
  | Before of (string)
  | BLANK
  | BEGIN
  | AUTHOR

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val reference_parts: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> ((string option * string) list)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Octavius_types.t)
