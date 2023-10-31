l = 2.25
d = 0.65

p = seq(0, 1, 0.001)
w = p^d/((p^d + (1-p)^d)^(1/d))

b = l*p/(1 - p + l*p)
b2 = (1/l)*p/(1 - p + (1/l)*p)

for(ii in 1:4){
  pdf(paste("decomposition_distortions", ii, ".pdf", sep=""), height = 4, width = 8)
  par(mar = c(6, 6, 2, 2) + 0.1)
  plot(p, w, type = 'l', lwd = 2, col = "red", xlab = "Probability",
       ylab = "Weighted probability", xaxs = "i", yaxs = "i",
       cex.axis = 1.3, cex.lab = 1.3)
   if(ii > 1){
    par(new = TRUE)
    plot(p, b, type = 'l', lwd = 2, lty = 1, col = "blue", xlab = "",
         ylab = "", xaxs = "i", yaxs = "i",
         cex.axis = 1.3, cex.lab = 1.3)
    if(ii > 2){
      par(new = TRUE)
      plot(p, b2, type = 'l', lwd = 2, lty = 4, col = "blue", xlab = "",
           ylab = "", xaxs = "i", yaxs = "i",
           cex.axis = 1.3, cex.lab = 1.3)
      if(ii > 3){
      par(new = TRUE)
      plot(p, p, type = 'l', lwd = 2, lty = 3, col = "gray", xlab = "",
           ylab = "", xaxs = "i", yaxs = "i",
           cex.axis = 1.3, cex.lab = 1.3)
      }
    }
  }
  dev.off()
}
