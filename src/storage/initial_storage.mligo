{
            admin = {
              admin = ("tz1YPSCGWXwBdTncK2aCctSZAXWvGsGwVJqU" : address);
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