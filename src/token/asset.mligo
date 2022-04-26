
#include "manager.mligo"
#include "admin.mligo"

type single_asset_storage = {
  admin : simple_admin_storage;
  assets : single_token_storage;
  metadata : contract_metadata;
}

type single_asset_param =
  | Assets of fa2_entry_points
  | Admin of simple_admin
  | Tokens of token_manager

let single_asset_main 
    (param, s : single_asset_param * single_asset_storage)
  : (operation list) * single_asset_storage =
  match param with
  | Admin p ->

    let ops, admin = simple_admin (p, s.admin) in
    let new_s = { s with admin = admin; } in
    (ops, new_s)

  | Tokens p ->
    let u1 = fail_if_not_admin s.admin in

    let ops, assets = token_manager (p, s.assets) in 
    let new_s = { s with assets = assets; } in 
    (ops, new_s)

  | Assets p -> 
    let u2 = fail_if_paused s.admin in

    let ops, assets = fa2_main (p, s.assets) in
    let new_s = { s with assets = assets; } in
    (ops, new_s)


(**
This is a sample initial fa2_single_asset storage.
 *)

let store : single_asset_storage = {
            admin = {
              admin = ("tz1iAUh2mga5rHX8RwdqgyZCDKESwLtsAngg" : address);
              pending_admin = (None : address option);
              paused = true;
            };
            assets = {
                ledger = (Big_map.empty : (address, nat) big_map);
                operators = (Big_map.empty : operator_storage);
                token_metadata = Big_map.literal [
                  ( 0n,
                    {
                      token_id = 0n;
                      token_info = Map.literal [
                        ("symbol", 0x544b31);
                        ("name", 0x5465737420546f6b656e);
                        ("decimals", 0x30);
                      ];
                    }
                  ); 
                ];
                total_supply = 0n;
            };
            metadata = Big_map.literal [
              ("", Bytes.pack "tezos-storage:content" );
              (* ("", 0x74657a6f732d73746f726167653a636f6e74656e74); *)
              ("content", 0x00) (* bytes encoded UTF-8 JSON *)
            ];
        }