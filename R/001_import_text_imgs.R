#-------------------------------------------------------------------------------
#
# Importing text images within R
#
#-------------------------------------------------------------------------------
# Define input directory containing text images and corresponding files

input_dir <- "./text_images/" # Change input directory as needed
ls_fil <- list.files(input_dir, pattern = "*.txt", full.names = T)
N_fil <- length(ls_fil)

#-------------------------------------------------------------------------------
# Initiate empty list to hold image matrices

ls_mat <- list()

#-------------------------------------------------------------------------------
# Fill list with matrices with a loop

for (i in 1:N_fil) {
  mat <- as.matrix(read.table(ls_fil[i]))
  ls_mat[[i]] <- mat
}

#-------------------------------------------------------------------------------
#Plot one of the images to check

image(ls_mat[[1]])

#-------------------------------------------------------------------------------
#Save as R object for easier importation in following scripts

save(ls_mat, file = "ls_mat.RData")
