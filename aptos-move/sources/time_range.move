module xrender_form_utils::time_range {
    use std::vector;

    use xrender_form_utils::time::{Self, Time};

    const EInvalidTimeRange: u64 = 101;
    const EInvalidValuesLength: u64 = 104;


    struct TimeRange has store, drop, copy {
        start: Time,
        end: Time,
    }

    public fun value_of(values: vector<u8>): TimeRange {
        assert!(vector::length(&values) == 6, EInvalidValuesLength);
        let start = vector::empty<u8>();
        vector::push_back(&mut start, *vector::borrow(&values, 0));
        vector::push_back(&mut start, *vector::borrow(&values, 1));
        vector::push_back(&mut start, *vector::borrow(&values, 2));
        let end = vector::empty<u8>();
        vector::push_back(&mut end, *vector::borrow(&values, 3));
        vector::push_back(&mut end, *vector::borrow(&values, 4));
        vector::push_back(&mut end, *vector::borrow(&values, 5));
        new(
            time::value_of(start),
            time::value_of(end),
        )
    }

    public fun new(
        start: Time,
        end: Time,
    ): TimeRange {
        validate(&start, &end);
        let time_range = TimeRange {
            start,
            end,
        };
        time_range
    }

    fun validate(start: &Time, end: &Time) {
        let c = time::compare(end, start);
        assert!(c != time::less_than(), EInvalidTimeRange);
    }

    public fun start(time_range: &TimeRange): Time {
        time_range.start
    }

    public fun end(time_range: &TimeRange): Time {
        time_range.end
    }
}

