#!/usr/bin/env Rscript

library(ggplot2) # load up the ggplot2 library

# load up the data from the google csv export
smst <- read.csv('data.csv')

# force count to be a factor instead of a continuous variable
smst$count <- factor(smst$count)

# calculate the mean for each type/count group
# this line is a bit funky
smst_mean <- melt(cast(smst, type ~ count, mean), id=c("type"))

png(filename = "submodule_vs_subtree.png", width=700, height=700)

ggplot(smst_mean, aes(x=count, y=value, group=type, color=type)) + geom_line(size = 2) + ylab("time") + xlab("plugin count") + opts(title = "Submodule vs. Subtree checkout times")
