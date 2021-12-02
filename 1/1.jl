using DelimitedFiles
f = open("1/input.txt","r")
depths = map((x)-> parse(Int32,x), readdlm(f,String))
close(f)

function count_increases(list)
    n_increases = 0
    for (idx,val) in enumerate(list)
        if(idx > 1)
            n_increases += val > list[idx-1]
        end
    end
    return n_increases
end

function moving_sum(list, window)
    summed_list = zeros(size(list))
    for i in 1:(size(list)[1] - window+1)
        s = sum(list[i:i+window-1])
        summed_list[i] = s
    end
    return summed_list
end

function main()
    println(string("number of increases: ",count_increases(depths)))
    denoised = moving_sum(depths, 3)
    println(string("n denoised increases: ", count_increases(denoised)))
end

main()