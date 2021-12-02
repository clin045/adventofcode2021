using DelimitedFiles

function process_instructions(ins)
    instructions = Vector{Tuple{String, Int32}}(undef,size(ins)[1])
    for i in 1:size(ins)[1]
        instructions[i] = (ins[i,1],parse(Int32,ins[i,2]))
    end
    return instructions
end

function exec_instruction(ins, cur_pos)
    ins_dict = Dict(
        "forward" => ((x,k) -> (x[1] + k,x[2]+(k*x[3]),x[3])),
        "back" => ((x,k) -> (x[1] - k,x[2]-(k*x[3]),x[3])),
        "up" => ((x,k) -> (x[1],x[2],x[3]-k)),
        "down" => ((x,k) -> (x[1],x[2],x[3]+k)),
    )
    return ins_dict[ins[1]](cur_pos,ins[2])
end

function main()
    f = open("2/input.txt","r")
    #f = open("2/test.txt","r")
    instructions_raw = readdlm(f,String)
    close(f)
    instructions = process_instructions(instructions_raw)
    # (horizontal, depth, aim)
    cur_pos = (0,0,0)
    for i in instructions
        cur_pos = exec_instruction(i,cur_pos)
    end
    println(cur_pos)
    println(cur_pos[1]*cur_pos[2])
end
main()