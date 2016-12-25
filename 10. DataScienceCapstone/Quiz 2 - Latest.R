
text123 <- wf_sample_4gram$word[grep("a case of",wf_sample_4gram$word, fixed = TRUE)]
text123

text123 <- wf_sample_4gram$word[grep("would mean the",wf_sample_4gram$word, fixed = TRUE)]
text123

text123 <- wf_sample_4gram$word[grep("make me",wf_sample_4gram$word, fixed = TRUE)]
text123

text123 <- wf_sample_4gram$word[grep("Bills game",wf_sample_4gram$word, fixed = TRUE)]
text123


#Go on a romantic date at the
text123 <- wf_sample_4gram$word[grep("date at",wf_sample_4gram$word, fixed = TRUE)]
text123

#Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my
text123 <- wf_sample_4gram$word[grep("be on my",wf_sample_4gram$word, fixed = TRUE)]
text123


#7. Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some
text123 <- wf_sample_4gram$word[grep("in quite some",wf_sample_4gram$word, fixed = TRUE)]
text123

#8. After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little
text123 <- wf_sample_4gram$word[grep(" his little",wf_sample_4gram$word, fixed = TRUE)]
text123

#9. Be grateful for the good times and keep the faith during the
text123 <- wf_sample_4gram$word[grep("during the sad",wf_sample_4gram$word, fixed = TRUE)]
text123

#10. If this isn't the cutest thing you've ever seen, then you must be
text123 <- wf_sample_4gram$word[grep("be insane",wf_sample_4gram$word, fixed = TRUE)]
text123


dim(wf_sample_4gram)
head(wf_sample_4gram)
tail(wf_sample_4gram)
write.csv(wf_sample_4gram, file = "quad_gram.csv")
          