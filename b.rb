$hi = Hash.new

get_counter = gets.chomp.to_i
mm2 = Hash.new
mm3 = Array.new

c = 0
for n in 1..get_counter
    m = gets.chomp.split(' ')
    f = Array.new
    m.each do |i|
        f << i.to_i
    end
    mm3[c] = Array.new
    mm2[c] = f
    c += 1
end

master = [2]

find_sosu = lambda do
    t = master.max+1
    check = true
    while check
        c3 = 0
        master.each do |xx|
            c3 += 1
            if t%xx == 0
                t += 1
                break
            end
        end
        if master.length == c3
            check = false
        end
    end
    master << t
    return t
end

robot = lambda do |mm, y, x, total_value, total_where, ey, ex, sosu|
    if y == ey and x == ex
        t = total_value + mm[y][x]
        $hi[t] = total_where
    else
        begin
            if mm3[y][x] == nil
                mm3[y][x] = Array.new
            end
            tto = find_sosu[]
            sosu2 = sosu*tto
            mm3[y][x] << tto
            t = total_value + mm[y][x]
            check = 0
            if y >= 0 and x >= 0
                if mm[y+1] != nil
                    if mm[y+1][x] != nil
                        nx = true
                        if mm3[y+1][x] == nil
                            nx = true
                        else
                            mm3[y+1][x].each do |sosu3|
                                if sosu2%sosu3 == 0
                                    nx = false
                                    break
                                end
                            end
                        end

                        if nx
                            robot[mm, y+1, x, t, total_where+'D', ey, ex, sosu2]
                            check = 1
                        end
                    end
                end

                if mm[y-1] != nil
                    if mm[y-1][x] != nil
                        nx = true
                        if mm3[y-1][x] == nil
                            nx = true
                        else
                            mm3[y-1][x].each do |sosu3|
                                if sosu2%sosu3 == 0
                                    nx = false
                                    break
                                end
                            end
                        end

                        if nx
                            robot[mm, y-1, x, t, total_where+'U', ey, ex, sosu2]
                            check = 1
                        end
                    end
                end

                if mm[y][x+1] != nil
                    nx = true
                    if mm3[y][x+1] == nil
                        nx = true
                    else
                        mm3[y][x+1].each do |sosu3|
                            if sosu2%sosu3 == 0
                                nx = false
                                break
                            end
                        end
                    end

                    if nx
                        robot[mm, y, x+1, t, total_where+'R', ey, ex, sosu2]
                        check = 1
                    end

                end

                if mm[y][x-1] != nil
                    nx = true
                    if mm3[y][x-1] == nil
                        nx = true
                    else
                        mm3[y][x-1].each do |sosu3|
                            if sosu2%sosu3 == 0
                                nx = false
                                break
                            end
                        end
                    end
                    if nx
                        robot[mm, y, x-1, t, total_where+'L', ey, ex, sosu2]
                        check = 1
                    end
                end
            end
        rescue

        end
    end
end

robot[mm2, 0, 0, 0, '', mm2.length-1, mm2[0].length-1, 1]
v = $hi.keys.max
puts v
puts $hi[v]