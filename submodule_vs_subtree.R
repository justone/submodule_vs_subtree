#!/usr/bin/env Rscript

library(ggplot2) # load up the ggplot2 library

# load up the data from the google csv export
smst <- read.csv('data.csv')

# add names to the data
names(smst) <- c('type', 'count', 'time')

# force count to be a factor instead of a continuous variable
smst$count <- factor(smst$count)

# calculate the mean for each type/count group
smst_mean <- aggregate(list(time=smst$time), list(type=smst$type, count=smst$count), mean)

png(filename = "submodule_vs_subtree.png", width=700, height=700)

ggplot(smst_mean, aes(x=count, y=time, group=type, color=type)) + geom_line(size = 2) + ylab("time") + xlab("plugin count") + opts(title = "Submodule vs. Subtree checkout times")
