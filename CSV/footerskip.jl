using Printf
using CSV

# `footerskip`: number of rows at the end of a file to skip parsing.
# By default, `ignoreemptylines` is true

# Let's say I want to read rows 1, 2, 3

# MWE of original problem
open("bar_n.csv", "w") do io
    @printf(io, "1, a\n")
    @printf(io, "2, b\n")
    @printf(io, "3, c\n")
    @printf(io, "ignore this line\n")
    @printf(io, "\n")
    @printf(io, "and this line\n")
end

# BROKEN: In linux, this reads rows 1, 2, 3, and "ignore this line"
CSV.File("bar_n.csv"; skipto=1, footerskip=2)




# Lines end in "\n" only
open("foo_n.csv", "w") do io
    @printf(io, "1, a\n")
    @printf(io, "2, b\n")
    @printf(io, "3, c\n")
    @printf(io, "4, d\n")
    @printf(io, "\n")
end

# BROKEN: on Linux, this reads rows 1, 2, 3, 4
CSV.File("foo_n.csv"; skipto=1, footerskip=1)


# No difference if lines end in "\r\n"
open("foo_rn.csv", "w") do io
    @printf(io, "1, a\r\n")
    @printf(io, "2, b\r\n")
    @printf(io, "3, c\r\n")
    @printf(io, "4, d\r\n")
    @printf(io, "\r\n")
end

# BROKEN: on Windows and Linux, this reads rows 1, 2, 3, 4
CSV.File("foo_rn.csv"; skipto=1, footerskip=1)


# It works without the extra empty line at the end
open("foo2_n.csv", "w") do io
    @printf(io, "1, a\n")
    @printf(io, "2, b\n")
    @printf(io, "3, c\n")
    @printf(io, "4, d\n")
end

# WORKING: on Linux, this reads rows 1, 2, 3
CSV.File("foo2_n.csv"; skipto=1, footerskip=1)


# No difference if lines end in "\r\n"
open("foo2_rn.csv", "w") do io
    @printf(io, "1, a\r\n")
    @printf(io, "2, b\r\n")
    @printf(io, "3, c\r\n")
    @printf(io, "4, d\r\n")
end

# WORKING: on Linux, this reads rows 1, 2, 3
CSV.File("foo2_rn.csv"; skipto=1, footerskip=1)