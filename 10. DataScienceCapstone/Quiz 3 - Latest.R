
#1. When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd
text123 <- wf_sample_5gram$word[grep("id live and id",wf_sample_5gram$word, fixed = TRUE)]
text123
text123 <- wf_sample_4gram$word[grep("live and id",wf_sample_4gram$word, fixed = TRUE)]
text123 <- wf_sample_3gram[,grep("live and id ",wf_sample_3gram$word, fixed = TRUE)]
text123

#2. Guy at my table's wife got up to go to the bathroom and I asked about dessert and he 
#started telling me about his
text123 <- wf_sample_5gram$word[grep("me about his",wf_sample_5gram$word, fixed = TRUE)]
text123

#3. I'd give anything to see arctic monkeys this
text123 <- wf_sample_5gram$word[grep("see arctic monkeys this",wf_sample_5gram$word, fixed = TRUE)]
text123

#4. Talking to your mom has the same effect as a hug and helps reduce your
text123 <- wf_sample_5gram$word[grep("helps reduce your",wf_sample_5gram$word, fixed = TRUE)]
text123 <- wf_sample_4gram$word[grep("helps reduce your",wf_sample_4gram$word, fixed = TRUE)]
text123

#5. When you were in Holland you were like 1 inch away from me but you hadn't time to take a
text123 <- wf_sample_5gram$word[grep("time to take a",wf_sample_5gram$word, fixed = TRUE)]
text123

text123 <- wf_sample_5gram$word[grep("picture",wf_sample_5gram$word, fixed = TRUE)]
text123

text123 <- wf_sample_5gram$word[grep("jury to settle the",wf_sample_5gram$word, fixed = TRUE)]
text123 <- wf_sample_4gram$word[grep("to settle the",wf_sample_4gram$word, fixed = TRUE)]
text123


text123 <- wf_sample_5gram$word[grep("in each hand",wf_sample_5gram$word, fixed = TRUE)]
text123

#7. I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each
text123 <- wf_sample_5gram$word[grep("settle the",wf_sample_5gram$word, fixed = TRUE)]
text123


#8. Every inch of you is perfect from the bottom to the

text123 <- wf_sample_5gram$word[grep("bottom to the",wf_sample_5gram$word, fixed = TRUE)]
text123

#9. I'm thankful my childhood was filled with imagination and bruises from playing

text123 <- wf_sample_5gram$word[grep("from playing",wf_sample_5gram$word, fixed = TRUE)]
text123


#10. I like how the same people are in almost all of Adam Sandler's

text123 <- wf_sample_5gram$word[grep("Adam Sandlers",wf_sample_5gram$word, fixed = TRUE)]
text123


dim(wf_sample_5gram)
head(wf_sample_5gram)
tail(wf_sample_5gram)
write.csv(wf_sample_5gram, file = "quad_gram.csv")
