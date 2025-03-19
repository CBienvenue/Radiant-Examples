"""
    get_lockwood_data(N_benchmark::Int64)

Get the data from Lockwood's benchmarks.

# Input Argument(s)
- `N_benchmark::Int64` : number corresponding to the following Lockwood's benchmark:
    - `1`  : Be - 1.033 MeV
    - `2`  : Be - 0.521 MeV
    - `3`  : Be - 0.314 MeV
    - `4`  : Be - 0.109 MeV
    - `5`  : Be - 0.058 MeV
    - `6`  : C - 1.0 MeV
    - `7`  : Al - 1.033 MeV
    - `8`  : Al - 0.521 MeV
    - `9`  : Al - 0.314 MeV
    - `10` : Fe - 1.0 MeV
    - `11` : Fe - 0.5 MeV
    - `12` : Fe - 0.3 MeV
    - `13` : Cu - 1.0 MeV
    - `14` : Cu - 0.5 MeV
    - `15` : Cu - 0.3 MeV
    - `16` : Mo - 1.0 MeV
    - `17` : Mo - 0.5 MeV
    - `18` : Mo - 0.3 MeV
    - `19` : Mo - 0.1 MeV
    - `20` : Ta - 1.033 MeV
    - `21` : Ta - 0.521 MeV
    - `22` : Ta - 0.314 MeV
    - `23` : U - 1.0 MeV
    - `24` : U - 0.5 MeV
    - `25` : U - 0.3 MeV
    - `26` : Be/Au/Be - 1.0 MeV
    - `27` : C/Cu/C - 1.0 MeV
    - `28` : C/Ta/C - 1.0 MeV
    - `29` : C/Au/C - 1.0 MeV
    - `30` : C/U/C - 1.0 MeV
    - `31` : Al/Au/Al - 1.0 MeV

# Output Argument(s)
- `materials::Vector{String}` : list of the materials composing the slab assembly.
- `energy::Float64` : energy of the normally incident electrons [in MeV].
- `x::Vector{Float64}` : position of the experimental data in the slab assembly [in cm].
- `dose::Vector{Float64}` : experimental energy deposition [in MeV/g × cm²].
- `uncertainty::Vector{Float64}` : experimental uncertainty [in MeV/g × cm²].
- `bounds::Vector{Float64}`: slab boundaries.

# Reference(s)
- Lockwood (1980), Calorimetric Measurement of Electron Energy Deposition in Extended
  Media - Theory vs Experiment.

"""
function get_lockwood_data(N_benchmark::Int64)

    # Benchmark parameters -------------------------
    if N_benchmark == 1
        materials = ["be"] 
        energy = 1.033
    elseif N_benchmark == 2
        materials = ["be"] 
        energy = 0.521
    elseif N_benchmark == 3
        materials = ["be"] 
        energy = 0.314
    elseif N_benchmark == 4
        materials = ["be"] 
        energy = 0.109
    elseif N_benchmark == 5
        materials = ["be"] 
        energy = 0.058
    elseif N_benchmark == 6
        materials = ["c"] 
        energy = 1.0
    elseif N_benchmark == 7
        materials = ["al"] 
        energy = 1.033
    elseif N_benchmark == 8
        materials = ["al"] 
        energy = 0.521
    elseif N_benchmark == 9
        materials = ["al"] 
        energy = 0.314
    elseif N_benchmark == 10
        materials = ["fe"] 
        energy = 1.0
    elseif N_benchmark == 11
        materials = ["fe"] 
        energy = 0.5
    elseif N_benchmark == 12
        materials = ["fe"] 
        energy = 0.3
    elseif N_benchmark == 13
        materials = ["cu"] 
        energy = 1.0
    elseif N_benchmark == 14
        materials = ["cu"] 
        energy = 0.5
    elseif N_benchmark == 15
        materials = ["cu"] 
        energy = 0.3
    elseif N_benchmark == 16
        materials = ["mo"] 
        energy = 1.0
    elseif N_benchmark == 17
        materials = ["mo"] 
        energy = 0.5
    elseif N_benchmark == 18
        materials = ["mo"] 
        energy = 0.3
    elseif N_benchmark == 19
        materials = ["mo"] 
        energy = 0.1
    elseif N_benchmark == 20
        materials = ["ta"] 
        energy = 1.033
    elseif N_benchmark == 21
        materials = ["ta"] 
        energy = 0.521
    elseif N_benchmark == 22
        materials = ["ta"] 
        energy = 0.314
    elseif N_benchmark == 23
        materials = ["u"] 
        energy = 1.0
    elseif N_benchmark == 24
        materials = ["u"] 
        energy = 0.5
    elseif N_benchmark == 25
        materials = ["u"] 
        energy = 0.3
    elseif N_benchmark == 26
        materials = ["be","au","be"] 
        energy = 1.0
    elseif N_benchmark == 27
        materials = ["c","u","c"] 
        energy = 1.0
    elseif N_benchmark == 28
        materials = ["c","ta","c"] 
        energy = 1.0
    elseif N_benchmark == 29
        materials = ["c","au","c"] 
        energy = 1.0
    elseif N_benchmark == 30
        materials = ["c","u","c"] 
        energy = 1.0
    elseif N_benchmark == 31
        materials = ["al","au","al"] 
        energy = 1.0
    else
        error("Unknown benchmark.")
    end

    if materials == ["be"] && energy == 1.033

        x = [0.004,0.025,0.049,0.069,0.089,0.109,0.128,0.150,0.174,0.213,0.257,0.298,0.328,0.345,0.353,0.413,0.492,0.499,0.575,0.648,0.733,0.822,0.907,0.968,1.059] .* 5.54e-1./ Radiant.density(Radiant.atomic_number("be"))
        dose = [1.38,1.49,1.55,1.65,1.64,1.70,1.74,1.83,1.83,1.99,2.10,2.24,2.23,2.37,2.38,2.51,2.61,2.61,2.49,2.25,1.79,1.17,0.54,0.18,0.05]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["be"] && energy == 0.521

        x = [0.011,0.061,0.120,0.170,0.219,0.268,0.316,0.369,0.431,0.471,0.525,0.634,0.736,0.811,0.853,0.872,1.019] .* 2.24e-1 ./ Radiant.density(Radiant.atomic_number("be"))
        dose = [1.67,1.87,2.03,2.22,2.45,2.73,2.85,3.09,3.19,3.32,3.24,2.98,2.26,1.80,1.32,1.07,0.14]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["be"] && energy == 0.314

        x = [0.022,0.128,0.251,0.355,0.459,0.563,0.662,0.773,0.901,0.985] .* 1.07e-1 ./ Radiant.density(Radiant.atomic_number("be"))
        dose = [2.01,2.52,3.15,3.78,4.10,4.18,3.65,2.68,1.09,0.26]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["be"] && energy == 0.109

        x = [0.127,0.353,0.499,0.608,0.726,0.819,0.973,1.083] .* 1.89e-2 ./ Radiant.density(Radiant.atomic_number("be"))
        dose = [4.59,6.98,7.87,7.50,5.74,4.51,1.86,0.76]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["be"] && energy == 0.058

        x = [0.396,1.104] .* 6.04e-3 ./ Radiant.density(Radiant.atomic_number("be"))
        dose = [10.023,2.99]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["c"] && energy == 1.0

        x = [0.016,0.107,0.198,0.289,0.378,0.472,0.568,0.673,0.781,0.883] .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c"))
        dose = [1.66,2.09,2.50,2.89,3.03,2.98,2.64,1.97,1.21,0.49]
        uncertainty = 0.02 .* dose
        bounds = [0.0,1.2*x[end]]
    
    elseif materials == ["al"] && energy == 1.033

        x = [0.0045,0.0165,0.0317,0.0448,0.0591,0.0707,0.0836,0.0987,0.115,0.127,0.142,0.174,0.195,0.221,0.253,0.280,0.320,0.373,0.391,0.431,0.443,0.511,0.552,0.621,0.736,0.846] .* 5.69e-1 ./ Radiant.density(Radiant.atomic_number("al"))
        dose = [1.63,1.87,2.01,2.12,2.28,2.37,2.45,2.64,2.73,2.80,2.88,3.17,3.22,3.28,3.28,3.25,3.11,2.87,2.76,2.52,2.43,1.93,1.63,1.09,0.42,0.08]
        uncertainty = 0.014 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["al"] && energy == 0.521

        x = [0.0108,0.0403,0.0771,0.109,0.143,0.173,0.203,0.242,0.279,0.308,0.345,0.424,0.475,0.538,0.615,0.682,0.780,0.908,0.953] .* 2.34e-1 ./ Radiant.density(Radiant.atomic_number("al"))
        dose = [2.11,2.58,3.07,3.40,3.81,3.90,4.05,4.08,3.91,3.87,3.66,3.07,2.62,2.10,1.34,0.81,0.30,0.04,0.00]
        uncertainty = 0.014 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["al"] && energy == 0.314

        x = [0.0224,0.0831,0.160,0.226,0.297,0.357,0.422,0.501,0.579,0.638,0.717,0.879] .* 1.13e-1 ./ Radiant.density(Radiant.atomic_number("al"))
        dose = [2.82,3.91,4.67,4.92,4.90,4.40,3.77,3.08,2.00,1.54,0.76,0.08]
        uncertainty = 0.014 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["fe"] && energy == 1.0

        x = [0.016,0.048,0.078,0.111,0.142,0.174,0.186,0.218,0.248,0.312,0.388,0.451,0.526,0.586,0.652] .* 6.06e-1 ./ Radiant.density(Radiant.atomic_number("fe"))
        dose = [2.12,2.78,3.12,3.37,3.50,3.41,3.32,3.14,2.90,2.43,1.79,1.30,0.77,0.42,0.19]
        uncertainty = 0.012 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["fe"] && energy == 0.5

        x = [0.039,0.118,0.191,0.270,0.345,0.424,0.531,0.603,0.687] .* 2.49e-1 ./ Radiant.density(Radiant.atomic_number("fe"))
        dose = [2.99,4.08,3.99,3.37,2.68,1.78,0.87,0.54,0.21]
        uncertainty = 0.012 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["fe"] && energy == 0.3

        x = [0.081,0.244,0.385,0.558,0.714] .* 1.21e-1 ./ Radiant.density(Radiant.atomic_number("fe"))
        dose = [4.43,4.34,2.66,0.95,0.19]
        uncertainty = 0.012 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["cu"] && energy == 1.0

        x = [0.017,0.035,0.053,0.071,0.090,0.109,0.126,0.144,0.163,0.184,0.212,0.248,0.284,0.361,0.433,0.506,0.579,0.647,0.719] .* 6.25e-1 ./ Radiant.density(Radiant.atomic_number("cu"))
        dose = [2.25,2.62,2.97,3.24,3.48,3.53,3.59,3.56,3.49,3.41,3.26,3.06,2.73,2.00,1.39,0.83,0.42,0.20,0.07]
        uncertainty = 0.013 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["cu"] && energy == 0.5

        x = [0.042,0.086,0.129,0.173,0.220,0.264,0.307,0.351,0.397,0.447,0.516,0.602,0.689] .* 2.58e-1 ./ Radiant.density(Radiant.atomic_number("cu"))
        dose = [3.39,4.14,4.33,4.14,3.80,3.35,2.88,2.37,1.87,1.35,0.89,0.41,0.13]
        uncertainty = 0.013 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["cu"] && energy == 0.3

        x = [0.087,0.178,0.266,0.357,0.453,0.544,0.632,0.723] .* 1.25e-1 ./ Radiant.density(Radiant.atomic_number("cu"))
        dose = [4.77,4.95,4.04,2.80,1.64,0.78,0.31,0.09]
        uncertainty = 0.013 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["mo"] && energy == 1.0

        x = [0.004,0.012,0.022,0.048,0.088,0.122,0.159,0.198,0.240,0.280,0.319,0.400,0.476,0.555,0.632] .* 6.73e-1 ./ Radiant.density(Radiant.atomic_number("mo"))
        dose = [1.99,2.30,2.68,3.40,3.77,3.78,3.45,3.04,2.64,2.18,1.75,1.03,0.50,0.19,0.05]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["mo"] && energy == 0.5

        x = [0.008,0.028,0.052,0.083,0.118,0.171,0.212,0.293,0.382,0.475,0.575,0.871] .* 2.81e-1 ./ Radiant.density(Radiant.atomic_number("mo"))
        dose = [2.48,3.27,3.99,4.31,4.40,3.87,3.39,2.37,1.24,0.53,0.14,0.02]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["mo"] && energy == 0.3

        x = [0.019,0.041,0.058,0.106,0.139,0.171,0.210,0.241,0.291,0.350,0.434,0.482,0.546,0.599] .* 1.37e-1 ./ Radiant.density(Radiant.atomic_number("mo"))
        dose = [3.35,4.63,4.78,4.99,4.68,4.44,3.88,3.48,2.66,1.80,0.96,0.56,0.27,0.11]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["mo"] && energy == 0.1

        x = [0.108,0.230,0.264,0.324,0.385,0.446,0.480,0.531,0.591,0.653,1.342] .* 2.46e-2 ./ Radiant.density(Radiant.atomic_number("mo"))
        dose = [8.03,6.23,5.98,4.41,2.76,1.84,1.52,0.97,0.52,0.29,0.00]
        uncertainty = 0.016 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["ta"] && energy == 1.033

        x = [0.013,0.015,0.018,0.020,0.027,0.034,0.045,0.057,0.070,0.091,0.120,0.170,0.221,0.305,0.426] .* 7.88e-1 ./ Radiant.density(Radiant.atomic_number("ta"))
        dose = [2.44,2.65,2.90,2.95,3.17,3.36,3.56,3.75,3.75,3.56,3.29,2.60,1.81,0.88,0.17]
        uncertainty = 0.012 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["ta"] && energy == 0.521

        x = [0.029,0.037,0.042,0.048,0.063,0.078,0.104,0.133,0.163,0.212,0.279,0.396,0.577,0.710] .* 3.38e-1 ./ Radiant.density(Radiant.atomic_number("ta"))
        dose = [3.40,3.72,3.88,3.95,4.20,4.02,3.78,3.40,2.89,2.10,1.17,0.27,0.0,0.0]
        uncertainty = 0.012 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["ta"] && energy == 0.314

        x = [0.060,0.076,0.087,0.097,0.129,0.159,0.210,0.271,0.331,0.429,0.566] .* 1.67e-1 ./ Radiant.density(Radiant.atomic_number("ta"))
        dose = [4.32,4.38,4.32,4.23,3.92,3.41,2.52,1.54,0.82,0.22,0.02]
        uncertainty = 0.012 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["u"] && energy == 1.0

        x = [0.010,0.016,0.017,0.023,0.029,0.034,0.040,0.049,0.061,0.074,0.096,0.120,0.142,0.167,0.194,0.228,0.264,0.303,0.338,0.374] .* 8.09e-1 ./ Radiant.density(Radiant.atomic_number("u"))
        dose = [2.77,3.05,3.20,3.43,3.59,3.75,3.85,3.72,3.59,3.56,3.26,3.00,2.63,2.25,1.68,1.36,0.85,0.58,0.32,0.15]
        uncertainty = 0.014 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["u"] && energy == 0.5

        x = [0.022,0.037,0.038,0.053,0.067,0.079,0.094,0.115,0.141,0.172,0.223,0.278,0.330,0.387] .* 3.48e-1 ./ Radiant.density(Radiant.atomic_number("u"))
        dose = [3.61,4.37,4.09,4.31,4.13,4.07,3.63,3.49,2.89,2.35,1.35,0.83,0.35,0.13]
        uncertainty = 0.014 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["u"] && energy == 0.3

        x = [0.044,0.075,0.077,0.105,0.135,0.158,0.188,0.230,0.284,0.345,0.448] .* 1.74e-1 ./ Radiant.density(Radiant.atomic_number("u"))
        dose = [4.69,4.73,4.67,4.42,3.68,3.04,2.33,1.72,0.84,0.35,0.04]
        uncertainty =  0.014 .* dose
        bounds = [0.0,1.2*x[end]]

    elseif materials == ["be","au","be"] && energy == 1.0

        x = [
            [0.005,0.030,0.048,0.066,0.086,0.103,0.121,0.138,0.155,0.174,0.181,0.207] .* 5.36e-1 ./ Radiant.density(Radiant.atomic_number("be")) ;
            ([0.220,0.239,0.257] .- 0.21031) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au")) .+ 0.21031 .* 5.36e-1 ./ Radiant.density(Radiant.atomic_number("be"))  ;
            ([0.272,0.27,0.369,0.415,0.463,0.510,0.552,0.598,0.641,0.688,0.730,0.776,0.823,0.910] .- 0.26619) .* 5.36e-1 ./ Radiant.density(Radiant.atomic_number("be")) .+ 0.21031 .* 5.36e-1 ./ Radiant.density(Radiant.atomic_number("be")) .+ (0.26619-0.21031) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au"))
            ]
        dose = [1.94,2.15,2.22,2.33,2.45,2.50,2.57,2.62,2.69,2.76,2.84,3.04,2.44,2.57,2.08,2.33,2.02,1.92,1.82,1.66,1.56,1.44,1.30,1.12,0.95,0.77,0.60,0.42,0.15]
        uncertainty = [0.016 .*dose[1:12]; 0.015 .*dose[13:15];0.016 .*dose[16:end]]
        bounds = [0.0,0.21031 .* 5.36e-1 ./ Radiant.density(Radiant.atomic_number("be")),0.21031 .* 5.36e-1 ./ Radiant.density(Radiant.atomic_number("be")) .+ (0.26619-0.21031) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au")),1.2*x[end]]

    elseif materials == ["c","cu","c"] && energy == 1.0

        x = [
            [0.016,0.044,0.067,0.095,0.124,0.152] .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) ;
            ([0.186,0.221,0.256] .- 0.169475) .* 6.25e-1 ./ Radiant.density(Radiant.atomic_number("cu")) .+ 0.169475 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c"))  ;
            ([0.289,0.340,0.392,0.444,0.496,0.565,0.646,0.726,0.803,0.884] .- 0.272868) .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ 0.169475 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.272868-0.169475) .* 6.25e-1 ./ Radiant.density(Radiant.atomic_number("cu"))
            ]
        dose = [2.15,2.36,2.53,2.68,2.88,3.03,2.65,2.88,2.67,3.06,3.00,2.82,2.60,2.39,2.04,1.60,1.08,0.64,0.30]
        uncertainty = [0.02 .* dose[1:6]; 0.013 .* dose[7:9];0.02 .* dose[10:end]]
        bounds = [0.0,0.169475 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")),0.169475 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.272868-0.169475) .* 6.25e-1 ./ Radiant.density(Radiant.atomic_number("cu")),1.2*x[end]]

    elseif materials == ["c","ta","c"] && energy == 1.0

        x = [
            [0.016,0.044,0.072,0.105,0.133] .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) ;
            ([0.160,0.175,0.190] .- 0.14674) .* 7.63e-1 ./ Radiant.density(Radiant.atomic_number("ta")) .+ 0.14674 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c"))  ;
            ([0.218,0.269,0.320,0.372,0.424,0.494,0.574,0.654,0.728,0.808] .- 0.2) .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ 0.14674 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.2-0.14674) .* 7.63e-1 ./ Radiant.density(Radiant.atomic_number("ta"))
            ]
        dose = [2.38,2.59,2.80,3.02,3.41,2.29,2.38,2.15,3.27,2.88,2.89,2.58,2.38,2.09,1.66,1.27,0.87,0.48]
        uncertainty = [0.02 .* dose[1:5]; 0.012 .* dose[6:8];0.02 .* dose[9:end]]
        bounds = [0.0,0.14674 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")),0.14674 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.2-0.14674) .* 7.63e-1 ./ Radiant.density(Radiant.atomic_number("ta")),1.2*x[end]]

    elseif materials == ["c","au","c"] && energy == 1.0

        x = [
            [0.016,0.049,0.081,0.110,0.138,0.166] .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) ;
            ([0.191,0.210,0.228] .- 0.184197) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au")) .+ 0.184197 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c"))  ;
            ([0.254,0.282,0.310,0.339,0.371,0.404] .- 0.24093) .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ 0.184197 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.24093-0.184197) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au"))
            ]
        dose = [2.42,2.78,2.98,3.26,3.73,4.07,2.57,2.65,2.09,2.81,2.70,2.60,2.49,2.38,2.27]
        uncertainty = [0.02 .* dose[1:6]; 0.015 .* dose[7:9];0.02 .* dose[10:end]]
        bounds = [0.0,0.184197 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")),0.184197 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.24093-0.184197) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au")),1.2*x[end]]

    elseif materials == ["c","u","c"] && energy == 1.0

        x = [
            [0.016,0.044,0.072,0.105,0.133] .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) ;
            ([0.159,0.179,0.199] .- 0.15) .* 8.09e-1 ./ Radiant.density(Radiant.atomic_number("u")) .+ 0.15 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c"))  ;
            ([0.223,0.274,0.325,0.377,0.429,0.499,0.579,0.659,0.733,0.813] .- 0.2086) .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ 0.15 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.2086-0.15) .* 8.09e-1 ./ Radiant.density(Radiant.atomic_number("u"))
            ]
        dose = [2.57,2.87,3.07,3.30,3.79,2.69,2.57,2.07,2.86,2.59,2.38,2.21,2.06,1.80,1.44,1.07,0.73,0.40]
        uncertainty = [0.02 .* dose[1:5]; 0.014 .* dose[6:8];0.02 .* dose[9:end]]
        bounds = [0.0,0.15 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")),0.15 .* 4.89e-1 ./ Radiant.density(Radiant.atomic_number("c")) .+ (0.2086-0.15) .* 8.09e-1 ./ Radiant.density(Radiant.atomic_number("u")),1.2*x[end]]

    elseif materials == ["al","au","al"] && energy == 1.0

        x = [
            [0.005,0.017,0.028,0.041,0.053,0.064,0.078] .* 5.51e-1 ./ Radiant.density(Radiant.atomic_number("al")) ;
            ([0.083,0.112,0.130] .- 0.0854) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au")) .+ 0.0854 .* 5.51e-1 ./ Radiant.density(Radiant.atomic_number("al"))  ;
            ([0.145,0.186,0.226,0.296,0.353,0.394,0.447,0.520,0.590,0.668,0.741] .- 0.1396) .* 5.51e-1 ./ Radiant.density(Radiant.atomic_number("al")) .+ 0.0854 .* 5.51e-1 ./ Radiant.density(Radiant.atomic_number("al")) .+ (0.1396-0.0854) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au"))
            ]
        dose = [2.15,2.40,2.54,2.70,2.85,2.96,3.40,2.56,2.82,2.46,3.34,3.00,2.82,2.46,2.19,1.99,1.66,1.21,0.83,0.46,0.22]
        uncertainty = [0.014 .* dose[1:7]; 0.015 .* dose[8:10];0.014 .* dose[11:end]]
        bounds = [0.0,0.0854 .* 5.51e-1 ./ Radiant.density(Radiant.atomic_number("al")),0.0854 .* 5.51e-1 ./ Radiant.density(Radiant.atomic_number("al")) .+ (0.1396-0.0854) .* 7.72e-1 ./ Radiant.density(Radiant.atomic_number("au")),1.2*x[end]]

    else
        error("Unknown benchmark with materials $materials and energy $energy MeV.")
    end

    return materials, energy, x, dose, uncertainty, bounds

end