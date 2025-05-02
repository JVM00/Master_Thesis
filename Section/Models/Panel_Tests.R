#----------------------------TESTS----------------------------------------------------
#F and LMtests-ols vs fe:Tests on Individual Effects
#F and LMtests-ols vs fe:Tests on Individual and Time Effects
#F and LMtests-ols vs fe: Tests on Time Effects with Individual Effects

#Breusch-Pagan test: test on individual effect
#Breusch-Pagan test: test on time effects
#Breusch-Pagan test: test on individual effects and time effects

#Tests for Correlated Effects- Hausman Test

#Tests for Serial Correlation: unobserved effects test
#Tests for Serial Correlation: optimal conditional test of Baltagi and Li
#Tests for Serial Correlation: Breusch-Godfrey
#Tests for Serial Correlation: DurbinWatson tests
#Tests for Serial Correlation: Wald Tests for Serial Correlation using within and First-differenced Estimators
#Tests for Serial Correlation: Wooldridge's first difference test/ in first-differenced errors
#Tests for Serial Correlation: Wooldridge's first difference test/ in original errors

#Sargan_test


#Arellano and Bond-The error serial correlation test

#Test for Multicollinearity-VIF
#Test for Multicollinearity-Correlation Matrix


#AIC
#ANOVA

#Jarque-Bera test Test of normality-> The null of normality
#--------------------------------------------------------------------------------------

#Test for Multicollinearity-VIF

library(stargazer)

npl_model_vif <- function(df) {
  plm(def_model_ALL, data = df, model = "pooling")
}

(vif_coeff <- map( map(sets,npl_model_vif),vif))


for (i in names(vif_coeff)){
  z <- vif_coeff
  a <- i
  b <- names(z)
  c <- match(a,b)
  d <-  b[c]
  e <- names(z[c])
  f <- data.frame(z[c])
  g <- names(f)
  h <- gsub(paste(d,".",sep=""), "", g)
  names(f)<- h
  j <- c("Households","Financial Institutions","Non-Financial Institutions")
  #j <- c("Households & Non-Financial Corporations","Financial Institutions")
  k <- j[c]
  
 # l <- c("VIF","1/VIF","R_2")
  l <- c("VIF","1/VIF")
  names(f) <- c("O")
  # m <-  f %>% mutate( vif=O,vif_inv = 1/O, r_2= 1-vif_inv) %>%
  #   dplyr::select(vif,vif_inv,r_2)
  m <-  f %>% mutate( vif=O,vif_inv = 1/O, r_2= 1-vif_inv) %>%
    dplyr::select(vif,vif_inv) 
  row.names(m) <- row.names(f)
  names(m) <- l 
  

  stargazer(m,
            digits=3, align=T,summary=FALSE, title= paste("Variance Inflaction Vector (2014-2019):",k,sep=" "),out=paste("Research_Proposal/Progress/Tables/Final/vif/vif_",d,".html", sep = ""))
  
  capture.output(stargazer(m,
                           digits=3, align=T,summary=FALSE, type= "latex", title= paste("Variance Inflaction Vector (2014-2019):",k,sep=" "),out=paste("Research_Proposal/Progress/Tables/Final/vif/vif_",d,".tex", sep = "")))
  
  rm("a", "b", "c","d","e","f","g","h","i","j","k","l","z")
  

}
rm("npl_model_vif","vif_coeff")



#Jarque-Bera test Test of normality-> The null of normality
library(tseries)
map(sets$NPL_ratio,jarque.bera.test)


jarque.bera.test(npl_hh$NPL_ratio)
jarque.bera.test(npl_fi$NPL_ratio)
jarque.bera.test(npl_nfi$NPL_ratio)
jarque.bera.test(npl_hh.nfi$NPL_ratio)

x <- rnorm(100)  # null 
jarque.bera.test(x)


#Breusch-Pagan test: test on individual effect
options(scipen = 999)
#options(scipen=0, digits=7)

BP.test <- map(OLS_plm,function (x) plmtest (x))
View(BP.test[[1]])

BP.test.hh.nfi <- BP.test[[1]]
BP.test.fi <-BP.test[[2]]

#Breusch-Pagan test: test on time effects
#Lagrange Multiplier Test - time effects (Honda) for unbalanced panels
BP.test.1 <- map(OLS_plm,function (x) plmtest (x,effect = "time"))

#Breusch-Pagan test: test on individual effects and time effects
BP.test.2 <- map(OLS_plm,function (x) plmtest (x,effect = "twoways"))


#F and LMtests-ols vs fe:Tests on Individual Effects

F.test.hh.nfi <- pFtest(FE_plm$npl_hh.nfi, OLS_plm$npl_hh.nfi)

F.test.fi <- pFtest(FE_plm$npl_fi, OLS_plm$npl_fi)

#pFtest(FE_plm$npl_hh, OLS_plm$npl_hh)
#pFtest(FE_plm$npl_nfi, OLS_plm$npl_nfi)

#F and LMtests-ols vs fe:Tests on Individual and Time Effects

#options(scipen = 999)
options(scipen=0, digits=7)
npl_model_fe.test <- function(df) {
  plm(def_model_ALL, data = df, effect = "twoways")
}

(fe.test_plm <- map(sets,npl_model_fe.test))
(fe.test_summary <- map(fe.test_plm,summary))
(fe.test_coef <- map(fe.test_summary ,coef))

pFtest(fe.test_plm$npl_hh.nfi, OLS_plm$npl_hh.nfi)

#F and LMtests-ols vs fe: Tests on Time Effects with Individual Effects
pFtest(fe.test_plm$npl_hh.nfi, FE_plm$npl_hh.nfi)



#Tests for Correlated Effects- Hausman Test
#The Hausman test is performed with the phtest function, which can either take as arguments
#two estimated models (here: the within and the gls) or use the formula - data interface:

#fe_plm$npl_hh
#re_plm$npl_hh

(haus_test.hh.nfi <- phtest(FE_plm$npl_hh.nfi, RE_plm$npl_hh.nfi))
(haus_test.fi <-phtest(FE_plm$npl_fi, RE_plm$npl_fi))

phtest(FE_plm$npl_hh, RE_plm$npl_hh)
phtest(FE_plm$npl_nfi, RE_plm$npl_nfi)
# (Chamb_test.hh.nfi <- piest(def_model_ALL,npl_hh.nfi,index=c("name", "Year")))
# (Chamb_test.fi <- piest(def_model_ALL,npl_fi,index=c("name", "Year")))


#The variant of the Chamberlain test proposed by Angrist and Newey
# aneweytest(def_model,npl_hh)
#aneweytest(def_model,npl_fi)
# aneweytest(def_model,npl_nfi)

##Tests for Serial Correlation

(woold.1 <- pwtest(def_model_ALL,npl_hh.nfi))
(woold.2 <- pwtest(def_model_ALL,npl_fi))


 