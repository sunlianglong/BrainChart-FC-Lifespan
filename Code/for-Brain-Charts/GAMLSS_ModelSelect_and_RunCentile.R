
library(gamlss)
library(R.matlab)

args <- commandArgs(TRUE)
Datadir <- args[1]
idp_name <- args[2]
Outdir <- args[3]

M <- read.csv(paste0(Datadir, "/Data_", idp_name , ".csv"))
command <- paste0("M$phenotype <- M$", idp_name)
eval(parse(text = command))

M_HC <- M[1:33809, ]
M_DX <- M[33810:35084, ]

################################################################################ step 1: Model fitting
con<-gamlss.control(n.cyc=100)

mdl_bs1<-gamlss(phenotype~bs(Age,df=3) + Sex + meanFD,
                sigma.fo=~bs(Age,df=3) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs2<-gamlss(phenotype~bs(Age,df=4) + Sex + meanFD,
                sigma.fo=~bs(Age,df=3) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs3<-gamlss(phenotype~bs(Age,df=5) + Sex + meanFD,
                sigma.fo=~bs(Age,df=3) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs4<-gamlss(phenotype~bs(Age,df=6) + Sex + meanFD,
                sigma.fo=~bs(Age,df=3) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs5<-gamlss(phenotype~bs(Age,df=4) + Sex + meanFD,
                sigma.fo=~bs(Age,df=4) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs6<-gamlss(phenotype~bs(Age,df=5) + Sex + meanFD,
                sigma.fo=~bs(Age,df=4) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs7<-gamlss(phenotype~bs(Age,df=6) + Sex + meanFD,
                sigma.fo=~bs(Age,df=4) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs8<-gamlss(phenotype~bs(Age,df=5) + Sex + meanFD,
                sigma.fo=~bs(Age,df=5) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs9<-gamlss(phenotype~bs(Age,df=6) + Sex + meanFD,
                sigma.fo=~bs(Age,df=5) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)
mdl_bs10<-gamlss(phenotype~bs(Age,df=6) + Sex + meanFD,
                sigma.fo=~bs(Age,df=6) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=M_HC,
                control=con)


conv<-matrix(data=0,nrow=1,ncol=10)
for (i in 1:10) {
  command <- paste0( "conv[1, i] <- mdl_bs", as.character(i), "$converged" )
  eval(parse(text = command))
}
conv
bic_val<-matrix(data=0,nrow=1,ncol=10)
for (i in 1:10) {
  command <- paste0( "bic_val[1, i] <- mdl_bs", as.character(i), "$sbc" )
  eval(parse(text = command))
}

bic_val
fit_best_order <- as.character(which.min(bic_val))
fit_best_order


################################################################################ step 2: get quantiles
quantiles<-c(0.01, 0.05, 0.25, 0.5, 0.75, 0.95, 0.99)
x<-matrix(data=NA,ncol=length(quantiles),nrow=8001)
y<-matrix(data=NA,ncol=length(quantiles),nrow=8001)

for (i in 1:length(quantiles)){
  command <- paste0( "Qua <- getQuantile(mdl_bs", fit_best_order, ", quantile=quantiles[i], term='Age', n.points = 8000)" )
  eval(parse(text = command))
  c<-curve(Qua, 0, 80,  lwd=2, lty=1, add=T,col="red", ylim=c (0,1), n = 8001)
  x[,i]<-c$x
  y[,i]<-c$y
}


################################################################################ output quantiles and z_scores of HC
command <- paste0( "params<-predictAll(mdl_bs", fit_best_order ,",data=M_HC,newdata=M_HC,output='matrix',type='response',y.value='median',what=c('mu', 'sigma', 'nu','tau'))" )
eval(parse(text = command))
HC_quantiles <- pJSU(params[,1],mu=params[,2],sigma=params[,3],nu=params[,4],tau=params[,5])
# randomized residuals are quantiles transformed to corresponding
# z-scores of normal distribution
HC_Z_randomized <- qnorm(HC_quantiles, mean = 0, sd = 1)


################################################################################ step 3: get quantiles by sex
quantiles<-c(0.01, 0.05, 0.25, 0.5, 0.75, 0.95, 0.99)
x_male<-matrix(data=NA,ncol=length(quantiles),nrow=8001)
y_male<-matrix(data=NA,ncol=length(quantiles),nrow=8001)
x_female<-matrix(data=NA,ncol=length(quantiles),nrow=8001)
y_female<-matrix(data=NA,ncol=length(quantiles),nrow=8001)

for (i in 1:length(quantiles)){
  command <- paste0("Qua <- getQuantile(mdl_bs", fit_best_order ,", quantile=quantiles[i],term='Age',fixed.at=list(Sex=0), n.points = 8000)")
  eval(parse(text = command))
  c<-curve(Qua, 0, 80,  lwd=2, lty=1, add=T,col="red", ylim=c (0,1), n = 8001)
  x_female[,i]<-c$x
  y_female[,i]<-c$y
  
  command <- paste0("Qua <- getQuantile(mdl_bs", fit_best_order ,", quantile=quantiles[i],term='Age',fixed.at=list(Sex=1), n.points = 8000)")
  eval(parse(text = command))
  c<-curve(Qua, 0, 80,  lwd=2, lty=1, add=T,col="black", ylim=c (0,1), n = 8001)
  x_male[,i]<-c$x
  y_male[,i]<-c$y
}


################################################################################ step 4: get rate of change
age1=x[1:8000,4]
age2=x[2:8001,4]
v1=y[1:8000,4]
v2=y[2:8001,4]
a=age2-age1
v=v2-v1
velocity=v/a

v1=y_male[1:8000,4]
v2=y_male[2:8001,4]
v=v2-v1
velocity_male=v/a

v1=y_female[1:8000,4]
v2=y_female[2:8001,4]
v=v2-v1
velocity_female=v/a


################################################################################ step 5 :save model and other data
command <- paste0( "best_model <- mdl_bs", fit_best_order)
eval(parse(text = command))
save(best_model, file = paste0(Outdir, "/gamlss_fit_allData_", idp_name ,".RData")) # save model

fname<-paste0(Outdir,"/gamlss_fit_allData_", idp_name ,".mat")
command <- paste0("writeMat(fname,conv=conv,bic_val=bic_val,fit_best_order=fit_best_order,HC_quantiles=HC_quantiles,HC_Z_randomized=HC_Z_randomized,velocity_age=age1,all_velocity=velocity,velocity_male=velocity_male,velocity_female=velocity_female,all_cen_x=x,all_cen_y=y,male_cen_y=y_male,female_cen_y=y_female,age=M_HC$Age,sex=M_HC$Sex,data=M_HC$", idp_name ,", quantiles=quantiles)")
eval(parse(text = command))


################################################################################ step 6: get HC scores: 10-flods
if (fit_best_order == "1") {
  para_mean <- 3
  para_std <- 3
}
if (fit_best_order == "2") {
  para_mean <- 4
  para_std <- 3
}
if (fit_best_order == "3") {
  para_mean <- 5
  para_std <- 3
}
if (fit_best_order == "4") {
  para_mean <- 6
  para_std <- 3
}
if (fit_best_order == "5") {
  para_mean <- 4
  para_std <- 4
}
if (fit_best_order == "6") {
  para_mean <- 5
  para_std <- 4
}
if (fit_best_order == "7") {
  para_mean <- 6
  para_std <- 4
}
if (fit_best_order == "8") {
  para_mean <- 5
  para_std <- 5
}
if (fit_best_order == "9") {
  para_mean <- 6
  para_std <- 5
}

if (fit_best_order == "10") {
  para_mean <- 6
  para_std <- 6
}

# Run 10-fold CV to compute z-scores for HC individuals
nfolds<-10
column_length <- length(M_HC$Age)
column_length
zscores<-matrix(data=NA,nrow=column_length,ncol=1)
HC_quantiles<-matrix(data=NA,nrow=column_length,ncol=1)
conv<-matrix(data=0,nrow=1,ncol=nfolds)
bic_val<-matrix(data=0,nrow=1,ncol=nfolds)

# loop over 10 folds
source("/HeLabData2/llsun/Project2022/NormativeModel/PCNtoolkit20221103/tutorials/BLR_protocol/llsun_braincharts/For_ComBatGAM/createFolds.R")
folds_idx<-myCrossValidation(c(1:column_length),k=nfolds)
scores<-matrix(data=NA,nrow=column_length,1)

cen_line <- array(data = NA, dim = c(10, 8001, 7))

for (k in 1:nfolds){
  idx_test<-folds_idx[[k]]
  idx_train<-setdiff(c(1:column_length),idx_test)
  
  data_test<-M_HC[idx_test,]
  data_train<-M_HC[idx_train,]
  # Model fitting
  con<-gamlss.control(n.cyc=500)
  
  mdl<-gamlss(phenotype~bs(Age,df=para_mean) + Sex + meanFD,
                sigma.fo=~bs(Age,df=para_std) + Sex + meanFD,
                nu.fo=~1,
                nu.tau=~1,
                family=JSU,
                data=data_train,
                control=con)
  
  
  if (mdl$converged)
    print("Model converged")
  
  conv[k]<-mdl$converged
  bic_val[k]<-mdl$sbc
  
  params<-predictAll(mdl,data=data_train,
                     newdata=data_test,output='matrix',type="response",
                     y.value="median",what=c("mu", "sigma", "nu","tau"))
  tmp_quantiles <- pJSU(params[,1],mu=params[,2],sigma=params[,3],nu=params[,4],tau=params[,5])
  z_randomized <- qnorm(tmp_quantiles, mean = 0, sd = 1)
  zscores[idx_test]=z_randomized
  HC_quantiles[idx_test]=tmp_quantiles
  print(paste("Complete",k,"of", nfolds, "folds",sep=" "))
  
  ## cen line
  quantiles<-c(0.01, 0.05, 0.25, 0.5, 0.75, 0.95, 0.99)
  cen_x<-matrix(data=NA,ncol=length(quantiles),nrow=8001)
  cen_y<-matrix(data=NA,ncol=length(quantiles),nrow=8001)

  for (i in 1:length(quantiles)){
    Qua <- getQuantile(mdl, quantile=quantiles[i], term='Age', n.points = 8000)
    eval(parse(text = command))
    c<-curve(Qua, 0, 80,  lwd=2, lty=1, add=T,col="red", ylim=c (0,1), n = 8001)
    cen_x[,i]<-c$x
    cen_y[,i]<-c$y
  }
  cen_line[k,,] = cen_y
}

conv
bic_val

################################################################################ step 7: get DX scores
params<-predictAll(best_model,data=M_HC,
                   newdata=M_DX,output='matrix',type="response",
                   y.value="median",what=c("mu", "sigma", "nu","tau"))
DX_quantiles <- pJSU(params[,1],mu=params[,2],sigma=params[,3],nu=params[,4],tau=params[,5])
DX_z_randomized <- qnorm(DX_quantiles, mean = 0, sd = 1)


################################################################################ step : save data
fname<-paste0(Outdir,"/gamlss_fit_10folds_", idp_name ,".mat")
command <- paste0("writeMat(fname,cen_line=cen_line,HCzscores=zscores, DXzscores=DX_z_randomized, age=M_HC$Age, sex=M_HC$Sex, conv=conv, bic_val=bic_val, HC_quantiles=HC_quantiles, DX_quantiles=DX_quantiles)")
eval(parse(text = command))
print(paste("Writed into .mat"))




