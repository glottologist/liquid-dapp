#include "manager.mligo"

type event  = Xtz_exchange_rate of nat

type treasury = Treasury of address * nat



type liquid_storage = {
  treasury : treasury;
  allocation : token_storage;
}

type liquid_param =
  | Deposit of nat
  | Redeem of nat


let liquid_main
    (param, s : liquid_param * liquid_storage)
    : (operation list) * liquid_storage = 
    match param with
    | Deposit n -> redeem_tokens n
    | Redeem n -> deposit_tokens n


let redeem_tokens n  =  ([] : operation list)
 (* 
   Calculate current exchange rate
   Burn evXTZ tokens
   Transfer XTZ from treasury 
   Emit new FX rate as event
 
 
   *)


let deposit_tokens n =   ([] : operation list)
(*
  Deposit XTZ in Wallet.
  Check current exchange rate
  Mint tokens
  Caculate new exchange rate 
  Emit new FX rate as event
*)