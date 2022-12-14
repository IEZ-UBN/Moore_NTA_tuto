#-------------------------------------------------------------------------------

# Analyzing and plotting the subsampled suture lines landmarks

#-------------------------------------------------------------------------------
# Functions for Geometric Morphometrics (from J. Claude 2008 book)
# Library for some plotting fun

source("R/functions/Rfunctions1.txt")
library(grid)
#-------------------------------------------------------------------------------
# Load R data object containing array of xy coordinates for suture lines

load("./arr_coords.RData")

#-------------------------------------------------------------------------------
#Define variables and align the shapes based on first and last landmarks

N <- dim(arr_coords)[3]
NLM <- dim(arr_coords)[1]

aligned_lines <- booksteinA(arr_coords, 1, NLM) 
#Bookstein baseline alignement

#-------------------------------------------------------------------------------
#Plot with separate panels and save as PDF to specific folder

pdf(file = "./Figures/split_panels.pdf", width = 5, height = 5)
layout(matrix(1:4, nrow = 2))
par(mar = c(2,2,2,2))
for (i in 1:N) {
  plot(aligned_lines[, 1, i], 
       aligned_lines[, 2, i], 
       pch=20, 
       cex = 1.5, 
       col = i)
  lines(aligned_lines[c(1:NLM, NA), 1, i], 
        aligned_lines[c(1:NLM, NA), 2, i], 
        lwd=2, 
        col = i)
}
dev.off()

#-------------------------------------------------------------------------------
#Plot superimposed suture lines and save as PDF

pdf(file = "./Figures/superimposed.pdf", width = 5, height = 5)
plot(NA, NA, 
     xlim = c(min(aligned_lines[,1,]), max(aligned_lines[,1,])), 
     ylim = c(min(aligned_lines[,2,]), max(aligned_lines[,2,])))

for (i in 1:N) {
  points(aligned_lines[, 1, i], 
       aligned_lines[, 2, i], 
       pch=20, 
       cex = 1.5, 
       col = i)
  lines(aligned_lines[c(1:NLM, NA), 1, i], 
        aligned_lines[c(1:NLM, NA), 2, i], 
        lwd=2, 
        col = i)
}
dev.off()

#-------------------------------------------------------------------------------
#Make PCA on superimposed coordinates and plot

mat_coords <- matrix(NA, ncol = NLM*2, nrow = N)
#Initiate empty matrix for coordinates (indiv as rows, variables as columns)

for (i in 1:N) {
  mat_coords[i,] <- aligned_lines[,,i]
}

pca_lines <- prcomp(mat_coords)

#-------------------------------------------------------------------------------
#Playing around to make PCA plot nicer


plot(pca_lines$x[, 1:2], 
     pch = 20, 
     cex = 2, 
     col = c(1:N))
text(pca_lines$x[, 1:2], 
     labels = c(1:4),
     col = c(1:4),
     font = 2,
     pos = 1
     )

for (i in 1:N) { # Add subplots of line shapes within the plot

loc <- grid.locator(unit = "npc") #You'll have to click four times on the plot!
x <- loc$x
x <- as.numeric(gsub("npc", replacement = "", x=x))
y <- loc$y
y <- as.numeric(gsub("npc", replacement = "", x=y))

par(mfg = c(1,1), plt = c(x, x + 0.2, y, y + 0.1))

plot(aligned_lines[,,i], 
     new = F, 
     type = "l", 
     col = i, 
     xlab = "", 
     ylab = "", 
     axes = F)

}

dev.copy2pdf(file = "./Figures/pca_with_shapes.pdf", out.type = "pdf")

