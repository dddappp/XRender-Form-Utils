module xrender_form_utils::date {
    use std::vector;

    const EInvalidYear: u64 = 101;
    const EInvalidMonth: u64 = 102;
    const EInvalidDay: u64 = 103;
    const EInvalidValuesLength: u64 = 104;

    const LessThan: u8 = 255;
    const GreaterThan: u8 = 1;
    const Equal: u8 = 0;

    struct Date has store, drop, copy {
        year: u16,
        month: u8,
        day: u8,
    }

    public fun value_of(values: vector<u16>): Date {
        assert!(vector::length(&values) == 3, EInvalidValuesLength);
        let year = *vector::borrow(&values, 0);
        let month = *vector::borrow(&values, 1);
        let day = *vector::borrow(&values, 2);
        new(
            year,
            (month as u8),
            (day as u8),
        )
    }

    public fun new(
        year: u16,
        month: u8,
        day: u8,
    ): Date {
        validate(year, month, day);
        Date {
            year,
            month,
            day,
        }
    }

    public fun compare(
        a: &Date,
        b: &Date,
    ): u8 {
        if (a.year > b.year) {
            return GreaterThan
        };
        if (a.year < b.year) {
            return LessThan
        };
        if (a.month > b.month) {
            return GreaterThan
        };
        if (a.month < b.month) {
            return LessThan
        };
        if (a.day > b.day) {
            return GreaterThan
        };
        if (a.day < b.day) {
            return LessThan
        };
        Equal
    }

    public fun less_than(): u8 {
        LessThan
    }

    fun validate(
        year: u16,
        month: u8,
        day: u8,
    ) {
        assert!(year >= 0 && year <= 9999, EInvalidYear);
        let days_in_month = days_in_month(year, month);
        assert!(day >= 1 && day <= days_in_month, EInvalidDay);
    }

    const DaysInMonth: vector<u8> = vector[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    fun days_in_month(year: u16, month: u8): u8 {
        assert!(month >= 1 && month <= 12, EInvalidMonth);
        if (month == 2 && is_leap_year(year)) {
            return 29
        };
        return *vector::borrow(&DaysInMonth, (month as u64) - 1)
    }

    fun is_leap_year(year: u16): bool {
        (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
}