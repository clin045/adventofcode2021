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

function eval_metric(input_arr,eval_func)
    sum_arr = sum(input_arr,dims=1)
    n_inputs = size(input_arr)[1]
    final_arr = Vector{String}(undef,size(sum_arr)[2])
    for (idx,s) in enumerate(sum_arr)
        if eval_func(s,(n_inputs / 2))
            final_arr[idx] = "1"  
        else
            final_arr[idx] = "0"
        end
    end
    bool_str = join(final_arr)
    return parse(Int,bool_str,base=2)
end

function main()
    #f = open("3/test.txt","r")
    f = open("3/input.txt","r")
    lines = readdlm(f,String)
    input_arr = strs_to_array(lines)
    gamma = eval_metric(input_arr,>)
    epsilon = eval_metric(input_arr,<)
    println(gamma * epsilon)

    
    
end

main()