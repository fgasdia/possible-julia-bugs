using CSV

file = "footerskip.csv"
raw = CSV.File(file; skipto=3, footerskip=3)