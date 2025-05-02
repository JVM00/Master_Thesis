
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




#Households
re.1 <-  RE_bk_75e_plm$npl_hh.75e
fe.1 <- FE_bk_75e_plm$npl_hh.75e
sysgmm.1 <-  sysgmm4_bk_75e_plm$npl_hh.75e

#Non-Financial Institutions
re.2 <-  RE_bk_75e_plm$npl_nfi.75e
fe.2 <-  FE_bk_75e_plm$npl_nfi.75e
#diffgmm.2 <- diffgmm2_plm$npl_nfi
diffgmm.2 <- sysgmm4_bk_75e_plm$npl_nfi.75e

#Financial Institutions
re.3 <-  RE_bk_75e_plm$npl_fi.75e
fe.3 <- FE_bk_75e_plm$npl_fi.75e

#diffgmm.3 <- diffgmm2_plm$npl_fi
diffgmm.3 <- sysgmm4_bk_75e_plm$npl_fi.75e

# #Breusch-Godfrey/Wooldridge
# 
# 
# sc1.ols <- pbgtest(OLS_plm[[c]], order = 2)
# sc1.fe <-pbgtest(FE_plm[[c]], order = 2)
# sc1.re <-pbgtest(RE_plm[[c]], order = 2)
# 
# sc1 <- cbind(round(sc1.ols$statistic,3),round(sc1.fe$statistic,3),round(sc1.re$statistic,3))
# sc1.star <- cbind(sc1.ols$p.value,sc1.fe$p.value,sc1.re$p.value)
# 
# for(j in 1:length(sc1)) {
#   sc1[j] <- paste0(sc1[j], starPrinter(sc1.star[j]))
#   
# }
# 
# 
# sc1 <- as.vector(cbind("Breusch-Godfrey/Wooldridge",sc1))
# sc1
# 
# #Durbin-Watson test
# sc2.ols <-pdwtest(OLS_plm[[c]], order = 2)
# sc2.fe <-pdwtest(FE_plm[[c]], order = 2)
# sc2.re <-pdwtest(RE_plm[[c]], order = 2)
# 
# sc2 <- cbind(round(sc2.ols$statistic,3),round(sc2.fe$statistic,3),round(sc2.re$statistic,3))
# sc2.star <- cbind(sc2.ols$p.value,sc2.fe$p.value,sc2.re$p.value)
# 
# for(j in 1:length(sc2)) {
#   sc2[j] <- paste0(sc2[j], starPrinter(sc2.star[j]))
#   
# }
# sc2 <- as.vector(cbind("Durbin-Watson",sc2))

#Sargan Test
# diffgmm <- lapply(diffgmm2_plm,sargan)
# sysgmm <- lapply(sysgmm4_plm,sargan)


r <- rep("",6)

gmm.st1 <- sargan(sysgmm.1)
gmm.st2 <- sargan(diffgmm.2)
gmm.st3 <- sargan(diffgmm.3)

st <- cbind(round(gmm.st1$statistic,2), round(gmm.st2$statistic,2),round(gmm.st3 $statistic,2))
st.star <-cbind(round(gmm.st1$p.value,4), round(gmm.st2$p.value,4),round(gmm.st3 $p.value,4))

st <- as.vector(c("Sargan Test",r,st))
st.star <- as.vector(c("Prob (Sargan Test)",r,st.star))

gmm.ar1.1 <-  mtest(sysgmm.1, order = 1)
gmm.ar1.2 <-  mtest(diffgmm.2, order = 1)
gmm.ar1.3 <-  mtest(diffgmm.3, order = 1)

gmm.ar2.1 <-  mtest(sysgmm.1, order = 2)
gmm.ar2.2 <-  mtest(diffgmm.2, order = 2)
gmm.ar2.3 <-  mtest(diffgmm.3, order = 2)

ar1 <- cbind(round(gmm.ar1.1$statistic,2), round(gmm.ar1.2$statistic,2),round(gmm.ar1.3$statistic,2))
ar1.star <- cbind(round(gmm.ar1.1$p.value,4), round(gmm.ar1.2$p.value,4),round(gmm.ar1.3$p.value,4))


ar1 <- as.vector(c("Arellano-Bond:AR(1)",r,ar1))
ar1.star <- as.vector(c("Prob (AR(1))",r,ar1.star))

ar2 <- cbind(round(gmm.ar2.1$statistic,2), round(gmm.ar2.2$statistic,2),round(gmm.ar2.3$statistic,2))
ar2.star <- cbind(round(gmm.ar2.1$p.value,4), round(gmm.ar2.2$p.value,4),round(gmm.ar2.3$p.value,4))

ar2 <- as.vector(c("Arellano-Bond:AR(2)",r,ar2))
ar2.star <- as.vector(c("Prob (AR(2))",r,ar2.star))



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

#Households
#reHC.1 <-  RE_summary$npl_hh
#sysgmm.1 <-  sysgmm4_plm$npl_hh

#Non-Financial Institutions
#feHC.2 <-  FE_summary$npl_nfi
#diffgmm.2 <- diffgmm2_plm$npl_nfi

#Financial Institutions
#reHC.3 <-  RE_summary$npl_fi
#diffgmm.3 <- diffgmm2_plm$npl_fi


coeftest1 <- function(x) {
   coeftest(x,vcovHC(x,method= "white1", type="sss", cluster="group"))
 # coeftest(x,vcovHC(x,method= "arellano", type="sss", cluster="group"))
 # coeftest(x,vcovHC(x, cluster="group"))
}

reHC.1b <- coeftest1(re.1)
feHC.1b <- coeftest1(fe.1)
#diff.1b  <- coeftest1(diff.1 [[1]])
reHC.2b <- coeftest1(re.2)
feHC.2b <- coeftest1(fe.2)

reHC.3b <- coeftest1(re.3)
feHC.3b <- coeftest1(fe.3)

se1 = list(reHC.1b[,"Std. Error"],feHC.1b[,"Std. Error"],reHC.2b[,"Std. Error"], feHC.2b[,"Std. Error"],reHC.3b[,"Std. Error"],feHC.3b[,"Std. Error"]) 
  
options(scipen=0, digits=3)
haus_test.hh <- phtest(FE_bk_75e_plm[[1]], RE_bk_75e_plm[[1]])
haus_test.fi <-phtest(FE_bk_75e_plm[[2]], RE_bk_75e_plm[[2]])
haus_test.nfi <-phtest(FE_bk_75e_plm[[3]], RE_bk_75e_plm[[3]])

# ht1 <- cbind(haus_test.hh$method,round(haus_test.hh$statistic,3),haus_test.hh$p.value,haus_test.hh$alternative)
# ht2 <- cbind(haus_test.fi$method,round(haus_test.fi$statistic,3),haus_test.fi$p.value,haus_test.fi$alternative)
# ht3 <- cbind(haus_test.nfi$method,round(haus_test.nfi$statistic,3),haus_test.nfi$p.value,haus_test.nfi$alternative)


ht <- cbind(round(haus_test.hh$statistic,2),"", round(haus_test.nfi$statistic,2),"",round(haus_test.fi$statistic,2),"")
ht.star <- cbind(round(haus_test.hh$p.value,4),"", round(haus_test.nfi$p.value,4),"",round(haus_test.fi$p.value,4),"")

ht <- as.vector(c("Hausman Test",ht,"","",""))
ht.star <- as.vector(c("Prob (Hausman Test)",ht.star,"","",""))


# 
# #Households
# re.1 <-  RE_plm$npl_hh
# sysgmm.1 <-  sysgmm4_plm$npl_hh
# 
# #Non-Financial Institutions
# fe.2 <-  FE_plm$npl_nfi
# diffgmm.2 <- diffgmm2_plm$npl_nfi
# 
# #Financial Institutions
# re.3 <-  RE_plm$npl_fi
# diffgmm.3 <- diffgmm2_plm$npl_fi


  stargazer(re.1,  fe.1,re.2 ,fe.2 , re.3,fe.3,sysgmm.1, diffgmm.2,diffgmm.3,title="Panel Data Models  (2014-2019)",
             align=TRUE,type = "latex",
             se = se1,
            column.labels=c("Households","Non-Financial","Financial","Households","Non-Financial","Financial"),
             column.separate = c(2,2,2,1,1,1),
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
            add.lines = list(ht,ht.star,st,st.star,ar1,ar1.star,ar2,ar2.star),
            #add.lines = list(st1,ar1,ar2),
             out="Research_Proposal/Progress/Tables/Final/Panel/Static_Models_SELEC_bk_75e.tex")
  
  capture.output( stargazer(re.1,  fe.1,re.2 ,fe.2 , re.3,fe.3,sysgmm.1, diffgmm.2,diffgmm.3, title="Panel Data Models (2014-2019)",
                            align=TRUE,
                            se = se1,
                            column.labels=c("Households","Non-Financial","Financial","Households","Non-Financial","Financial"),
                            column.separate = c(2,2,2,1,1,1),
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
                        add.lines = list(ht,ht.star,st,st.star,ar1,ar1.star,ar2,ar2.star),
                        #add.lines = list(st1,ar1,ar2),
                           out="Research_Proposal/Progress/Tables/Final/Panel/Static_Models_SELEC_bk_75e.html"))
  
 
  
  


#library(lmtest)
#coeftest(OLS_plm[[1]], function(x) vcovHC(x,method= "arellano", type="HC3", cluster="group"))
