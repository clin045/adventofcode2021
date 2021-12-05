using DelimitedFiles

function strs_to_array(lines)
    arr = zeros(Int32,(size(lines)[1],length(lines[1])))
    for (lidx,l) in enumerate(lines)
        for (cidx,c) in enumerate(l)
            arr[lidx,cidx] = parse(Int32,c)
        end
    end
    return(arr)
end

function eval_metric(input_arr,eval_func,pos)
    sum_arr = sum(input_arr,dims=1)
    n_inputs = size(input_arr)[1]
    filter_bit = eval_func(sum_arr[pos],n_inputs / 2)
    filtered_arr = input_arr[input_arr[:,pos] .== filter_bit,:]
    return filtered_arr
end

function main()
    #f = open("3/test.txt","r")
    f = open("3/input.txt","r")
    lines = readdlm(f,String)
    input_arr = strs_to_array(lines)
    # filter for o2
    o2 = input_arr
    for i in 1:size(input_arr)[2]
        filtered = eval_metric(o2,>=,i)
        if size(filtered)[1] > 0
            o2 = filtered
        else
            break
        end
    end
    co2 = input_arr
    for i in 1:size(input_arr)[2]
        filtered = eval_metric(co2,<,i)
        if size(filtered)[1] > 0
            co2 = filtered
        else
            break
        end
    end
    o2_bool_str = join(o2)
    o2_num = parse(Int,o2_bool_str,base=2)
    co2_bool_str = join(co2)
    co2_num = parse(Int,co2_bool_str,base=2)
    println(o2_num * co2_num)

    
    
end

main()