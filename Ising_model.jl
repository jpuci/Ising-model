using Plots

#= Implementation for Ising model.
Arguments:
    L - size of matrix (L x L)
    T - reducet temperature
    N_MCS - number of monte carlo steps
    file_name - name of file to save trajectories for every MCS =#
function Metropolis_ising(L, T, N_MCS, file_name)
    b = zeros(Int16, L + 2)
    b[2:end - 1] = 1:L
    b[1] = L
    b[end] = 1
    MC = L^2
    state_table = ones(Int8, L, L)
    state_table[1:end] = rand([-1, 1], L^2)
    exp_dic = Dict(i => exp(-i/T) for i in [-8, -4, 0, 4, 8])
    open(file_name*".txt", "w") do file

    for i in 1:N_MCS
        for rep in 1:MC
            cur_x = rand(1:L)
            cur_y = rand(1:L)
            cur_val = state_table[cur_x, cur_y]
            delta_E = 2 * cur_val * (state_table[cur_x, b[cur_y + 2]] + state_table[cur_x, b[cur_y]] +
                                                        state_table[b[cur_x + 2], cur_y] + state_table[b[cur_x], cur_y])
            if delta_E <= 0
                state_table[cur_x, cur_y] *= -1
            elseif rand() <= exp_dic[delta_E]
                state_table[cur_x, cur_y] *= -1
            end
        end
        write(file, string(sum(state_table)/(MC)) *"\n")
        end
    end
end


#= Ising for susceptibility and temperature plots
Arguments:
    L - size of matrix (L x L)
    T - reduced temperature
    N_MC - number of Monte Carlo steps
Return:
    average mangetization
    average absolute value magnetization
    average magnetization to the power of 2 =#
function Metropolis_ising_2(L, T, N_MCS)
    b = zeros(Int16, L + 2)
    b[2:end - 1] = 1:L
    b[1] = L
    b[end] = 1
    MC = L^2
    state_table = ones(Int8, L, L)
    exp_dic = Dict(i => exp(-i/T) for i in [-8, -4, 0, 4, 8])

    for i in 1:10^4
        for rep in 1:MC
            cur_x = rand(1:L)
            cur_y = rand(1:L)
            cur_val = state_table[cur_x, cur_y]
            delta_E = 2 * cur_val * (state_table[cur_x, b[cur_y + 2]] + state_table[cur_x, b[cur_y]] +
                                                        state_table[b[cur_x + 2], cur_y] + state_table[b[cur_x], cur_y])
            if delta_E <= 0
                state_table[cur_x, cur_y] = -1 * cur_val
            elseif rand() <= exp_dic[delta_E]
                state_table[cur_x, cur_y] = -1 * cur_val
            end
        end
    end
    m_av = 0
    m_av_abs = 0
    m_av_sq = 0
    for i in 1:(N_MCS - 10^4)
        for rep in 1:MC
            cur_x = rand(1:L)
            cur_y = rand(1:L)
            cur_val = state_table[cur_x, cur_y]
            delta_E = 2 * cur_val * (state_table[cur_x, b[cur_y + 2]] + state_table[cur_x, b[cur_y]] +
                                                        state_table[b[cur_x + 2], cur_y] + state_table[b[cur_x], cur_y])
            if delta_E <= 0
                state_table[cur_x, cur_y] = -1 * cur_val
            elseif rand() <= exp_dic[delta_E]
                state_table[cur_x, cur_y] = -1 * cur_val
            end
        end
        m_av += sum(state_table)/(MC)
        m_av_abs += abs(sum(state_table)/(MC))
        m_av_sq += (sum(state_table)/(MC))^2
    end
    return m_av/(N_MCS-10^4), m_av_abs/(N_MCS - 10^4), m_av_sq/(N_MCS - 10^4)
end

#= Ising for animation and heatmaps
Arguments:
    L - matrix size (L x L)
    T - reduced temperature
    N_MCS - number of Monte Carlo steps
    file_name - name of file to save flatten table of states=#
function Metropolis_ising_3(L, T, N_MCS, file_name)
    b = zeros(Int16, L + 2)
    b[2:end - 1] = 1:L
    b[1] = L
    b[end] = 1
    MC = L^2
    state_table = ones(Int8, L, L)
    state_table[1:end] = rand([-1, 1], L^2)
    exp_dic = Dict(i => exp(-i/T) for i in [-8, -4, 0, 4, 8])
    open(file_name*"_anim.txt", "w") do file

    for i in 1:N_MCS
        for rep in 1:MC
            cur_x = rand(1:L)
            cur_y = rand(1:L)
            cur_val = state_table[cur_x, cur_y]
            delta_E = 2 * cur_val * (state_table[cur_x, b[cur_y + 2]] + state_table[cur_x, b[cur_y]] +
                                                        state_table[b[cur_x + 2], cur_y] + state_table[b[cur_x], cur_y])
            if delta_E <= 0
                state_table[cur_x, cur_y] *= -1
            elseif rand() <= exp_dic[delta_E]
                state_table[cur_x, cur_y] *= -1
            end
        end
        if rem(i, 2) == 0
        write(file, string(reshape(state_table, length(state_table), 1))*"\n")
    end

        end
    end
end

#= Ising for set average.
Arguments:
    L - matrix size (L X L)
    T - reduced temeprature
    K0 - termalization time=#
function Metropolis_ising_4(L, T, K0)
    b = zeros(Int16, L + 2)
    b[2:end - 1] = 1:L
    b[1] = L
    b[end] = 1
    MC = L^2
    state_table = ones(Int8, L, L)
    exp_dic = Dict(i => exp(-i/T) for i in [-8, -4, 0, 4, 8])
    for i in 1:K0
        for rep in 1:MC
            cur_x = rand(1:L)
            cur_y = rand(1:L)
            cur_val = state_table[cur_x, cur_y]
            delta_E = 2 * cur_val * (state_table[cur_x, b[cur_y + 2]] + state_table[cur_x, b[cur_y]] +
                                                        state_table[b[cur_x + 2], cur_y] + state_table[b[cur_x], cur_y])
            if delta_E <= 0
                state_table[cur_x, cur_y] = -1 * cur_val
            elseif rand() <= exp_dic[delta_E]
                state_table[cur_x, cur_y] = -1 * cur_val
            end
        end
    end
    m_abs = abs(sum(state_table)/(MC))
    m_sq = (sum(state_table)/(MC))^2

    return m_abs, m_sq
end

#= Evaluation of Ising to create data for susceptibility and magnetization plots.
Arguments:
    L - size of matrix (L X L)
    v - vector of temperatures
    file_name - name of file to save data =#
function temp_set(L, v, file_name, N, N_MC)
    open(file_name*"_pod.txt", "w") do file
    open(file_name*"_abs.txt", "w") do file2

    vect_abs = zeros(length(v))
    pod = zeros(length(v))
    for (i, val) in enumerate(v)
        res = Metropolis_ising_2(L, val, 10^6)
        pod[i] = L^2/val*(res[3] - res[2].^2)
        vect_abs[i] = res[2]
    end
    write(file, string(pod)*"\n")
    write(file2, string(vect_abs)*"\n")
    end
    end
    end
end

#= Make animation from data in file_name.txt =#
function make_anim(file_name, L, T)
    f = open(file_name*".txt", "r")
    lines = readlines(f)
    a = @animate for i in 1:length(lines)
        data = prepare_for_heatmap(lines[i], L)
        heatmap(data, c= :blues, clim=(-1, 1), title="T* = "* string(T)*"  "*string(2*i)*"MCS")
        end
    gif(a, file_name*".gif", fps = 200)
end

#= Prepate data for heatmap =#
function prepare_for_heatmap(line, L)
    temp = replace(line, "["=> "")
    temp = replace(temp, "]"=> "")
    temp = replace(temp, "Int8"=> "")
    temp = split(temp, ";")
    temp = [parse(Int8, i) for i in temp]
    temp = reshape(temp, L, L)
    return temp
end

function get_spin(x, y)
    return data[x][y]
end


#= Evaluation of Ising to create data for susceptibility and magnetization plots
using set average.
Arguments:
    L - size of matrix (L X L)
    v - vector of temperatures
    rep - number of sets to get average from
    K0 - termalization time
    file_name - name of file to save data =#
function temp_zes(L, v, rep, K0, file_name)
    res_pod = zeros(size(v))
    res_mag = zeros(size(v))
    for (count, val) in enumerate(v)
        println(count)
        pod = 0
        mag = 0
        for i in 1:rep
            data = Metropolis_ising_4(L, val, K0)
            pod += abs(data[2])
            mag += abs(data[1])
        end
        res_pod[count] = (L^2/val)*(pod/rep - (mag/rep)^2)
        res_mag[count] = mag/rep
    end
    open(file_name*"_pod.txt", "w") do file
        write(file, string(res_pod)*"\n")
    open(file_name*"_mag.txt", "w") do file2
        write(file2, string(res_mag)*"\n")
    end
end
    return res_pod, res_mag

end

#exaple of temperatures
#v2 = [LinRange(1, 2, 3) ; LinRange(2.05, 2.75, 16); LinRange(2.8, 3.5, 3)]

#make animation
# a = Metropolis_ising_3(10, 4, 1000, "L_10_t_4")
# make_anim("L_10_t_4_anim", 10, 4)
