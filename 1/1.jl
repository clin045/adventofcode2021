using DelimitedFiles
f = open("1/input.txt","r")
depths = map((x)-> parse(Int32,x), readdlm(f,String))
close(f)

function increases(cur,prev)
    if cur > prev
        return true
    else
        return false
    end
end

function main()
    n_increases = 0
    for (idx,val) in enumerate(depths)
        if(idx > 1)
            n_increases += increases(val,depths[idx-1])
        end
    end
    print(n_increases)
end

main()