using DelimitedFiles


function read_input()
    #f = open("6/test.txt","r")
    f = open("6/input.txt","r")
    lines = readdlm(f,',')
    close(f)
    return lines
end

function age_fish!(school)
    for i in 0:7
        school[i] = school[i+1]
    end
end


function main()
    input = read_input()
    school = Dict(
                0 => 0,
                1 => 0,
                2 => 0,
                3 => 0,
                4 => 0,
                5 => 0,
                6 => 0,
                7 => 0,
                8 => 0)
    
    for i in input
        school[i] += 1
    end
    # step day
    for d in 1:256
        n_repro = school[0]
        age_fish!(school)
        school[6] += n_repro
        school[8] = n_repro
    end
    total_fish = 0
    for i in 0:8
        total_fish += school[i]
    end
    println(total_fish)
    
    
end

main()