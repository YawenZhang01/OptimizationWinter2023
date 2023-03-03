module tire_deg

    using LinearAlgebra

    function calc_tire_degradation(;tire_age_start::Union{Int, Float64},
                                stint_length::Int,
                                compound::String)

        #check input
        if compound ∉ ["soft", "medium", "hard"]
            error("Unknown tire compound!")
        end

        # CASE 1: calculation for a single lap 
        if stint_length == 1
            # soft
            if compound == "soft"
                t_tire_degr = (exp(.07*tire_age_start)-1)

            # medium
            elseif compound == "medium"
                t_tire_degr = (.05*tire_age_start+0.35)

            # hard
            elseif compound == "hard"
                t_tire_degr = 0.8
            end 
        

        # CASE 2: calculation for more than one lap 
        else
            laps_tmp = [tire_age_start:1.0:tire_age_start + stint_length-1;]

            # soft
            if compound == "soft"
                t_tire_degr = (exp.(.07 .* laps_tmp) .- 1)

            # medium
            elseif compound == "medium"
                t_tire_degr = (.05 .* laps_tmp .+ 0.35)

            # hard
            elseif compound == "hard"
                laps_tmp[1:end] .= 0.8
                t_tire_degr = laps_tmp
            end 
        end

            
        return t_tire_degr
    end
end