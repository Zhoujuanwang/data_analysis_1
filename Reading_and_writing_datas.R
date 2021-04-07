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


