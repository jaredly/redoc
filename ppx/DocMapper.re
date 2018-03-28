
open Parsetree;

let reduceOptional = (fn, items) => List.fold_left((result, item) => switch (fn(item)) {
| None => result
| Some(item) => [item, ...result]
}, [], items);

let getDocStrings = ({pstr_desc}) => switch pstr_desc {
| Pstr_value(isRec, bindings) => {
  bindings |> List.map(({pvb_attributes}) => {
    pvb_attributes |> reduceOptional((({Asttypes.txt, loc}, payload)) => {
      switch (txt, payload) {
      | ("ocaml.doc", PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(docstring, _)), pexp_loc}, _)}])) => Some((docstring, pexp_loc))
      | _ => None
      }
    })
  }) |> List.concat
}
| _ => []
};

let makeMapper = mapDoc => {
  ...Ast_mapper.default_mapper,
  structure: (mapper, items) => {
    let rec loop = (items) => switch items {
      | [] => []
      | [item, ...rest] => {
        let item = mapper.structure_item(mapper, item);
        switch (getDocStrings(item)) {
        | [] => [item, ...loop(rest)]
        | docStrings => switch (mapDoc(docStrings)) {
          | [] => [item, ...loop(rest)]
          | items => List.append([item, ...items], loop(rest))
          }
        }
      }
    };
    loop(items)
  }
};

let map = (mapDoc, structure) => {
  let mapper = makeMapper(mapDoc);
  mapper.structure(mapper, structure)
};
