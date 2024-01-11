#[test_only]
module xrender_form_utils::random_tests {
    use aptos_framework::account::Self;
    use aptos_framework::timestamp;
    use aptos_std::debug;

    use xrender_form_utils::account_ts_random;

    #[test]
    public fun test_random_1() {
        let aptos_account = account::create_account_for_test(@aptos_framework);
        timestamp::set_time_has_started_for_testing(&aptos_account);
        let addr = @0x124979797979;
        let account = account::create_account_for_test(addr);
        let i = account_ts_random::next_int(&account, 3);
        debug::print(&i);
        let i = account_ts_random::next_int(&account, 256);
        debug::print(&i);
        timestamp::update_global_time_for_test(1000);
        let i = account_ts_random::next_int(&account, 256);
        debug::print(&i);
        timestamp::update_global_time_for_test(2000);
        let i = account_ts_random::next_int(&account, 256);
        debug::print(&i);
        timestamp::update_global_time_for_test(3000);
        let i = account_ts_random::next_int(&account, 256);
        debug::print(&i);
    }
}