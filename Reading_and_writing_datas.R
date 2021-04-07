# reading data:
# 1 读取表格类数据：
read.table()
read.csv()

# for reading lines of a text file:
readLines()
readLines("leu.txt")

# reading in R code files(inverse of dump)
source()
# reading in R code files(inverse of dump)
dget()
# for reading in saved workspaces
load()
# for reading single R object in binary form
unserialize()

# analogous functions for writing datas to files:
write.table()
writeLines()
dump()
dput()
save()
serialize()

args(read.table)
str(read.table)

# dput() and dget()
x <- c(1, 2, 3, 5, 8, 10)
Author <- c("meta", "cox", "inverse", "simultaneous", "cosmopolitan", "sovereign")
SD <- c(12.3, 4.5, 6.7, 8.9, 12.01, 5.6)
mydata <- data.frame(x, Author, SD)
dput(mydata)
dput(mydata, file = "dupt_try.R")
newdata <- dget("dupt_try.R")
newdata

# multiple objects can be deparsed using the dump() function and read 
#back in using source()
a <- "foo"
dump(c("a", "newdata"), file = "dump_try.R")
rm(a, newdata)
source("dump_try.R")


