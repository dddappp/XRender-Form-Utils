module xrender_form_utils::string_range {
    use std::string::String;
    use std::vector;

    struct StringRange has store, drop, copy {
        start: String,
        end: String,
    }

    public fun value_of(values: vector<String>): StringRange {
        let start = vector::borrow(&values, 0);
        let end = vector::borrow(&values, 1);
        new(*start, *end)
    }

    public fun new(
        start: String,
        end: String,
    ): StringRange {
        validate(&start, &end);
        let string_range = StringRange {
            start,
            end,
        };
        string_range
    }

    fun validate(start: &String, end: &String) {
        let _ = start;
        let _ = end;
    }

    public fun start(string_range: &StringRange): String {
        string_range.start
    }

    public fun end(string_range: &StringRange): String {
        string_range.end
    }
}

