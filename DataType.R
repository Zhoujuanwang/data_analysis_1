# 基本的数据类型
# 1 and 1L
a <- 1
class(a)
b <- 1L
class(b)  # The type of a is "numeric" while the type of b is "integer"

# 向量
a <- c(1:10)
a
class(a)  # 向量中的元素都是同一类型的

a <- c(T, "a")
a  # 当向量中元素类型不同时，将自动将其统一为统一类型

# list
list_1 <- list(c("a", "b", "c"), c(T, F, F) ,c(1+4i, 6+6i), c(1 ,2, 4, 5))
list_1 
# list可以看作时多个数据类型的集合，其中的元素可以是dataframe、matrix，或者是普通的向量
a <- matrix(1:6, ncol = 3, nrow = 2)
a
list_2 <- list(a, mtcars, c(1, 2, 3))
list_2

# matrix
a <- matrix(1:6, ncol=2, nrow=3)
a
b <- 1:12
dim(b) <- c(3, 4)
b

# 矩阵的拼接
a <- 3:6
b <- 6:9
cbind(a, b)

x <- 4:8
y <- 8:12
rbind(x, y)

# 矩阵行列重命名
m <- matrix(1:12, ncol = 3, nrow = 4)
colnames(m) <- c("L1", "L2", "L3")
row.names(m) <- c("R1", "R2", "R3", "R4")
m
# 或者直接用dimnames()函数，名称是一个列表，前面的表示行的名字，后面的为列的名字
m <- matrix(1:12, ncol = 3, nrow = 4)
dimnames(m) <- list(c("R1", "R2", "R3", "R4"), c("L1", "L2", "L3"))
m

# factors 因子变量，做线性模型时常用
# 普通因子
a <- factor(c("poor", "improved", "excellent", "poor", "improved", "poor"))
a
# 有序型因子 ordered = T
a <- factor(c("poor", "improved", "excellent", "poor", "improved", "poor"),
            ordered = T)
a
a <- factor(c("poor", "improved", "excellent", "poor", "improved", "poor"),
            ordered = T,
            levels = c("poor", "improved", "excellent"))
a # levels的顺序表示排序

# 为数字类型的因子添加标签：
gender <- c(1, 2, 1, 2, 1, 1, 2, 2)
sex <- factor(gender, levels = c(1, 2), labels = c("female", "male"))
sex
table(x)


