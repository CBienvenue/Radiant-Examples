"""
    run_tabata(N_benchmark::Int64)

Run transport calculations with Radiant for a given Tabata's benchmark.

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
    N/A

# Reference(s)
- Tabata et al. (1971), Charge Distribution Produced by 4- to 24-MeV Electrons in
  Elemental Materials.
- Bienvenue et al. (2025), Toward highly accurate multigroup coupled photon-electron-positron
  cross-sections for the Boltzmann Fokker-Planck equation.

"""
function run_tabata(N_benchmark::Int64)
    
    # Get Lockwood data -------------------------
    material, energy, x_exp, charge_exp, uncertainty_exp, bounds = get_tabata_data(N_benchmark)

    # Define materials -------------------------
    mat = Material()
    mat.set_density(Radiant.density(Radiant.atomic_number(material)))
    mat.add_element(material,1.0)

    # Define particles -------------------------
    electron = Electron()
    positron = Positron()
    photon = Photon()

    # Produce cross-sections -------------------------
    cs = Cross_Sections()
    cs.set_source("physics-models")
    cs.set_materials(mat)
    cs.set_particles([electron,photon,positron])
    cs.set_energy(energy)
    cs.set_cutoff(0.001)
    cs.set_number_of_groups(80)
    cs.set_group_structure("log")
    cs.set_interactions([Inelastic_Collision(),Elastic_Collision(),Bremsstrahlung(),Pair_Production(),Photoelectric(),Rayleigh(),Compton(),Auger(),Fluorescence(),Annihilation()])
    cs.set_legendre_order(15)

    # Define geometry -------------------------
    geo = Geometry()
    geo.set_type("Cartesian")
    geo.set_dimension(1)
    geo.set_boundary_conditions("X-","void")
    geo.set_boundary_conditions("X+","void")
    geo.set_material_per_region([mat])
    geo.set_number_of_regions("X",1)
    geo.set_voxels_per_region("X",[80])
    geo.set_region_boundaries("X",bounds)

    # Define methods ----------------
    m1 = Discrete_Ordinates()
    m1.set_particle(electron)
    m1.set_solver_type("BFP")
    m1.set_acceleration("livolant")
    m1.set_quadrature("Gauss-Lobatto",12)
    m1.set_legendre_order(15)
    m1.set_angular_boltzmann("galerkin")
    m1.set_angular_fokker_planck("finite-difference")
    m1.set_convergence_criterion(1e-7)
    m1.set_maximum_iteration(500)
    m1.set_scheme("E","DG",2)
    m1.set_scheme("x","DG",2)

    m2 = Discrete_Ordinates()
    m2.set_particle(photon)
    m2.set_solver_type("BTE")
    m2.set_acceleration("livolant")
    m2.set_quadrature("Gauss-Lobatto",12)
    m2.set_legendre_order(15)
    m2.set_angular_boltzmann("galerkin")
    m2.set_convergence_criterion(1e-7)
    m2.set_maximum_iteration(500)
    m2.set_scheme("x","DG",2)

    m3 = Discrete_Ordinates()
    m3.set_particle(positron)
    m3.set_solver_type("BFP")
    m3.set_acceleration("livolant")
    m3.set_quadrature("Gauss-Lobatto",12)
    m3.set_legendre_order(15)
    m3.set_angular_boltzmann("galerkin")
    m3.set_angular_fokker_planck("finite-difference")
    m3.set_convergence_criterion(1e-7)
    m3.set_maximum_iteration(500)
    m3.set_scheme("E","DG",2)
    m3.set_scheme("x","DG",2)

    m = Solvers()
    m.add_solver(m1)
    m.add_solver(m2)
    m.add_solver(m3)
    m.set_maximum_number_of_generations(20)
    m.set_convergence_criterion(1e-7)
    m.set_convergence_type("flux")

    # Define fixed sources ----------------
    ss = Surface_Source()
    ss.set_particle(electron)
    ss.set_intensity(1.0)
    ss.set_energy_group(1)
    ss.set_direction([1.0,0.0,0.0])
    ss.set_location("X-")
    s = Fixed_Sources(cs,geo,m)
    s.add_source(ss)

    # Define computation settings --------------
    c1 = Computation_Unit()
    c1.set_cross_sections(cs)
    c1.set_geometry(geo)
    c1.set_solvers(m)
    c1.set_sources(s)
    c1.run()
    
    # Plot graph --------------\
    x = c1.get_voxels_position("x")
    charge = c1.get_charge_deposition()
    p = plot(x, charge, label="Radiant", xlabel="Depth (cm)", ylabel="Charge deposition (cm²/g)", fontsize=14)
    scatter!(p, x_exp, charge_exp, yerr=uncertainty_exp, label="Experimental data", marker=:circle, color=:black, error_bar_color=:black, linewidth=1, legend=:topright, markersize=3)
    savefig(p, joinpath(@__DIR__, "results/tabata_$(N_benchmark)_$(material)_$(energy)MeV.png"))

end