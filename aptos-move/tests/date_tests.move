#[test_only]
module xrender_form_utils::date_tests {
    use aptos_std::debug;

    use xrender_form_utils::date_range;
    use xrender_form_utils::date;

    #[test]
    public fun test_new_dates() {
        let _d1 = date::new(2020, 1, 1);
        let _d2 = date::new(2020, 8, 31);
        let _d3 = date::new(2020, 2, 29);
        //debug::print(&d1);
    }

    #[test]
    #[expected_failure]
    public fun test_new_dates_fail() {
        let _d1 = date::new(2020, 1, 32);
    }

    #[test]
    #[expected_failure]
    public fun test_new_dates_fail_2() {
        let _d3 = date::new(2021, 2, 29);
    }

    #[test]
    public fun test_new_date_ranges() {
        let v1: vector<u16> = vector[2020, 1, 1, 2020, 2, 29];
        let _dr1 = date_range::value_of(v1);
        debug::print(&_dr1);
    }
}

