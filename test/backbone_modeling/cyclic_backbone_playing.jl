

using JSON3, Dates, StructTypes, CairoMakie

#get file from repo
json_string = read(download("https://raw.githubusercontent.com/cfsrc/FastenerConnectionData/main/data/Zhang_2020_10.json"), String)


#define data structure
struct Source
authors::Array{String}
date::Date
title::String
bibtex::String
units::Array{String}
nominal_data::Vector{String}
end

struct Fastener
type::Vector{String}
details::Vector{Dict}
end

struct Ply
type::Vector{String}
thickness::Array{Float64}
elastic_modulus::Array{Float64}
yield_stress::Array{Float64}
ultimate_stress::Array{Float64}
end

struct Test
name::String
loading::String
force::Array{Float64}
displacement::Array{Float64}
end

struct Specimen
source::Source
fastener::Fastener
ply::Ply
test::Test
end

#define data type to convert JSON
StructTypes.StructType(::Type{Specimen}) = StructTypes.Struct()

#read raw data into data structure
specimen = JSON3.read(json_string, Specimen)


specimen.test.displacement
specimen.test.force


bins = [findall(x->isapprox(x, specimen.test.displacement[i], rtol=0.5), specimen.test.displacement) for i in eachindex(specimen.test.displacement)]

max_x = [specimen.test.displacement[bins[i][1]] for i in eachindex(bins)]
max_y = [maximum(specimen.test.force[bins[i]]) for i in eachindex(bins)]

