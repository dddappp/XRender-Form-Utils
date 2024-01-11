module xrender_form_utils::account_ts_random {
    use std::bcs;
    use std::hash;
    use std::signer;
    use std::vector;
    use aptos_framework::account;
    use aptos_framework::timestamp;
    use aptos_std::from_bcs;

    public fun next_int(account: &signer, bound: u64): u64 {
        let addr = signer::address_of(account);
        let bs = vector::empty<u8>();
        vector::append(&mut bs, bcs::to_bytes(&addr));
        vector::append(&mut bs, bcs::to_bytes(&account::get_sequence_number(addr)));
        vector::append(&mut bs, bcs::to_bytes(&timestamp::now_microseconds()));
        let hash = hash::sha3_256(bs);
        (from_bcs::to_u256(hash) % (bound as u256) as u64)
    }
}
