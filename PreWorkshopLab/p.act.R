



# pvalues <- reg.r.summary$LRT.p  # get p-values from the analyses for the risk factors you are interested in
# p.act <- P.act(IDs=SNP.IDs, Ps=pvalues, X=X, y=Y, W=NULL)


# implements a version of p-act that returns adjusted p-values

##############  The P-Act approach for adjusting for multiple comparison ############
## need library(mvtnorm) first
## IDs: The IDs for Ps and Xs; 
## Ps: A vector of P-values in the same order of IDs
## X: A matrix of the factors, whose colnames should be IDs
## y: the outcome
## W: covariates
library(mvtnorm)
library(MASS)

P.act<-function(IDs=IDs,Ps=Ps,X=X,y=y,W=W){
  
  X<-X[,!is.na(Ps)]
  NA.ids<-IDs[is.na(Ps)]
  IDs.back<-IDs
  IDs<-IDs[!is.na(Ps)]
  
  Ps<-Ps[!is.na(Ps)]
  
  cutoff<-0.1
  level1=25000
  cutoff2=.05
  level2=250000
  cutoff3=.01
  level3=2500000
  cutoff4=.00001
  level4=25000000
  
  #### imputing the missings #######
  #X<-apply(X,2,iGs,imputation.method="expectation")
  #y<-iGs(y,imputation.method="expectation")
  #if (is.null(W)) W<-rep(1,nrow(X)) else {
  #  W<-apply(W,2,iGs,imputation.method="expectation")
  #}
  
  #### calculating the covarance matrix #####   
  corg<-cov2cor(t(X)%*%X - t(X)%*%W %*% ginv(t(W)%*%W) %*% t(W)%*%X)  
  cory=cor(as.matrix(y))
  v=kronecker(cory,corg)
  rank=order(Ps)
  v_orig=v[rank,rank]
  ordered=Ps[rank]
  IDs<-IDs[rank]
  ##### permuting ########  
  stop=0
  i=1
  v=v_orig
  L<-length(Ps)
  P_adj<-{}
  while (stop==0) {
    #print(i)
    minp=ordered[i]
    if (minp==0) {p_ACT=0}      
    if (minp>0) {
      lower=rep(qnorm(minp/2),(L+1-i))
      upper=rep(qnorm(1-minp/2),(L+1-i))
      p_ACT=1-pmvnorm(lower=lower,upper=upper,sigma=v,maxpts=level1,abseps=.0000000000001)
      if (p_ACT<cutoff4) {
        p_ACT=1-pmvnorm(lower=lower,upper=upper,sigma=v,maxpts=level4,abseps=.0000000000001)
      } else  if (p_ACT<cutoff3) {
        p_ACT=1-pmvnorm(lower=lower,upper=upper,sigma=v,maxpts=level3,abseps=.0000000000001)
        
      }  else  if (p_ACT<cutoff2) {
        p_ACT=1-pmvnorm(lower=lower,upper=upper,sigma=v,maxpts=level2,abseps=.0000000000001)
        
      } 
    }
    if (i<length(Ps)) {
      v=v[-1,-1]
      i=i+1
    } else stop=1
    
    P_adj<-c(P_adj,p_ACT)
  }
  
  if (length(NA.ids)!=0) {
    NAs<-rep(NA,length(NA.ids))
    P_adj<-c(P_adj,NAs)
    
  }
  names(P_adj)<-c(IDs,NA.ids)
  P_adj<-P_adj[IDs.back]   
  P_adj
} 



