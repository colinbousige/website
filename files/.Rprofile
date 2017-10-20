# Sample Rprofile.site file


.First <- function(){
 library(R.utils)
 library(signal)
 library(Hmisc)
 library(plotrix)
 library(nls2)
 library(rgl)
 cat("\nWelcome at", date(), "\n")
}

options(device="quartz")

THz_to_cm <- 8.066/0.24185       # Convert THz to cm-1
Ma        <- 1.6605402e-27       # Unité de masse atomique en kg
Na        <- 6.02214129e23       # Avogadro number in mol^(-1)
Mn        <- 1.67494e-27         # Masse du neutron en kg
mC        <- 12.0107
mH        <- 1.00794
mO        <- 15.9994
mN        <- 14.0067
R         <- 8.3144621           # Gas constant in J/K/mol
kB        <- 1.38058e-23         # Boltzmann constant in J/K
kB_eV     <- 8.6173423e-5        # Boltzmann constant in eV.K-1  
h         <- 1.05457266e-34*2*pi # Planck cst in J.s
h_eV      <- 6.582122e-16*2*pi   # Planck cst in eV.s
hbar      <- 1.05457266e-34      # hbar in J.s
hbar_eV   <- 6.582122e-16        # hbar in eV.s
c         <- 299792458           # Vitesse de la lumiere en m.s-1


constantes <- matrix(ncol=2,nrow=16)
colnames(constantes) <- c("Value","Unit")
rownames(constantes) <- c("THz_to_cm","Ma","Na","Mn","mC","mH","mO","mN","R","kB","kB_eV","h","h_eV","hbar","hbar_eV","c")
constantes[,1] <- c(THz_to_cm,Ma,Na,Mn,mC,mH,mO,mN,R,kB,kB_eV,h,h_eV,hbar,hbar_eV,c)
constantes[,2] <- c("Convert THz to cm-1","Atomic mass unit in kg","Avogadro number in mol^(-1)","Neutron mass in kg","Carbon","Hydrogen","Oxygen","Nitrogen","Gas constant in J/K/mol","Boltzmann constant in J/K","Boltzmann constant in eV.K-1","Planck cst in J.s","Planck cst in eV.s","hbar in J.s","hbar in eV.s","Speed of light m.s-1")


reb <- function(u, N){
	M <- dim(u)[1]
	sep <- M / N	
	if(N >= M){
		return("Requested size is longer than initial vector")
	}
	
	if(dim(u)[2] == 1){
		x <- 1:M
		y <- u[,1]
		dy <- rep(1,M)
	}
	if(dim(u)[2] == 2){
		u <- u[order(u[,1]),]
    x <- u[,1]
		y <- u[,2]	
		dy <- rep(1,M)
	}
	if(dim(u)[2] == 3){
		u <- u[order(u[,1]),]
    x <- u[,1]
		y <- u[,2]	
		dy <- u[,3]	
	}
	
	xj <- seq(x[1], x[M], length = N+1 )
	yj <- sapply(1:N, function(i){
			weighted.mean(y[which(x>=xj[(i)] & x<=xj[i+1])],
						 dy[which(x>=xj[(i)] & x<=xj[i+1])])
			})
	dyj <- sapply(1:N, function(i){sqrt(sum((dy[which(x>=xj[(i)] & x<=xj[i+1])])^2))})
	dx <- xj[2] - xj[1]
	xj <- xj[2:(N+1)] - dx / 2
	
	if(dim(u)[2] == 3){
		data.frame(x = xj, y = yj, dy = dyj)
	}else{
		data.frame(x = xj, y = yj)
	}
}

axislog <- function(ax,min,max,step=1,labels=TRUE,lwd=1){
    range    <- min:max
    if(labels){label <- sapply(seq(min,max,step),function(i) as.expression(bquote(10^ .(i))))}
    ticksat  <- as.vector(sapply(range, function(p) (1:10)*10^p))
    if(labels){
      if(step==1){axis(ax,at=10^range,labels=label,lwd.ticks=lwd)}
      else{
        axis(ax,at=10^range,labels=FALSE,lwd.ticks=lwd)
        axis(ax,at=10^seq(min,max,step),labels=label,lwd.ticks=lwd)
      }
    }
    else{axis(ax,at=10^range,labels=FALSE,lwd.ticks=lwd)}
    axis(ax, ticksat, labels=NA, tcl=0.25, lwd=0, lwd.ticks=lwd)
}

mgpaxislog <- function(ax,min,max,labels=TRUE,lwd=1){
    range    <- min:max
    if(labels){label <- sapply(range,function(i) as.expression(bquote(10^ .(i))))}
    ticksat  <- as.vector(sapply(range, function(p) (1:10)*10^p))
    if(labels){mgp.axis(ax,at=10^range,labels=label,lwd.ticks=lwd)}
    else{mgp.axis(ax,at=10^range,labels=FALSE,lwd.ticks=lwd)}
    mgp.axis(ax, ticksat, labels=NA, tcl=0.25, lwd=0, lwd.ticks=lwd)
}

Gaussian <- function(x,x0,FWHM){
    2.*sqrt(2*log(2))/sqrt(2*pi)/FWHM*exp(-(x-x0)^2*4*log(2)/FWHM^2)
}


Lorentzian <- function(x,x0,FWHM){
    2/(pi*FWHM)/(1 + ((x-x0)/(FWHM/2))^2)
}

convolution <- function(data, FWHM, func="gaussian"){
    x_in <- data[,1]
    dx   <- x_in[2]-x_in[1]
    y_in <- data[,2]
    y_out <- y_in
    NpasX <- length(x_in)
    NpasY <- length(y_in)
    
    if(func=="gaussian"){
        for(ix in 1:NpasX){
            X     <- x_in[ix]
            IxRes <- y_in*Gaussian(x_in, X, FWHM)
            y_out[ix] <- sum(IxRes)*dx
        }
    }
    if(func=="lorentzian"){
        for(ix in 1:NpasX){
            X     <- x_in[ix]
            IxRes <- y_in*Lorentzian(x_in, X, FWHM)
            y_out[ix] <- sum(IxRes)*dx
        }
    }
    d <- data.frame(x_in,y_out)
}

sinc <- function(x){
	a <- which(x==0)
	b <- which(x!=0)
	y <- x
	y[b] <- sin(x[b])/x[b]
	y[a] <- 1.
	y
}

FFT <- function(d,corr=0){
  if(corr==0){f <- 1:length(d[,1])/max(d[,1])}
	if(corr==1){f <- 1:length(d[,1])/max(d[,1])*8.066/0.24185}
	y <- d[,2]
	Y <- fft(d[,2])
	FY <- sqrt(Re(Y)^2+Im(Y)^2)*2/length(y)
	out <- data.frame(f[1:(length(f)/2)],FY[1:(length(f)/2)])	
}

FFTLorch <- function(d,delta=1,corr=0){
  if(corr==0){f <- 1:length(d[,1])/max(d[,1])}
  if(corr==1){f <- 1:length(d[,1])/max(d[,1])*8.066/0.24185}
  y <- d[,2]
  Y <- fft( d[,2]*sinc(pi*d[,1]/(max(d[,1])/delta)) )
  FY <- sqrt(Re(Y)^2+Im(Y)^2)*2/length(y)
  out <- data.frame(f[1:(length(f)/2)],FY[1:(length(f)/2)]) 
}

FFTGauss <- function(d,FWHM=1,corr=0){
	if(corr==0){f <- 1:length(d[,1])/max(d[,1])}
  if(corr==1){f <- 1:length(d[,1])/max(d[,1])*8.066/0.24185}
	y <- d[,2]
	Y <- fft( d[,2]*Gaussian(d[,1],0.,FWHM) )
	FY <- sqrt(Re(Y)^2+Im(Y)^2)*2/length(y)
	out <- data.frame(f[1:(length(f)/2)],FY[1:(length(f)/2)])	
}

autocorr <- function(d){
  DIM<-length(d[1,])
  
  f <- 1:length(d[,1])/max(d[,1])
  y <- d[,2]
  Y <- vector("list", length(DIM))
  for (i in 2:DIM) {
    Y[[i]] <- fft(d[,i]) 
  }
  FY <- rep(0,length(y))
  for (i in 2:DIM) {
    FY <- FY + (Re(Y[[i]])^2+Im(Y[[i]])^2)/length(y)
  }
  dd <- data.frame(f,FY)

  f <- 1:length(dd[,1])/max(dd[,1])
  y <- dd[,2]
  Y <- fft(dd[,2], inverse = TRUE)
  data.frame(f,Y/length(y))

}



deriv <- function(x,y,n=1) {
  d  <- data.frame(x,y)
  for (i in 1:n) {
    x  <- d[,1]
    y  <- d[,2]
    dy <- diff(y)/diff(x)
    dx <- rowMeans(embed(x,2))
    d  <- data.frame(dx,dy)
  }
  d
}

integ <- function(d) {
  x <- d[,1]
	y <- d[,2]
  idx = 2:length(x)
  return (as.double( (x[idx] - x[idx-1]) %*% (y[idx] + y[idx-1])) / 2)
}

cone3d <- function(base=c(0,0,0),tip=c(0,0,1),rad=1,n=30,draw.base=TRUE,qmesh=FALSE,
                    trans = par3d("userMatrix"), ...) {
   ax <- tip-base
   if (missing(trans) && !rgl.cur()) trans <- diag(4)
   ### is there a better way?
   if (ax[1]!=0) {
     p1 <- c(-ax[2]/ax[1],1,0)
     p1 <- p1/sqrt(sum(p1^2))
     if (p1[1]!=0) {
       p2 <- c(-p1[2]/p1[1],1,0)
       p2[3] <- -sum(p2*ax)
       p2 <- p2/sqrt(sum(p2^2))
     } else {
       p2 <- c(0,0,1)
     }
   } else if (ax[2]!=0) {
     p1 <- c(0,-ax[3]/ax[2],1)
     p1 <- p1/sqrt(sum(p1^2))
     if (p1[1]!=0) {
       p2 <- c(0,-p1[3]/p1[2],1)
       p2[3] <- -sum(p2*ax)
       p2 <- p2/sqrt(sum(p2^2))
     } else {
       p2 <- c(1,0,0)
     }
   } else {
     p1 <- c(0,1,0); p2 <- c(1,0,0)
   }
   degvec <- seq(0,2*pi,length=n+1)[-1]
   ecoord2 <- function(theta) {
     base+rad*(cos(theta)*p1+sin(theta)*p2)
   }
   i <- rbind(1:n,c(2:n,1),rep(n+1,n))
   v <- cbind(sapply(degvec,ecoord2),tip)
   if (qmesh) 
     ## minor kluge for quads -- draw tip twice
     i <- rbind(i,rep(n+1,n))
   if (draw.base) {
     v <- cbind(v,base)
     i.x <- rbind(c(2:n,1),1:n,rep(n+2,n))
     if (qmesh)  ## add base twice
       i.x <-  rbind(i.x,rep(n+2,n))
     i <- cbind(i,i.x)
   }
   if (qmesh) v <- rbind(v,rep(1,ncol(v))) ## homogeneous
   if (!qmesh)
     triangles3d(v[1,i],v[2,i],v[3,i],...)
   else
     return(rotate3d(qmesh3d(v,i,material=...), matrix=trans))
 }  

WaveColor <- function(w){
  R <- rep(0.0,length(w))
  G <- rep(0.0,length(w))
  B <- rep(0.0,length(w))
  
  a <- which(w >= 380 & w < 440)
  R[a] <- -(w[a] - 440.) / (440. - 380.)
  G[a] <- 0.0
  B[a] <- 1.0
  
  b <- which(w >= 440 & w < 490)
  R[b] <- 0.0
  G[b] <- (w[b] - 440.) / (490. - 440.)
  B[b] <- 1.0
  
  c <- which(w >= 490 & w < 510)
  R[c] <- 0.0
  G[c] <- 1.0
  B[c] <- -(w[c] - 510.) / (510. - 490.)

  d <- which(w >= 510 & w < 580)
  R[d] <- (w[d] - 510.) / (580. - 510.)
  G[d] <- 1.0
  B[d] <- 0.0

  e <- which(w >= 580 & w < 645)
  R[e] <- 1.0
  G[e] <- -(w[e] - 645.) / (645. - 580.)
  B[e] <- 0.0

  f <- which(w >= 645 & w <= 780)
  R[f] <- 1.0
  G[f] <- 0.0
  B[f] <- 0.0
  
  rgb(R,G,B)
}


cleanMem <- function(x) { 
	rm(x)
	gc() 
}

.Last <- function(){
 cat("\nGoodbye at ", date(), "\n")
}




