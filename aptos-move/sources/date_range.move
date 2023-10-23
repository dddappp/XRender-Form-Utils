module xrender_form_utils::date_range {
    use std::vector;

    use xrender_form_utils::date::{Self, Date};

    const EInvalidDateRange: u64 = 101;
    const EInvalidValuesLength: u64 = 104;


    struct DateRange has store, drop, copy {
        start: Date,
        end: Date,
    }

    public fun value_of(values: vector<u16>): DateRange {
        assert!(vector::length(&values) == 6, EInvalidValuesLength);
        let start = vector::empty<u16>();
        vector::push_back(&mut start, *vector::borrow(&values, 0));
        vector::push_back(&mut start, *vector::borrow(&values, 1));
        vector::push_back(&mut start, *vector::borrow(&values, 2));
        let end = vector::empty<u16>();
        vector::push_back(&mut end, *vector::borrow(&values, 3));
        vector::push_back(&mut end, *vector::borrow(&values, 4));
        vector::push_back(&mut end, *vector::borrow(&values, 5));
        new(
            date::value_of(start),
            date::value_of(end),
        )
    }

    public fun new(
        start: Date,
        end: Date,
    ): DateRange {
        validate(&start, &end);
        let date_range = DateRange {
            start,
            end,
        };
        date_range
    }

    fun validate(start: &Date, end: &Date) {
        let c = date::compare(end, start);
        assert!(c != date::less_than(), EInvalidDateRange);
    }

    public fun start(date_range: &DateRange): Date {
        date_range.start
    }

    public fun end(date_range: &DateRange): Date {
        date_range.end
    }
}

