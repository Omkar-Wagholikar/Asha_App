import enchant

d = enchant.Dict("en_US")
en_us_weird_words = ['panipuri']

for word in en_us_weird_words:
    d.add_to_session(word)

print(d.check("Asha"))
print(d.suggest("Asha"))