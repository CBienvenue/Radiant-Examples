"""
    run_lockwood(N_benchmark::Int64)

Run transport calculations with Radiant for a given Lockwood's benchmark.

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
    N/A

# Reference(s)
- Lockwood (1980), Calorimetric Measurement of Electron Energy Deposition in Extended
  Media - Theory vs Experiment.
- Bienvenue et al. (2025), Toward highly accurate multigroup coupled photon-electron-positron
  cross-sections for the Boltzmann Fokker-Planck equation.

"""
function run_lockwood(N_benchmark::Int64)
    
    # Get Lockwood data -------------------------
    material_names, energy, x_exp, dose_exp, uncertainty_exp, bounds = get_lockwood_data(N_benchmark)

    # Define materials -------------------------
    i = 1
    materials = Vector{Material}()
    material_slabs = Vector{Material}()
    for material_name in material_names
        mat_index = findfirst(==(material_names[i]), material_names)
        if mat_index == i
            mat = Material()
            mat.set_density(Radiant.density(Radiant.atomic_number(material_name)))
            mat.add_element(material_name,1.0)
            push!(materials,mat)
            push!(material_slabs,mat)
        else
            push!(material_slabs,materials[mat_index])
        end
        i += 1
    end

    # Define particles -------------------------
    electron = Electron()
    positron = Positron()
    photon = Photon()

    # Produce cross-sections -------------------------
    cs = Cross_Sections()
    cs.set_source("physics-models")
    cs.set_materials(materials)
    cs.set_particles([electron,photon,positron])
    cs.set_energy(energy)
    cs.set_cutoff(0.001)
    cs.set_number_of_groups(80)
    cs.set_group_structure("log")
    cs.set_interactions([Inelastic_Collision(),Elastic_Collision(),Bremsstrahlung(),Pair_Production(),Photoelectric(),Rayleigh(),Compton(),Auger(),Fluorescence(),Annihilation()])
    cs.set_legendre_order(15)

    # Define geometry -------------------------
    N_slabs = length(material_slabs)
    geo = Geometry()
    geo.set_type("Cartesian")
    geo.set_dimension(1)
    geo.set_boundary_conditions("X-","void")
    geo.set_boundary_conditions("X+","void")
    geo.set_material_per_region(material_slabs)
    geo.set_number_of_regions("X",N_slabs)
    geo.set_voxels_per_region("X",80*ones(Int64,N_slabs))
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
    
    # Plot graph --------------
    x = c1.get_voxels_position("x")
    dose = c1.get_energy_deposition()

    p = plot(x, dose, label="Radiant", xlabel="Depth (cm)", ylabel="Energy deposition (MeV/g × cm²)", fontsize=14)
    scatter!(p, x_exp, dose_exp, yerr=uncertainty_exp, label="Experimental data", marker=:circle, color=:black, error_bar_color=:black, linewidth=1, legend=:topright, markersize=3)
    savefig(p, joinpath(@__DIR__, "results/lockwood_$(N_benchmark)_$(join(material_names, "-"))_$(energy)MeV.png"))

end