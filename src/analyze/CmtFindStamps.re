module T = {
  type pathType = PrintType.pathType = PModule | PModuleType | PValue | PType;
  type fullPath = (string, list(string), pathType);
  type stamps = list((int, fullPath));
};
open T;

open PrepareUtils;

let rec stampsFromTypesSignature = (currentPath, types) => {
  open Types;
  foldOpt(item => switch item {
  | Sig_value({stamp, name}, {val_type, val_kind}) => Some((stamp, addToPath(currentPath, name) |> toFullPath(PValue)))
  | Sig_type({stamp, name}, decl, _) => Some((stamp, addToPath(currentPath, name) |> toFullPath(PType)))
  | Sig_modtype({stamp, name}, _) => Some((stamp, addToPath(currentPath, name) |> toFullPath(PModule)))
  | _ => None
  }, types, [])
};

let rec stampsFromTypedtreeInterface = (currentPath, types) => {
  open Typedtree;
  List.fold_left((items, item) => {
      let more = switch (item.sig_desc) {
      | Tsig_value({val_id: {stamp, name}}) => [(stamp, addToPath(currentPath, name) |> toFullPath(PValue))]
      | Tsig_type(decls) => List.map(({typ_id: {stamp, name}}) => (stamp, addToPath(currentPath, name) |> toFullPath(PType)), decls)
      | Tsig_include({incl_mod, incl_type}) => stampsFromTypesSignature(currentPath, incl_type)
      | Tsig_module({md_id: {stamp, name}, md_type: {mty_desc: Tmty_signature(signature)}}) => {
        let (stamps) = stampsFromTypedtreeInterface(addToPath(currentPath, name), signature.sig_items);
        [(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps]
      }
      | Tsig_module({md_id: {stamp, name}}) => [(stamp, addToPath(currentPath, name) |> toFullPath(PModule))]
      | _ => []
      };
      more @ items
  }, [], types)
};

let rec stampsFromTypedtreeImplementation = (currentPath, types) => {
  open Typedtree;
  List.fold_left((items, item) => {
      let more = switch (item.str_desc) {
      | Tstr_value(_rec, bindings) => (
        bindings |> filterNil(binding => switch binding {
        | {vb_pat: {pat_desc: Tpat_var({stamp, name}, _)}} => Some((stamp, addToPath(currentPath, name) |> toFullPath(PValue)))
        | _ => None
        }),
      )
      | Tstr_type(decls) => List.map(({typ_id: {stamp, name}}) => (stamp, addToPath(currentPath, name) |> toFullPath(PType)), decls)
      | Tstr_module({mb_id: {stamp, name}, mb_expr: {mod_type, mod_desc: Tmod_structure(structure) | Tmod_constraint({mod_desc: Tmod_structure(structure)}, _, _, _)}})
       => {
        let (stamps) = stampsFromTypedtreeImplementation(addToPath(currentPath, name), structure.str_items);
        [(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps]
      }
      | Tstr_modtype({mtd_id: {stamp, name}, mtd_type: Some({mty_desc: Tmty_signature(signature), mty_type})}) => {
        let (stamps) = stampsFromTypedtreeInterface(addToPath(currentPath, name), signature.sig_items);
        [(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps]
      }
      | Tstr_module({mb_id: {stamp, name}}) => [(stamp, addToPath(currentPath, name) |> toFullPath(PModule))]
      | Tstr_include({incl_loc, incl_mod, incl_attributes, incl_type}) => {
        stampsFromTypesSignature(currentPath, incl_type)
      }
      | _ => []
      };
      more @ items
  }, [], types)
};
