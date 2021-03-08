function whoaRound(n, dp)
    return math.floor((n * 10^dp) + .5) / (10^dp)
end

function whoaFormatNr(n)
    local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)')
    return left..(num:reverse():gsub('(%d%d%d)', '%1'.."."):reverse())..right
end
