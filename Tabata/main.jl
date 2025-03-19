# Import package
using Radiant
using Plots
gr(fmt=:png, dpi=300)

# Import benchmark-related functions
include("get_tabata_data.jl")
include("run_tabata.jl")

# --------------------------------------
# The following Tabata's benchmark are defined:
# --------------------------------------
# 1) Be - 4.09 MeV
# 2) Be - 11.5 MeV
# 3) Al - 4.09 MeV
# 4) Al - 7.79 MeV
# 5) Al - 11.5 MeV
# 6) Al - 14.9 MeV
# 7) Al - 23.5 MeV
# 8) Cu - 4.09 MeV
# 9) Cu - 7.79 MeV
# 10) Cu - 11.5 MeV
# 11) Cu - 14.9 MeV
# 12) Cu - 23.5 MeV
# 13) Ag - 4.09 MeV
# 14) Ag - 7.79 MeV
# 15) Ag - 11.5 MeV
# 16) Ag - 14.9 MeV
# 17) Ag - 23.5 MeV
# 18) Au - 4.09 MeV
# 19) Au - 7.79 MeV
# 20) Au - 11.5 MeV
# 21) Au - 14.9 MeV
# 22) Au - 23.5 MeV
# --------------------------------------
for N_benchmark in range(1,22)
    run_tabata(N_benchmark)
end
