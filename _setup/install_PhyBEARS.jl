
#######################################################
# Installing PhyBEARS
#
# PhyBEARS.jl is a package in the language Julia
#
# It has similar functions to BioGeoBEARS, but enables
# various new functionality:
#
# 1. It recasts all BioGeoBEARS models as special cases
#    of ClaSSE models (Cladogenetic State-Dependent 
#    Speciation-Extinction)
#
# 2. It uses Julia's DifferentialEquations library to
#    solve the large systems of Ordinary Differential
#    Equations (ODEs) involved in solving ClaSSE 
#    likelihoods for large numbers of areas.
#
# 3. It allows proper treatment of fossils by adding a
#    fossil-sampling process to the ClaSSE likelihoods
#
# 4. It allows dispersal, speciation, extinction, etc.
#    to be influenced by geographical variables such as
#    the distances between areas and the size of areas
#    (or the size of ecosystems/habitat types).
#
# 5. It allows paleodistances and other geographic
#    variables to change continuously in time, and to
#    have these continuously-changing variables influence
#    the ODEs and thus the ClaSSE likelihoods
#######################################################

#######################################################
# Installation
#######################################################
# Step 1: Install Julia:
#
# https://julialang.org/install/
#######################################################


#######################################################
# Step 2: Install dependencies:
# (This may take 5-20 minutes when done the first time)
#######################################################

import Pkg
using Pkg

Pkg.add("Compat")
Pkg.add("Preferences")

# PhyloBits dependencies
Pkg.add("DelimitedFiles")
Pkg.add("DataFrames")
Pkg.add("UUIDs")
Pkg.add("CSV")
Pkg.add("FilePathsBase")
Pkg.add("BenchmarkTools")
Pkg.add("SciMLBase")
Pkg.add("Distributed")
Pkg.add("Hwloc")
Pkg.add("Printf")
Pkg.add("SpecialFunctions")
Pkg.add("StaticArrays")
Pkg.add("StatsBase")

# PhyBEARS.jl dependencies
Pkg.add("Interpolations")
Pkg.add("RCall")
Pkg.add("Combinatorics")
Pkg.add("Dates")
Pkg.add("DiffEqNoiseProcess")
Pkg.add("Distributions")
Pkg.add("DoubleFloats")
Pkg.add("Interpolations")
Pkg.add("InvertedIndices")
Pkg.add("JLD2")
Pkg.add("LSODA")
Pkg.add("LinearAlgebra")
Pkg.add("NLopt")
Pkg.add("ODE")
Pkg.add("Optim")
Pkg.add("Polynomials")
Pkg.add("Random")
Pkg.add("Sundials")
Pkg.add("Test")
Pkg.add("DifferentialEquations")


# Loading them
using Compat
using Preferences

# PhyloBits dependencies
using DelimitedFiles
using DataFrames
using UUIDs
using CSV
using FilePathsBase
using BenchmarkTools
using SciMLBase
using Distributed
using Hwloc
using Printf
using SpecialFunctions
using StaticArrays
using StatsBase

# PhyBEARS.jl dependencies
using Combinatorics
using Dates
using DiffEqNoiseProcess
using Distributions
using DoubleFloats
using Interpolations
using InvertedIndices
using JLD2
using LSODA
using LinearAlgebra
using NLopt
using ODE
using Optim
using Polynomials
using Random
using Sundials
using Test
using DifferentialEquations

# Update, resolve, garbage collect (gc)
Pkg.update()
Pkg.resolve()
Pkg.gc()



#######################################################
# Step 3: Install PhyloBits
#
# PhyloBits is a small package that contains bits of code
# from PhyloNetworks for reading Newick files to 
# internal tree objects, plus various code written by
# Matzke to ease interpretation/use of phylogenies
#######################################################
Pkg.add(url="https://github.com/nmatzke/PhyloBits.jl")

using PhyloBits

using PhyloBits.PNtypes						# Types: Tree, Node, Edge etc.
using PhyloBits.PNmanipulateNet
using PhyloBits.PNreadwrite				# Helper functions
using PhyloBits.PNreadwrite 			# Reading and writing trees; readTopology
using PhyloBits.PNdescriptive			# show() commands for trees etc.
using PhyloBits.TrUtils						# basic utility functions, R-like functions
using PhyloBits.TreeTable					# for prt() tree tables (tree dataframes, trdfs), bd_liks(), etc.


#######################################################
# Step 4: Install PhyBEARS
#######################################################

print("Re-loading PhyBEARS...\n")

Pkg.add(url="https://github.com/nmatzke/PhyBEARS.jl")
using PhyBEARS

#using PhyloBits.TrUtils
#using PhyloBits.TreeTable
using PhyBEARS.BGExample
using PhyBEARS.TimeDep
using PhyBEARS.MaxentInterp
using PhyBEARS.StateSpace
using PhyBEARS.SSEs
using PhyBEARS.Parsers
using PhyBEARS.TreePass
using PhyBEARS.Flow
using PhyBEARS.Gmaps
using PhyBEARS.Optimizers

# Update, resolve, garbage collect (gc)
Pkg.update()
Pkg.resolve()
Pkg.gc()



#######################################################
# Step 5: Check if PhyBEARS is working
#######################################################

print("Checking if PhyloBits is working:\n")
print("\n")

# Check if updates are working
PhyloBits.TrUtils.hello_world_TrUtils()


print("\nChecking if PhyloBits.PNreadwrite.readTopology is working:\n")
print("\n")

# Psychotria tree
Psychotria_tree = readTopology("((((((((P_hawaiiensis_WaikamoiL1:0.9665748366,P_mauiensis_Eke:0.9665748366):0.7086257935,(P_fauriei2:1.231108298,P_hathewayi_1:1.231108298):0.4440923324):0.1767115552,(P_kaduana_PuuKukuiAS:1.851022399,P_mauiensis_PepeAS:1.851022399):0.0008897862802):0.3347375986,P_kaduana_HawaiiLoa:2.186649784):0.302349378,(P_greenwelliae07:1.132253042,P_greenwelliae907:1.132253042):1.35674612):1.689170274,((((P_mariniana_MauiNui:1.99490084,P_hawaiiensis_Makaopuhi:1.99490084):0.7328279804,P_mariniana_Oahu:2.72772882):0.2574151709,P_mariniana_Kokee2:2.985143991):0.4601084855,P_wawraeDL7428:3.445252477):0.732916959):0.7345185743,(P_grandiflora_Kal2:2.480190277,P_hobdyi_Kuia:2.480190277):2.432497733):0.2873119899,((P_hexandra_K1:2.364873976,P_hexandra_M:2.364873976):0.4630447802,P_hexandra_Oahu:2.827918756):2.372081244);")

show(Psychotria_tree)



#######################################################
# Test the birth-death likelihood calculation in bd_liks()
#######################################################
# These numbers come from: bd_liks() in ClaSSE_mods_v2.R
R_dev = -0.9741936
R_lnl_topology = 36.39545
R_lnl_numBirths = -18.90835
R_lnl_Births_above_root = 13.58031
R_lnl_numtips_wOneMinusDeathRate = 0.0
R_lnl_branching_times = -30.58031
R_lnL = 0.4870968

tr = readTopology("((((((((P_hawaiiensis_WaikamoiL1:0.9665748366,P_mauiensis_Eke:0.9665748366):0.7086257935,(P_fauriei2:1.231108298,P_hathewayi_1:1.231108298):0.4440923324):0.1767115552,(P_kaduana_PuuKukuiAS:1.851022399,P_mauiensis_PepeAS:1.851022399):0.0008897862802):0.3347375986,P_kaduana_HawaiiLoa:2.186649784):0.302349378,(P_greenwelliae07:1.132253042,P_greenwelliae907:1.132253042):1.35674612):1.689170274,((((P_mariniana_MauiNui:1.99490084,P_hawaiiensis_Makaopuhi:1.99490084):0.7328279804,P_mariniana_Oahu:2.72772882):0.2574151709,P_mariniana_Kokee2:2.985143991):0.4601084855,P_wawraeDL7428:3.445252477):0.732916959):0.7345185743,(P_grandiflora_Kal2:2.480190277,P_hobdyi_Kuia:2.480190277):2.432497733):0.2873119899,((P_hexandra_K1:2.364873976,P_hexandra_M:2.364873976):0.4630447802,P_hexandra_Oahu:2.827918756):2.372081244);")
birthRate=0.3288164   # ML birthRate for Psychotria tree
deathRate=0.0					# ML deathRate for Psychotria tree
bd = bd_liks(tr, birthRate, deathRate)


@test round(R_dev; digits=5) == round(bd.deviance; digits=5)
@test round(R_lnl_topology; digits=5) == round(bd.lnl_topology; digits=5)
@test round(R_lnl_numBirths; digits=5) == round(bd.lnl_numBirths; digits=5)
@test round(R_lnl_Births_above_root; digits=5) == round(bd.lnl_Births_above_root; digits=5)
@test round(R_lnl_numtips_wOneMinusDeathRate; digits=5) == round(bd.lnl_numtips_wOneMinusDeathRate; digits=5)
@test round(R_lnl_branching_times; digits=5) == round(bd.lnl_branching_times; digits=5)
@test round(R_lnL; digits=5) == round(bd.lnL; digits=5)


# These numbers come from: bd_liks() in ClaSSE_mods_v2.R
R_dev = 8.613706
R_lnl_topology = 0.6931472
R_lnl_numBirths = 0.0
R_lnl_Births_above_root = 1.0
R_lnl_numtips_wOneMinusDeathRate = 0.0
R_lnl_branching_times = -6.0
R_lnL = -4.306853

tr = readTopology("((chimp:1,human:1):1,gorilla:2);")
birthRate=1.0
deathRate=0.0
bd = bd_liks(tr, birthRate, deathRate)

@test round(R_dev; digits=5) == round(bd.deviance; digits=5)
@test round(R_lnl_topology; digits=5) == round(bd.lnl_topology; digits=5)
@test round(R_lnl_numBirths; digits=5) == round(bd.lnl_numBirths; digits=5)
@test round(R_lnl_Births_above_root; digits=5) == round(bd.lnl_Births_above_root; digits=5)
@test round(R_lnl_numtips_wOneMinusDeathRate; digits=5) == round(bd.lnl_numtips_wOneMinusDeathRate; digits=5)
@test round(R_lnl_branching_times; digits=5) == round(bd.lnl_branching_times; digits=5)
@test round(R_lnL; digits=5) == round(bd.lnL; digits=5)

