#https://cran.r-project.org/web/packages/clubSandwich/vignettes/panel-data-CRVE.html
#https://eeecon.uibk.ac.at/~discdown/flexregression/select.html
#http://thomas.deselaers.de/computing/texsqueezing.html
path_main <- 'C:/Users/varga/Desktop/Thesis/R_data/'

#source(file= paste(path_main,"Dataset_setup.r", sep = ""))
source(file= paste(path_main,"Dataset_setup.r", sep = ""))
#source(file= paste(path_main,"Dataset_setup_nout.r", sep = ""))
source(file= paste(path_main,"Panel_Def.r", sep = ""))
setwd(path_main)

rm(list=ls(pattern="^base_|^data$|npl_dataset"))
rm("sbv", "mal100","sbv1","durch1000","npl_hh1","npl_fi1","npl_nfi1")

#sets <- sets_nout





#----------------------------INDEX MODELS----------------------------------------
#Pooling-OLS
#Pooling-OLS with Robust covariance matrix estimators/clustered standard errors
#Pooling-OLS controlling Year 
#Pooling-OLS controlling Year with Robust covariance matrix estimators/clustered standard errors

#Pooling-OLS with Generalized Least Squares
#Pooling-OLS with Generalized Least Squares with Robust covariance matrix estimators/clustered standard errors
#Pooling-OLS with Generalized Least Squares controlling Year 
#Pooling-OLS with Generalized Least Squares controlling Year with Robust covariance matrix estimators/clustered standard errors

#LSDV Method controlling For INDIVIDUALS-Probably not relevant

#FD-OLS
#FD-OLS with Robust covariance matrix estimators/clustered standard errors

#FD-OLS with Generalized Least Squares
#FD-OLS with Generalized Least Squares with Robust covariance matrix estimators/clustered standard errors


#Fixed Effects
#Fixed Effects with Robust covariance matrix estimators/clustered standard errors
#Fixed Effects controlling Year 
#Fixed Effects controlling Year with Robust covariance matrix estimators/clustered standard errors

#Fixed Effects Time
#Fixed Effects Time  with Robust covariance matrix estimators/clustered standard errors


#One-way Random Effects
#One-way Random Effects with Robust covariance matrix estimators/clustered standard errors
#One-way Random Effects controlling Year 
#One-way Random Effects controlling Year with Robust covariance matrix estimators/clustered standard errors

#Difference gmm estimator: onestep & individual
#Difference gmm estimator: twostep & individual
#Difference gmm estimator: onestep & twoways
#Difference gmm estimator: twosteps & twoways

#System GMM Estimator: onestep & individual
#System GMM Estimator: twostep & individual
#System GMM Estimator: onestep & twoways
#System GMM Estimator: twosteps & twoways

#Pooled/Random Effects GGLS
#Fixed Effects GGLS
#FD Effects GGLS

##Pooled Effects Maxim Likelihood

#-------------------------------------------------------------------------------------


#--------------------------------POOLING---------------------------------------------
#Pooling-OLS
#def_model_ALL <- update(def_model_ALL,.~. + loan_change_perc)
#def_model_ALL <- update(def_model_ALL,.~. + factor(Year))
# +GDP_per_cap_ppp +TimTOres_insol
# def_model_ALL3 <- update(def_model_ALL,.~.- LEVER_tr_ratio - Stgth_legal_index +TimTOres_insol )
# 
# def_model_ALL2 <- update(def_model_ALL,.~.- LEVER_tr_ratio)
# def_model_ALL13 <- update(def_model_ALL,.~.+ npl_0- log(BankSize_tran))
# def_model_ALL14 <- update(def_model_ALL,.~.+TimTOres_insol - Stgth_legal_index)
 #def_model_ALL <- update(def_model_ALL,.~.+. - curr_acc_bal)
#def_model_ALL <- update(def_model_ALL,.~.+. - Reco_rate_dol)

# (def_model_ALL_Year <- update(def_model_ALL_Year,.~.-. + curr_acc_bal+factor(Year)))

OLS_model <- function(df) {
  plm(def_model_ALL, data = df, model = "pooling")
}

(OLS_plm <- map(sets,OLS_model))
(OLS_summary <- map(OLS_plm,summary))
(OLS_coef <- map(OLS_summary ,coef))



OLS_bk_model <- function(df) {
  plm(def_model_BANK, data = df, model = "pooling")
}

(OLS_bk_plm <- map(sets,OLS_bk_model))
(OLS_bk_summary <- map(OLS_bk_plm,summary))
(OLS_bk_coef <- map(OLS_bk_summary ,coef))

OLS_mk_model <- function(df) {
  plm(def_model_MACR, data = df, model = "pooling")
}

(OLS_mk_plm <- map(sets,OLS_mk_model))
(OLS_mk_summary <- map(OLS_mk_plm,summary))
(OLS_mk_coef <- map(OLS_mk_summary ,coef))

map(OLS_mk_plm ,function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group"),diagnostics=T))
#Pooling-OLS with Robust covariance matrix estimators/clustered standard errors


map(OLS_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group"),diagnostics=T))

#vcovHC(OLS_plm,method= "arellano", type="HC3", cluster="group")
##Pooling-OLS controlling Year 

OLS2_model <- function(df) {
  plm(def_model_ALL_Year, data = df, model = "pooling")
}

(OLS2_plm <- map(sets,OLS2_model))
(OLS2_summary <- map(OLS2_plm,summary))
(OLS2_coef <- map(OLS2_summary ,coef))

#Pooling-OLS controlling Year with Robust covariance matrix estimators/clustered standard errors

map(OLS2_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group")))

#Pooling-OLS with Generalized Least Squares

GLS_model <- function(df) {
  glm(def_model_ALL, data=df)
}


(GLS_plm <- map(sets,GLS_model))
(GLS_summary <- map(GLS_plm,summary))
(GLS_coef <- map(GLS_summary ,coef))



#Pooling-OLS with Generalized Least Squares with Robust covariance matrix estimators/clustered standard errors

map(GLS_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group")))

#Pooling-OLS with Generalized Least Squares controlling Year 

GLS2_model <- function(df) {
  glm(def_model_ALL_Year, data=df)
}


(GLS2_plm <- map(sets,GLS2_model))
(GLS2_summary <- map(GLS2_plm,summary))
(GLS2_coef <- map(GLS2_summary ,coef))

##Pooling-OLS with Generalized Least Squares controlling Year with Robust covariance matrix estimators/clustered standard errors

map(GLS2_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group")))


#--------------------------------FD---------------------------------------------

#FD-OLS
lm(npl_hh.nfi,NPL_ratio~ SSM)


def_model_ALL_diff <- update(def_model_ALL,.~.-SSM - 1)
FD_model <- function(df) {
  plm(def_model_ALL_diff , data=df,model = "fd")
}


(FD_plm <- map(sets,FD_model))
(FD_summary <- map(FD_plm,summary))
(FD_coef <- map(FD_summary ,coef))

#FD-OLS with Robust covariance matrix estimators/clustered standard errors

map(FD_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))

def_model_MACR_diff <- update(def_model_MACR,.~.-SSM - 1)

FD_mk_model <- function(df) {
  plm(def_model_MACR_diff , data=df,model = "fd")
}


(FD_mk_plm <- map(sets,FD_mk_model))
(FD_mk_summary <- map(FD_mk_plm,summary))
(FD_mk_coef <- map(FD_summary ,coef))


#FD-OLS with Generalized Least Squares

FD2_model <- function(df) {
  glm(def_model_ALL_diff, data=df)
}


(FD2_plm <- map(sets,FD2_model))
(FD2_summary <- map(FD2_plm,summary))
(FD2_coef <- map(FD2_summary ,coef))

#FD-OLS with Generalized Least Squares with Robust covariance matrix estimators/clustered standard errors

map(FD2_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group")))


#--------------------------------FIXED EFFECTS--------------------------------------------------

#Fixed Effects
#def_model_ALL1 <- update(def_model_ALL,.~.-curr_acc_bal)
#def_model_ALL13 <- update(def_model_ALL,.~.+ log(npl_0)- log(BankSize_tran))
#def_model_ALL13 <- update(def_model_ALL,.~.+ npl_0- log(BankSize_tran))
#def_model_ALL13 <- update(def_model_ALL,.~.+ diff(npl_0)- log(BankSize_tran))
#def_model_ALL13 <- update(def_model_ALL,.~.+ npl_0- log(BankSize_tran))
#def_model_ALL11 <- update(def_model_ALL,.~.-gross_public_debt)
#def_model_ALL2 <- update(def_model_ALL,.~.-CET1_ratio_tr)
#def_model_ALL3 <- update(def_model_ALL,.~.-CET1_ratio_tr + TCAP_ratio-unempl_rate_imf)



FE_model <- function(df) {
  #plm(def_model_ALL, data = df, model = "within")
  plm(def_model_ALL, data = df, model = "within")
}

(FE_plm <- map(sets,FE_model))
(FE_summary <- map(FE_plm,summary))
(FE_coef <- map(FE_summary ,coef))


#(FE_coef <- map(FE_summary ,function(x) coef(x ,)))

#def_model_BANK13 <- update(def_model_BANK,.~.+ log(npl_0)- log(BankSize_tran))

#def_model_BANK1 <- update(def_model_BANK,.~. +GDP_growth_perc )
FE_bk_model <- function(df) {
  plm(def_model_BANK, data = df, model = "within")
}


(FE_bk_plm <- map(sets,FE_bk_model))
(FE_bk_summary <- map(FE_bk_plm,summary))
(FE_bk_coef <- map(FE_bk_summary ,coef))

map(FE_bk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="HC3", cluster="group")))
#def_model_MACR13 <- update(def_model_BANK,.~.+ log(npl_0)- log(BankSize_tran))
#def_model_MACR13 <- update(def_model_MACR,.~. - unempl_rate_imf)

FE_mk_model <- function(df) {
  plm(def_model_MACR, data = df, model = "within",effect="time")
}

(FE_mk_plm <- map(sets,FE_mk_model))
(FE_mk_summary <- map(FE_mk_plm,summary))
(FE_mk_coef <- map(FE_mk_summary ,coef))

#(FE_coef <- map(FE_summary ,function(x) coef(x ,)))

#Fixed Effects with Robust covariance matrix estimators/clustered standard errors


# map(FE_plm, function(x) summary(x , vcov = vcovHC(x , cluster="group")))
# map(FE_plm, function(x) summary(x , vcov = vcovHC(x , type="HC0", cluster="group")))
#map(FE_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="HC3", cluster="group")))
 map(FE_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="HC3", cluster="group")))
 map(FE_mk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="HC3", cluster="group")))
 
 FE2_mk_model <- function(df) {
   plm(def_model_MACR_Year, data = df, model = "within",effect="time")
 }
 
 (FE2_mk_plm <- map(sets,FE2_mk_model))
 (FE2_mk_summary <- map(FE2_mk_plm,summary))
 (FE2_mk_coef <- map(FE2_mk_summary ,coef))
 
 
 map(FE2_mk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="HC3", cluster="group")))
 
 FE2_bk_model <- function(df) {
   plm(def_model_BANK_Year, data = df, model = "within",effect="time")
 }
 
 (FE2_bk_plm <- map(sets,FE2_bk_model))
 (FE2_bk_summary <- map(FE2_bk_plm,summary))
 (FE2_bk_coef <- map(FE2_bk_summary ,coef))
 
 
 map(FE2_bk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="HC3", cluster="group")))
 
 
#"vcovHC"(x, method = c("arellano", "white1", "white2"), type = c("HC0", "sss", "HC1", "HC2", "HC3", "HC4"), cluster = c("group", "time"), ...)
map(FE_plm, function(x) coeftest(x,vcovHC(x,method= "arellano", type="HC3", cluster="group")))

# coeftest1 <- function(x) {
#   coeftest(x,vcovHC(x,method= "arellano", type="HC3", cluster="group"))
# }
# coeftest1(FE_plm[[1]])
# coeftest(FE_plm[[1]], function(x) vcovHC(x, type="HC0"))


#Fixed Effects controlling Year 

FE2_model <- function(df) {
  plm(def_model_ALL_Year, data = df, model = "within")
}

(FE2_plm <- map(sets,FE2_model))
(FE2_summary <- map(FE2_plm,summary))
(FE2_coef <- map(FE2_summary ,coef))

#Fixed Effects controlling Year with Robust covariance matrix estimators/clustered standard errors

map(FE2_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))

#Fixed Effects Time

FE3_model <- function(df) {
  plm(def_model_ALL, data = df, model = "within",effect = "time")
}

(FE3_plm <- map(sets,FE3_model))
(FE3_summary <- map(FE3_plm,summary))
(FE3_coef <- map(FE3_summary ,coef))

#Fixed Effects Time  with Robust covariance matrix estimators/clustered standard errors

map(FE3_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group")))

#--------------------------------RANDOM EFFECTS--------------------------------------------------

#One-way Random Effects
#def_model_ALL1 <- update(def_model_ALL,.~.- SSM)

RE_model <- function(df) {
  #plm(def_model_ALL, data = df, model = "random", random.method = "swar")
 # plm(def_model_ALL, data = df, model = "random")
  plm(def_model_ALL, data = df, model = "random")
 # plm(def_model_ALL, data = df, model = "random",random.method = "amemiya")
 # plm(def_model_ALL, data = df, model = "random",random.method = "nerlove")-->ONLY BALANCED MODELS
}

(RE_plm <- map(sets,RE_model))
(RE_summary <- map(RE_plm,summary))
(RE_coef <- map(RE_summary ,coef))

#One-way Random Effects with Robust covariance matrix estimators/clustered standard errors

map(RE_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))

RE_mk_model <- function(df) {
  #plm(def_model_ALL, data = df, model = "random", random.method = "swar")
  plm(def_model_MACR, data = df, model = "random")
  # plm(def_model_ALL, data = df, model = "random",random.method = "amemiya")
  # plm(def_model_ALL, data = df, model = "random",random.method = "nerlove")-->ONLY BALANCED MODELS
}

(RE_mk_plm <- map(sets,RE_mk_model))
(RE_mk_summary <- map(RE_mk_plm,summary))
(RE_mk_coef <- map(RE_mk_summary ,coef))

map(RE_mk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))

RE2_mk_model <- function(df) {
  #plm(def_model_ALL, data = df, model = "random", random.method = "swar")
  plm(def_model_MACR_Year, data = df, model = "random")
  # plm(def_model_ALL, data = df, model = "random",random.method = "amemiya")
  # plm(def_model_ALL, data = df, model = "random",random.method = "nerlove")-->ONLY BALANCED MODELS
}

(RE2_mk_plm <- map(sets,RE2_mk_model))
(RE2_mk_summary <- map(RE2_mk_plm,summary))
(RE2_mk_coef <- map(RE2_mk_summary ,coef))

map(RE2_mk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))


RE2_bk_model <- function(df) {
  #plm(def_model_ALL, data = df, model = "random", random.method = "swar")
  plm(def_model_BANK_Year, data = df, model = "random")
  # plm(def_model_ALL, data = df, model = "random",random.method = "amemiya")
  # plm(def_model_ALL, data = df, model = "random",random.method = "nerlove")-->ONLY BALANCED MODELS
}

(RE2_bk_plm <- map(sets,RE2_bk_model))
(RE2_bk_summary <- map(RE2_bk_plm,summary))
(RE2_bk_coef <- map(RE2_bk_summary ,coef))

map(RE2_bk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))




RE_bk_model <- function(df) {
  #plm(def_model_ALL, data = df, model = "random", random.method = "swar")
  plm(def_model_BANK, data = df, model = "random")
  # plm(def_model_ALL, data = df, model = "random",random.method = "amemiya")
  # plm(def_model_ALL, data = df, model = "random",random.method = "nerlove")-->ONLY BALANCED MODELS
}

(RE_bk_plm <- map(sets,RE_bk_model))
(RE_bk_summary <- map(RE_bk_plm,summary))
(RE_bk_coef <- map(RE_bk_summary ,coef))

map(RE_bk_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))


#One-way Random Effects
#def_model_ALL1 <- update(def_model_ALL,.~.- SSM)

RE2_model <- function(df) {
  #plm(def_model_ALL, data = df, model = "random", random.method = "swar")
  # plm(def_model_ALL, data = df, model = "random")
  plm(def_model_ALL_Year, data = df, model = "random")
  # plm(def_model_ALL, data = df, model = "random",random.method = "amemiya")
  # plm(def_model_ALL, data = df, model = "random",random.method = "nerlove")-->ONLY BALANCED MODELS
}

(RE2_plm <- map(sets,RE2_model))
(RE2_summary <- map(RE2_plm,summary))
(RE2_coef <- map(RE2_summary ,coef))

#One-way Random Effects with Robust covariance matrix estimators/clustered standard errors

map(RE2_plm, function(x) summary(x , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group")))

#------------------------------------------------------Difference GMM---------------------------------
#data_model <- def_model_ALL_gmmdd2
data_model <- def_model_ALL_gmmdd_a
#data_model <- def_model_BANK_gmm
#data_model <-def_model_MACR_gmm
#data_model2 <- def_model_ALL_gmmdd2
 pdim(npl_hh.nfi)
# pgmm(def_model_ALL_gmm, data = npl_hh.nfi, model="onestep", effect="individual")
#onestep & individual
 
 #def_model_ALL_gmmdd_a_Year
 def_model_ALL_gmmdd_a_Year
npl_model_diffgmm <- function(df) {
  pgmm(data_model , data = df, model="onestep", effect="individual")
}

(diffgmm_plm <- map(sets,npl_model_diffgmm))
(diffgmm_summary <- map(diffgmm_plm,summary))
(diffgmm_coef <- map(diffgmm_summary ,coef))

lapply(diffgmm_plm,sargan)
map(diffgmm_plm, function(x) mtest(x , order = 2))
map(diffgmm_plm, function(x) mtest(x , order = 1))

npl_model_mk_diffgmm <- function(df) {
  pgmm(def_model_MACR_gmm , data = df, model="onestep", effect="individual")
}

(diffgmm_mk_plm <- map(sets,npl_model_mk_diffgmm))
(diffgmm_mk_summary <- map(diffgmm_mk_plm,summary))
(diffgmm_mk_coef <- map(diffgmm_mk_summary ,coef))



#twostep & individual
npl_model_diffgmm2 <- function(df) {
  pgmm(data_model , data = df, model="twosteps", effect="individual")
}

(diffgmm2_plm <- map(sets,npl_model_diffgmm2))
(diffgmm2_summary <- map(diffgmm2_plm,summary))
(diffgmm2_coef <- map(diffgmm2_summary ,coef))
nobs(diffgmm2_summary  )

npl_model_bk_diffgmm2 <- function(df) {
  pgmm(def_model_ALL_bk_gmmdd_a , data = df, model="twosteps", effect="individual")
}

(diffgmm2_bk_plm <- map(sets,npl_model_bk_diffgmm2))
(diffgmm2_bk_summary <- map(diffgmm2_bk_plm,summary))
(diffgmm2_bk_coef <- map(diffgmm2_bk_summary ,coef))
nobs(diffgmm2_bk_summary  )

npl_model_mk_diffgmm2 <- function(df) {
  pgmm(def_model_ALL_gmmdd_mk_a , data = df, model="twosteps", effect="individual")
}

(diffgmm2_mk_plm <- map(sets,npl_model_mk_diffgmm2))
(diffgmm2_mk_summary <- map(diffgmm2_mk_plm,summary))
(diffgmm2_mk_coef <- map(diffgmm2_mk_summary ,coef))
nobs(diffgmm2_summary  )


#twostep & individual
npl_model_mk_diffgmm2 <- function(df) {
  pgmm(def_model_ALL_gmmdd_mk_a , data = df, model="twosteps", effect="individual")
}

(diffgmm2_mk_plm <- map(sets,npl_model_mk_diffgmm2))
(diffgmm2_mk_summary <- map(diffgmm2_mk_plm,summary))
(diffgmm2_mk_coef <- map(diffgmm2_mk_summary ,coef))
nobs(diffgmm2_summary  )

#onestep & twoways
npl_model_diffgmm3 <- function(df) {
  pgmm(data_model , data = df, model="onestep", effect= "twoways")
}

(diffgmm3_plm <- map(sets,npl_model_diffgmm3))
(diffgmm3_summary <- map(diffgmm3_plm,summary))
(diffgmm3_coef <- map(diffgmm3_summary ,coef))

#twosteps & twoways
npl_model_diffgmm4 <- function(df) {
  pgmm(data_model , data = df, model="twosteps", effect= "twoways")
}

(diffgmm4_plm <- map(sets,npl_model_diffgmm4))
(diffgmm4_summary <- map(diffgmm4_plm,summary))
(diffgmm4_coef <- map(diffgmm4_summary ,coef))


#------------------------------------------------------SYSTEM GMM---------------------------------

#https://rdrr.io/rforge/plm/src/R/est_gmm.R
#data_model <- def_model_ALL_gmmdd

data_model <- def_model_ALL_gmmdd_a
#onestep & individual
npl_model_sysgmm <- function(df) {
  pgmm(data_model, data = df, model="onestep", effect="individual",  transformation = "ld")
}

(sysgmm_plm <- map(sets,npl_model_sysgmm))
(sysgmm_summary <- map(sysgmm_plm,summary))
(sysgmm_coef <- map(sysgmm_summary ,coef))


lapply(sysgmm_plm,sargan)
map(sysgmm_plm, function(x) summary(x , vcov = vcovHC(x ,method= "arellano", type="sss", cluster="group"),diagnostics=T))

npl_model_mk_sysgmm <- function(df) {
  pgmm(def_model_MACR_gmm , data = df, model="onestep", effect="individual",  transformation = "ld")
}

(sysgmm_mk_plm <- map(sets,npl_model_mk_sysgmm))
(sysgmm_mk_summary <- map(sysgmm_mk_plm,summary))
(sysgmm_mk_coef <- map(sysgmm_mk_summary ,coef))


#twostep & individual
npl_model_sysgmm2 <- function(df) {
  pgmm(data_model, data = df, model="twosteps", effect="individual",  transformation = "ld")
}

(sysgmm2_plm <- map(sets,npl_model_sysgmm2))
(sysgmm2_summary <- map(sysgmm2_plm,summary))
(sysgmm2_coef <- map(sysgmm2_summary ,coef))

#onestep & twoways
npl_model_sysgmm3 <- function(df) {
  pgmm(data_model, data = df, model="onestep", effect= "twoways",  transformation = "ld")
}
#trace(summary, edit=TRUE)

(sysgmm3_plm <- map(sets,npl_model_sysgmm3))
(sysgmm3_summary <- map(sysgmm3_plm,summary))
(sysgmm3_coef <- map(sysgmm3_summary ,coef))

#twosteps & twoways
npl_model_sysgmm4 <- function(df) {
  pgmm(data_model, data = df, model="twosteps", effect= "twoways",  transformation = "ld")
}

(sysgmm4_plm <- map(sets,npl_model_sysgmm4))
(sysgmm4_summary <- map(sysgmm4_plm,summary))
(sysgmm4_coef <- map(sysgmm4_summary ,coef))

npl_model_mk_sysgmm4 <- function(df) {
  pgmm(def_model_ALL_gmmdd_mk_a , data = df, model="twosteps", effect= "twoways",  transformation = "ld")
}

(sysgmm4_mk_plm <- map(sets,npl_model_mk_sysgmm4))
(sysgmm4_mk_summary <- map(sysgmm4_mk_plm,summary))
(sysgmm4_mk_coef <- map(sysgmm4_mk_summary ,coef))

npl_model_bk_sysgmm4 <- function(df) {
  pgmm(def_model_ALL_bk_gmmdd_a , data = df, model="twosteps", effect= "twoways",  transformation = "ld")
}

(sysgmm4_bk_plm <- map(sets,npl_model_bk_sysgmm4))
(sysgmm4_bk_summary <- map(sysgmm4_bk_plm,summary))
(sysgmm4_bk_coef <- map(sysgmm4_bk_summary ,coef))


#twosteps & twoways
npl_model_sysgmm4y <- function(df) {
  pgmm(def_model_ALL_gmmdd_a_Year, data = df, model="twosteps", effect= "twoways",  transformation = "ld")
}

(sysgmm4y_plm <- map(sets,npl_model_sysgmm4y))
(sysgmm4y_summary <- map(sysgmm4y_plm,summary))
(sysgmm4y_coef <- map(sysgmm4y_summary ,coef))


#------------------------------------------General Feasible Generalized Least Squares-----------------------------------------

#Pooled/Random Effects GGLS

npl_model_pggls <- function(df) {
  pggls(def_model_ALL, data = df, model = "pooling")
}

(pggls_plm <- map(sets,npl_model_pggls))
(pggls_summary <- map(pggls_plm,summary))
(pggls_coef <- map(pggls_summary ,coef))

round(pggls_plm[[1]]$sigma,3)
# An exception is that the estimate
# of the group covariance matrix of errors (sigma, a matrix) is reported in the model objects
# instead of the usual estimated variances of the two error components.
# the correlations between pairs of residuals (in time) for the same individual
# do not die out with the distance in time. The estimated error covariance very much resembles
# the random effects structure, with a strong prevalence of the individual variance component ????2
# ???? over ????2 ???? (witness the small difference between values on and outside the diagonal).


#Fixed Effects GGLS
#FD Effects GGLS
# individual heterogeneity is present but we do not trust the random effects assumption, and
# moreover the remainder errors are expected to show heteroscedasticity and serial correlation,
# the fe estimator can be employed together with a robust covariance matrix
# but if the
# cross-sectional dimension is sufficient and the assumption of constant covariance matrix across
# individuals is realistic, then applying the ggls method to time-demeaned data can provide a
#more efficient alternative, called the fixed effects gls (fegls) estimator
npl_model_fegls <- function(df) {
  pggls(def_model_ALL, data = df, model = "within")
}

(fegls_plm <- map(sets,npl_model_fegls))
(fegls_summary <- map(fegls_plm,summary))
(fegls_coef <- map(fegls_summary ,coef))

(fe_cov <- map(fegls_plm$sigma,round(3)))

round(fegls_plm[[1]]$sigma,3)

round(gglsmod$sigma, 3)

map2(fegls_plm,pggls_plm ,phtest)
#Hausman test
#phtest(feglsmod, gglsmod)

##--------------------------------------------The Maximum Likelihood Estimator-------------------------------
#pooled model

library("pglm")
LogLik_model <- function(df) {
  pglm(def_model_ALL, data=df,family=gaussian)
  
}


t <- pglm(def_model_ALL, data=npl_hh.nfi,family=gaussian)
t1 <- pglm(def_model_ALL, data=npl_fi,family=gaussian)
summary(t)
summary(t1)
AIC(t)
AIC(t1)

summary(t , vcov = vcovHC(x ,method= "white1", type="sss", cluster="group"))

#FD model

LogLik_modeldd <- function(df) {
  pglm(def_model_ALL_diff, data=df,family=gaussian)
  
}

td <-  pglm(def_model_ALL_diff, data=npl_hh.nfi,family=gaussian)
td1 <-pglm(def_model_ALL_diff, data=npl_fi,family=gaussian)

summary(td)
summary(td1)
AIC(td)
AIC(td1)

tf <-  pglm(def_model_ALL_diff, data=npl_hh.nfi,family=gaussian, model= "within")
summary(tf)


####Weighted Least Squares


#pool

po_wg_model <- function(dt,wg) {
  
  eval(substitute(ols <- plm(def_model_ALL, data = dt, weights = wg, model = "pooling")))
  ols
  
}
wg <- function(nm) {
  # 1/(nm)^2
  1/(resid(nm))^2
  
}

wg2 <- function(nm) {
  # 1/(nm)^2
  1/(exp(fitted(nm)))
  
}


s <- wg(OLS_plm$npl_hh.nfi)
sexp <- wg2(OLS_plm$npl_hh.nfi)

a <- po_wg_model(npl_hh.nfi,s)
a1 <- po_wg_model(npl_hh.nfi,1/npl_hh.nfi$npl_0)
a2<- po_wg_model(npl_hh.nfi,sexp )
summary(a)
summary(a1)
summary(a2)
s1 <- wg(OLS_plm$npl_fi)
b <- po_wg_model(npl_fi,s1)
b1 <- po_wg_model(npl_fi,1/npl_fi$npl_0)

summary(b)
summary(b1)


#fe

FE_wg_model <- function(dt,wg) {
  
  eval(substitute(ols <- plm(def_model_ALL, data = dt, weights = wg, model = "within")))
  ols
  
}
wg <- function(nm) {
  # 1/(nm)^2
  1/(resid(nm))^2
  
}

wg2 <- function(nm) {
  # 1/(nm)^2
  1/(exp(fitted(nm)))
  
}


s <- wg(FE_plm$npl_hh.nfi)
sexp <- wg2(FE_plm$npl_hh.nfi)

a <- FE_wg_model(npl_hh.nfi,s)
a1 <- FE_wg_model(npl_hh.nfi,1/npl_hh.nfi$npl_0)
a2<- FE_wg_model(npl_hh.nfi,sexp )
summary(a)
summary(a1)
summary(a2)
s1 <- wg(FE_plm$npl_fi)
b <- FE_wg_model(npl_fi,s1)
b1 <- FE_wg_model(npl_fi,1/npl_fi$npl_0)

summary(b)
summary(b1)
