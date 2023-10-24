module xrender_form_utils::time {
    use std::vector;

    const EInvalidHour: u64 = 101;
    const EInvalidMinute: u64 = 102;
    const EInvalidSecond: u64 = 103;
    const EInvalidValuesLength: u64 = 104;

    const LessThan: u8 = 255;
    const GreaterThan: u8 = 1;
    const Equal: u8 = 0;

    struct Time has store, drop, copy {
        hour: u8,
        minute: u8,
        second: u8,
    }

    public fun value_of(values: vector<u8>): Time {
        assert!(vector::length(&values) == 3, EInvalidValuesLength);
        let hour = *vector::borrow(&values, 0);
        let minute = *vector::borrow(&values, 1);
        let second = *vector::borrow(&values, 2);
        new(
            hour,
            minute,
            second,
        )
    }

    public fun new(
        hour: u8,
        minute: u8,
        second: u8,
    ): Time {
        validate(hour, minute, second);
        Time {
            hour,
            minute,
            second,
        }
    }

    public fun compare(
        a: &Time,
        b: &Time,
    ): u8 {
        if (a.hour > b.hour) {
            return GreaterThan
        };
        if (a.hour < b.hour) {
            return LessThan
        };
        if (a.minute > b.minute) {
            return GreaterThan
        };
        if (a.minute < b.minute) {
            return LessThan
        };
        if (a.second > b.second) {
            return GreaterThan
        };
        if (a.second < b.second) {
            return LessThan
        };
        Equal
    }

    public fun less_than(): u8 {
        LessThan
    }

    fun validate(
        hour: u8,
        minute: u8,
        second: u8,
    ) {
        assert!(hour >= 0 && hour <= 23, EInvalidHour);
        assert!(minute >= 0 && minute <= 59, EInvalidMinute);
        assert!(second >= 0 && second <= 59, EInvalidSecond);
    }
}