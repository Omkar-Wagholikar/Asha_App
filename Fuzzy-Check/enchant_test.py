import enchant

d = enchant.Dict("en_US")
en_us_weird_words = ['taty']

for word in en_us_weird_words:
    d.add_to_session(word)

print(d.check("taty"))
print(d.suggest("taty"))