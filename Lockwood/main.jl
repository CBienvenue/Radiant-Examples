# Import package
using Radiant
using Plots
gr(fmt=:png, dpi=300)

# Import benchmark-related functions
include("get_lockwood_data.jl")
include("run_lockwood.jl")

# --------------------------------------
# The following Lockwood's benchmark are defined:
# --------------------------------------
#    1) Be - 1.033 MeV
#    2) Be - 0.521 MeV
#    3) Be - 0.314 MeV
#    4) Be - 0.109 MeV
#    5) Be - 0.058 MeV
#    6) C - 1.0 MeV
#    7) Al - 1.033 MeV
#    8) Al - 0.521 MeV
#    9) Al - 0.314 MeV
#   10) Fe - 1.0 MeV
#   11) Fe - 0.5 MeV
#   12) Fe - 0.3 MeV
#   13) Cu - 1.0 MeV
#   14) Cu - 0.5 MeV   
#   15) Cu - 0.3 MeV
#   16) Mo - 1.0 MeV
#   17) Mo - 0.5 MeV
#   18) Mo - 0.3 MeV
#   19) Mo - 0.1 MeV   
#   20) Ta - 1.033 MeV
#   21) Ta - 0.521 MeV
#   22) Ta - 0.314 MeV
#   23) U - 1.0 MeV
#   24) U - 0.5 MeV   
#   25) U - 0.3 MeV
#   26) Be/Au/Be - 1.0 MeV
#   27) C/Cu/C - 1.0 MeV
#   28) C/Ta/C - 1.0 MeV
#   29) C/Au/C - 1.0 MeV      
#   30) C/U/C - 1.0 MeV
#   31) Al/Au/Al - 1.0 MeV
# --------------------------------------
for N_benchmark in range(1,31)
    run_lockwood(N_benchmark)
end
