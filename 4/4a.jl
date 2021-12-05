using DelimitedFiles

function read_input()
    f = open("4/input.txt")
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

function score_boards(marks, boards)
    marked_boards = zeros(Int8,size(boards))
    for m in marks
        marked_boards[m] = 1
    end
    # horizontal
    hsum = sum(marked_boards,dims=1)
    hwins = findall(x -> x >= 5, hsum)
    if length(hwins) > 0
        return true, hwins[1][3]
    end
    # vertical
    vsum = sum(marked_boards,dims=2)
    vwins = findall(x -> x >= 5, vsum)
    if length(vwins) > 0
        return true, vwins[1][3]
    end
    return false, undef
end

function main()
    draws, boards = read_input()
    marks = []
    winning_board = 0
    for d in draws
        mark_boards!(marks, boards, d)
        (won, winning_board) = score_boards(marks, boards)
        if won
            for m in marks
                boards[m] = 0
            end
            unmarked_sum = sum(boards[:,:,winning_board])
            print(unmarked_sum * d)
            break
        end
    end
end

main()