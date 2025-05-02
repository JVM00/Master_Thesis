#Breusch-Pagan test: test on individual effect
#options(scipen = 999)
options(scipen=0, digits=7)

BP.test <- map(OLS_plm,function (x) plmtest (x))
#View(BP.test[[1]])

BP.test.hh.nfi <- BP.test[[1]]
BP.test.fi <-BP.test[[2]]


BP.test.hh.nfi
BP.test.hh.nfi$statistic
BP.test.hh.nfi$p.value
BP.test.hh.nfi$method
BP.test.hh.nfi$alternative

cnames <- c("Method","Statistic","P-Value","Alternative")
#rnames1 <- c("Househoulds & Non-Financial Corp.")
#rnames2 <- c("Financial Corp.")
rnames <- c("Househoulds & Non-Financial Corp.","Financial Corp.")
bp1 <- cbind(BP.test.hh.nfi$method,round(BP.test.hh.nfi$statistic,3),BP.test.hh.nfi$p.value,BP.test.hh.nfi$alternative)
bp2 <- cbind(BP.test.fi$method,round(BP.test.fi$statistic,3),BP.test.fi$p.value,BP.test.fi$alternative)

#bp1 <- data.frame(bp1)
#bp2 <- data.frame(bp2)
#colnames(bp1) <- cnames
#rownames(bp1) <- rnames1
#rownames(bp2) <- rnames2

#View(bp1)
#View(bp2)

bp <- rbind(bp1,bp2)
bp <- data.frame(bp)
colnames(bp) <- cnames
rownames(bp) <- rnames
#View(bp)
x <- xtable(bp, caption = "Breusch-Pagan Lagrange Multiplier Test: Test on Individual Effects")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= TRUE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/bp_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= TRUE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/bp_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",


#F and LMtests-ols vs fe:Tests on Individual Effects

F.test.hh.nfi <- pFtest(FE_plm$npl_hh.nfi, OLS_plm$npl_hh.nfi)

F.test.fi <- pFtest(FE_plm$npl_fi, OLS_plm$npl_fi)


F.test.hh.nfi
F.test.hh.nfi$statistic
F.test.hh.nfi$p.value
F.test.hh.nfi$method
F.test.hh.nfi$alternative

f1 <- cbind(F.test.hh.nfi$method,round(F.test.hh.nfi$statistic,3),F.test.hh.nfi$p.value,F.test.hh.nfi$alternative)
f2 <- cbind(F.test.fi$method,round(F.test.fi$statistic,3),F.test.fi$p.value,F.test.fi$alternative)

f <- rbind(f1,f2)
f<- data.frame(f)
colnames(f) <- cnames
rownames(f) <- rnames
#View(f)
x <- xtable(f, caption = "Breusch-Pagan Lagrange Multiplier Test: Test on Individual Effects")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= TRUE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/F_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= TRUE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/F_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",

bpf.hh.nfi <- rbind(bp1,f1)
bpf.hh.nfi<- data.frame(bpf.hh.nfi)
colnames(bpf.hh.nfi) <- cnames
rownames(bpf.hh.nfi) <- c("")
#View(bpf.hh.nfi)
x <- xtable(bpf.hh.nfi, caption = "Breusch-Pagan Lagrange Multiplier  & F Test: Households & Non-Financial Corp.")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPF.hh.nfi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPF.hh.nfi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",

bpf.fi <- rbind(bp2,f2)
bpf.fi<- data.frame(bpf.fi)
colnames(bpf.fi) <- cnames
rownames(bpf.fi) <- c("")
#View(bpf.fi)
x <- xtable(bpf.fi, caption = "Breusch-Pagan Lagrange Multiplier  & F Test: Financial Corporations")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPF.fi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPF.fi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",


#Tests for Correlated Effects- Hausman Test

(haus_test.hh.nfi <- phtest(FE_plm$npl_hh.nfi, RE_plm$npl_hh.nfi))
(haus_test.fi <-phtest(FE_plm$npl_fi, RE_plm$npl_fi))


#(haus_test.hh.nfi <- phtest( def_model_ALL2t ,data= npl_hh.nfi,method = "aux", vcov = vcovHC))
#(haus_test.fi <-phtest( def_model_ALL2t ,data= npl_fi,method = "aux", vcov = vcovHC))



# def_model_ALL2t <-  NPL_ratio ~ 
#   
#   CET1_ratio_tr +
#   # T1_ratio+
#   #TCAP_ratio+
#   LEVER_tr_ratio +
#   
#   RORAC +
#   #RORWA+
#   
#   #log(npl_0) +
#   BankSize_tran +
#   
#   Cost_to_Income +
#   
#   NIM_tr +
#   #NFCI +
#   # NII +
#   
#   # TimTOres_insol +
#   Stgth_legal_index +
#   Reco_rate_dol +
#   # Reco_rate_dol_Score +
#   
#   infl_perc +
#   #infl_avrg_imf+
#   
#   curr_acc_bal +
#   
#   GDP_growth_perc +
#   # GDP_per_cap_growth_perc+
#   # log(GDP_per_cap_ppp) +
#   unempl_rate_imf +
#   
#   gross_public_debt +
#   #net_public_debt+
#   # Fiscal_Deficit +
#   
#   # Public_Revenue+
#   # Public_expenditure+
#   
#   SSM+
#   CBDI_index



def_model_ALL2t <-  NPL_ratio ~ 
  
  CET1_ratio_tr +
  # T1_ratio+
  #TCAP_ratio+
  LEVER_tr_ratio +
  
  RORAC +
  #RORWA+
  
  #log(npl_0) +
  BankSize_tran +
  
  Cost_to_Income +
  
  NIM_tr +
  #NFCI +
  # NII +
  
 
  #net_public_debt+
  # Fiscal_Deficit +
  
  # Public_Revenue+
  # Public_expenditure+
  
  SSM+
  CBDI_index

(haus_test2.hh.nfi <- phtest(def_model_ALL2t ,data= npl_hh.nfi,method = "aux"))
(haus_test2.fi <-phtest( def_model_ALL2t ,data= npl_fi,method = "aux"))

(haus_test2a.hh.nfi <- phtest( def_model_ALL2t ,data= npl_hh.nfi,method = "aux", vcov = vcovHC))
(haus_test2a.fi <-phtest( def_model_ALL2t ,data= npl_fi,method = "aux", vcov = vcovHC))


# haus_test.hh.nfi
# haus_test.hh.nfi$statistic
# haus_test.hh.nfi$parameter
# haus_test.hh.nfi$p.value
# haus_test.hh.nfi$method
# haus_test.hh.nfi$alternative



ht1 <- cbind(haus_test.hh.nfi$method,round(haus_test.hh.nfi$statistic,3),haus_test.hh.nfi$p.value,haus_test.hh.nfi$alternative)
ht2 <- cbind(haus_test.fi$method,round(haus_test.fi$statistic,3),haus_test.fi$p.value,haus_test.fi$alternative)

cnames <- c("Method","Statistic","P-Value","Alternative")
#rnames1 <- c("Househoulds & Non-Financial Corp.")
#rnames2 <- c("Financial Corp.")
rnames <- c(" ")

bpfht.hh.nfi <- rbind(bp1,f1,ht1)
bpfht.hh.nfi<- data.frame(bpfht.hh.nfi)

colnames(bpfht.hh.nfi) <- cnames
rownames(bpfht.hh.nfi) <- c("")
#View(bpfht.hh.nfi)

x <- xtable(bpfht.hh.nfi, caption ="Breusch-Pagan Lagrange Multiplier, F-Test & Hausman Test : Households & Non-Financial Corp.")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHT.hh.nfi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHT.hh.nfi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",


bpfht.fi <- rbind(bp2,f2,ht2)
bpfht.fi<- data.frame(bpfht.fi)

colnames(bpfht.fi) <- cnames
rownames(bpfht.fi) <- c("")
#View(bpfht.fi)

x <- xtable(bpfht.fi, caption = "Breusch-Pagan Lagrange Multiplier, F-Test & Hausman Test : Financial Corporations")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHT.fi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHT.fi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",


##Tests for Serial Correlation

(woold.hh.nfi <- pwtest(def_model_ALL,npl_hh.nfi))
(woold.fi <- pwtest(def_model_ALL,npl_fi))


wt1 <- cbind(woold.hh.nfi$method,round(woold.hh.nfi$statistic,3),woold.hh.nfi$p.value,woold.hh.nfi$alternative)
wt2 <- cbind(woold.fi$method,round(woold.fi$statistic,3),woold.fi$p.value,woold.fi$alternative)


bpfhtwt.hh.nfi <- rbind(bp1,f1,ht1,wt1)
bpfhtwt.hh.nfi<- data.frame(bpfhtwt.hh.nfi)

colnames(bpfhtwt.hh.nfi) <- cnames
rownames(bpfhtwt.hh.nfi) <- c("")
#View(bpfhtwt.hh.nfi)

x <- xtable(bpfhtwt.hh.nfi, caption ="Breusch-Pagan Lagrange Multiplier, F-Test, Hausman & Wooldridge's Test: Households & Non-Financial Corp.")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT.hh.nfi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT.hh.nfi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",

bpfhtwt.fi <- rbind(bp1,f1,ht1,wt1)
bpfhtwt.fi <- data.frame(bpfhtwt.fi )

colnames(bpfhtwt.fi ) <- cnames
rownames(bpfhtwt.fi ) <- c("")
#View(bpfhtwt.fi )

x <- xtable(bpfhtwt.fi , caption ="Breusch-Pagan Lagrange Multiplier, F-Test, Hausman & Wooldridge's Test: Financial Corporations")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT.fi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT.fi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",


cnames <- c("Method","Statistic","P-Value","Alternative")
#rnames1 <- c("Househoulds & Non-Financial Corp.")
#rnames2 <- c("Financial Corp.")
rnames <- c(" ")

(woold2.hh.nfi <- pwartest(def_model_ALL,npl_hh.nfi))
(woold2.fi <- pwartest(def_model_ALL,npl_fi))


wt2.1 <- cbind(woold2.hh.nfi$method,round(woold2.hh.nfi$statistic,3),woold2.hh.nfi$p.value,woold2.hh.nfi$alternative)
wt2.2 <- cbind(woold2.fi$method,round(woold2.fi$statistic,3),woold2.fi$p.value,woold2.fi$alternative)


bpfhtwt2.hh.nfi <- rbind(bp1,f1,ht1,wt1,wt2.1)
bpfhtwt2.hh.nfi<- data.frame(bpfhtwt2.hh.nfi)

colnames(bpfhtwt2.hh.nfi) <- cnames
rownames(bpfhtwt2.hh.nfi) <- c("")
View(bpfhtwt2.hh.nfi)

x <- xtable(bpfhtwt2.hh.nfi, caption =" Test for Individual & Correlated Effects: Households & Non-Financial Corp.")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.hh.nfi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.hh.nfi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",

bpfhtwt2.fi <- rbind(bp2,f2,ht2,wt2,wt2.2)
bpfhtwt2.fi<- data.frame(bpfhtwt2.fi)

colnames(bpfhtwt2.fi) <- cnames
rownames(bpfhtwt2.fi) <- c("")
View(bpfhtwt2.fi)

x <- xtable(bpfhtwt2.fi, caption =" Test for Individual & Correlated Effects: Financial Corporations")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.fi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.fi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",



#Breusch-Godfrey and DurbinWatson tests
options(scipen=0, digits=7)


starPrinter <- function(pVal) {
  as.numeric(pVal)
  if(pVal < 0.01) {return("***")}
  if(pVal < 0.05){ return("**")}
  if(pVal < 0.1) {return("*")}
  
  return("")
}

#Breusch-Godfrey/Wooldridge
sc1.ols <- pbgtest(OLS_plm$npl_hh.nfi, order = 2)
sc1.fe <-pbgtest(FE_plm$npl_hh.nfi, order = 2)
sc1.re <-pbgtest(RE_plm $npl_hh.nfi, order = 2)

sc1 <- cbind(sc1.ols$statistic,sc1.fe$statistic,sc1.re$statistic)
sc1.star <- cbind(sc1.ols$p.value,sc1.fe$p.value,sc1.re$p.value)

for(j in 1:length(sc1)) {
  sc1[j] <- paste0(sc1[j], starPrinter(sc1.star[j]))
  
}


sc1 <- cbind("Breusch-Godfrey/Wooldridge",sc1)
sc1
#starPrinter(sc1.star[3])

#Durbin-Watson test
sc2.ols <-pdwtest(OLS_plm$npl_hh.nfi, order = 2)
sc2.fe <-pdwtest(FE_plm$npl_hh.nfi, order = 2)
sc2.re <-pdwtest(RE_plm $npl_hh.nfi, order = 2)

sc2 <- cbind(sc2.ols$statistic,sc2.fe$statistic,sc2.re$statistic)
sc2.star <- cbind(sc2.ols$p.value,sc2.fe$p.value,sc2.re$p.value)

for(j in 1:length(sc2)) {
  sc2[j] <- paste0(sc2[j], starPrinter(sc2.star[j]))
  
}
sc2 <- cbind("Durbin-Watson",sc2)
sc2


sysgmm <- map(sysgmm4_plm,function (x) sargan(x,weights = "twosteps"))

map(diffgmm2_plm,function (x) sargan(x,weights = "twosteps"))

#sargan(object, weights = c("twosteps", "onestep"))
diffgmm <- lapply(diffgmm_plm,sargan)
sysgmm <- lapply(sysgmm_plm,sargan)
# diffgmm.1 <- diffgmm_plm[[1]]
# sysgmm.1 <-  sysgmm_plm[[1]]
# 
# diffgmm.sum1 <- diffgmm_summary[[1]]
# sysgmm.sum1 <-  sysgmm_summary[[1]]

options(scipen=0, digits=7)


starPrinter <- function(pVal) {
  as.numeric(pVal)
  if(pVal < 0.01) {return("***")}
  if(pVal < 0.05){ return("**")}
  if(pVal < 0.1) {return("*")}
  
  return("")
}
# 
# diffgmm[[1]]$statistic
# diffgmm[[1]]$p.value 

st1 <- cbind(diffgmm[[1]]$statistic, sysgmm[[1]]$statistic)
st1.star <- cbind(diffgmm[[1]]$p.value,sysgmm[[1]]$p.value)

for(j in 1:length(st1)) {
  st1[j] <- paste0(st1[j], starPrinter(st1.star[j]))
  
}


st1 <- cbind("Sargan Test","","","",st1)
st1


diffgmm.AR1 <-map(diffgmm_plm, function(x) mtest(x , order = 1))
sysgmm.AR1 <-map(sysgmm_plm, function(x) mtest(x , order = 1))

ar1 <- cbind(diffgmm.AR1[[1]]$statistic, sysgmm.AR1 [[1]]$statistic)
ar1.star <- cbind(diffgmm.AR1[[1]]$p.value,sysgmm.AR1 [[1]]$p.value)

for(j in 1:length(ar1)) {
  ar1[j] <- paste0(ar1[j], starPrinter(ar1.star[j]))
  
}


ar1 <- cbind("Arellano-Bond:AR(1)","","","",ar1)
ar1



diffgmm.AR2 <- map(diffgmm_plm, function(x) mtest(x , order = 2))
sysgmm.AR2 <-map(sysgmm_plm, function(x) mtest(x , order = 2))

ar2 <- cbind(diffgmm.AR2[[1]]$statistic, sysgmm.AR2 [[1]]$statistic)
ar2.star <- cbind(diffgmm.AR2[[1]]$p.value,sysgmm.AR2 [[1]]$p.value)

for(j in 1:length(ar2)) {
  ar2[j] <- paste0(ar2[j], starPrinter(ar2.star[j]))
  
}


ar2 <- cbind("Arellano-Bond:AR(2)","","","",ar2)
ar2


# 
# #options(scipen = 999)
# lapply(diffgmm_plm,sargan)
# lapply(sysgmm_plm,sargan)
# 
# lapply(diffgmm_plm,sargan)
# lapply(diffgmm2_plm,sargan)
# lapply(diffgmm3_plm,sargan)
# lapply(diffgmm4_plm,sargan)
# 
# sysgmm2_plm 
# lapply(sysgmm_plm ,sargan)
# lapply(sysgmm2_plm ,sargan)
# lapply(sysgmm3_plm ,sargan)
# 
# lapply(sysgmm_plm ,sargan)
map(diffgmm_plm, function(x) mtest(x , order = 2))

map(diffgmm_plm, function(x) mtest(x , order = 1))



#RESIDUALS GRAPHICS


# (r <- data.frame(ols1$model$NPL_ratio))
# View(r)
# (t <- data.frame(ols1$residuals))
# View(t)
# t1 <- data.frame(resid(OLS_plm$npl_hh.nfi))
# f1 <- data.frame(fitted(OLS_plm$npl_hh.nfi))
# #fitted <- data.frame(as.numeric(OLS_plm$npl_hh.nfi$model$NPL_ratio - OLS_plm$npl_hh.nfi$residuals) )
# h1 <- data.frame(OLS_plm$npl_hh.nfi$model$NPL_ratio)
# ols_resi <- data.frame(cbind(OLS_plm$npl_hh.nfi$model$NPL_ratio,fitted(OLS_plm$npl_hh.nfi),resid(OLS_plm$npl_hh.nfi)))
# colnames(ols_resi) <- c("NPL_ratio","Fitted","Residuals")
ols1 <- OLS_plm[[1]]
ols2 <- OLS_plm[[2]]

ols_resi.hh.nfi <- data.frame(cbind(OLS_plm[[1]]$model$NPL_ratio,fitted(OLS_plm[[1]]),resid(OLS_plm[[1]])))
colnames(ols_resi.hh.nfi ) <- c("NPL_ratio","Fitted","Residuals")
ols_resi.fi <- data.frame(cbind(OLS_plm[[2]]$model$NPL_ratio,fitted(OLS_plm[[2]]),resid(OLS_plm[[2]])))
colnames(ols_resi.fi ) <- c("NPL_ratio","Fitted","Residuals")

ggplot(data = ols_resi.hh.nfi) + 
  geom_point(mapping = aes(x = NPL_ratio, y = Residuals)) +
  geom_hline(yintercept=0,col="red") 

ggplot(data = ols_resi.fi) + 
  geom_point(mapping = aes(x = NPL_ratio, y = Residuals)) +
  geom_hline(yintercept=0,col="red")


  ggplot(data = ols_resi.hh.nfi) + 
  geom_point(mapping = aes(x = NPL_ratio, y = Fitted)) +
  #geom_smooth(aes(x = NPL_ratio, y = Fitted),method = "lm", se = FALSE,col="red")
  geom_abline(intercept = 0, slope = 1,col="red")
  
  ggplot(data = ols_resi.fi) + 
    geom_point(mapping = aes(x = NPL_ratio, y = Fitted)) +
    #geom_smooth(aes(x = NPL_ratio, y = Fitted),method = "lm", se = FALSE,col="red")
    geom_abline(intercept = 0, slope = 1,col="red")
  
  fe1 <- FE_plm[[1]]
  fe2 <- FE_plm[[2]]
  
  fe_resi.hh.nfi <- data.frame(cbind(FE_plm[[1]]$model$NPL_ratio,fitted(FE_plm[[1]]),resid(FE_plm[[1]])))
  colnames(fe_resi.hh.nfi ) <- c("NPL_ratio","Fitted","Residuals")
  fe_resi.fi <- data.frame(cbind(FE_plm[[2]]$model$NPL_ratio,fitted(FE_plm[[2]]),resid(FE_plm[[2]])))
  colnames(fe_resi.fi ) <- c("NPL_ratio","Fitted","Residuals")
  
  ggplot(data = fe_resi.hh.nfi) + 
    geom_point(mapping = aes(x = NPL_ratio, y = Residuals)) +
    geom_hline(yintercept=0,col="red") 
  
  ggplot(data = fe_resi.hh.nfi) + 
    geom_point(mapping = aes(x = NPL_ratio, y = Fitted)) +
    geom_smooth(aes(x = NPL_ratio, y = Fitted),method = "lm", se = FALSE,col="red")
    #geom_abline(intercept = 0, slope = 1,col="red")
  
  
  ggplot(data = fe_resi.fi) + 
    geom_point(mapping = aes(x = NPL_ratio, y = Residuals)) +
    geom_hline(yintercept=0,col="red")
  
 
  ggplot(data = fe_resi.fi) + 
    geom_point(mapping = aes(x = NPL_ratio, y = Fitted)) +
    #geom_smooth(aes(x = NPL_ratio, y = Fitted),method = "lm", se = FALSE,col="red")
    geom_abline(intercept = 0, slope = 1,col="red")
  
  re1 <- RE_plm[[1]]
  re2 <-  RE_plm[[2]]
  
  re_resi.hh.nfi <- data.frame(cbind( RE_plm[[1]]$model$NPL_ratio,fitted( RE_plm[[1]]),resid( RE_plm[[1]])))
  colnames(re_resi.hh.nfi ) <- c("NPL_ratio","Fitted","Residuals")
  re_resi.fi <- data.frame(cbind( RE_plm[[2]]$model$NPL_ratio,fitted( RE_plm[[2]]),resid( RE_plm[[2]])))
  colnames(re_resi.fi ) <- c("NPL_ratio","Fitted","Residuals")
  
  ggplot(data = re_resi.hh.nfi) + 
    geom_point(mapping = aes(x = NPL_ratio, y = Residuals)) +
    geom_hline(yintercept=0,col="red") 
  
  ggplot(data = re_resi.fi) + 
    geom_point(mapping = aes(x = NPL_ratio, y = Residuals)) +
    geom_hline(yintercept=0,col="red")
  
  ggplot(data = re_resi.hh.nfi) +
    geom_point(mapping = aes(x = NPL_ratio, y = Fitted)) +
    #geom_smooth(aes(x = NPL_ratio, y = Fitted),method = "lm", se = FALSE,col="red")
    geom_abline(intercept = 0, slope = 1,col="red")

  ggplot(data = re_resi.fi) +
    geom_point(mapping = aes(x = NPL_ratio, y = Fitted)) +
    #geom_smooth(aes(x = NPL_ratio, y = Fitted),method = "lm", se = FALSE,col="red")
    geom_abline(intercept = 0, slope = 1,col="red")