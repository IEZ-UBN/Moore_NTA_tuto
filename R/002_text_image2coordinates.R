#-------------------------------------------------------------------------------

# Converting image matrix data into xy coordinates using Moore tracing algo

#-------------------------------------------------------------------------------
#Source function for Moore tracing algo

source("./R/functions/Moore_NTA.R")

#-------------------------------------------------------------------------------
#Import R object containing images as text images. 

load("./ls_mat.RData")
N_mat <- length(ls_mat)

#-------------------------------------------------------------------------------
#Convert matrices of pixel values to matrices of x,y coordinates

NLM <- 100 #Define number of landmarks to keep along line
prog <- T #Define if you want to see the algorithm in action

ls_coord <- list() #Initiate empty list

for (i in 1:N_mat) {
  ls_coord[[i]] <- Moore.alg(ls_mat[[i]], NLM = NLM, progress = prog)
} 
# Note each element of the list is a list of two matrices
# the $o matrix with all points
# the matrix $subo with subsampled points

#-------------------------------------------------------------------------------
#Extract subsampled matrices and place them in array, which will be exported

arr_coords <- array(NA, dim = c(NLM, 2, N_mat))

for (i in 1:N_mat) {
  arr_coords[,,i] <- ls_coord[[i]]$subo
}

save(arr_coords, file = "arr_coords.RData")
