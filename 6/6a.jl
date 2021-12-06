using DelimitedFiles

mutable struct Fish
    timer::Int8
end

function read_input()
    #f = open("6/test.txt","r")
    f = open("6/input.txt","r")
    lines = readdlm(f,',')
    close(f)
    return lines
end

function age_fish!(f::Fish)
    f.timer -= 1
end

function reproduce!(school::Vector{Fish})
    for f in school
        if f.timer < 0
            f.timer = 6
            push!(school, Fish(8))
        end
    end
end

function main()
    input = read_input()
    school = Vector{Fish}()
    for i in input
        push!(school, Fish(i))
    end
    for d in 1:80
        println(d)
        for f in school
            age_fish!(f)
        end
        reproduce!(school)
    end
    #println(school)
    println(length(school))
end

main()