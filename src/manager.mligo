

#include "token.mligo"

type change_tx =
[@layout:comb]
{
  owner : address;
  amount : nat;
}

type change_tx_param =  change_tx list

(* `token_manager` entry points *)
type token_manager =
  | Create_token of token_metadata
  | Mint_tokens of change_tx_param
  | Burn_tokens of change_tx_param

let create_token (metadata, storage
    : token_metadata * multi_token_storage) : multi_token_storage =
  (* extract token id *)
  let new_token_id = metadata.token_id in
  let existing_meta = Big_map.find_opt new_token_id storage.token_metadata in
  match existing_meta with
  | Some _m -> (failwith "FA2_DUP_TOKEN_ID" : multi_token_storage)
  | None ->
    let meta = Big_map.add new_token_id metadata storage.token_metadata in
    let supply = Big_map.add new_token_id 0n storage.token_total_supply in
    { storage with
      token_metadata = meta;
      token_total_supply = supply;
    }

