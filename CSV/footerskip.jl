using Printf
using CSV

open("foo_rn.csv", "w") do io
    @printf(io, "1, a\r\n")
    @printf(io, "2, b\r\n")
    @printf(io, "3, c\r\n")
end

open("foo_n.csv", "w") do io
    @printf(io, "1, a\n")
    @printf(io, "2, b\n")
    @printf(io, "3, c\n")
end

CSV.File("foo_rn.csv"; skipto=1, footerskip=2)

CSV.File("foo_n.csv"; skipto=1, footerskip=2)