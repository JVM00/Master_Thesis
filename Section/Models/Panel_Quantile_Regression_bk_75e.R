

#****************************QUANTILE REGRESSION*********************************************


#**********************************Cross-Section***********************************************
#library(quantreg)
#https://www.rdocumentation.org/packages/quantreg/versions/5.74/topics/summary.rq
#https://stats.stackexchange.com/questions/129200/r-squared-in-quantile-regression
# "rank" which produces confidence intervals for the estimated parameters
# by inverting a rank test as described in Koenker (1994). This method involves solving a parametric linear programming problem, and for large
# sample sizes can be extremely slow, so by default it is only used when
# the sample size is less than 1000, see below. The default option assumes
# that the errors are iid, while the option iid = FALSE implements a proposal
# of Koenker Machado (1999). See the documentation for rq.fit.br for
# additional arguments.
#[1] Koenker, R., P. Ng and S. Portnoy, (1994) Quantile Smoothing Splines; Biometrika 81, 673-680.


#rq_fit <- rq(def_model_ALL,  tau = seq(0.1,0.9,0.1),data = npl_hh)

# dat <- def_model_ALL
# datset <- npl_hh
# # rq_fit1 <- rq(dat,  tau = .1 ,data = datset)
# # rq_fit2 <- rq(dat,  tau = .2,data = datset)
# # rq_fit3<- rq(dat,  tau = .3,data = datset)
# # rq_fit4 <- rq(dat,  tau = .4,data = datset)
# # rq_fit5 <- rq(dat,  tau = .5,data = datset)
# # rq_fit6 <- rq(dat,  tau = .6,data = datset)
# # rq_fit7 <- rq(dat,  tau = .7,data = datset)
# # rq_fit8 <- rq(dat,  tau =.8,data = datset)
# # rq_fit9 <- rq(dat,  tau = .9,data = datset)
# 
# rq_fit1 <- rq(dat,  tau = .1 ,data = datset)
# rq_fit2 <- rq(dat,  tau = .25,data = datset)
# rq_fit3<- rq(dat,  tau = .5,data = datset)
# rq_fit4 <- rq(dat,  tau = .75e ,data = datset)
# rq_fit5 <- rq(dat,  tau = .9,data = datset)
# 
# #rq_summ1 <- summary(rq_fit1 ,se="boot", bsmethod="cluster",cluster= npl_hh$name )
# rq_summ1 <- summary(rq_fit1 ,se="boot")
# rq_summ1 <- summary(rq_fit1,se="rank")
# rq_summ2 <- summary(rq_fit2 ,se="boot", bsmethod= "xy")
# rq_summ3 <- summary(rq_fit3 ,se="boot", bsmethod= "xy")
# rq_summ4 <- summary(rq_fit4 ,se="boot", bsmethod= "xy")
# rq_summ5 <- summary(rq_fit5 ,se="boot", bsmethod= "xy")
# 
# #Slope
# anova.rq(rq_fit1, rq_fit2, rq_fit3,rq_fit4,rq_fit5,
#          test = "Wald", joint = TRUE)
# 
# #Symmetric
# anova.rq(rq_fit2, rq_fit4,
#          test = "Wald", joint = TRUE)

 # anova.rq(rq_fit1, rq_fit2, rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9, 
 #          test = "Wald", joint = TRUE)
 # anova.rq(rq_fit1, rq_fit2, rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9, 
 #          test = "Wald", joint = TRUE,score="tau")

# rq_fit10 <- rq(dat,  tau =.25,data = datset)
# rq_fit11 <- rq(dat,  tau = .75e,data = datset)
# anova.rq(rq_fit10, rq_fit11, test = "Wald", joint = FALSE,score="tau")

 
 
 
 
 #   # 
#   # #Slope
#   # anova.rq(rq_fit1, rq_fit2, rq_fit3,rq_fit4,rq_fit5,
#   #          test = "Wald", joint = TRUE)
#   # 
#   # #Symmetric
#   # anova.rq(rq_fit2, rq_fit4,
#   #          test = "Wald", joint = TRUE)
#   # 
#   
#   
#   rq_pval1 <- summary(rq_fit1,se="boot")$coefficients[,4]
#   rq_pval2 <- summary(rq_fit2,se="boot")$coefficients[,4]
#   rq_pval3 <- summary(rq_fit3,se="boot")$coefficients[,4]
#   rq_pval4 <- summary(rq_fit4,se="boot")$coefficients[,4]
#   rq_pval5 <- summary(rq_fit5,se="boot")$coefficients[,4]
#   
#   rq_se1 <- summary(rq_fit1,se="boot")$coefficients[,2]
#   rq_se2 <- summary(rq_fit2,se="boot")$coefficients[,2]
#   rq_se3 <- summary(rq_fit3,se="boot")$coefficients[,2]
#   rq_se4 <- summary(rq_fit4,se="boot")$coefficients[,2]
#   rq_se5 <- summary(rq_fit5,se="boot")$coefficients[,2] 
#  
#   rq_coef1 <-  data.frame(summary(rq_fit1,se="rank")$coefficients) %>% mutate(type= .1,var=row.names(summary(rq_fit1,se="rank")$coefficients),pval=rq_pval1,se= rq_se1,pval_type=ifelse(pval <0.01,"***",ifelse( pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
#   rq_coef2 <-  data.frame(summary(rq_fit2 ,se="rank")$coefficients) %>% mutate(type= .25,var=row.names(summary(rq_fit2,se="rank")$coefficients),pval=rq_pval2,se= rq_se2,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
#   
#   
#   rq_coef3 <-  data.frame(summary(rq_fit3 ,se="rank")$coefficients) %>% mutate(type= .50,var=row.names(summary(rq_fit3,se="rank")$coefficients),pval=rq_pval3,se= rq_se3,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
#   
#   
#   rq_coef4 <-  data.frame(summary(rq_fit4 ,se="rank")$coefficients) %>% mutate(type= .75e,var=row.names(summary(rq_fit4,se="rank")$coefficients),pval=rq_pval4,se= rq_se4,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
#   
#   
#   rq_coef5 <-  data.frame(summary(rq_fit5 ,se="rank")$coefficients) %>% mutate(type= .9,var=row.names(summary(rq_fit5,se="rank")$coefficients),pval=rq_pval5,se= rq_se5,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
#   
#  
#    #l <- list( "10%"=rq_coef1,"25%"=rq_coef2,"50%"=rq_coef3$coefficients, "75%"=rq_coef4$coefficients, "90%"=rq_coef5$coefficients )
#   
#   l <-  rbind(rq_coef1, rq_coef2,rq_coef3,rq_coef4,rq_coef5)
#   
#   assign(paste("QR_",d, sep= ""), l)
#   
# 
# } 

#Test of slope( Test of slope and symmetric)
# In the first the fitted objects all have the same specified quantile (tau) and the intent is to test 
# the hypothesis that smaller models are adaquete relative to the largest specified model. In this case
# there are two options for the argument `test', by default a Wald test is computed as in Bassett and Koenker (1982).
#[1] Bassett, G. and R. Koenker (1982). Tests of Linear Hypotheses and L1 Estimation, Econometrica, 50, 1577-83.

#Pseudo_R_Square
# Koenker, R and Machado, J (1999),
# Goodness of Fit and Related Inference Processes for Quantile Regression,
# Journal of the American Statistical Association, 94:448, 1296-1310

set.seed(123)
library(quantreg)
library(stargazer)

dat <- def_model_BANK
for (i in names(sets.75e)){
  
  a <- i
  b <- names(sets.75e)
  c <- match(a,b)
  d <-  b[c]
  e <- names(sets.75e[[c]])
  datset <- sets.75e[[c]]
  g <- names(datset)
  h <- gsub(paste(d,".",sep=""), "", g)
  names(datset)<- h
  #j <- c("Households & Non-Financial Corporations","Financial Corporations")
  j <- c("Households","Financial Institutions","Non-Financial Institutions")
  k <- j[c]
  
  
  
  rq_fit1 <- rq(dat,  tau = .1 ,data = datset)
  rq_fit2 <- rq(dat,  tau = .2,data = datset)
  rq_fit3<- rq(dat,  tau = .3,data = datset)
  rq_fit4 <- rq(dat,  tau = .4 ,data = datset)
  rq_fit5 <- rq(dat,  tau = .5,data = datset)
  rq_fit6 <- rq(dat,  tau = .6,data = datset)
  rq_fit7<- rq(dat,  tau = .7,data = datset)
  rq_fit8 <- rq(dat,  tau = .8 ,data = datset)
  rq_fit9 <- rq(dat,  tau = .9,data = datset)
  
  
  
  rq_pval1 <- summary(rq_fit1,se="boot")$coefficients[,4]
  rq_pval2 <- summary(rq_fit2,se="boot")$coefficients[,4]
  rq_pval3 <- summary(rq_fit3,se="boot")$coefficients[,4]
  rq_pval4 <- summary(rq_fit4,se="boot")$coefficients[,4]
  rq_pval5 <- summary(rq_fit5,se="boot")$coefficients[,4]
  rq_pval6 <- summary(rq_fit6,se="boot")$coefficients[,4]
  rq_pval7 <- summary(rq_fit7,se="boot")$coefficients[,4]
  rq_pval8 <- summary(rq_fit8,se="boot")$coefficients[,4]
  rq_pval9 <- summary(rq_fit9,se="boot")$coefficients[,4]
  
  
  rq_se1 <- summary(rq_fit1,se="boot")$coefficients[,2]
  rq_se2 <- summary(rq_fit2,se="boot")$coefficients[,2]
  rq_se3 <- summary(rq_fit3,se="boot")$coefficients[,2]
  rq_se4 <- summary(rq_fit4,se="boot")$coefficients[,2]
  rq_se5 <- summary(rq_fit5,se="boot")$coefficients[,2] 
  rq_se6 <- summary(rq_fit6,se="boot")$coefficients[,2]
  rq_se7 <- summary(rq_fit7,se="boot")$coefficients[,2]
  rq_se8 <- summary(rq_fit8,se="boot")$coefficients[,2]
  rq_se9 <- summary(rq_fit9,se="boot")$coefficients[,2] 
  
  # rq_coef1 <-  data.frame(summary(rq_fit1,se="rank")$coefficients) %>% mutate(type= .1,var=row.names(summary(rq_fit1,se="rank")$coefficients),pval=rq_pval1,se= rq_se1,pval_type=ifelse(pval <0.01,"***",ifelse( pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef2 <-  data.frame(summary(rq_fit2 ,se="rank")$coefficients) %>% mutate(type= .2,var=row.names(summary(rq_fit2,se="rank")$coefficients),pval=rq_pval2,se= rq_se2,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef3 <-  data.frame(summary(rq_fit3 ,se="rank")$coefficients) %>% mutate(type= .3,var=row.names(summary(rq_fit3,se="rank")$coefficients),pval=rq_pval3,se= rq_se3,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef4 <-  data.frame(summary(rq_fit4 ,se="rank")$coefficients) %>% mutate(type= .4,var=row.names(summary(rq_fit4,se="rank")$coefficients),pval=rq_pval4,se= rq_se4,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef5 <-  data.frame(summary(rq_fit5 ,se="rank")$coefficients) %>% mutate(type= .5,var=row.names(summary(rq_fit5,se="rank")$coefficients),pval=rq_pval5,se= rq_se5,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef6 <-  data.frame(summary(rq_fit6 ,se="rank")$coefficients) %>% mutate(type= .6,var=row.names(summary(rq_fit6,se="rank")$coefficients),pval=rq_pval6,se= rq_se2,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef7 <-  data.frame(summary(rq_fit7 ,se="rank")$coefficients) %>% mutate(type= .7,var=row.names(summary(rq_fit7,se="rank")$coefficients),pval=rq_pval7,se= rq_se3,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef8 <-  data.frame(summary(rq_fit8 ,se="rank")$coefficients) %>% mutate(type= .8,var=row.names(summary(rq_fit8,se="rank")$coefficients),pval=rq_pval8,se= rq_se4,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # rq_coef9 <-  data.frame(summary(rq_fit9 ,se="rank")$coefficients) %>% mutate(type= .9,var=row.names(summary(rq_fit9,se="rank")$coefficients),pval=rq_pval9,se= rq_se5,pval_type=ifelse(pval <0.01,"***",ifelse(pval <0.05,"**", ifelse(pval <0.1,"*"," "))))
  # 
  rq_coef1 <-  data.frame(summary(rq_fit1,se="rank")$coefficients) %>% mutate(type= .1,var=row.names(summary(rq_fit1,se="rank")$coefficients),pval=rq_pval1,se= rq_se1,pval_type=ifelse(pval <0.01,"<0.01",ifelse( pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef2 <-  data.frame(summary(rq_fit2 ,se="rank")$coefficients) %>% mutate(type= .2,var=row.names(summary(rq_fit2,se="rank")$coefficients),pval=rq_pval2,se= rq_se2,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef3 <-  data.frame(summary(rq_fit3 ,se="rank")$coefficients) %>% mutate(type= .3,var=row.names(summary(rq_fit3,se="rank")$coefficients),pval=rq_pval3,se= rq_se3,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef4 <-  data.frame(summary(rq_fit4 ,se="rank")$coefficients) %>% mutate(type= .4,var=row.names(summary(rq_fit4,se="rank")$coefficients),pval=rq_pval4,se= rq_se4,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef5 <-  data.frame(summary(rq_fit5 ,se="rank")$coefficients) %>% mutate(type= .5,var=row.names(summary(rq_fit5,se="rank")$coefficients),pval=rq_pval5,se= rq_se5,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef6 <-  data.frame(summary(rq_fit6 ,se="rank")$coefficients) %>% mutate(type= .6,var=row.names(summary(rq_fit6,se="rank")$coefficients),pval=rq_pval6,se= rq_se2,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef7 <-  data.frame(summary(rq_fit7 ,se="rank")$coefficients) %>% mutate(type= .7,var=row.names(summary(rq_fit7,se="rank")$coefficients),pval=rq_pval7,se= rq_se3,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef8 <-  data.frame(summary(rq_fit8 ,se="rank")$coefficients) %>% mutate(type= .8,var=row.names(summary(rq_fit8,se="rank")$coefficients),pval=rq_pval8,se= rq_se4,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  rq_coef9 <-  data.frame(summary(rq_fit9 ,se="rank")$coefficients) %>% mutate(type= .9,var=row.names(summary(rq_fit9,se="rank")$coefficients),pval=rq_pval9,se= rq_se5,pval_type=ifelse(pval <0.01,"<0.01",ifelse(pval <0.05,"<0.05", ifelse(pval <0.1,"<0.1",">=0.1"))))
  
  
  
  # stargazer( rq_fit1, rq_fit2,rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,rq.se = "boot",
  #            column.labels=c("10%","20%","30%","40%","50%","60%","70%","80%","90%"),
  #            column.separate = rep(1,9),model.numbers = FALSE,
  #            # column.labels=c("Quantiles"),
  #            # column.separate = c(9),model.numbers = FALSE,
  #            digits=3, align=T, title= paste("Quantil Regression (2014-2019):",k,sep=" ")
  #            ,out=paste("Research_Proposal/Progress/Tables/Final/quantil/Quantil_Regression_",d,".html", sep = ""))
  # 
  # capture.output(stargazer( rq_fit1, rq_fit2,rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,rq.se = "boot",
  #                           column.labels=c("10%","20%","30%","40%","50%","60%","70%","80%","90%"),
  #                           column.separate = rep(1,9),model.numbers = FALSE,type="latex",
  #                           # column.labels=c("Quantiles"),
  #                           # column.separate = c(9),model.numbers = FALSE,
  #                           digits=3, align=T, title= paste("Quantil Regression (2014-2019):",k,sep=" ")
  #                           ,out=paste("Research_Proposal/Progress/Tables/Final/quantil/Quantil_Regression_",d,".tex", sep = "")))
  # 
  #l <- list( "10%"=rq_coef1,"25%"=rq_coef2,"50%"=rq_coef3$coefficients, "75%"=rq_coef4$coefficients, "90%"=rq_coef5$coefficients )
  
  l <-  rbind(rq_coef1, rq_coef2,rq_coef3,rq_coef4,rq_coef5, rq_coef6,rq_coef7,rq_coef8,rq_coef9)
  
  assign(paste("QR_bk_75e_",d, sep= ""), l)
  
  #Slope
  m <- anova.rq(rq_fit1, rq_fit2, rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,
                test = "Wald", joint = FALSE)
  assign(paste("ANOVA_",d, sep= ""), m)
  
  m1 <- anova.rq(rq_fit1, rq_fit2, rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,
                 test = "Wald", joint = TRUE)
  
  m1.tn <- round(m1[["table"]][["Tn"]],2)
  m1.pvalue <- round(m1[["table"]][["pvalue"]],3)
  
  m1.tn <- c("Slope-equal  test",m1.tn)
  m1.pvalue <- c("Prob (Slope-equal)",m1.pvalue)
  
  
  
  #Symmetric
  rq_fit.25 <- rq(dat,  tau = .25 ,data = datset)
  rq_fit.75 <- rq(dat,  tau = .75,data = datset)
  
  si <- anova.rq(rq_fit.25, rq_fit.75,
                 test = "Wald", joint = TRUE)
  
  
  si.tn <- round(si[["table"]][["Tn"]],2)
  si.pvalue <- round(si[["table"]][["pvalue"]],3)
  
  si.tn <- c("Symmetry (.25-.75) test",si.tn)
  si.pvalue <- c("Prob (Symmetry(.25-.75))",si.pvalue)
  
  
  #10%-90%
  si1 <- anova.rq(rq_fit1, rq_fit9,
                  test = "Wald", joint = TRUE)
  
  si1.tn <- round(si1[["table"]][["Tn"]],2)
  si1.pvalue <- round(si1[["table"]][["pvalue"]],3)
  
  si1.tn <- c("Symmetry (.1-.9) test",si1.tn)
  si1.pvalue <- c("Prob (Symmetry(.1-.9))",si1.pvalue)
  
  #20%-80%
  si2 <-anova.rq(rq_fit2, rq_fit8,
                 test = "Wald", joint = TRUE)
  
  si2.tn <- round(si2[["table"]][["Tn"]],2)
  si2.pvalue <- round(si2[["table"]][["pvalue"]],3)
  
  si2.tn <- c("Symmetry (.2-.8) test",si2.tn)
  si2.pvalue <- c("Prob (Symmetry(.2-.8))",si2.pvalue)
  
  #30%-70%
  si3 <-anova.rq(rq_fit3, rq_fit7,
                 test = "Wald", joint = TRUE)
  
  si3.tn <- round(si3[["table"]][["Tn"]],2)
  si3.pvalue <- round(si3[["table"]][["pvalue"]],3)
  
  si3.tn <- c("Symmetry (.3-.7) test",si3.tn)
  si3.pvalue <- c("Prob (Symmetry(.3-.7))",si3.pvalue)
  
  #40%-60%
  si4 <-anova.rq(rq_fit4, rq_fit6,
                 test = "Wald", joint = TRUE)
  
  si4.tn <- round(si4[["table"]][["Tn"]],2)
  si4.pvalue <- round(si4[["table"]][["pvalue"]],3)
  
  si4.tn <- c("Symmetry (.4-.6) test",si4.tn)
  si4.pvalue <- c("Prob (Symmetry (.4-.6))",si4.pvalue)
  
  
  
  ct <- NPL_ratio~ 1
  rq_fit1_ct <- rq(ct,  tau = .1 ,data = datset)
  rq_fit2_ct <- rq(ct,  tau = .2,data = datset)
  rq_fit3_ct<- rq(ct,  tau = .3,data = datset)
  rq_fit4_ct <- rq(ct,  tau = .4 ,data = datset)
  rq_fit5_ct <- rq(ct,  tau = .5,data = datset)
  rq_fit6_ct <- rq(ct,  tau = .6,data = datset)
  rq_fit7_ct<- rq(ct,  tau = .7,data = datset)
  rq_fit8_ct <- rq(ct,  tau = .8 ,data = datset)
  rq_fit9_ct <- rq(ct,  tau = .9,data = datset)
  
  rho <- function(u,tau=.1)u*(tau - (u < 0))
  
  V_01 <-  sum(rho(rq_fit1_ct$resid, rq_fit1_ct$tau))
  V_02 <-  sum(rho(rq_fit2_ct$resid, rq_fit2_ct$tau))
  V_03 <-  sum(rho(rq_fit3_ct$resid, rq_fit3_ct$tau))
  V_04 <-  sum(rho(rq_fit4_ct$resid, rq_fit4_ct$tau))
  V_05 <-  sum(rho(rq_fit5_ct$resid, rq_fit5_ct$tau))
  V_06 <-  sum(rho(rq_fit6_ct$resid, rq_fit6_ct$tau))
  V_07 <-  sum(rho(rq_fit7_ct$resid, rq_fit7_ct$tau))
  V_08 <-  sum(rho(rq_fit8_ct$resid, rq_fit8_ct$tau))
  V_09 <-  sum(rho(rq_fit9_ct$resid, rq_fit9_ct$tau))
  
  Vhat1 <-  sum(rho(rq_fit1$resid, rq_fit1$tau))
  Vhat2 <-  sum(rho(rq_fit2$resid, rq_fit2$tau))
  Vhat3 <-  sum(rho(rq_fit3$resid, rq_fit3$tau))
  Vhat4 <-  sum(rho(rq_fit4$resid, rq_fit4$tau))
  Vhat5 <-  sum(rho(rq_fit5$resid, rq_fit5$tau))
  Vhat6 <-  sum(rho(rq_fit6$resid, rq_fit6$tau))
  Vhat7 <-  sum(rho(rq_fit7$resid, rq_fit7$tau))
  Vhat8 <-  sum(rho(rq_fit8$resid, rq_fit8$tau))
  Vhat9 <-  sum(rho(rq_fit9$resid, rq_fit9$tau))
  
  
  R_sq1 <- 1-(Vhat1/V_01)
  R_sq2 <- 1-(Vhat2/V_02)
  R_sq3 <- 1-(Vhat3/V_03)
  R_sq4 <- 1-(Vhat4/V_04)
  R_sq5 <- 1-(Vhat5/V_05)
  R_sq6 <- 1-(Vhat6/V_06)
  R_sq7 <- 1-(Vhat7/V_07)
  R_sq8 <- 1-(Vhat8/V_08)
  R_sq9 <- 1-(Vhat9/V_09)
  
  rsq_all <-  cbind(R_sq1,R_sq2,R_sq3,R_sq4,R_sq5,R_sq6,R_sq7,R_sq8,R_sq9)
  rsq_all <- data.frame( rsq_all)
  
  assign(paste("R2rq_",d, sep= ""),rsq_all)
  
  # [1] Koenker, R and Machado, J (1999),
  # Goodness of Fit and Related Inference Processes for Quantile Regression,
  # Journal of the American Statistical Association, 94:448, 1296-1310
  
} 


View(R2rq_npl_hh.nfi.75e)
View(R2rq_npl_fi.75e)
View(R2rq_npl_nfi.75e)

# QR_npl_hh.nfi_bk_75e<- QR_npl_hh.nfi
# QR_npl_hh_bk_75e<- QR_npl_hh
# QR_npl_nfi_bk_75e<- QR_npl_nfi
# QR_npl_fi_bk_75e <- QR_npl_fi

path_data <- 'C:/Users/varga/Desktop/Thesis/R_data/Data/'
#save(QR_bk_75e_npl_hh.nfi,file=paste(path_data,'QR_npl_hh.nfi_bk.RData', sep = ""))
save(QR_bk_75e_npl_hh.75e,file=paste(path_data,'QR_bk_75e_npl_hh.75e.RData', sep = ""))
save(QR_bk_75e_npl_nfi.75e,file=paste(path_data,'QR_bk_75e_npl_nfi.75e.RData', sep = ""))
save(QR_bk_75e_npl_fi.75e,file=paste(path_data,'QR_bk_75e_npl_fi.75e.RData', sep = ""))


set.seed(123)
library(quantreg)
library(stargazer)

#t <- round(R2rq_npl_hh.nfi,3)
t <- round(R2rq_npl_hh.75e,3)
t1 <- round(R2rq_npl_fi.75e,3)
t2 <- round(R2rq_npl_nfi.75e,3)

e<- as.vector(t(t))
e1<- as.vector(t(t1))
e2<- as.vector(t(t2))

a1 <- c("Pseudo R$^{2}$",e)
class(a1)
a2 <- c("Pseudo R$^{2}$",e1)
class(a2)

a3 <- c("Pseudo R$^{2}$",e2)
class(a3)

dat <- def_model_BANK
r_2 <- list(a1,a2,a3)
#r_2[[1]]
for (i in names(sets.75e)){
  
  a <- i
  b <- names(sets.75e)
  c <- match(a,b)
  d <-  b[c]
  e <- names(sets.75e[[c]])
  datset <- sets.75e[[c]]
  g <- names(datset)
  h <- gsub(paste(d,".",sep=""), "", g)
  names(datset)<- h
 # j <- c("Households \& Non-Financial Corporations","Financial Corporations")
  j <- c("Households","Financial Institutions","Non-Financial Institutions")
  k <- j[c]
  
  l <- r_2[[c]]
  
  rq_fit1 <- rq(dat,  tau = .1 ,data = datset)
  rq_fit2 <- rq(dat,  tau = .2,data = datset)
  rq_fit3<- rq(dat,  tau = .3,data = datset)
  rq_fit4 <- rq(dat,  tau = .4,data = datset)
  rq_fit5 <- rq(dat,  tau = .5,data = datset)
  rq_fit6 <- rq(dat,  tau = .6,data = datset)
  rq_fit7 <- rq(dat,  tau = .7,data = datset)
  rq_fit8 <- rq(dat,  tau =.8,data = datset)
  rq_fit9 <- rq(dat,  tau = .9,data = datset)
  
 # tests <- list(m1.tn ,m1.pvalue,si.tn,si.pvalue,si1.tn,si1.pvalue,si2.tn,si2.pvalue,si3.tn,si3.pvalue,si4.tn,si4.pvalue)
  #tests <- list(m1.tn ,m1.pvalue,si.tn,si.pvalue,si1.tn,si1.pvalue,si3.tn,si3.pvalue)
  
  
  stargazer( rq_fit1, rq_fit2,rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,rq.se = "boot",
             column.labels=c("10%","20%","30%","40%","50%","60%","70%","80%","90%"),
             column.separate = rep(1,9),model.numbers = FALSE,
             # column.labels=c("Quantiles"),
             # column.separate = c(9),model.numbers = FALSE,
              #add.lines = list(c("Groups", "48"), c("Periods", "17")),
            # add.lines = list(l),
            #add.lines = list(l,m1.tn ,m1.pvalue,si.tn,si.pvalue,si1.tn,si1.pvalue,si3.tn,si3.pvalue),
            add.lines = list(l,m1.tn ,m1.pvalue,si.tn,si.pvalue),
             digits=3, align=T, title= paste("Quantil Regression (2014-2019):",k,sep=" "),
             out=paste("Research_Proposal/Progress/Tables/Final/quantil/Quantil_Regression_bk_75e_",d,".html", sep = ""))
  
  capture.output(stargazer( rq_fit1, rq_fit2,rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,rq.se = "boot",
                            column.labels=c("10%","20%","30%","40%","50%","60%","70%","80%","90%"),
                            column.separate = rep(1,9),model.numbers = FALSE,type="latex",
                            # column.labels=c("Quantiles"),
                            # column.separate = c(9),model.numbers = FALSE,
                            # add.lines = list(c("Groups", "48"), c("Periods", "17")),
                            #add.lines = list(l),
                            #add.lines = list(l,m1.tn ,m1.pvalue,si.tn,si.pvalue,si1.tn,si1.pvalue,si3.tn,si3.pvalue),
                            add.lines = list(l,m1.tn ,m1.pvalue,si.tn,si.pvalue),
                            digits=3, align=T, title= paste("Quantil Regression (2014-2019):",k,sep=" ")
                            ,out=paste("Research_Proposal/Progress/Tables/Final/quantil/Quantil_Regression_bk_75e_",d,".tex", sep = "")))
} 



#anova <- list(ANOVA_npl_hh=ANOVA_npl_hh,ANOVA_npl_fi=ANOVA_npl_fi,ANOVA_npl_nfi=ANOVA_npl_nfi)

#anova <- list(ANOVA_npl_hh.nfi=ANOVA_npl_hh.nfi,ANOVA_npl_fi=ANOVA_npl_fi)
anova <- list(ANOVA_npl_hh=ANOVA_npl_hh,ANOVA_npl_nfi=ANOVA_npl_nfi,ANOVA_npl_fi=ANOVA_npl_fi)
class(anova)
anova[1]
#anova <- list(ANOVA_npl_fi=ANOVA_npl_fi)

#anova <- list(ANOVA_npl_hh.nfi=ANOVA_npl_hh.nfi)

for (i in names(anova)){
  a <- i
  b <- names(anova)
  c <- match(a,b)
  d <-  b[c]
  e <- names(anova[[c]])  
  anova.tb <- anova[[c]]
  
  #j <- c("Households & Non-Financial Corporations","Financial Corporations")
  j <- c("Households","Non-Financial Institutions","Financial Institutions")
  k <- j[c]
  
  df <-  -data.frame((anova.tb$table)*(-1))
  
  anova_names <- c("Df","Resi Df","F-stat","P-val")
  names(df) <- anova_names
  
  df[3] <- round(df[3],4)
  df[4] <- round(df[4],7)
  
  assign(paste(d, ".coef",sep= ""), df)
  
  starPrinter <- function(pVal){
    as.numeric(pVal)
    if(pVal < 0.01) {return("***")}
    if(pVal < 0.05){ return("**")}
    if(pVal < 0.1) {return("*")}
    
    return("")
  }
  
  
  
  pvals <- df$`P-val`
    
  for(j in (1:nrow(df))){
    df[j, 4] <- paste0(df[j, 4], starPrinter(pvals[j]))
    }
  

  
  df1 <- xtable(data.frame(df), caption = paste("Quantil Regression-Slope Test (2014-2019):",k,sep=" "))
                 
  
  align( df1) <- xalign( df1)
  digits( df1) <- xdigits( df1)
  display( df1) <- xdisplay( df1)
  
 print.xtable(  df1, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/Slope Test_bk_75e_",d,".html", sep = ""))
print.xtable(  df1, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="latex",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/Slope Test_bk_75e_",d,".tex", sep = ""))
  
  }

options(scipen = 999)


# 
# 
# anova_names <- c("Df","Resi Df","F-stat","P-val")
# names(ANOVA_npl_hh.coef) <- anova_names
# 
# ANOVA_npl_hh.coef[3] <- round(ANOVA_npl_hh.coef[3],4)
# ANOVA_npl_hh.coef[4] <- round(ANOVA_npl_hh.coef[4],5)
# 
# x <- xtable(k, caption = "Quantile Regression: Slope Test")
# 
# align(x) <- xalign(x)
# digits(x) <- xdigits(x)
# display(x) <- xdisplay(x)
# 
# print.xtable( x, caption.placement = 'top' ,align= "r|llrc",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",file= "Research_Proposal/Progress/Tables/slopeTest_hh.html", sep = "")
# print.xtable( x,  caption.placement = 'top',align= "r|llrc",booktabs = T,size = "small",  include.rownames= TRUE,type="latex",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
# QR_npl_hh <- QR_npl_hh %>% mutate(Exposure = "Households")
# QR_npl_nfi <- QR_npl_nfi %>% mutate(Exposure = "Non-Financial Corp.")
# QR_npl_fi <- QR_npl_fi %>% mutate(Exposure = "Financial Corp.")
# 
# QR_npl <- as.data.frame(bind_rows(QR_npl_hh,QR_npl_nfi,QR_npl_fi))
# View(QR_npl)
# 
# 
# QR_npl1 <- QR_npl %>% group_by(Exposure) %>%  count(vars="Exposure")
# View( QR_npl1)
# 
# ggplot(data=QR_npl_hh,aes(x=type,y = coefficients)) + 
#   xlab("Quantile(%)") +
#   ylab(" ")+
#   facet_wrap(~ var,scales = "free")+
#   geom_line(color = "black", size=.6) +
#   geom_line(data=QR_npl_nfi,color = "grey",size=.6) + 
#   geom_line(data=QR_npl_fi, color = "blue",size=.6) + 
#   #guides(color=guide_legend(title="My Legend Title")) 
#   geom_point(data=QR_npl_hh,aes(color=pval_type),shape=16,size=1)+
#   geom_point(data=QR_npl_nfi,aes(color=pval_type),shape=16,size=1)+
#   geom_point(data=QR_npl_fi,aes(color=pval_type),shape=16,size=1)+
#     scale_color_manual( values=c( "green2","yellow", "red", "black"),name = "P-values:")+
#  # geom_line(aes(y = lower.bd), color =  "lightblue3") +
#  # geom_line(aes(y = upper.bd), color="lightblue3") +
#   geom_hline(aes(yintercept= 0),color="grey27",linetype="dotdash",size=.5)+
#  # geom_ribbon(aes(ymin=pmin(lower.bd), ymax=pmin(upper.bd)), fill="lightblue", alpha=0.5)+# Ignore NA values for mean  color="black", linetype="longdasehd", size=1)+
#   scale_x_continuous(breaks = seq(0.1,0.9,0.1),limits = c(0.1, 0.9),labels = scales::percent_format(accuracy = 1,scale = 100))+
#   theme(plot.title = element_text(hjust = 0.5))+
#   theme(strip.background =element_rect(fill="lightblue4"))+
#  theme(strip.text = element_text(colour = 'white',size = 9))+
#  theme(legend.position="bottom",panel.background = element_rect(fill = "grey84"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),axis.title.x = element_text(face = "italic"))+
#   theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
#   labs(caption = "Source: EBA Transparency Exercises, authors' calculations")+
#   theme(legend.position="bottom",legend.direction = "horizontal",legend.spacing.x = unit(.5, 'cm'))+
#   ggtitle("Standard Quantile Regression: Households")
# 
# 
# ggplot(data=QR_npl,aes(x=type,y = coefficients)) + 
#   xlab("Quantile(%)") +
#   ylab(" ")+ 
#   facet_wrap(~ var,scales = "free")+
#   geom_line(aes(color=Exposure), size=.8,alpha=.7) +
#  # geom_line(data=QR_npl_nfi,color = "grey",size=.6) + 
#  # geom_line(data=QR_npl_fi, color = "blue",size=.6) + 
#   #guides(color=guide_legend(title="My Legend Title")) 
#   #geom_point(aes(color=pval_type),shape=16,size=1.3)+
#   geom_point(aes(fill=pval_type),shape=21,size=2)+
#   #geom_point(data=QR_npl_nfi,aes(color=pval_type),shape=16,size=1)+
#  # geom_point(data=QR_npl_fi,aes(color=pval_type),shape=16,size=1)+
#   #scale_fill_manual( values=c("blue", "black", "grey"),name = "Exposure")+
#   scale_color_manual( values=c("darkblue", "purple", "orange2"),name = "Exposure")+
#  
# # scale_color_manual( values=c( "green2","yellow", "red", "black","blue", "black", "grey"),name = "P-values:")+
#    scale_fill_manual( values=c( "green2","yellow", "red", "black"),name = "P-values:")+
#   # geom_line(aes(y = lower.bd), color =  "lightblue3") +
#   # geom_line(aes(y = upper.bd), color="lightblue3") +
#   geom_hline(aes(yintercept= 0),color="grey27",linetype="dotdash",size=.5)+
#   # geom_ribbon(aes(ymin=pmin(lower.bd), ymax=pmin(upper.bd)), fill="lightblue", alpha=0.5)+# Ignore NA values for mean  color="black", linetype="longdasehd", size=1)+
#   scale_x_continuous(breaks = seq(0.1,0.9,0.1),limits = c(0.1, 0.9),labels = scales::percent_format(accuracy = 1,scale = 100))+
#   theme(plot.title = element_text(hjust = 0.5))+
#   theme(strip.background =element_rect(fill="lightblue4"))+
#   theme(strip.text = element_text(colour = 'white',size = 9))+
#   theme(legend.position="bottom",panel.background = element_rect(fill = "grey84"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),axis.title.x = element_text(face = "italic"))+
#   theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
#   labs(caption = "Source: EBA Transparency Exercises, authors' calculations")+
#   theme(legend.position="bottom",legend.direction = "horizontal",legend.spacing.x = unit(.5, 'cm'))+
#   ggtitle("Standard Quantile Regression")



# 
# 
# ggplot(QR_npl_hh.nfi, aes(x=type)) + 
#   xlab("Quantile(%)") +
#   ylab(" ")+
#   facet_wrap(~ var,scales = "free")+
#   geom_line(aes(y = coefficients), color = "black",size=.6) + 
#   geom_point(aes(x=type,y = coefficients,color=pval_type),shape=16,size=2)+
#    scale_color_manual( values=c( "green2","yellow", "red", "black"),name = "P-values:")+
#   geom_line(aes(y = lower.bd), color =  "lightblue3") +
#   geom_line(aes(y = upper.bd), color="lightblue3") +
#   geom_hline(aes(yintercept= 0),color="grey27",linetype="dotdash",size=.5)+
#   geom_ribbon(aes(ymin=pmin(lower.bd), ymax=pmin(upper.bd)), fill="lightblue", alpha=0.5)+# Ignore NA values for mean  color="black", linetype="longdasehd", size=1)+
#   scale_x_continuous(breaks = seq(0.1,0.9,0.1),limits = c(0.1, 0.9),labels = scales::percent_format(accuracy = 1,scale = 100))+
#   theme(plot.title = element_text(hjust = 0.5))+
#   theme(strip.background =element_rect(fill="lightblue4"))+
#   theme(strip.text = element_text(colour = 'white',size = 9))+
#   theme(legend.position="bottom",panel.background = element_rect(fill = "grey84"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),axis.title.x = element_text(face = "italic"))+
#   theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
#   labs(caption = "Source: EBA Transparency Exercises, authors' calculations")+
#   theme(legend.position="bottom",legend.direction = "horizontal",legend.spacing.x = unit(.5, 'cm'))+
#   ggtitle("Standard Quantile Regression: Households")
# 
# 
# ggplot(QR_npl_hh, aes(x=type)) + 
#   xlab("Quantile(%)") +
#   ylab(" ")+
#   facet_wrap(~ var,scales = "free")+
#   geom_line(aes(y = coefficients), color = "black",size=.6) + 
#   geom_point(aes(x=type,y = coefficients,color=pval_type),shape=16,size=2)+
#   scale_color_manual( values=c( "green2","yellow", "red", "black"),name = "P-values:")+
#   geom_line(aes(y = lower.bd), color =  "lightblue3") +
#   geom_line(aes(y = upper.bd), color="lightblue3") +
#   geom_hline(aes(yintercept= 0),color="grey27",linetype="dotdash",size=.5)+
#   geom_ribbon(aes(ymin=pmin(lower.bd), ymax=pmin(upper.bd)), fill="lightblue", alpha=0.5)+# Ignore NA values for mean  color="black", linetype="longdasehd", size=1)+
#   scale_x_continuous(breaks = seq(0.1,0.9,0.1),limits = c(0.1, 0.9),labels = scales::percent_format(accuracy = 1,scale = 100))+
#   theme(plot.title = element_text(hjust = 0.5))+
#   theme(strip.background =element_rect(fill="lightblue4"))+
#   theme(strip.text = element_text(colour = 'white',size = 9))+
#   theme(legend.position="bottom",panel.background = element_rect(fill = "grey84"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),axis.title.x = element_text(face = "italic"))+
#   theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
#   labs(caption = "Source: EBA Transparency Exercises, authors' calculations")+
#   theme(legend.position="bottom",legend.direction = "horizontal",legend.spacing.x = unit(.5, 'cm'))+
#   ggtitle("Standard Quantile Regression: Households")
# 
# ggplot(QR_npl_fi, aes(x=type)) + 
#   xlab("Quantile(%)") +
#   ylab(" ")+
#   facet_wrap(~ var,scales = "free")+
#   geom_line(aes(y = coefficients), color = "black",size=.6) + 
#   geom_point(aes(x=type,y = coefficients,color=pval_type),shape=16,size=2)+
#   scale_color_manual( values=c( "green2","yellow", "red", "black"),name = "P-values:")+
#   geom_line(aes(y = lower.bd), color =  "lightblue3") +
#   geom_line(aes(y = upper.bd), color="lightblue3") +
#   geom_hline(aes(yintercept= 0),color="grey27",linetype="dotdash",size=.5)+
#   geom_ribbon(aes(ymin=pmin(lower.bd), ymax=pmin(upper.bd)), fill="lightblue", alpha=0.5)+# Ignore NA values for mean  color="black", linetype="longdasehd", size=1)+
#   scale_x_continuous(breaks = seq(0.1,0.9,0.1),limits = c(0.1, 0.9),labels = scales::percent_format(accuracy = 1,scale = 100))+
#   theme(plot.title = element_text(hjust = 0.5))+
#   theme(strip.background =element_rect(fill="lightblue4"))+
#   theme(strip.text = element_text(colour = 'white',size = 9))+
#   theme(legend.position="bottom",panel.background = element_rect(fill = "grey84"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),axis.title.x = element_text(face = "italic"))+
#   theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
#   labs(caption = "Source: EBA Transparency Exercises, authors' calculations")+
#   theme(legend.position="bottom",legend.direction = "horizontal",legend.spacing.x = unit(.5, 'cm'))+
#   ggtitle("Standard Quantile Regression: Financial Corporations")
# 
# 
# 
# ggplot(QR_npl_nfi, aes(x=type)) + 
#   xlab("Quantile(%)") +
#   ylab(" ")+
#   facet_wrap(~ var,scales = "free")+
#   geom_line(aes(y = coefficients), color = "black",size=.6) + 
#   geom_point(aes(x=type,y = coefficients,color=pval_type),shape=16,size=2)+
#   scale_color_manual( values=c( "green2","yellow", "red", "black"),name = "P-values:")+
#   geom_line(aes(y = lower.bd), color =  "lightblue3") +
#   geom_line(aes(y = upper.bd), color="lightblue3") +
#   geom_hline(aes(yintercept= 0),color="grey27",linetype="dotdash",size=.5)+
#   geom_ribbon(aes(ymin=pmin(lower.bd), ymax=pmin(upper.bd)), fill="lightblue", alpha=0.5)+# Ignore NA values for mean  color="black", linetype="longdasehd", size=1)+
#   scale_x_continuous(breaks = seq(0.1,0.9,0.1),limits = c(0.1, 0.9),labels = scales::percent_format(accuracy = 1,scale = 100))+
#   theme(plot.title = element_text(hjust = 0.5))+
#   theme(strip.background =element_rect(fill="lightblue4"))+
#   theme(strip.text = element_text(colour = 'white',size = 9))+
#   theme(legend.position="bottom",panel.background = element_rect(fill = "grey84"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),axis.title.x = element_text(face = "italic"))+
#   theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
#   labs(caption = "Source: EBA Transparency Exercises, authors' calculations")+
#   theme(legend.position="bottom",legend.direction = "horizontal",legend.spacing.x = unit(.5, 'cm'))+
#   ggtitle("Standard Quantile Regression: Non-Financial Corporations")
# 
# 




# stargazer( rq_summ1, rq_summ2,rq_summ3,rq_summ4,rq_summ5,
#            column.labels=c("10%","20%","30%","40%","50%","60%","70%","80%","90%"),
#            column.separate = rep(1,9),model.numbers = FALSE,
#            # column.labels=c("Quantiles"),
#            # column.separate = c(9),model.numbers = FALSE,
#            digits=3, align=T, title= "Quantil Regression with Year Dummy  (2014-2019): Households",out= "Research_Proposal/Progress/Tables/Quantil Regression_Year_hh.html")
# 


#stargazer(qr_10,qr_25,qr_50,qr_75e,qr_95, rq.se = "iid", type = "text", title="Regression Results", initial.zero = F,single.row=TRUE)
# stargazer( rq_fit1, rq_fit2,rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,rq.se = "boot", 
#            column.labels=c("10%","20%","30%","40%","50%","60%","70%","80%","90%"),
#            column.separate = rep(1,9),model.numbers = FALSE,
#            # column.labels=c("Quantiles"),
#            # column.separate = c(9),model.numbers = FALSE,
#            digits=3, align=T, title= "Quantil Regression with Year Dummy  (2014-2019): Households",out= "Research_Proposal/Progress/Tables/Quantil Regression_Year_hh.html")

# stargazer( rq_fit1, rq_fit2,rq_fit3,rq_fit4,rq_fit5,rq_fit6,rq_fit7,rq_fit8,rq_fit9,rq.se = "boot", 
#            #column.labels=c("Q1","Q2","Q3","Q4","Q5","Q6","Q7","Q8","Q9"),
#            column.labels=c("10%","20%","30%","40%","50%","60%","70%","80%","90%"),
#            column.separate = rep(1,9),model.numbers = FALSE, omit = c("factor(Year)2014", "factor(Year)2015","factor(Year)2016", "factor(Year)2017","factor(Year)2018", "factor(Year)2019"),
#            digits=3, align=T, title= "Quantil Regression with Year Dummy (2014-2019): Households",out= "Research_Proposal/Progress/Tables/Quantil Regression_hh.html")
# 

# With your small samples, your estimate of standard deviation will be very biased (low). With bootstrapping, you can approximate the sampling distribution of your estimators by treating your sample as an approximation of the true distribution of your data. The more samples you have, the closer your empirical distribution will be to the actual distribution, hence allowing ever more accurate error estimates.
# 
# That is why boostrapping works. The standard deviation approach only works when you know the true standard deviation and the distribution of the estimator is approximately normal. Boostrapping is just monte carlo simulation using your data as the input distribution, and so the more representative your sample, the better your inferences.
# 
# Also, I would highly recommend a parametric boostrap for samples <20 points. This requires assuming some underlying distribution for your data and then simulating boostrap samples from the fitted distribution. If your data are strictly positive, then try a lognormal, if they can be both positive and negative, try the normal distribution.
# 

#**********************************Fixed-Effects***********************************************
# install.packages("pastecs")
# library(pastecs)
# seq(.1, .9, length.out= 9)
# quantile(npl_hh$NPL_ratio,seq(.1,.9,.1))
# summary(npl_hh$NPL_ratio)
# stat.desc(npl_hh$NPL_ratio)
#qqnorm(npl_hh$NPL_ratio, pch = 1, frame = FALSE)

set.seed(123)
library(quantreg)
library(stargazer)

library(rqpd)
lambda <- 1
dat <- de_model_BANK_rqpd
for (i in names(sets.75e)){
  
  a <- i
  b <- names(sets.75e)
  c <- match(a,b)
  d <-  b[c]
  e <- names(sets.75e[[c]])
  datset <- sets.75e[[c]]
  g <- names(datset)
  h <- gsub(paste(d,".",sep=""), "", g)
  names(datset)<- h
  j <- c("Households","Financial Institutions","Non-Financial Institutions")
  #j <- c("Households & Non-Financial Corporations","Financial Corporations")
  k <- j[c]
  
  pfe2.fit1 <- rqpd(dat, panel(lambda = lambda,taus= seq(.1,.9,.1),tauw=rep(1/9,9),method="pfe"), data= datset, control=sfn.control(tmpmax=20*nrow(npl_hh)) )
  
  pfe2.summ1 <- summary.rqpd(pfe2.fit1, se = "boot",covariance = TRUE)
  
  
  pfe.name<- names(npl_hh[all.vars(de_model_BANK_rqpd)])
  
  a <- length(pfe.name) - 1
  b <- length(seq(.1,.9,.1))
  c <- a*b
  
  pfe2.table <- data.frame(pfe2.summ1$coefficients[1:c,])
  
  
  pfe.row.names <- row.names(pfe2.table)
  pfe.row.names_mod <- gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","",pfe.row.names)
  
  pfe.types <- str_extract(pfe.row.names,"(\\[)(\\d*)(\\.)(\\d*)(\\])")
  
  
  starPrinter <- function(pVal) {
    as.numeric(pVal)
    if(pVal < 0.01) {return("***")}
    if(pVal < 0.05){ return("**")}
    if(pVal < 0.1) {return("*")}
    
    return("")
  }
  
  pfe2.table2 <-  cbind(pfe2.table,pfe.row.names_mod, pfe.types)
  pfe2.table2$Pr...t.. <- round(pfe2.table2$Pr...t..,5)
  pfe2.table2[c(1,2,3)] <- round(pfe2.table2[c(1,2,3)],3)
  # coefficients and t-values in matrix
  cf_10 <-  pfe2.table2[,c(1,2)]
  # p-values
  cf_10.pVals <-  pfe2.table2 [,4]
  
  
  
  
  
  pfe2.table2 <-  pfe2.table2 %>% mutate( pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
                                          ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
  # QRFE_npl_hh1 <-  QRFE_npl_hh %>% mutate(pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
  #                                                                                        ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
  # View( QRFE_npl_hh1)
  # View( QRFE_npl_hh)
  
  #QRFE_npl_hh1$var <- as.numeric(gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","", QRFE_npl_hh1$var))
  #QRFE_npl_hh1$pfe.types <- as.numeric(gsub("(\\[)|(\\])","", QRFE_npl_hh1$pfe.types))
  #pfe2.table6 <-  pfe2.table2 %>% mutate(var=row.names(pfe2.table2),pval_type=ifelse(Pr...t.. <0.01,"***",ifelse( Pr...t.. <0.05,"**", ifelse(Pr...t.. <0.1,"*"," "))))

  pfe2.table2$pfe.types <- as.numeric(gsub("(\\[)|(\\])","",pfe2.table2$pfe.types))
 # class( pfe2.table2$pfe.types)
  
  assign(paste("QRFE1_bk_75e_",d, sep= ""),pfe2.table2)
  # View(QRFE_npl_hh)
  
  for(j in 1:nrow(pfe2.table2)) {
    pfe2.table2[j, 1] <- paste0(pfe2.table2[j, 1], starPrinter(cf_10.pVals[j]))
    pfe2.table2[j, 2] <- paste0("(", pfe2.table2[j, 2], ")")
  }
  
  pfe2.table2[, 1] <-  paste(pfe2.table2[, 1], pfe2.table2[, 2],sep=" ")
  
  pfe2.table2.list<- split(pfe2.table2, pfe2.table2$pfe.type)
  
  # 
  # op <- pfe2.table2.list[[1]]
  # op1 <-op %>% gather(Value,Std..Error,key=pfe.row.names_mod)
  
  r <- seq(.1,.9,.1)
  b <- length(r)
  
  pfe3.table2 <- c()
  
  for (i in 1:b){
    
    r[i]
    #seq(.25,.75e,.25)
    w <- pfe2.table2.list[[i]]$Value
    # h <-  pfe2.table2.list[[i]]$pfe.type
    
    # names(w) <- r[i]
    
    Vector1<- as.character(t(w))
    pfe3.table2  <- cbind(pfe3.table2 ,Vector1)
    
  }
  
  pfe2.name <-pfe2.table2$pfe.row.names_mod[1:a]
  # de_model_ALL_nam <- update(de_model_ALL_rqpd,.~.-name)
  #pfe2.name <-names(npl_hh[all.vars(de_model_ALL_nam)])
  row.names(pfe3.table2) <-as.character(t(pfe2.name))
  
  #colnames(pfe3.table2) <-as.character(t(r))
  colnames(pfe3.table2) <-c("10%","20%","30%","40%","50%","60%","70%","80%","90%")
  #View(pfe3.table2)
  
  
  # pfe3.table2.df<-  data.frame(pfe3.table2[, 1])
  # myTable.names <- row.names(myTable.df)
  
  
 # x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019)[$\lambda = 1$]:",k,sep=" "))
  x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019):",k,sep=" "))
  
  align(x) <- xalign(x)
  digits(x) <- xdigits(x)
  display(x) <- xdisplay(x)
  
  
  print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE1_bk_75e_",d,lambda,".html", sep = ""))
  print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="latex",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE1_bk_75e_",d,lambda,".tex", sep = ""))

  
  }


View(QRFE1_npl_hh.nfi)

path_data <- 'C:/Users/varga/Desktop/Thesis/R_data/Data/'
save(QRFE1_bk_75e_npl_hh.nfi,file=paste(path_data,'QRFE1_npl_hh.nfi_bk_75e.RData', sep = ""))
save(QRFE1_bk_75e_npl_fi.75e,file=paste(path_data,'QRFE1_bk_75e_npl_fi.75e.RData', sep = ""))

save(QRFE1_bk_75e_npl_hh.75e,file=paste(path_data,'QRFE1_bk_75e_npl_hh.75e.RData', sep = ""))
save(QRFE1_bk_75e_npl_nfi.75e,file=paste(path_data,'QRFE1_bk_75e_npl_nfi.75e.RData', sep = ""))




set.seed(123)
lambda <- 5
dat <- de_model_BANK_rqpd
for (i in names(sets.75e)){
  
  a <- i
  b <- names(sets.75e)
  c <- match(a,b)
  d <-  b[c]
  e <- names(sets.75e[[c]])
  datset <- sets.75e[[c]]
  g <- names(datset)
  h <- gsub(paste(d,".",sep=""), "", g)
  names(datset)<- h
 # j <- c("Households & Non-Financial Corporations","Financial Corporations")
  j <- c("Households","Financial Institutions","Non-Financial Institutions")
  k <- j[c]
  
  pfe2.fit1 <- rqpd(dat, panel(lambda = lambda,taus= seq(.1,.9,.1),tauw=rep(1/9,9),method="pfe"), data= datset, control=sfn.control(tmpmax=20*nrow(npl_hh.75e)) )
  
  pfe2.summ1 <- summary.rqpd(pfe2.fit1, se = "boot",covariance = TRUE)
  
  
  pfe.name<- names(npl_hh.75e[all.vars(de_model_BANK_rqpd)])
  
  a <- length(pfe.name) - 1
  b <- length(seq(.1,.9,.1))
  c <- a*b
  
  pfe2.table <- data.frame(pfe2.summ1$coefficients[1:c,])
  
  
  pfe.row.names <- row.names(pfe2.table)
  pfe.row.names_mod <- gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","",pfe.row.names)
  
  pfe.types <- str_extract(pfe.row.names,"(\\[)(\\d*)(\\.)(\\d*)(\\])")
  
  
  starPrinter <- function(pVal) {
    as.numeric(pVal)
    if(pVal < 0.01) {return("***")}
    if(pVal < 0.05){ return("**")}
    if(pVal < 0.1) {return("*")}
    
    return("")
  }
  
  pfe2.table2 <-  cbind(pfe2.table,pfe.row.names_mod, pfe.types)
  pfe2.table2$Pr...t.. <- round(pfe2.table2$Pr...t..,5)
  pfe2.table2[c(1,2,3)] <- round(pfe2.table2[c(1,2,3)],3)
  # coefficients and t-values in matrix
  cf_10 <-  pfe2.table2[,c(1,2)]
  # p-values
  cf_10.pVals <-  pfe2.table2 [,4]
  
  
  
  
  
  pfe2.table2 <-  pfe2.table2 %>% mutate( pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
                                                                                          ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
  # QRFE_npl_hh.75e1 <-  QRFE_npl_hh.75e %>% mutate(pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
  #                                                                                        ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
  # View( QRFE_npl_hh.75e1)
  # View( QRFE_npl_hh.75e)
  
  #QRFE_npl_hh.75e1$var <- as.numeric(gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","", QRFE_npl_hh.75e1$var))
  #QRFE_npl_hh.75e1$pfe.types <- as.numeric(gsub("(\\[)|(\\])","", QRFE_npl_hh.75e1$pfe.types))
  #pfe2.table6 <-  pfe2.table2 %>% mutate(var=row.names(pfe2.table2),pval_type=ifelse(Pr...t.. <0.01,"***",ifelse( Pr...t.. <0.05,"**", ifelse(Pr...t.. <0.1,"*"," "))))
  
  pfe2.table2$pfe.types <- as.numeric(gsub("(\\[)|(\\])","",pfe2.table2$pfe.types))
  # class( pfe2.table2$pfe.types)
  
  assign(paste("QRFE5_bk_75e_",d, sep= ""),pfe2.table2)
  # View(QRFE_npl_hh.75e)
  
  for(j in 1:nrow(pfe2.table2)) {
    pfe2.table2[j, 1] <- paste0(pfe2.table2[j, 1], starPrinter(cf_10.pVals[j]))
    pfe2.table2[j, 2] <- paste0("(", pfe2.table2[j, 2], ")")
  }
  
  pfe2.table2[, 1] <-  paste(pfe2.table2[, 1], pfe2.table2[, 2],sep=" ")
  
  pfe2.table2.list<- split(pfe2.table2, pfe2.table2$pfe.type)
  
  # 
  # op <- pfe2.table2.list[[1]]
  # op1 <-op %>% gather(Value,Std..Error,key=pfe.row.names_mod)
  
  r <- seq(.1,.9,.1)
  b <- length(r)
  
  pfe3.table2 <- c()
  
  for (i in 1:b){
    
    r[i]
    #seq(.25,.75e,.25)
    w <- pfe2.table2.list[[i]]$Value
    # h <-  pfe2.table2.list[[i]]$pfe.type
    
    # names(w) <- r[i]
    
    Vector1<- as.character(t(w))
    pfe3.table2  <- cbind(pfe3.table2 ,Vector1)
    
  }
  
  pfe2.name <-pfe2.table2$pfe.row.names_mod[1:a]
  # de_model_ALL_nam <- update(de_model_ALL_rqpd,.~.-name)
  #pfe2.name <-names(npl_hh.75e[all.vars(de_model_ALL_nam)])
  row.names(pfe3.table2) <-as.character(t(pfe2.name))
  
  #colnames(pfe3.table2) <-as.character(t(r))
  colnames(pfe3.table2) <-c("10%","20%","30%","40%","50%","60%","70%","80%","90%")
  #View(pfe3.table2)
  
  
  # pfe3.table2.df<-  data.frame(pfe3.table2[, 1])
  # myTable.names <- row.names(myTable.df)
  
  
  # x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019)[$\lambda = 1$]:",k,sep=" "))
  x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019):",k,sep=" "))
  
  align(x) <- xalign(x)
  digits(x) <- xdigits(x)
  display(x) <- xdisplay(x)
  
  
  print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE5_bk_75e_",d,lambda,".html", sep = ""))
  print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="latex",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE5_bk_75e_",d,lambda,".tex", sep = ""))
}

path_data <- 'C:/Users/varga/Desktop/Thesis/R_data/Data/'
#save(QRFE5_bk_75e_npl_hh.75e.nfi,file=paste(path_data,'QRFE5_npl_hh.75e.nfi_bk_75e.RData', sep = ""))
save(QRFE5_bk_75e_npl_fi.75e,file=paste(path_data,'QRFE5_bk_75e_npl_fi.75e.RData', sep = ""))

save(QRFE5_bk_75e_npl_hh.75e,file=paste(path_data,'QRFE5_bk_75e_npl_hh.75e.RData', sep = ""))
save(QRFE5_bk_75e_npl_nfi.75e,file=paste(path_data,'QRFE5_bk_75e_npl_nfi.75e.RData', sep = ""))



set.seed(123)
lambda <- 2.5
dat <- de_model_BANK_rqpd
for (i in names(sets.75e)){
  
  a <- i
  b <- names(sets.75e)
  c <- match(a,b)
  d <-  b[c]
  e <- names(sets.75e[[c]])
  datset <- sets.75e[[c]]
  g <- names(datset)
  h <- gsub(paste(d,".",sep=""), "", g)
  names(datset)<- h
  # j <- c("Households & Non-Financial Corporations","Financial Corporations")
  j <- c("Households","Financial Institutions","Non-Financial Institutions")
  k <- j[c]
  
  pfe2.fit1 <- rqpd(dat, panel(lambda = lambda,taus= seq(.1,.9,.1),tauw=rep(1/9,9),method="pfe"), data= datset, control=sfn.control(tmpmax=20*nrow(npl_hh.75e)) )
  
  pfe2.summ1 <- summary.rqpd(pfe2.fit1, se = "boot",covariance = TRUE)
  
  
  pfe.name<- names(npl_hh.75e[all.vars(de_model_BANK_rqpd)])
  
  a <- length(pfe.name) - 1
  b <- length(seq(.1,.9,.1))
  c <- a*b
  
  pfe2.table <- data.frame(pfe2.summ1$coefficients[1:c,])
  
  
  pfe.row.names <- row.names(pfe2.table)
  pfe.row.names_mod <- gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","",pfe.row.names)
  
  pfe.types <- str_extract(pfe.row.names,"(\\[)(\\d*)(\\.)(\\d*)(\\])")
  
  
  starPrinter <- function(pVal) {
    as.numeric(pVal)
    if(pVal < 0.01) {return("***")}
    if(pVal < 0.05){ return("**")}
    if(pVal < 0.1) {return("*")}
    
    return("")
  }
  
  pfe2.table2 <-  cbind(pfe2.table,pfe.row.names_mod, pfe.types)
  pfe2.table2$Pr...t.. <- round(pfe2.table2$Pr...t..,5)
  pfe2.table2[c(1,2,3)] <- round(pfe2.table2[c(1,2,3)],3)
  # coefficients and t-values in matrix
  cf_10 <-  pfe2.table2[,c(1,2)]
  # p-values
  cf_10.pVals <-  pfe2.table2 [,4]
  
  
  
  
  
  pfe2.table2 <-  pfe2.table2 %>% mutate( pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
                                                                                          ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
  # QRFE_npl_hh.75e1 <-  QRFE_npl_hh.75e %>% mutate(pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
  #                                                                                        ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
  # View( QRFE_npl_hh.75e1)
  # View( QRFE_npl_hh.75e)
  
  #QRFE_npl_hh.75e1$var <- as.numeric(gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","", QRFE_npl_hh.75e1$var))
  #QRFE_npl_hh.75e1$pfe.types <- as.numeric(gsub("(\\[)|(\\])","", QRFE_npl_hh.75e1$pfe.types))
  #pfe2.table6 <-  pfe2.table2 %>% mutate(var=row.names(pfe2.table2),pval_type=ifelse(Pr...t.. <0.01,"***",ifelse( Pr...t.. <0.05,"**", ifelse(Pr...t.. <0.1,"*"," "))))
  
  pfe2.table2$pfe.types <- as.numeric(gsub("(\\[)|(\\])","",pfe2.table2$pfe.types))
  # class( pfe2.table2$pfe.types)
  
  assign(paste("QRFE2.5_bk_75e_",d, sep= ""),pfe2.table2)
  # View(QRFE_npl_hh.75e)
  
  for(j in 1:nrow(pfe2.table2)) {
    pfe2.table2[j, 1] <- paste0(pfe2.table2[j, 1], starPrinter(cf_10.pVals[j]))
    pfe2.table2[j, 2] <- paste0("(", pfe2.table2[j, 2], ")")
  }
  
  pfe2.table2[, 1] <-  paste(pfe2.table2[, 1], pfe2.table2[, 2],sep=" ")
  
  pfe2.table2.list<- split(pfe2.table2, pfe2.table2$pfe.type)
  
  # 
  # op <- pfe2.table2.list[[1]]
  # op1 <-op %>% gather(Value,Std..Error,key=pfe.row.names_mod)
  
  r <- seq(.1,.9,.1)
  b <- length(r)
  
  pfe3.table2 <- c()
  
  for (i in 1:b){
    
    r[i]
    #seq(.25,.75e,.25)
    w <- pfe2.table2.list[[i]]$Value
    # h <-  pfe2.table2.list[[i]]$pfe.type
    
    # names(w) <- r[i]
    
    Vector1<- as.character(t(w))
    pfe3.table2  <- cbind(pfe3.table2 ,Vector1)
    
  }
  
  pfe2.name <-pfe2.table2$pfe.row.names_mod[1:a]
  # de_model_ALL_nam <- update(de_model_ALL_rqpd,.~.-name)
  #pfe2.name <-names(npl_hh.75e[all.vars(de_model_ALL_nam)])
  row.names(pfe3.table2) <-as.character(t(pfe2.name))
  
  #colnames(pfe3.table2) <-as.character(t(r))
  colnames(pfe3.table2) <-c("10%","20%","30%","40%","50%","60%","70%","80%","90%")
  #View(pfe3.table2)
  
  
  # pfe3.table2.df<-  data.frame(pfe3.table2[, 1])
  # myTable.names <- row.names(myTable.df)
  
  
  # x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019)[$\lambda = 1$]:",k,sep=" "))
  x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019):",k,sep=" "))
  
  align(x) <- xalign(x)
  digits(x) <- xdigits(x)
  display(x) <- xdisplay(x)
  
  
  print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE25_bk_75e_",d,lambda,".html", sep = ""))
  print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="latex",
                 file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE25_bk_75e_",d,lambda,".tex", sep = ""))
}



# 
# 
# 
# set.seed(123)
# lambda <- 2.5
# dat <- de_model_BANK_rqpd
# for (i in names(sets.75e)){
#   
#   a <- i
#   b <- names(sets.75e)
#   c <- match(a,b)
#   d <-  b[c]
#   e <- names(sets.75e[[c]])
#   datset <- sets.75e[[c]]
#   g <- names(datset)
#   h <- gsub(paste(d,".",sep=""), "", g)
#   names(datset)<- h
#  # j <- c("Households & Non-Financial Corporations","Financial Corporations")
#   j <- c("Households","Financial Institutions","Non-Financial Institutions")
#   k <- j[c]
#   
#   pfe2.fit1 <- rqpd(dat, panel(lambda = lambda,taus= seq(.1,.9,.1),tauw=rep(1/9,9),method="pfe"), data= datset, control=sfn.control(tmpmax=20*nrow(npl_hh.75e)) )
#   
#   pfe2.summ1 <- summary.rqpd(pfe2.fit1, se = "boot",covariance = TRUE)
#   
#   
#   pfe.name<- names(npl_hh.75e[all.vars(de_model_ALL_rqpd)])
#   
#   a <- length(pfe.name) - 1
#   b <- length(seq(.1,.9,.1))
#   c <- a*b
#   
#   pfe2.table <- data.frame(pfe2.summ1$coefficients[1:c,])
#   
#   
#   pfe.row.names <- row.names(pfe2.table)
#   pfe.row.names_mod <- gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","",pfe.row.names)
#   
#   pfe.types <- str_extract(pfe.row.names,"(\\[)(\\d*)(\\.)(\\d*)(\\])")
#   
#   
#   starPrinter <- function(pVal) {
#     as.numeric(pVal)
#     if(pVal < 0.01) {return("***")}
#     if(pVal < 0.05){ return("**")}
#     if(pVal < 0.1) {return("*")}
#     
#     return("")
#   }
#   
#   pfe2.table2 <-  cbind(pfe2.table,pfe.row.names_mod, pfe.types)
#   pfe2.table2$Pr...t.. <- round(pfe2.table2$Pr...t..,5)
#   pfe2.table2[c(1,2,3)] <- round(pfe2.table2[c(1,2,3)],3)
#   # coefficients and t-values in matrix
#   cf_10 <-  pfe2.table2[,c(1,2)]
#   # p-values
#   cf_10.pVals <-  pfe2.table2 [,4]
#   
#   
#   
#   
#   
#   pfe2.table2 <-  pfe2.table2 %>% mutate( pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
#                                                                                           ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
#   # QRFE_npl_hh.75e1 <-  QRFE_npl_hh.75e %>% mutate(pval_type=ifelse(Pr...t.. <0.01,"<0.01",ifelse( Pr...t.. <0.05,"<0.05", 
#   #                                                                                        ifelse(Pr...t.. <0.1,"<0.1",">=0.1"))))
#   # View( QRFE_npl_hh.75e1)
#   # View( QRFE_npl_hh.75e)
#   
#   #QRFE_npl_hh.75e1$var <- as.numeric(gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","", QRFE_npl_hh.75e1$var))
#   #QRFE_npl_hh.75e1$pfe.types <- as.numeric(gsub("(\\[)|(\\])","", QRFE_npl_hh.75e1$pfe.types))
#   #pfe2.table6 <-  pfe2.table2 %>% mutate(var=row.names(pfe2.table2),pval_type=ifelse(Pr...t.. <0.01,"***",ifelse( Pr...t.. <0.05,"**", ifelse(Pr...t.. <0.1,"*"," "))))
#   
#   pfe2.table2$pfe.types <- as.numeric(gsub("(\\[)|(\\])","",pfe2.table2$pfe.types))
#   # class( pfe2.table2$pfe.types)
#   
#   assign(paste("QRFE2.5_bk_75e_",d, sep= ""),pfe2.table2)
#   # View(QRFE_npl_hh.75e)
#   
#   for(j in 1:nrow(pfe2.table2)) {
#     pfe2.table2[j, 1] <- paste0(pfe2.table2[j, 1], starPrinter(cf_10.pVals[j]))
#     pfe2.table2[j, 2] <- paste0("(", pfe2.table2[j, 2], ")")
#   }
#   
#   pfe2.table2[, 1] <-  paste(pfe2.table2[, 1], pfe2.table2[, 2],sep=" ")
#   
#   pfe2.table2.list<- split(pfe2.table2, pfe2.table2$pfe.type)
#   
#   # 
#   # op <- pfe2.table2.list[[1]]
#   # op1 <-op %>% gather(Value,Std..Error,key=pfe.row.names_mod)
#   
#   r <- seq(.1,.9,.1)
#   b <- length(r)
#   
#   pfe3.table2 <- c()
#   
#   for (i in 1:b){
#     
#     r[i]
#     #seq(.25,.75e,.25)
#     w <- pfe2.table2.list[[i]]$Value
#     # h <-  pfe2.table2.list[[i]]$pfe.type
#     
#     # names(w) <- r[i]
#     
#     Vector1<- as.character(t(w))
#     pfe3.table2  <- cbind(pfe3.table2 ,Vector1)
#     
#   }
#   
#   pfe2.name <-pfe2.table2$pfe.row.names_mod[1:a]
#   # de_model_ALL_nam <- update(de_model_ALL_rqpd,.~.-name)
#   #pfe2.name <-names(npl_hh.75e[all.vars(de_model_ALL_nam)])
#   row.names(pfe3.table2) <-as.character(t(pfe2.name))
#   
#   #colnames(pfe3.table2) <-as.character(t(r))
#   colnames(pfe3.table2) <-c("10%","20%","30%","40%","50%","60%","70%","80%","90%")
#   #View(pfe3.table2)
#   
#   
#   # pfe3.table2.df<-  data.frame(pfe3.table2[, 1])
#   # myTable.names <- row.names(myTable.df)
#   
#   
#   # x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019)[$\lambda = 1$]:",k,sep=" "))
#   x <- xtable(pfe3.table2, caption = paste("A Fixed Effects Quantile Regression (2014-2019):",k,sep=" "))
#   
#   align(x) <- xalign(x)
#   digits(x) <- xdigits(x)
#   display(x) <- xdisplay(x)
#   
#   
#   print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",
#                  file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE2.5_bk_75e_",d,lambda,".html", sep = ""))
#   print.xtable(  x, caption.placement = 'top' ,align= "c",booktabs = T,size = "small", include.rownames= TRUE,type="latex",
#                  file= paste("Research_Proposal/Progress/Tables/Final/quantil/QRFE2.5_bk_75e_",d,lambda,".tex", sep = ""))
# }

path_data <- 'C:/Users/varga/Desktop/Thesis/R_data/Data/'
#save(QRFE2.5_bk_75e_npl_hh.75e.nfi,file=paste(path_data,'QRFE2.5_npl_hh.75e.nfi_bk_75e.RData', sep = ""))
save(QRFE2.5_bk_75e_npl_fi.75e,file=paste(path_data,'QRFE2.5_bk_75e_npl_fi.75e.RData', sep = ""))

save(QRFE2.5_bk_75e_npl_hh.75e,file=paste(path_data,'QRFE2.5_bk_75e_npl_hh.75e.RData', sep = ""))
save(QRFE2.5_bk_75e_npl_nfi.75e,file=paste(path_data,'QRFE2.5_bk_75e_npl_nfi.75e.RData', sep = ""))


# ggplot(QRFE2.5_npl_hh.nfi, aes(x=pfe.types)) + 
#   xlab("Quantile(%)") +
#   ylab(" ")+
#   facet_wrap(~ pfe.row.names_mod,scales = "free")+
#   geom_line(aes(y = Value), color = "black",size=.6) + 
#   geom_point(aes(x=pfe.types,y = Value,color=pval_type),shape=16,size=2)+
#   scale_color_manual( values=c( "green2","yellow", "red", "black"),name = "P-values:")+
#   # geom_line(aes(y = lower.bd), color =  "lightblue3") +
#   # geom_line(aes(y = upper.bd), color="lightblue3") +
#   geom_hline(aes(yintercept= 0),color="grey27",linetype="dotdash",size=.5)+
#   #geom_ribbon(aes(ymin=pmin(lower.bd), ymax=pmin(upper.bd)), fill="lightblue", alpha=0.5)+# Ignore NA values for mean  color="black", linetype="longdasehd", size=1)+
#   scale_x_continuous(breaks = seq(0.1,0.9,0.1),limits = c(0.1, 0.9),labels = scales::percent_format(accuracy = 1,scale = 100))+
#   theme(plot.title = element_text(hjust = 0.5))+
#   theme(strip.background =element_rect(fill="lightblue4"))+
#   theme(strip.text = element_text(colour = 'white',size = 9))+
#   theme(legend.position="bottom",panel.background = element_rect(fill = "grey84"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),axis.title.x = element_text(face = "italic"))+
#   theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
#   labs(caption = "Source: EBA Transparency Exercises, authors' calculations")+
#   theme(legend.position="bottom",legend.direction = "horizontal",legend.spacing.x = unit(.5, 'cm'))+
#   ggtitle("Fixed Effects Quantile Regression ("~lambda~"= 2.5 ): Households & Non-Finanial Corporations")




# 
# 
# pfe2.fit1 <- rqpd(de_model_ALL_rqpd, panel(lambda = 1,taus= seq(.1,.9,.1),tauw=rep(1/9,9),method="pfe"), data=npl_hh, control=sfn.control(tmpmax=20*nrow(npl_hh)) )
# 
# pfe2.summ1 <- summary.rqpd(pfe2.fit1, se = "boot",covariance = TRUE)
# 
# # qqplot(npl_hh$NPL_ratio)
# # library("car")
# # qqPlot(npl_hh$NPL_ratio)
# 
# 
# 
# pfe.name<- names(npl_hh[all.vars(de_model_ALL_rqpd)])
# 
# a <- length(pfe.name) - 1
# b <- length(seq(.1,.9,.1))
# c <- a*b
# 
# pfe2.table <- data.frame(pfe2.summ1$coefficients[1:c,])
# 
# 
# pfe.row.names <- row.names(pfe2.table)
# pfe.row.names_mod <- gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","",pfe.row.names)
# 
# pfe.types <- str_extract(pfe.row.names,"(\\[)(\\d*)(\\.)(\\d*)(\\])")
# 
# 
# starPrinter <- function(pVal) {
#   as.numeric(pVal)
#   if(pVal < 0.01) {return("***")}
#   if(pVal < 0.05){ return("**")}
#   if(pVal < 0.1) {return("*")}
#   
#   return("")
# }
# 
# pfe2.table2 <-  cbind(pfe2.table,pfe.row.names_mod, pfe.types)
# pfe2.table2$Pr...t.. <- round(pfe2.table2$Pr...t..,5)
# pfe2.table2[c(1,2,3)] <- round(pfe2.table2[c(1,2,3)],3)
# # coefficients and t-values in matrix
# cf_10 <-  pfe2.table2[,c(1,2)]
# # p-values
# cf_10.pVals <-  pfe2.table2 [,4]
# 
# for(j in 1:nrow(pfe2.table2)) {
#   pfe2.table2[j, 1] <- paste0(pfe2.table2[j, 1], starPrinter(cf_10.pVals[j]))
#   pfe2.table2[j, 2] <- paste0("(", pfe2.table2[j, 2], ")")
# }
# 
# pfe2.table2.list<- split(pfe2.table2, pfe2.table2$pfe.type)
# 
# # 
# # op <- pfe2.table2.list[[1]]
# # op1 <-op %>% gather(Value,Std..Error,key=pfe.row.names_mod)
# 
# r <- seq(.1,.9,.1)
# b <- length(r)
# 
# pfe3.table2 <- c()
# 
# for (i in 1:b){
#   
#   r[i]
#   #seq(.25,.75e,.25)
#   w <- pfe2.table2.list[[i]]$Value
#   # h <-  pfe2.table2.list[[i]]$pfe.type
#   
#   # names(w) <- r[i]
#   
#   Vector1<- as.character(t(w))
#   pfe3.table2  <- cbind(pfe3.table2 ,Vector1)
#   
# }
# 
# pfe2.name <-pfe2.table2$pfe.row.names_mod[1:a]
# # de_model_ALL_nam <- update(de_model_ALL_rqpd,.~.-name)
# #pfe2.name <-names(npl_hh[all.vars(de_model_ALL_nam)])
# row.names(pfe3.table2) <-as.character(t(pfe2.name))
# 
# colnames(pfe3.table2) <-as.character(t(r))
# View(pfe3.table2)
# 
# 
# 
# x <- xtable(pfe3.table2, caption = "A Fixed Effects Quantile Regression")
# 
# align(x) <- xalign(x)
# digits(x) <- xdigits(x)
# display(x) <- xdisplay(x)
# 
# print.xtable( x, caption.placement = 'top' ,align= "r|llrc",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",file= "Research_Proposal/Progress/Tables/pfe_hh.html", sep = "")
# print.xtable( x,  caption.placement = 'top',align= "r|llrc",booktabs = T,size = "small",  include.rownames= TRUE,type="latex",file= "Research_Proposal/Progress/Tables/pfe_hh.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/pfe_hh.tex", sep = "")
























# 
# 
# 
# #**********************************Random-Effects***********************************************
# #demos()
# pdim(npl_hh)
# library(quantreg)
# library(rqpd)
# 
# # trace(rq.fit.sfn, edit=TRUE)
# library(sdcMicro)
# 
# # npl_hh1 <- npl_hh
# # npl_hh_1 <- addNoise(data.frame(npl_hh), variables =  c("NPL_ratio","CET1_ratio_tr","LEVER_tr_ratio_imput", "RORAC","BankSize_tran_imput", "Cost_to_Income" ,      "NIM_tr_imput"  ,       "Stgth_legal_index" ,   "Reco_rate_dol"    ,    "infl_perc"   ,        
# #                                                         "curr_acc_bal"   , "GDP_growth_perc"   ,"unempl_rate_imf"  , "gross_public_debt"   ,          
# #   
# #                                                                                                                                                         "CBDI_index"   ) , noise = 20,method = "additive") 
# # npl_hh2 <-   data.frame( npl_hh_1$xm    )    
# 
# #names(npl_hh[all.vars(def_model_ALL)])
# npl_hh$NPL_ratio
#  options(dplyr.width = Inf)
# 
# cre.fit1 <- rqpd(de_model_ALL_rqpd_cre, panel(taus= seq(.25,.75e,.25), method="cre",cre="crem"), 
#                  data=npl_hh,control=sfn.control(tmpmax=2.5*nrow(npl_hh),small=0.000000000000001,cachsz=100))
# cre.fit2 <- rqpd(de_model_ALL_rqpd_cre, panel( method="cre",cre="m"), data=p1)
# cre.fit3 <- rqpd(de_model_ALL_rqpd_cre, panel(taus= .5, method="cre",cre="crem"), data=npl_hh)
# cre.fit4 <- rqpd(de_model_ALL_rqpd_cre, panel(taus= 0.75e, method="cre",cre="crem"), data=npl_hh)
# cre.fit5 <- rqpd(de_model_ALL_rqpd_cre, panel(taus= 0.9, method="cre",cre="crem"), data=npl_hh)
# 
# cre.summ1 <- summary.rqpd(cre.fit1, se = "boot", covariance = TRUE)
# cre.summ2 <- summary.rqpd(cre.fit2, se = "boot", covariance = TRUE)
# cre.summ3 <- summary.rqpd(cre.fit3, se = "boot", covariance = TRUE)
# cre.summ4 <- summary.rqpd(cre.fit4, se = "boot", covariance = TRUE)
# cre.summ5 <- summary.rqpd(cre.fit5, se = "boot", covariance = TRUE)
# # sfn.control()
#  trace(rqpd.fit.sfn, edit=TRUE)
#  help(rq.fit.sfn)
# trace(rqpd, edit=TRUE)
# trace(sfn, edit=TRUE)
# trace(rqpd, edit=TRUE)
# sfn.control(small=0.000000000000001)
# sfn.control(tmpmax=1000)
# 
# 
# # nsubmax upper bound for dimension of lindx
# # tmpmax upper bound for dimension of tmpvec
# # nnzlmax upper bound for non-zero entries of L stored in lnz, including diagonal
# # cachsz size of cache in kbytes on target machine
# # small convergence tolerance for interior point algorithm
# # maxiter maximal number of interior point iterations.
# # warn.mesg logical flag controlling printing of warnings.
# trace(sfn.control, edit=TRUE)
# trace(rq.fit.sfnc , edit=TRUE)
# trace(rqpd.fit.cre, edit=TRUE)
# trace(model.cre, edit=TRUE)
# trace(sfnMessage, edit=TRUE)
# # warnings()
# starPrinter <- function(pVal) {
#   as.numeric(pVal)
#   if(pVal < 0.01) {return("***")}
#   if(pVal < 0.05){ return("**")}
#   if(pVal < 0.1) {return("*")}
#   
#   return("")
# }
# # sets.75e_pfe <- list(pfe.summ1=pfe.summ1,pfe.summ2=pfe.summ2,pfe.summ3=pfe.summ3,
# #                  pfe.summ4=pfe.summ4,pfe.summ5=pfe.summ5,pfe.summ6=pfe.summ6,
# #                  pfe.summ7=pfe.summ7,pfe.summ8=pfe.summ9,pfe.summ9=pfe.summ9)
# 
# sets.75e_cre <- list(cre.summ1=cre.summ1, cre.summ2=cre.summ2, cre.summ3=cre.summ3,cre.summ4=cre.summ4,cre.summ5=cre.summ5)
# 
# 
# myEstVector <- c()
# for (i in names(sets.75e_cre)){
#   
#   a <- i
#   b <- names( sets.75e_cre)
#   c <- match(a,b)
#   d <-  b[c]
#   e <- names(sets.75e_cre[c])
#   f <-  sets.75e_cre[[c]]
#   
#   # coefficients and t-values in matrix
#   cf_10 <-  f$coefficients[1:15,1:3]
#   # p-values
#   cf_10.pVals <-  f$coefficients [1:15,4]
#   
#   diag(f$cov)
#   myTable <- round(cf_10, 3)
#   # get stars and put tvalues in parentheses
#   for(j in 1:nrow(myTable)) {
#     myTable[j, 1] <- paste0(myTable[j, 1], starPrinter(cf_10.pVals[j]))
#     myTable[j, 2] <- paste0("(", myTable[j, 2], ")")
#   }
#   
#   myTable[, 1] <-  paste(myTable[, 1], myTable[, 2],sep=" ")
#   
#   myTable.df<-  data.frame(myTable[, 1])
#   myTable.names <- row.names(myTable.df)
#   
#   myTable.names <- gsub("(\\[)(\\d*)(\\.)(\\d*)(\\])","",myTable.names)
#   
#   assign(paste(d,".Table", sep= ""), myTable.df)
#   
#   
#   Vector1<- as.character(t(myTable[, 1]))
#   myEstVector <- cbind(myEstVector,Vector1)
#   
#   
#   
#   #rm("a", "b", "c","d","e","i","j","f"," myTable.df"," myTable","cf_10 ","cf_10.pVals")
#   
# }
# #features <- c(sprintf("Q %0.1f", seq(0.1,0.9,0.1),"label"))
# #(features <- c(sprintf("%.0f%%", seq(10,90,10),"label")))
# 
# myNewTable <- data.frame( myEstVector)
# # names(myNewTable) <-features
# row.names(myNewTable) <-myTable.names
# colnames(myNewTable) <- c(0.10,0.25,0.5,0.75e,0.9)
# View(myNewTable)
# 
# 
# x <- xtable(pfe3.table2, caption = "A Fixed Effects Quantile Regression")
# 
# align(x) <- xalign(x)
# digits(x) <- xdigits(x)
# display(x) <- xdisplay(x)
# 
# print.xtable( x, caption.placement = 'top' ,align= "r|llrc",booktabs = T,size = "small", include.rownames= TRUE,type="HTML",file= "Research_Proposal/Progress/Tables/pfe_hh.html", sep = "")
# print.xtable( x,  caption.placement = 'top',align= "r|llrc",booktabs = T,size = "small",  include.rownames= TRUE,type="latex",file= "Research_Proposal/Progress/Tables/pfe_hh.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/pfe_hh.tex", sep = "")
# 

