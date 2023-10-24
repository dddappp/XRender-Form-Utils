#[test_only]
module xrender_form_utils::time_tests {
    use aptos_std::debug;

    use xrender_form_utils::time_range;
    use xrender_form_utils::time;

    #[test]
    public fun test_new_times() {
        let _d1 = time::new(0, 1, 1);
        let _d2 = time::new(2, 8, 31);
        let _d3 = time::new(13, 2, 29);
        //debug::print(&d1);
    }

    #[test]
    #[expected_failure]
    public fun test_new_times_fail() {
        let _d1 = time::new(39, 1, 32);
    }

    #[test]
    #[expected_failure]
    public fun test_new_times_fail_2() {
        let _d3 = time::new(24, 200, 29);
    }

    #[test]
    public fun test_new_time_ranges() {
        let v1: vector<u8> = vector[20, 1, 1, 20, 2, 29];
        let _dr1 = time_range::value_of(v1);
        debug::print(&_dr1);
    }
}

