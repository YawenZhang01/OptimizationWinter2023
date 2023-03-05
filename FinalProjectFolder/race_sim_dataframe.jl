module race_sim_dataframe

    include("./calc_race_times.jl")
    using DataFrames

    t_base=80
    tot_no_laps=70
    t_lap_sens_mass=.03
    t_pitdrive_inlap=3
    t_pitdrive_outlap=16
    t_pit_tirechange=3
    cold_tire_pen=1.0
    pits_aft_finishline= true
    p_grid=5
    t_loss_firstlap=10
    t_loss_pergridpos=2
    m_fuel_init=110
    b_fuel_perlap=1.557

    function race_sim_df(;strategy_vector :: Vector{Vector{Vector{Any}}})
        df = DataFrame(Race_Strategy = Vector[], Race_Time = Float64[])
        for i in 1:length(strategy_vector)
            timer = Calc_Race_Times.calc_racetimes_basic(;t_base=t_base, 
                                tot_no_laps=tot_no_laps, 
                                t_lap_sens_mass=t_lap_sens_mass, 
                                t_pitdrive_inlap=t_pitdrive_inlap, 
                                t_pitdrive_outlap=t_pitdrive_outlap, 
                                t_pit_tirechange=t_pit_tirechange, 
                                cold_tire_pen=cold_tire_pen,
                                pits_aft_finishline= pits_aft_finishline, 
                                p_grid=p_grid, 
                                t_loss_firstlap=t_loss_firstlap, 
                                t_loss_pergridpos=t_loss_pergridpos, 
                                strategy=strategy_vector[i], 
                                m_fuel_init=m_fuel_init, 
                                b_fuel_perlap=b_fuel_perlap)
            push!(df, [strategy_vector[i], timer])
        end
        return sort!(df, :Race_Time)
    end
end

