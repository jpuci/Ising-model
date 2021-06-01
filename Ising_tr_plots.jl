using Plots


function prepare_for_plot(file_name)
    open(file_name*".txt", "r") do file
        temp = readlines(file)
        temp = temp[1:5000]
        temp = [parse(Float64, i) for i in temp]
        return temp
    end
end

# for i in 1:8
#     plot!(1:5000, prepare_for_plot("trajectory_L_10_vol" * string(i)))
# end
# savefig("trajectory")
