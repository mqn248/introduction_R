#coerce numeric to character
num <- 2.2
class(num)
num_char <- as.character(num)
num_char
class(num_char)
my_mat <-matrix(1:16, nrow =4, byrow = TRUE)
my_array <- array(1:16, dim = c(2, 4, 2))
my_array
rownames(my_mat) <- c("A", "B", "C", "D")
colnames(my_mat) <- c("a", "b", "c", "d")
my_mat
my_mat_t <- t(my_mat)
