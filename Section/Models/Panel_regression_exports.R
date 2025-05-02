
# stargazer(out.plain,out.lsdv,
#           type="html", 
#           column.labels = c("Plain","With Fixed Effects"),title="Comparing Pooled and Fixed-Effects",
#           omit="as.factor",
#           covariate.labels = c("Per Capita GDP in 1000s", "Economic Globalization", "Polity 2 Score"),
#           notes=c("Fixed effects estimated but not shown in Fixed Effects column"),
#           add.lines = list(c("Fixed effects?", "No", "Yes")),
#           dep.var.labels = "Military Expenditure"
# )


#https://stackoverrun.com/de/q/9105874


starPrinter <- function(pVal) {
  as.numeric(pVal)
  if(pVal < 0.01) {return("***")}
  if(pVal < 0.05){ return("**")}
  if(pVal < 0.1) {return("*")}
  
  return("")
}


for (i in names(sets)){
  
  a <- i
  b <- names(sets)
  c <- match(a,b)
  d <-  b[c]
  #e <- names(sets[c])
  #f <- data.frame(sets[c])
  #g <- names(f)
  #h <- gsub(paste(d,".",sep=""), "", g)
  #names(f)<- h
  j <- c("Households & Non-Financial Institutions","Households & Non-Financial & Financial Institutions")
 #j <- c("Households","Financial Institutions","Non-Financial Institutions")
  k <- j[c]
  
ols.1 <- OLS_plm[c]
#diff.1 <- FD_plm[c]
fe.1 <-  FE_plm [c]
re.1 <-  RE_plm [c]
diffgmm.1 <- diffgmm2_plm[c]
sysgmm.1 <-  sysgmm4_plm[c]


#Breusch-Godfrey/Wooldridge
sc1.ols <- pbgtest(OLS_plm[[c]], order = 2)
sc1.fe <-pbgtest(FE_plm[[c]], order = 2)
sc1.re <-pbgtest(RE_plm[[c]], order = 2)

sc1 <- cbind(round(sc1.ols$statistic,3),round(sc1.fe$statistic,3),round(sc1.re$statistic,3))
sc1.star <- cbind(sc1.ols$p.value,sc1.fe$p.value,sc1.re$p.value)

for(j in 1:length(sc1)) {
  sc1[j] <- paste0(sc1[j], starPrinter(sc1.star[j]))
  
}


sc1 <- as.vector(cbind("Breusch-Godfrey/Wooldridge",sc1))
sc1

#Durbin-Watson test
sc2.ols <-pdwtest(OLS_plm[[c]], order = 2)
sc2.fe <-pdwtest(FE_plm[[c]], order = 2)
sc2.re <-pdwtest(RE_plm[[c]], order = 2)

sc2 <- cbind(round(sc2.ols$statistic,3),round(sc2.fe$statistic,3),round(sc2.re$statistic,3))
sc2.star <- cbind(sc2.ols$p.value,sc2.fe$p.value,sc2.re$p.value)

for(j in 1:length(sc2)) {
  sc2[j] <- paste0(sc2[j], starPrinter(sc2.star[j]))
  
}
sc2 <- as.vector(cbind("Durbin-Watson",sc2))

#Sargan Test
diffgmm <- lapply(diffgmm2_plm,sargan)

sysgmm <- lapply(sysgmm4_plm,sargan)

st1 <- cbind(round(diffgmm[[c]]$statistic,3), round(sysgmm[[c]]$statistic,3))
st1.star <- cbind(diffgmm[[c]]$p.value,sysgmm[[c]]$p.value)

for(j in 1:length(st1)) {
  st1[j] <- paste0(st1[j], starPrinter(st1.star[j]))
  
}


st1 <- as.vector(cbind("Sargan Test","","","",st1))
#st1

#Arellano-Bond: AR(1)
diffgmm.AR1 <-map(diffgmm2_plm, function(x) mtest(x , order = 1))
sysgmm.AR1 <-map(sysgmm4_plm, function(x) mtest(x , order = 1))

ar1 <- cbind(round(diffgmm.AR1[[c]]$statistic,3), round(sysgmm.AR1 [[c]]$statistic,3))
ar1.star <- cbind(diffgmm.AR1[[c]]$p.value,sysgmm.AR1 [[c]]$p.value)

for(j in 1:length(ar1)) {
  ar1[j] <- paste0(ar1[j], starPrinter(ar1.star[j]))
  
}


ar1 <- as.vector(cbind("Arellano-Bond:AR(1)","","","",ar1))
#ar1


#Arellano-Bond: AR(2)
diffgmm.AR2 <- map(diffgmm2_plm, function(x) mtest(x , order = 2))
sysgmm.AR2 <-map(sysgmm4_plm, function(x) mtest(x , order = 2))

ar2 <- cbind(round(diffgmm.AR2[[c]]$statistic,3), round(sysgmm.AR2 [[c]]$statistic,3))
ar2.star <- cbind(diffgmm.AR2[[c]]$p.value,sysgmm.AR2 [[c]]$p.value)

for(j in 1:length(ar2)) {
  ar2[j] <- paste0(ar2[j], starPrinter(ar2.star[j]))
  
}


ar2 <- as.vector(cbind("Arellano-Bond:AR(2)","","","",ar2))
#ar2
#class(sc2)

  # ols.1 <- OLS_summary[c]
  # diff.1 <- FD_summary[c]
  # fe.1 <-  FE_summary [c]
  # re.1 <-  RE_summary [c]
  # diffgmm.1 <- diffgmm2_summary[c]
  # sysgmm.1 <-  sysgmm2_summary[c]
  # 
  # 

#Robust Estimators
ols.1a <- OLS_summary[c]
#diff.1a <- FD_summary[c]
fe.1a <-  FE_summary [c]
re.1a <-  RE_summary [c]
diffgmm.1a <- diffgmm_summary[c]
sysgmm.1a <-  sysgmm_summary[c]

coeftest1 <- function(x) {
   coeftest(x,vcovHC(x,method= "white1", type="sss", cluster="group"))
 # coeftest(x,vcovHC(x,method= "arellano", type="sss", cluster="group"))
 # coeftest(x,vcovHC(x, cluster="group"))
}

ols.1b <- coeftest1(ols.1[[1]])
#diff.1b  <- coeftest1(diff.1 [[1]])
fe.1b <- coeftest1(fe.1[[1]])
re.1b <- coeftest1(re.1[[1]])

se1 = list(ols.1b[,"Std. Error"], fe.1b[,"Std. Error"],re.1b[,"Std. Error"]) 
  
  stargazer( ols.1, fe.1 , re.1,diffgmm.1, sysgmm.1,title=paste("Panel Data Models and HC-Robust Standard Errors (2014-2019):",k,sep=" "),
             align=TRUE,type = "latex",
             se = se1,
             column.labels=c("OLS","FE","RE","DIF","SYS"),
             column.separate = c(1,1,1,1,1),
             font.size = "small",
             # covariate.labels=c("Handling of Complaints","No Special Privileges",
             #   "Opportunity to Learn","Performance-Based Raises","Too Critical","Advancement"),
             # omit.stat=c("LL","ser","f"), 
            # keep.stat=c("all"),
             column.sep.width = "10pt",
             #omit.stat=c("f", "ser"),
            omit.stat=c( "ser"),
             no.space=TRUE ,
            omit="SSMN",
            dep.var.labels.include = FALSE,
            model.numbers          = FALSE,
            add.lines = list(sc1, sc2,st1,ar1,ar2),
            #add.lines = list(st1,ar1,ar2),
             out=paste("Research_Proposal/Progress/Tables/Final/Panel/Static_Models_",d,".tex", sep = ""))
  
  capture.output( stargazer(ols.1, fe.1 , re.1,diffgmm.1, sysgmm.1, title=paste("Panel Data Models and HC-Robust Standard Errors (2014-2019):",k,sep=" "),
                            align=TRUE,
                            se = se1,
                            column.labels=c("OLS","FE","RE","GMM I","GGM II"),
                            column.separate = c(1,1,1,1,1),
                            font.size = "small",
                            # covariate.labels=c("Handling of Complaints","No Special Privileges",
                            #   "Opportunity to Learn","Performance-Based Raises","Too Critical","Advancement"),
                            # omit.stat=c("LL","ser","f"),
                            #keep.stat=c("all"),
                            column.sep.width = "10pt",
                            #omit.stat=c("f", "ser"),
                            omit.stat=c( "ser"),
                            no.space=TRUE ,
                          omit="SSMN",
                          dep.var.labels.include = FALSE,
                          model.numbers          = FALSE,
                        #  add.lines = list(c("Groups", "48"), c("Periods", "17")),
                        add.lines = list(sc1, sc2,st1,ar1,ar2),
                        #add.lines = list(st1,ar1,ar2),
                           out=paste("Research_Proposal/Progress/Tables/Final/Panel/Static_Models_",d,".html", sep = "")))
  
  # stargazer(cor(f[all.vars(def_model)], use="complete.obs",method= "pearson"),
  #           digits=3, align=T, title= paste("Correlation Matrix (2014-2019):",k,sep=" "),out=paste("Research_Proposal/Progress/Tables/correlation_matrix_",d,".html", sep = ""))
  # 
  # capture.output(stargazer(cor(f[all.vars(def_model)], use="complete.obs",method= "pearson"),
  #                          digits=3, align=T, type= "latex", title= paste("Correlation Matrix (2014-2019):",k,sep=" "),out=paste("Research_Proposal/Progress/Tables/correlation_matrix_",d,".tex", sep = "")))
  # 
 # rm("a", "b", "c","d","i","j","k","ols.1", "ols.2","diff.1","diff.2" , "fe.1" ,  "re.1","re.2")
  #rm("a", "b", "c","d","i","j","k")
}

# 
# require(lmtest)
# 
# rob.fit1        <- coeftest(fit1, function(x) vcovHC(x, type="HC0"))
# rob.fit2        <- coeftest(fit2, function(x) vcovHC(x, type="HC0"))
# summ.fit1 <- summary(fit1, vcov. = function(x) vcovHC(x, type="HC0"), diagnostics=T)
# summ.fit2 <- summary(fit2, vcov. = function(x) vcovHC(x, type="HC0"), diagnostics=T)
# 
# stargazer(fit1, fit2, type = "text", 
#           se = list(rob.fit1[,"Std. Error"], rob.fit2[,"Std. Error"]), 
#           add.lines = list(c(rownames(summ.fit1$diagnostics)[1], 
#                              round(summ.fit1$diagnostics[1, "p-value"], 2), 
#                              round(summ.fit2$diagnostics[1, "p-value"], 2)), 
#                            c(rownames(summ.fit1$diagnostics)[2], 
#                              round(summ.fit1$diagnostics[2, "p-value"], 2), 
#                              round(summ.fit2$diagnostics[2, "p-value"], 2)) ))


library(lmtest)
#coeftest(OLS_plm[[1]], function(x) vcovHC(x,method= "arellano", type="HC3", cluster="group"))

for (i in names(sets)){
  
  a <- i
  b <- names(sets)
  c <- match(a,b)
  d <-  b[c]
  #e <- names(sets[c])
  #f <- data.frame(sets[c])
  #g <- names(f)
  #h <- gsub(paste(d,".",sep=""), "", g)
  #names(f)<- h
  j <- c("Households & Non-Financial Institutions","Financial Institutions")
  k <- j[c]
  
  ols.1 <- OLS_plm[c]
  #diff.1 <- FD_plm[c]
  fe.1 <-  FE_plm [c]
  re.1 <-  RE_plm [c]
  diffgmm.1 <- diffgmm_plm[c]
  sysgmm.1 <-  sysgmm_plm[c]
  
  ols.1a <- OLS_summary[c]
  #diff.1a <- FD_summary[c]
  fe.1a <-  FE_summary [c]
  re.1a <-  RE_summary [c]
  diffgmm.1a <- diffgmm_summary[c]
  sysgmm.1a <-  sysgmm_summary[c]
  
  coeftest1 <- function(x) {
   # coeftest(x,vcovHC(x,method= "white1", type="sss", cluster="group"))
    coeftest(x,vcovHC(x,method= "arellano", type="sss", cluster="group"))
  }
  
  ols.1b <- coeftest1(ols.1[[1]])
  #diff.1b  <- coeftest1(diff.1 [[1]])
  fe.1b <- coeftest1(fe.1[[1]])
  re.1b <- coeftest1(re.1[[1]])
  
  se1 = list(ols.1b[,"Std. Error"], fe.1b[,"Std. Error"],re.1b[,"Std. Error"]) 
  # ols.1 <- OLS_summary[c]
  # diff.1 <- FD_summary[c]
  # fe.1 <-  FE_summary [c]
  # re.1 <-  RE_summary [c]
  # diffgmm.1 <- diffgmm2_summary[c]
  # sysgmm.1 <-  sysgmm2_summary[c]
  # 
  # 
  
  # Adjust standard errors
  # cov1         <- vcovHC(ols.1,method= "arellano", type="HC3", cluster="group")
  # robust_se1    <- sqrt(diag(cov1))
  # # Adjust standard errors
  # cov2         <- vcovHC(diff.1 ,method= "arellano", type="HC3", cluster="group")
  # robust_se2    <- sqrt(diag(cov2))
  # # Adjust standard errors
  # cov3         <- vcovHC(fe.1,method= "arellano", type="HC3", cluster="group")
  # robust_se3    <- sqrt(diag(cov3))
  # # Adjust standard errors
  # cov4         <- vcovHC(re.1,method= "arellano", type="HC3", cluster="group")
  # robust_se4    <- sqrt(diag(cov4))
  
  
  stargazer( ols.1, fe.1 , re.1,title=paste("Panel Data Models and HC-Robust Standard Errors (2014-2019):",k,sep=" "),
             align=TRUE,type = "latex",
             column.labels=c("OLS","FE","RE"),
             se = se1,
             column.separate = c(1,1,1),
             font.size = "small",
             # covariate.labels=c("Handling of Complaints","No Special Privileges",
             #   "Opportunity to Learn","Performance-Based Raises","Too Critical","Advancement"),
             # omit.stat=c("LL","ser","f"), 
             column.sep.width = "10pt",
             omit.stat=c("f", "ser"),
             no.space=TRUE ,
             omit="SSMN",
             dep.var.labels.include = FALSE,
             model.numbers          = FALSE,
             # add.lines = list(c("Groups", "48"), c("Periods", "17")),
             out=paste("Research_Proposal/Progress/Tables/Final/Panel/Static_Models_HC_",d,".tex", sep = ""))
  
  capture.output( stargazer(ols.1, fe.1 , re.1, title=paste("Panel Data Models and Robust Standard Errors (2014-2019):",k,sep=" "),
                            align=TRUE,
                            column.labels=c("OLS","FE","RE"),
                            se = se1,
                            column.separate = c(1,1,1),
                            font.size = "small",
                            # covariate.labels=c("Handling of Complaints","No Special Privileges",
                            #   "Opportunity to Learn","Performance-Based Raises","Too Critical","Advancement"),
                            # omit.stat=c("LL","ser","f"), 
                            column.sep.width = "10pt",
                            omit.stat=c("f", "ser"),
                            no.space=TRUE ,
                            omit="SSMN",
                            dep.var.labels.include = FALSE,
                            model.numbers          = FALSE,
                            #  add.lines = list(c("Groups", "48"), c("Periods", "17")),
                            out=paste("Research_Proposal/Progress/Tables/Final/Panel/Static_Models_HC_",d,".html", sep = "")))
  
  # stargazer(cor(f[all.vars(def_model)], use="complete.obs",method= "pearson"),
  #           digits=3, align=T, title= paste("Correlation Matrix (2014-2019):",k,sep=" "),out=paste("Research_Proposal/Progress/Tables/correlation_matrix_",d,".html", sep = ""))
  # 
  # capture.output(stargazer(cor(f[all.vars(def_model)], use="complete.obs",method= "pearson"),
  #                          digits=3, align=T, type= "latex", title= paste("Correlation Matrix (2014-2019):",k,sep=" "),out=paste("Research_Proposal/Progress/Tables/correlation_matrix_",d,".tex", sep = "")))
  # 
  # rm("a", "b", "c","d","i","j","k","ols.1", "ols.2","diff.1","diff.2" , "fe.1" ,  "re.1","re.2")
  #rm("a", "b", "c","d","i","j","k")
}



######FEASIBLE GENERALIZED FIXED SQUARES


library("texreg")



extract.pggls <- function (model, include.rsquared = TRUE, include.adjrs = TRUE, 
                           include.nobs = TRUE, ...) 
{
  s <- summary(model, ...)
  coefficient.names <- rownames(s$CoefTable)
  coefficients <- s$CoefTable[, 1]
  standard.errors <- s$CoefTable[, 2]
  significance <- s$CoefTable[, 4]
  rs <- s$rsqr
  n <- length(s$resid)
  gof <- numeric()
  gof.names <- character()
  gof.decimal <- logical()
  if (include.rsquared == TRUE) {
    gof <- c(gof, rs)
    gof.names <- c(gof.names, "R$^2$")
    gof.decimal <- c(gof.decimal, TRUE)
  }
  if (include.nobs == TRUE) {
    gof <- c(gof, n)
    gof.names <- c(gof.names, "Num. obs.")
    gof.decimal <- c(gof.decimal, FALSE)
  }
  tr <- createTexreg(coef.names = coefficient.names, coef = coefficients, 
                     se = standard.errors, pvalues = significance, gof.names = gof.names, 
                     gof = gof, gof.decimal = gof.decimal)
  return(tr)
}

setMethod("extract", signature = className("pggls", "plm"),
          definition = extract.pggls)


for (i in names(sets)){
  
  a <- i
  b <- names(sets)
  c <- match(a,b)
  d <-  b[c]
  #e <- names(sets[c])
  #f <- data.frame(sets[c])
  #g <- names(f)
  #h <- gsub(paste(d,".",sep=""), "", g)
  #names(f)<- h
  #j <- c("Households & Non-Financial Institutions","Financial Institutions")
  j <- c("Households","Financial Institutions","Non-Financial Institutions")
  k <- j[c]
  pggls <- pggls_plm[[c]]
  fegls <- fegls_plm[[c]]
  
  texreg(list(pggls, fegls),
         custom.model.names = c("Random Effects", "Fixed Effects"),
         #single.row = T,
         file=paste("Research_Proposal/Progress/Tables/Final/Panel/GFLS_",d,".tex", sep = ""),
         caption = paste("Feasible Generalized Least Square Estimation (2014-2019):",k,sep=" "), 
         #label = "table:1",
         digits = 3,
         caption.above= TRUE,
         # custom.gof.names = c("R$ ^ 2$", "Adj. R$ ^ 2$", "Num. obs.", "s\\_idios","s\\_id"),
         scriptsize = FALSE)
  
  htmlreg(list(pggls, fegls),
          custom.model.names = c("Random Effects", "Fixed Effects"),
         # single.row = T,
         file=paste("Research_Proposal/Progress/Tables/Final/Panel/GFLS_",d,".html", sep = ""),
         caption = paste("Feasible Generalized Least Square Estimation (2014-2019):",k,sep=" "), 
         #label = "table:1",
         digits = 3,
         caption.above= TRUE,
         # custom.gof.names = c("R$ ^ 2$", "Adj. R$ ^ 2$", "Num. obs.", "s\\_idios","s\\_id"),
         scriptsize = FALSE)
  
}

 pggls1 <-  pggls_plm[[1]]
fegls1 <-  fegls_plm[[1]] 
 pggls2 <-  pggls_plm[[2]]
fegls2 <-  fegls_plm[[2]] 
pggls3<-  pggls_plm[[3]]
fegls3 <-  fegls_plm[[3]] 
  
texreg(list(pggls1, fegls1,pggls2,fegls2,pggls3,fegls3),
       custom.model.names = c("Random Effects", "Fixed Effects","Random Effects", "Fixed Effects","Random Effects", "Fixed Effects"),
       #single.row = T,
       file="Research_Proposal/Progress/Tables/Final/Panel/GFLS_ALL.tex",
       caption ="Feasible Generalized Least Square Estimation (2014-2019)", 
       #label = "table:1",
       digits = 3,
       caption.above= TRUE,
       # custom.gof.names = c("R$ ^ 2$", "Adj. R$ ^ 2$", "Num. obs.", "s\\_idios","s\\_id"),
       scriptsize = TRUE)

htmlreg(list(pggls1, fegls1,pggls2,fegls2,pggls3,fegls3),
       custom.model.names = c("Random Effects", "Fixed Effects","Random Effects", "Fixed Effects","Random Effects", "Fixed Effects"),
       #single.row = T,
       file="Research_Proposal/Progress/Tables/Final/Panel/GFLS_ALL.html",
       caption ="Feasible Generalized Least Square Estimation (2014-2019)", 
       #label = "table:1",
       digits = 3,
       caption.above= TRUE,
       # custom.gof.names = c("R$ ^ 2$", "Adj. R$ ^ 2$", "Num. obs.", "s\\_idios","s\\_id"),
       scriptsize = TRUE)

