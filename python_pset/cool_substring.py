# all substring of len = 4 which have no repeating characters are considered 'cool' strings.
# Return count of cool sub-string in a given string.
#
# Input : abcdcad
#
# substring:
# abcd - cool
# bcfc - not cool
# cdca - cool
# dcad - not cool
#
# cool count = 1


def cool_count(str):
    cool = 0
    for i in range(0,len(str)-3):
        sub = str[i:i+4]

        if len(set(sub)) == 4:
            cool = cool + 1
    return cool


cool_no = cool_count('abcdcad')
print(cool_no)

