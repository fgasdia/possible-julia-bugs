using Printf
using CSV

# `footerskip`: number of rows at the end of a file to skip parsing.
# By default, `ignoreemptylines` is true

# Let's say I want to read rows 1, 2, 3

# Lines end in "\n" only
open("foo_n.csv", "w") do io
    @printf(io, "1, a\n")
    @printf(io, "2, b\n")
    @printf(io, "3, c\n")
    @printf(io, "4, d\n")
    @printf(io, "\n")
end

# on Windows, this reads rows 1, 2, 3???
# on Linux, this reads rows 1, 2, 3, 4
CSV.File("foo_n.csv"; skipto=1, footerskip=1)

# This doesn't happen without the extra blank line at the end.
# In practice, this problem occurs if there is a text line that we also want skipped
# at the end. Here's an example:
open("bar_n.csv", "w") do io
    @printf(io, "1, a\n")
    @printf(io, "2, b\n")
    @printf(io, "3, c\n")
    @printf(io, "\n")
    @printf(io, "ignore this line\n")
end

# In linux, this only reads rows 1, 2, 3
CSV.File("bar_n.csv"; skipto=1, footerskip=1)

# Lines end in "\r\n"
open("foo_rn.csv", "w") do io
    @printf(io, "1, a\r\n")
    @printf(io, "2, b\r\n")
    @printf(io, "3, c\r\n")
    @printf(io, "4, d\r\n")
    @printf(io, "\r\n")
end

# on Windows and Linux, this reads rows 1, 2, 3, 4
CSV.File("foo_rn.csv"; skipto=1, footerskip=1)
