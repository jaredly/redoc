

let (|?>) = (a, fn) => switch a { | None => None | Some(x) => fn(x) };
let (|?>>) = (a, fn) => a |?> x => Some(fn(x));
let (|!) = (a, b) => switch a { | None => failwith(b) | Some(x) => x };
let (|?) = (a, b) => switch a { | None => b | Some(x) => x };

let fromShortUrl = text => {
  if (Str.string_match(Str.regexp("\([a-zA-Z0-9_.-]+\)/\([a-zA-Z0-9_.-]+\)"), text, 0))  {
    Some(Printf.sprintf({|https://github.com/%s/%s/blob/master/|}, Str.matched_group(1, text), Str.matched_group(2, text)))
  } else {
    None
  }
};

let (/+) = Filename.concat;
let getUrl = (base) => {
  let repo = (Files.readFile(base /+ "package.json")) |?>> Json.parse |?> Json.get("repository");
  let url = repo |?> Json.get("url") |?> Json.string;
  let isGit = repo |?> Json.get("type") |?> Json.string |?>> (x => x == "git") |? false;
  isGit ? (url |?> fromShortUrl) : None
};
