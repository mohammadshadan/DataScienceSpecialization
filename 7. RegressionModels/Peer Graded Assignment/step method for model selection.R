step <- step(lm(mpg ~ ., mtcars), trace = 0); summary(step)
