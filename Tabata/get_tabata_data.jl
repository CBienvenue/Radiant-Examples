"""
    get_tabata_data(N_benchmark::Int64)

Get the data from Tabata's benchmarks.

# Input Argument(s)
- `N_benchmark::Int64` : number corresponding to the following Lockwood's benchmark:
    - `1`  : Be - 4.09 MeV
    - `2`  : Be - 11.5 MeV
    - `3`  : Al - 4.09 MeV
    - `4`  : Al - 7.79 MeV
    - `5`  : Al - 11.5 MeV
    - `6`  : Al - 14.9 MeV
    - `7`  : Al - 23.5 MeV
    - `8`  : Cu - 4.09 MeV
    - `9`  : Cu - 7.79 MeV
    - `10`  : Cu - 11.5 MeV
    - `11`  : Cu - 14.9 MeV
    - `12`  : Cu - 23.5 MeV
    - `13`  : Ag - 4.09 MeV
    - `14`  : Ag - 7.79 MeV
    - `15`  : Ag - 11.5 MeV
    - `16`  : Ag - 14.9 MeV
    - `17`  : Ag - 23.5 MeV
    - `18`  : Au - 4.09 MeV
    - `19`  : Au - 7.79 MeV
    - `20`  : Au - 11.5 MeV
    - `21`  : Au - 14.9 MeV
    - `22`  : Au - 23.5 MeV

# Output Argument(s)
- `materials::String` : list of the materials composing the slab assembly.
- `energy::Float64` : energy of the normally incident electrons [in MeV].
- `x::Vector{Float64}` : position of the experimental data in the slab assembly [in cm].
- `charge::Vector{Float64}` : experimental charge deposition [in cm²/g].
- `Δcharge::Vector{Float64}` : experimental Δcharge [in cm²/g].
- `bounds::Vector{Float64}`: slab boundaries.

# Reference(s)
- Tabata (1967), Backscattering of Electrons from 3.2 to 14 MeV.
- Tabata et al. (1971-A), Charge Distribution Produced by 4- to 24-MeV Electrons in
  Elemental Materials.
- Tabata et al. (1971-B), An Empirical Equation for the Backscattering Coefficient of
  Electrons.

"""
function get_tabata_data(N_benchmark::Int64)

    # Benchmark parameters -------------------------
    if N_benchmark == 1
        material = "be" 
        energy = 4.09
    elseif N_benchmark == 2
        material = "be"
        energy = 11.5
    elseif N_benchmark == 3
        material = "al" 
        energy = 4.09
    elseif N_benchmark == 4
        material = "al" 
        energy = 7.79
    elseif N_benchmark == 5
        material = "al" 
        energy = 11.5
    elseif N_benchmark == 6
        material = "al" 
        energy = 14.9
    elseif N_benchmark == 7
        material = "al" 
        energy = 23.5
    elseif N_benchmark == 8
        material = "cu" 
        energy = 4.09
    elseif N_benchmark == 9
        material = "cu"
        energy = 7.79
    elseif N_benchmark == 10
        material = "cu"
        energy = 11.5
    elseif N_benchmark == 11
        material = "cu" 
        energy = 14.9
    elseif N_benchmark == 12
        material = "cu"
        energy = 23.5
    elseif N_benchmark == 13
        material = "ag"
        energy = 4.09
    elseif N_benchmark == 14
        material = "ag"
        energy = 7.79
    elseif N_benchmark == 15
        material = "ag" 
        energy = 11.5
    elseif N_benchmark == 16
        material = "ag" 
        energy = 14.9
    elseif N_benchmark == 17
        material = "ag" 
        energy = 23.5
    elseif N_benchmark == 18
        material = "au" 
        energy = 4.09
    elseif N_benchmark == 19
        material = "au" 
        energy = 7.79
    elseif N_benchmark == 20
        material = "au"
        energy = 11.5
    elseif N_benchmark == 21
        material = "au" 
        energy = 14.9
    elseif N_benchmark == 22
        material = "au" 
        energy = 23.5
    else
        error("Unknown benchmark.")
    end

    # -----
    # Data from Tabata et al. (1971-A)
    # x [in g/cm²]
    # charge [in 10⁻¹ cm²/g absorbed electrons]
    # -----
    if material == "be" && energy == 4.09

        x = [0.071,0.173,0.265,0.448,0.642,0.825,0.971,1.17,1.35,1.54,1.72,1.82,1.94,2.04,2.14,2.24,2.32,2.42,2.45,2.51,2.55,2.61,2.65,2.69,2.73,2.79,2.83,2.84,2.87]
        charge = [-1.6,-0.603,-0.288,0.046,0.524,0.943,1.45,2.52,3.70,5.45,7.33,8.21,9.30,9.53,9.32,8.72,7.92,5.94,5.19,3.93,3.13,1.97,1.34,1.14,0.906,0.282,0.165,0.128,0.062]
        Δcharge = 0.002 .* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "be" && energy == 7.79

        x = [0.091,0.193,0.468,1.19,1.96,2.70,3.22,3.60,3.82,4.02,4.20,4.39,4.57,4.72,4.92,5.10,5.29,5.39,5.47,5.57,5.67]
        charge = [-1.5,-0.738,-0.336,0.069,0.584,1.57,2.96,4.18,4.87,5.40,5.59,5.49,4.85,3.96,2.64,1.41,0.541,0.235,0.151,0.051,0.018]
        Δcharge = 0.001 .* ones(length(charge)) .+ 0.039 .* charge

    elseif material == "be" && energy == 11.5

        x = [0.14,0.33,1.04,2.01,2.57,2.95,3.51,3.85,4.44,4.97,5.38,5.72,5.90,6.10,6.28,6.47,6.61,6.79,6.94,7.13,7.36,7.41,7.51,7.61,7.68,7.79,7.91,8.01,8.08,8.18,8.28,8.38]
        charge = [-1.3,-0.536,-0.107,0.076,0.247,0.371,0.636,0.879,1.45,2.15,2.81,3.31,3.53,3.83,3.95,3.93,3.77,3.39,3.11,2.54,1.91,1.56,1.28,0.915,0.765,0.497,0.323,0.182,0.119,0.064,0.030,0.019]
        Δcharge = 0.001 .* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "be" && energy == 14.9

        x = [0.17,0.37,0.74,1.11,2.06,2.98,3.90,4.80,5.73,6.44,6.96,7.34,7.77,8.12,8.31,8.49,8.74,9.02,9.21,9.57,9.95,10.14,10.32,10.52,10.70,10.89]
        charge = [-1.1,-0.541,-0.293,-0.187,-0.035,0.091,0.247,0.520,0.976,1.59,2.15,2.55,3.07,3.23,3.21,3.20,2.92,2.53,2.10,1.26,0.513,0.245,0.127,0.044,0.016,0.006]
        Δcharge = 0.001 .* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "al" && energy == 4.09

        x = [0.072,0.124,0.207,0.344,0.479,0.614,0.749,0.886,1.02,1.16,1.29,1.45,1.59,1.72,1.86,1.99,2.05,2.13,2.18,2.27,2.32,2.40,2.45,2.54]
        charge = [-0.73,0.183,0.794,1.58,2.37,3.04,4.21,5.10,6.08,6.79,7.42,7.72,7.55,6.86,5.49,4.13,3.33,2.37,1.88,1.12,0.789,0.383,0.229,0.027]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "al" && energy == 7.79

        x = [0.100,0.231,0.372,0.642,0.914,1.18,1.48,1.75,2.02,2.29,2.56,2.80,3.07,3.34,3.61,3.88,4.18,4.31,4.45,4.58,4.72,4.85,4.99,5.13]
        charge = [-1.1,-0.305,-0.032,0.333,0.694,1.06,1.63,2.21,2.81,3.43,3.94,4.28,4.39,4.21,3.63,2.71,1.59,1.15,0.680,0.416,0.221,0.094,0.034,0.009]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "al" && energy == 11.5

        x = [0.13,0.18,0.32,0.54,0.94,1.35,1.78,2.19,2.59,2.96,3.37,3.78,4.21,4.62,5.02,5.43,5.76,6.17,6.36,6.57,6.76,7.00,7.19,7.41,7.68]
        charge = [-1.0,-0.645,-0.354,-0.146,0.089,0.306,0.607,0.927,1.33,1.72,2.25,2.64,3.05,3.17,3.08,2.61,1.99,1.24,0.882,0.552,0.318,0.137,0.059,0.019,0.003]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "al" && energy == 14.9

        x = [0.17,0.30,0.43,0.71,1.25,1.81,2.36,2.87,3.41,3.95,4.51,5.06,5.53,6.07,6.61,7.17,7.45,7.72,7.99,8.23,8.49,8.77,9.04,9.31,9.58,9.87]
        charge = [-0.92,-0.462,-0.307,-0.153,0.031,0.218,0.423,0.687,0.987,1.36,1.77,2.14,2.40,2.54,2.43,2.00,1.70,1.37,1.05,0.757,0.466,0.257,0.122,0.048,0.014,0.006]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "al" && energy == 23.5

        x = [0.29,0.83,2.17,3.55,5.58,7.19,8.30,9.37,10.87,11.41,12.48,13.02,13.59,14.13]
        charge = [-0.78,-0.128,0.113,0.312,0.722,1.16,1.41,1.61,1.38,1.17,0.657,0.432,0.185,0.091]
        Δcharge = 0.020 .* ones(length(charge)) .+ 0.050 .* charge

    elseif material == "cu" && energy == 4.09

        x = [0.065,0.083,0.156,0.335,0.511,0.621,0.781,0.949,1.13,1.40,1.57,1.84,2.01,2.11,2.28,2.37,2.46,2.55,2.72]
        charge = [-0.72,0.475,2.06,3.89,5.34,6.16,7.14,7.60,7.47,6.06,4.79,2.57,1.21,0.769,0.258,0.124,0.070,0.032,0.022]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "cu" && energy == 7.79

        x = [0.102,0.138,0.281,0.548,0.986,1.43,1.87,2.05,2.23,2.50,2.94,3.11,3.38,3.82,4.09,4.27,4.50,4.68,4.86,5.13]
        charge = [-0.91,-0.187,0.563,1.33,2.26,3.20,3.85,3.94,3.90,3.87,3.25,2.79,2.09,1.06,0.546,0.344,0.141,0.066,0.025,0.006]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge
        
    elseif material == "cu" && energy == 11.5

        x = [0.12,0.57,1.00,1.46,1.89,2.34,2.77,2.95,3.23,3.40,3.66,4.11,4.33,4.78,5.39,5.67,5.84,6.10,6.28,6.55,6.73,6.98,7.16]
        charge = [-0.84,0.378,0.866,1.27,1.77,2.20,2.53,2.66,2.74,2.77,2.68,2.50,2.31,1.91,1.19,0.861,0.666,0.434,0.312,0.147,0.101,0.045,0.023]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.039 .* charge

    elseif material == "cu" && energy == 14.9

        x = [0.17,0.62,1.05,1.50,1.94,2.39,2.82,3.27,3.71,4.16,4.38,4.83,5.26,5.71,6.15,6.60,7.03,7.48,7.92,8.37,8.80,9.21,9.64]
        charge = [-0.87,0.129,0.424,0.723,1.01,1.31,1.66,1.91,2.15,2.25,2.25,2.22,2.09,1.82,1.54,1.17,0.858,0.523,0.306,0.145,0.061,0.023,0.013]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "cu" && energy == 23.5

        x = [0.29,1.17,2.94,4.50,5.38,6.27,7.15,8.04,8.88,9.76,10.65,11.53,12.42,13.09,13.97]
        charge = [-0.59,0.109,0.630,1.09,1.29,1.45,1.44,1.35,1.19,0.914,0.616,0.373,0.153,0.067,0.014]
        Δcharge = 0.003 .* ones(length(charge)) .+ 0.040 .* charge

    elseif material == "ag" && energy == 4.09

        x = [0.071,0.093,0.179,0.276,0.384,0.481,0.614,0.722,0.819,0.927,1.02,1.25,1.45,1.68,1.89,2.09,2.31,2.51,2.74]
        charge = [0.24,1.67,3.83,5.19,6.43,7.36,7.99,8.36,8.43,8.01,7.57,5.72,3.81,2.08,0.958,0.329,0.091,0.027,0.015]
        Δcharge = 0.002.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "ag" && energy == 7.79
        
        x = [0.114,0.222,0.319,0.524,0.765,0.970,1.18,1.39,1.59,1.84,2.04,2.24,2.56,2.90,3.31,3.72,4.17,4.37,4.58,4.78]
        charge = [-0.31,0.731,1.40,2.11,2.78,3.34,3.72,3.98,4.19,4.11,3.93,3.67,3.02,2.32,1.36,0.626,0.183,0.091,0.041,0.014]
        Δcharge = 0.002.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "ag" && energy == 11.5

        x = [0.14,0.19,0.34,0.68,1.21,1.75,2.27,2.52,2.81,3.34,3.88,4.40,4.94,5.36,5.90,6.43,6.68,6.97,7.23]
        charge = [-0.48,0.060,0.536,1.13,1.84,2.48,2.78,2.90,2.81,2.64,2.10,1.49,0.857,0.484,0.190,0.060,0.031,0.015,0.007]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "ag" && energy == 14.9

        x = [0.19,0.40,0.73,1.26,1.80,2.32,2.86,3.39,3.93,4.45,4.99,5.41,5.95,6.48,7.02,7.54,8.08,8.61,9.15]
        charge = [-0.51,0.238,0.636,1.10,1.58,1.95,2.23,2.32,2.25,2.05,1.69,1.36,0.956,0.617,0.343,0.171,0.071,0.026,0.009]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "ag" && energy == 23.5

        x = [0.33,0.87,1.40,2.46,3.53,4.59,5.13,5.55,6.62,7.68,8.75,9.81,10.83,11.90,12.96]
        charge = [-0.34,0.271,0.494,0.908,1.30,1.53,1.57,1.58,1.41,1.09,0.736,0.417,0.178,0.060,0.015]
        Δcharge = 0.002 .* ones(length(charge)) .+ 0.039 .* charge

    elseif material == "au" && energy == 4.09

        x = [0.073,0.167,0.272,0.366,0.449,0.543,0.648,0.742,0.825,1.05,1.25,1.42,1.62,1.80,2.01,2.21,2.39,2.59,2.77]
        charge = [0.48,5.06,7.53,8.87,9.72,10.07,10.08,9.34,8.58,6.33,4.14,2.39,1.23,0.520,0.205,0.052,0.033,0.026,0.015]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "au" && energy == 7.79

        x = [0.104,0.143,0.198,0.303,0.480,0.679,0.856,1.08,1.28,1.45,1.65,2.04,2.34,2.62,2.89,3.22,3.77,3.98,4.18,4.36,4.56,4.74]
        charge = [-0.24,0.889,1.57,2.36,3.32,4.08,4.56,4.86,4.89,4.73,4.34,3.42,2.62,1.84,1.22,0.670,0.169,0.095,0.053,0.027,0.019,0.006]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "au" && energy == 11.5

        x = [0.13,0.22,0.32,0.50,0.80,1.10,1.47,1.67,1.85,2.07,2.54,3.04,3.51,4.01,4.30,4.58,4.98,5.27,5.55,5.83,6.14,6.52]
        charge = [-0.35,0.731,1.13,1.74,2.33,2.83,3.22,3.28,3.27,3.26,2.93,2.34,1.72,1.13,0.795,0.576,0.312,0.176,0.108,0.051,0.025,0.010]
        Δcharge = 0.004.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "au" && energy == 14.9

        x = [0.18,0.39,0.56,0.76,1.16,1.53,1.73,2.12,2.33,2.50,2.70,2.88,3.10,3.30,3.47,3.67,4.06,4.44,5.04,5.41,6.00,6.38,6.98,7.35,7.94,8.32,8.92]
        charge = [-0.35,0.665,1.03,1.31,1.81,2.21,2.41,2.62,2.62,2.62,2.58,2.54,2.46,2.35,2.25,2.10,1.76,1.43,0.972,0.686,0.377,0.246,0.111,0.052,0.023,0.012,0.005]
        Δcharge = 0.001.* ones(length(charge)) .+ 0.038 .* charge

    elseif material == "au" && energy == 23.5

        x = [0.32,0.69,1.29,1.76,2.26,2.73,3.23,3.70,4.20,5.17,6.14,7.11,8.08,9.05,10.02,10.99]
        charge = [-0.21,0.518,0.928,1.21,1.45,1.67,1.80,1.84,1.82,1.60,1.20,0.775,0.453,0.217,0.091,0.028]
        Δcharge = 0.002 .* ones(length(charge)) .+ 0.043 .* charge

    else
        error("Unknown benchmark with materials $materials and energy $energy MeV.")
    end

    # -----
    # Backscattering Coefficient
    # -----
    if material == "be"

        # Tabata (1967)
        if energy == 4.09
            η = 0.30/100
            Δη = 0.04/100

        # Tabata et al (1971-A)
        elseif energy == 11.5
            η = 0.1/100
            Δη = 0.02/100  # (Overestimation)
        else
            error("Backscattering coefficient is unknown.")
        end
    else

        # Empirical formula from Tabata et al. (1971-B)
        mₑc² = 0.510999
        Zi = Radiant.atomic_number(material)
        b1 = 1.15
        b2 = 8.35
        b3 = 0.525
        b4 = 0.0185
        b5 = 15.7
        b6 = 1.59
        b7 = 1.56
        b8 = 4.42
        E = (energy/mₑc²)
        η = (b1*exp(-b2*Zi^(-b3)))/(1+(b4+b5*Zi^(-b6))*E^(b7-b8/Zi))

        # Uncertainty propagation
        Δb1 = 0.06
        Δb2 = 0.25
        Δb3 = 0.020
        Δb4 = 0.0019
        Δb5 = 3.1
        Δb6 = 0.07
        Δb7 = 0.02
        Δb8 = 0.18
        Δη = sqrt((Δb1 * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)))^2 + (Δb2 * -b1 * Zi ^ (-b3) * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)))^2 + (Δb3 * b1 * b2 * Zi ^ (-b3) * log(Zi) * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)))^2 + (Δb4 * -b1 * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)) ^ 2 * E ^ (b7 - b8 / Zi))^2 + (Δb5 * -b1 * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)) ^ 2 * Zi ^ (-b6) * E ^ (b7 - b8 / Zi))^2 + (Δb6 * b1 * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)) ^ 2 * b5 * Zi ^ (-b6) * log(Zi) * E ^ (b7 - b8 / Zi))^2 + (Δb7 * -b1 * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)) ^ 2 * (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi) * log(E))^2 + (Δb8 * b1 * exp(-b2 * Zi ^ (-b3)) / (1 + (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi)) ^ 2 * (b4 + b5 * Zi ^ (-b6)) * E ^ (b7 - b8 / Zi) / Zi * log(E))^2)

    end

    #-----
    # Conversions
    #-----
    x = x./Radiant.density(Radiant.atomic_number(material)) # g/cm² → cm
    charge ./= 10; Δcharge = abs.(Δcharge)./10 # 10⁻¹ cm²/g → cm²/g
    charge = charge .* (1-η) # charge normalized by absorbed electron → charge normalized by incident electron

    #-----
    # Total uncertainty on charge deposition
    #-----
    uncertainty = sqrt.((Δcharge .* (1-η)).^2 .+ (Δη .* -charge).^2)

    #-----
    # Bounds for transport calculations
    #-----
    bounds = [0.0,1.2*x[end]]
                       
    return material, energy, x, charge, uncertainty, bounds
end