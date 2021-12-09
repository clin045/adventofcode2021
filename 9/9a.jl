using DelimitedFiles

function read_input()
    lines = readdlm("9/input.txt",'\n',String)
    map = zeros(Int16, (length(lines),length(lines[1])))
    for l in 1:length(lines)
        for c in 1:length(lines[l])
            num = parse(Int8, lines[l][c])
            map[l, c] = num
        end
    end
    return map
end

function lowpoints(map)
    ibound = size(map)[1]
    jbound = size(map)[2]
    lowpoints = []
    for i in 1:ibound
        for j in 1:jbound
            if i - 1 < 1
                left = 1000
            else
                left = map[i-1,j]
            end
            if i + 1 > ibound
                right = 1000
            else
                right = map[i+1,j]
            end
            if j - 1 < 1
                up = 1000
            else
                up = map[i,j-1]
            end
            if j + 1 > jbound
                down = 1000
            else
                down = map[i,j+1]
            end
            min_neighbor = minimum([up,down,left,right])
            if min_neighbor > map[i,j]
                push!(lowpoints, map[i,j])
            end

        end
    end
    return lowpoints
end


function main()
    map = read_input()
    #display(map)
    low = lowpoints(map)
    println(sum(1 .+ low))
end

main()
