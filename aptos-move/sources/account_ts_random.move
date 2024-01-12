module xrender_form_utils::account_ts_random {
    use std::bcs;
    use std::hash;
    use std::signer;
    use std::vector;
    use aptos_framework::account;
    use aptos_framework::timestamp;
    use aptos_std::from_bcs;

    const EAmountLessThanShares: u64 = 50;

    public fun next_int(account: &signer, bound: u64): u64 {
        let addr = signer::address_of(account);
        let bs = vector::empty<u8>();
        vector::append(&mut bs, bcs::to_bytes(&addr));
        vector::append(&mut bs, bcs::to_bytes(&account::get_sequence_number(addr)));
        vector::append(&mut bs, bcs::to_bytes(&timestamp::now_microseconds()));
        let hash = hash::sha3_256(bs);
        (from_bcs::to_u256(hash) % (bound as u256) as u64)
    }

    public fun random_amount(
        account: &signer,
        total_amount: u64, // Total (remaining) amount
        total_shares: u64, // Number of total (remaining) shares
        max_shares: u64, // Maximum number of shares per account
        min_amount: u64, // Minimum amount
    ): u64 {
        if (total_shares == 1) {
            return total_amount
        };
        if (total_amount == total_shares) {
            return 1
        };
        assert!(total_amount > total_shares, EAmountLessThanShares);
        let max_shares = if (max_shares > total_shares) { total_shares } else { max_shares };
        max_shares = if (max_shares == 0) { 1 } else { max_shares };
        let max_amount = total_amount / total_shares * max_shares;
        max_amount = if (max_amount > total_amount - total_shares) { total_amount - total_shares } else { max_amount };
        if (max_amount == 1) {
            return 1
        };
        let min_amount = if (min_amount >= max_amount) { max_amount - 1 } else { min_amount };
        let bound = max_amount - min_amount;
        next_int(account, bound) + min_amount
    }
}
