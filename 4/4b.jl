using DelimitedFiles

function read_input()
    f = open("4/input.txt")
    #f = open("4/test.txt")
    lines = readdlm(f)
    close(f)
    draws = map(x->parse(Int8, x),split(lines[1,1],","))

    board_stream = lines[2:end,:]
    boards = Array{Int8}(undef, 5,5,size(board_stream)[1] ÷ 5)
    for i in 1:5:size(board_stream)[1]-4
        boards[:,:,(i + 5) ÷ 5] = board_stream[i:i+4,:]
    end
    return draws, boards
end

function mark_boards!(marks, boards, draw)
    new_marks = findall(x -> x == draw, boards)
    for n in new_marks
        push!(marks,n)
    end

    
end

function score_boards(marks, boards,exclude)
    marked_boards = zeros(Int8,size(boards))
    #filt_marks = filter(x -> x[3] ∉ exclude, marks)
    filt_marks = marks
    for m in filt_marks
        marked_boards[m] = 1
    end
    # horizontal
    hsum = sum(marked_boards,dims=1)
    hwins = findall(x -> x >= 5, hsum)

    # vertical
    vsum = sum(marked_boards,dims=2)
    vwins = findall(x -> x >= 5, vsum)
    if length(vwins) > 0 || length(hwins) > 0
        return true, vcat(map(x->x[3],hwins), map(x->x[3],vwins))
    end
    return false, undef
end

function main()
    draws, boards = read_input()
    println(size(boards))
    marks = []
    winning_board = 0
    n_won = 0
    already_won = []
    last_winning_draw = draws[1]
    last_winning_markset = copy(marks)
    for d in draws
        println(string("draw ", d))
        mark_boards!(marks, boards, d)
        (won, winning_boards) = score_boards(marks, boards, already_won)
        n_won += won
        if won
            #println(size(already_won))
            #println(length(marks))
            for w in winning_boards
                #println(string(w, " ", already_won))
                if(w ∉ already_won)
                    println("new win")
                    last_winning_draw = d
                    last_winning_markset = copy(marks)
                    push!(already_won, w)
                end
            end 
        end
    end
    # println(already_won)
    # println(size(marks))
    # println(size(last_winning_markset))
    for m in last_winning_markset
        boards[m] = 0
    end
    display(boards[:,:,already_won[end]])
    unmarked_sum = sum(boards[:,:,already_won[end]])
    # println(unmarked_sum)
    println(last_winning_draw)
    # println(already_won[end])
    println(unmarked_sum * last_winning_draw)
    
end

main()