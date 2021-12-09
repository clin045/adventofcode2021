using DelimitedFiles
using LinearAlgebra

function process_line(l)
    splitted = split(l," -> ")
    src_nums = split(splitted[1],",")
    dst_nums = split(splitted[2],",")
    src = (parse(Int32, src_nums[1]),parse(Int32, src_nums[2]))
    dst = (parse(Int32, dst_nums[1]),parse(Int32, dst_nums[2]))
    return (src, dst)
end

function read_input()
    f = open("5/input.txt")
    rawlines = readdlm(f,'\n')
    processed = map(x -> process_line(x),rawlines)
    return processed
end

function blank_map(lines)
    x_vals = []
    y_vals = []
    for l in lines
        push!(x_vals, l[1][1])
        push!(x_vals, l[2][1])
        push!(y_vals, l[1][2])
        push!(y_vals, l[2][2])
    end
    max_x = maximum(x_vals) + 1
    max_y = maximum(y_vals) + 1
    return zeros(Int32,(max_x,max_y))

end

function mark_map(l,map)
    (src, dst) = l
    marked_map = zeros(size(map))
    
    # diagonals
    if src[1] != dst[1] && src[2] !=dst[2]
        #println(src, dst)
        dx = dst[1] - src[1]
        dy = dst[2] - src[2]
        n_steps = abs(dx)
        unit_x = dx/n_steps
        unit_y = dy/n_steps
        for i in 0:n_steps
            x = Integer(src[1]+1 + i*unit_x)
            y = Integer(src[2]+1 + i*unit_y)
            #println((x, y))
            marked_map[x,y] = 1
        end
        #display(marked_map)
        return marked_map
    end
    
    if dst[1] < src[1]
        xstart = dst[1]
        xend = src[1]
    else
        xstart = src[1]
        xend = dst[1]
    end
    
    if dst[2] < src[2]
        ystart = dst[2]
        yend = src[2]
    else
        ystart = src[2]
        yend = dst[2]
    end
    
    marked_map[xstart+1:xend+1,ystart+1:yend+1] .= 1
    return marked_map
    
end

function main()
    lines = read_input()
    map = blank_map(lines)
    for l in lines
        marked_map = mark_map(l,map)
        map += marked_map
        #display(map)

    end
    #display(reverse(rotl90(map,3),dims=2))
    print(length(findall(x->x>=2,map)))
end

main()