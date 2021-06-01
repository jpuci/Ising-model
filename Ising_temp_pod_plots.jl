using Plots

#= Take file_name and prepare data for plot =#
function prepare_for_plot(file_name)
    open(file_name*".txt", "r") do file
        temp = read(file, String)
        temp = replace(temp, "["=> "")
        temp = replace(temp, "]"=> "")
        temp = split(temp, ",")
        temp = [parse(Float64, i) for i in temp]
        return temp
    end
end

# pod_1 = prepare_for_plot("temp_res_L_10_v2_pod")
# pod_2 = prepare_for_plot("temp_res_L_50_v2_pod")
# pod_3 = prepare_for_plot("temp_res_L_100_v2_pod")
# v = [LinRange(1, 1.9, 4) ; LinRange(1.91, 2.8, 20); LinRange(2.9, 3.5, 4)]
# scatter(v, [pod_1, pod_2, pod_3], title = "Wykres podatności od zredukowanej temperatury", label = ["L=10" "L=50" "L=100"],
# markershape = [:utriangle :circle :pentagon], markersize = 4, markercolor = ["blue" "green" "orange"],
# xlabel = "T* - zredukowana temperatura", ylabel = "Podatność [1/J]")
# plot!(v, [pod_1, pod_2, pod_3],  linecolor = ["blue" "green" "orange"], label = "")
# savefig("plot_pod.png")

# pod_1 = prepare_for_plot("temp_res_L_10_v2_abs")
# pod_2 = prepare_for_plot("temp_res_L_50_v2_abs")
# pod_3 = prepare_for_plot("temp_res_L_100_v2_abs")
# v = [LinRange(1, 1.9, 4) ; LinRange(1.91, 2.8, 20); LinRange(2.9, 3.5, 4)]
# scatter(v, [pod_1, pod_2, pod_3], title = "Wykres magnetyzacji od zredukowanej temperatury", label = ["L=10" "L=50" "L=100"],
# markershape = [:utriangle :circle :pentagon], markersize = 4, markercolor = ["blue" "green" "orange"],
# xlabel = "T* - zredukowana temperatura", ylabel = "magnetyzacja <m>")
# plot!(v, [pod_1, pod_2, pod_3],  linecolor = ["blue" "green" "orange"], label = "")
# savefig("plot_m.png")


# pod_1 = prepare_for_plot("temp_res_L_10_zes_pod")
# v2 = [LinRange(1, 2, 3) ; LinRange(2.05, 2.75, 16); LinRange(2.8, 3.5, 3)]
# pod_2 = prepare_for_plot("temp_res_L_50_zes_pod")
# pod_3 = prepare_for_plot("temp_res_L_100_zes_pod")
# scatter(v2, [pod_1, pod_2, pod_3], title = "Wykres podatności od zredukowanej temperatury", label = ["L=10" "L=50" "L=100"],
# markershape = [:utriangle :circle :pentagon], markersize = 4, markercolor = ["blue" "green" "orange"],
# xlabel = "T* - zredukowana temperatura", ylabel = "Podatność [1/J]")
# plot!(v2, [pod_1, pod_2, pod_3],  linecolor = ["blue" "green" "orange"], label = "")
# savefig("plot_pod_zes.png")

# pod_1 = prepare_for_plot("temp_res_L_10_zes_mag")
# pod_2 = prepare_for_plot("temp_res_L_50_zes_mag")
# pod_3 = prepare_for_plot("temp_res_L_100_zes_mag")
# v2 = [LinRange(1, 2, 3) ; LinRange(2.05, 2.75, 16); LinRange(2.8, 3.5, 3)]
# scatter(v2, [pod_1, pod_2, pod_3], title = "Wykres magnetyzacji od zredukowanej temperatury", label = ["L=10" "L=50" "L=100"],
# markershape = [:utriangle :circle :pentagon], markersize = 4, markercolor = ["blue" "green" "orange"],
# xlabel = "T* - zredukowana temperatura", ylabel = "magnetyzacja <m>")
# plot!(v2, [pod_1, pod_2, pod_3],  linecolor = ["blue" "green" "orange"], label = "")
# savefig("plot_m_zes.png")
