function conky_pad(value, padding)
    return string.format(string.format('%%%is', conky_parse(padding)), conky_parse(value))
end
