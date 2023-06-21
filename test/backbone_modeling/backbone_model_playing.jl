
using JSON3, Dates, StructTypes, CairoMakie

#get file from repo
json_string = read(download("https://raw.githubusercontent.com/cfsrc/FastenerConnectionData/main/data/Zhang_2020_23.json"), String)


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

P3 = maximum(specimen.test.force)
Δ3 = specimen.test.displacement[argmax(specimen.test.force)]

P2 = 0.8 * P3

P_pre_peak_indices = findall(disp->disp<=Δ3, specimen.test.displacement)
P_pre_peak = specimen.test.force[P_pre_peak_indices]

difference = abs.(P_pre_peak .- 0.8 * P3)

sorted_difference = sort(difference)

closest_difference = sorted_difference[1:2]

closest_index = [findall(diff->diff==closest_difference[i], difference) for i in eachindex(closest_difference)]

δ1 = specimen.test.displacement[closest_index[1]][1]
δ2 = specimen.test.displacement[closest_index[2]][1]

p1 = specimen.test.force[closest_index[1]][1]
p2 = specimen.test.force[closest_index[2]][1]

slope = (p2 - p1) \ (δ2 - δ1)

Δ2 = δ1 + P2 \ slope

#need P1, Δ1 
#need P4, Δ4
#need P5, Δ5







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







