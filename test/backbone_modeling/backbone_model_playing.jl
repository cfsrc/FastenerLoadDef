
using JSON3, Dates, StructTypes, CairoMakie

#get file from repo
json_string = read(download("https://raw.githubusercontent.com/cfsrc/FastenerConnectionData/main/data/Zhang_2020_11.json"), String)


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

#plot data 



f = Figure()
Axis(f[1, 1])
scatterlines!(specimen.test.displacement, specimen.test.force)
f


#find peak
#find 40% of peak
#linear interpolation
# 40% 80% max 80% post-peak 

# are P and Δ zeroed?  if they aren't, then we deal with that too 

#inputs to neural network:  ply thickness, ply yield stress, ply elastic modulus, fastener diameter

#neural network
    # predict P @ 40% 80% max 80% post-peak 
    # predict Δ @ 40% 80% max 80% post-peak 


#model

#2 ply only...
#P, Δ = model(t1, t2, fy1, fy2, fu1, fu2, E1, E2, fastener_diameter)







