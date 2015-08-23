load("bigram.w.Rda")
load("trigram.w.Rda")
load("quadgram.w.Rda")

library(tm)
library(SnowballC)
library(RXKCD)
library(RWeka)
library(slam)
library(data.table)

badWords <- scan("./badwords", "")

set.seed(123)
options(mc.cores=1)