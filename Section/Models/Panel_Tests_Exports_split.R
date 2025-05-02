#Breusch-Pagan test: test on individual effect
#options(scipen = 999)
options(scipen=0, digits=7)

ols.1<- OLS_plm
fe.1<- FE_plm
re.1<- RE_plm
#rnames1 <- c("Househoulds & Non-Financial Corp.")
#rnames2 <- c("Financial Corp.")

#rnames <- c("Househoulds & Non-Financial Corp.","Financial Corp.")

cnames <- c("Method","Statistic","P-Value","Alternative")
rnames <- c(" ")

BP.test <- map(ols.1,function (x) plmtest (x))
#View(BP.test[[1]])

BP.test.hh <- BP.test[[1]]
BP.test.fi <-BP.test[[2]]
BP.test.nfi <-BP.test[[3]]




bp1 <- cbind(BP.test.hh$method,round(BP.test.hh$statistic,3),BP.test.hh$p.value,BP.test.hh$alternative)
bp2 <- cbind(BP.test.fi$method,round(BP.test.fi$statistic,3),BP.test.fi$p.value,BP.test.fi$alternative)
bp3 <- cbind(BP.test.nfi$method,round(BP.test.nfi$statistic,3),BP.test.nfi$p.value,BP.test.nfi$alternative)



#F and LMtests-ols vs fe:Tests on Individual Effects

F.test.hh<- pFtest(fe.1[[1]], ols.1[[1]])

F.test.fi <- pFtest(fe.1[[2]], ols.1[[2]])

F.test.nfi <- pFtest(fe.1[[3]], ols.1[[3]])


f1 <- cbind(F.test.hh$method,round(F.test.hh$statistic,3),F.test.hh$p.value,F.test.hh$alternative)
f2 <- cbind(F.test.fi$method,round(F.test.fi$statistic,3),F.test.fi$p.value,F.test.fi$alternative)
f3 <- cbind(F.test.nfi$method,round(F.test.nfi$statistic,3),F.test.nfi$p.value,F.test.nfi$alternative)


#Tests for Correlated Effects- Hausman Test

haus_test.hh <- phtest(fe.1[[1]], re.1[[1]])
haus_test.fi <-phtest(fe.1[[2]], re.1[[2]])
haus_test.nfi <-phtest(fe.1[[3]], re.1[[3]])

#(haus_test.hh.nfi <- phtest( def_model_ALL2t ,data= npl_hh.nfi,method = "aux", vcov = vcovHC))
#(haus_test.fi <-phtest( def_model_ALL2t ,data= npl_fi,method = "aux", vcov = vcovHC))


# 
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

# 
# (haus_test2.hh.nfi <- phtest(def_model_ALL2t ,data= npl_hh,method = "aux"))
# (haus_test2.fi <-phtest( def_model_ALL2t ,data= npl_fi,method = "aux"))
# (haus_test2.nfi <-phtest( def_model_ALL2t ,data= npl_nfi,method = "aux"))
# 
# (haus_test2a.hh<- phtest( def_model_ALL2t ,data= npl_hh,method = "aux", vcov = vcovHC))
# (haus_test2a.fi <-phtest( def_model_ALL2t ,data= npl_fi,method = "aux", vcov = vcovHC))
# (haus_test2a.nfi <-phtest( def_model_ALL2t ,data= npl_nfi,method = "aux", vcov = vcovHC))

# haus_test.hh.nfi
# haus_test.hh.nfi$statistic
# haus_test.hh.nfi$parameter
# haus_test.hh.nfi$p.value
# haus_test.hh.nfi$method
# haus_test.hh.nfi$alternative



ht1 <- cbind(haus_test.hh$method,round(haus_test.hh$statistic,3),haus_test.hh$p.value,haus_test.hh$alternative)
ht2 <- cbind(haus_test.fi$method,round(haus_test.fi$statistic,3),haus_test.fi$p.value,haus_test.fi$alternative)
ht3 <- cbind(haus_test.nfi$method,round(haus_test.nfi$statistic,3),haus_test.nfi$p.value,haus_test.nfi$alternative)


##Tests for Serial Correlation

(woold.hh<- pwtest(def_model_ALL,npl_hh))
(woold.fi <- pwtest(def_model_ALL,npl_fi))
(woold.nfi <- pwtest(def_model_ALL,npl_nfi))

wt1 <- cbind(woold.hh$method,round(woold.hh$statistic,3),woold.hh$p.value,woold.hh$alternative)
wt2 <- cbind(woold.fi$method,round(woold.fi$statistic,3),woold.fi$p.value,woold.fi$alternative)
wt3 <- cbind(woold.nfi$method,round(woold.nfi$statistic,3),woold.nfi$p.value,woold.nfi$alternative)


(woold2.hh <- pwartest(def_model_ALL,npl_hh))
(woold2.fi <- pwartest(def_model_ALL,npl_fi))
(woold2.nfi <- pwartest(def_model_ALL,npl_nfi))

wt2.1 <- cbind(woold2.hh$method,round(woold2.hh$statistic,3),woold2.hh$p.value,woold2.hh$alternative)
wt2.2 <- cbind(woold2.fi$method,round(woold2.fi$statistic,3),woold2.fi$p.value,woold2.fi$alternative)
wt2.3 <- cbind(woold2.nfi$method,round(woold2.nfi$statistic,3),woold2.nfi$p.value,woold2.nfi$alternative)


bpfhtwt2.hh <- rbind(bp1,f1,ht1,wt1,wt2.1)
bpfhtwt2.hh<- data.frame(bpfhtwt2.hh)

colnames(bpfhtwt2.hh) <- cnames
rownames(bpfhtwt2.hh) <- c("")
View(bpfhtwt2.hh)

x <- xtable(bpfhtwt2.hh, caption =" Test for Individual & Correlated Effects: Households")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.hh_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.hh_test.tex", sep = "")
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

bpfhtwt2.nfi <- rbind(bp3,f3,ht3,wt3,wt2.3)
bpfhtwt2.nfi<- data.frame(bpfhtwt2.nfi)

colnames(bpfhtwt2.nfi) <- cnames
rownames(bpfhtwt2.nfi) <- c("")
View(bpfhtwt2.nfi)

x <- xtable(bpfhtwt2.nfi, caption =" Test for Individual & Correlated Effects: Non-Financial Corporations")

align(x) <- xalign(x)
digits(x) <- xdigits(x)
display(x) <- xdisplay(x)

print.xtable( x, caption.placement = 'top' , booktabs = T,size = "small", include.rownames= FALSE,include.colnames = TRUE, type="HTML",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.nfi_test.html", sep = "")
print.xtable( x,  caption.placement = 'top',booktabs = T,size = "small",  include.rownames= FALSE,include.colnames = TRUE,type="latex",file= "Research_Proposal/Progress/Tables/Final/Tests/BPFHTWT2.nfi_test.tex", sep = "")
# #print.xtable( xtable(myNewTable), floating= TRUE,include.rownames= TRUE,type="latex",tabular.environment="longtable",file= "Research_Proposal/Progress/Tables/slopeTest_.tex", sep = "")
#,align= "r|llrc",



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