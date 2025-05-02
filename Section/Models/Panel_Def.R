path_main <- 'C:/Users/varga/Desktop/Thesis/R_data/'

#source(file= paste(path_main,"Dataset_setup.r", sep = ""))

#lapply(sets,pdim)
#lapply(sets,class)
library(plm)
#STATIC PANEL MODELS
def_model_ALL <-  NPL_ratio ~ 
  
  CET1_ratio_tr +
 # T1_ratio+
  #TCAP_ratio+
  LEVER_tr_ratio +
  
  RORAC +
  #RORWA+
  
  #log(npl_0) +
  log(BankSize_tran) +
  
  Cost_to_Income +

  NIM_tr +
  #NFCI +
 # NII +
  
 # TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
 # Reco_rate_dol_Score +
  
  infl_perc +
  #infl_avrg_imf+
  
  curr_acc_bal +
  
  GDP_growth_perc +
 # GDP_per_cap_growth_perc+
 # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  
  gross_public_debt +
  #net_public_debt+
 # Fiscal_Deficit +
  
 # Public_Revenue+
 # Public_expenditure+
  
  SSM+
  CBDI_index
  

def_model_BANK <- update(def_model_ALL, . ~ .
                         
                        #- TimTOres_insol 
                         -  Stgth_legal_index 
                          - Reco_rate_dol 
                          - Reco_rate_dol_Score 
                           
                          - infl_perc 
                          - infl_avrg_imf
                           
                          - curr_acc_bal 
                           
                          - GDP_growth_perc 
                          - GDP_per_cap_growth_perc
                          - log(GDP_per_cap_ppp) 
                           -unempl_rate_imf 
                           
                          - gross_public_debt 
                          - net_public_debt
                          - Fiscal_Deficit 
     
                           -Public_Revenue
                          - Public_expenditure
                        -SSM
                        )     

def_model_MACR <- update(def_model_ALL, . ~ .
                        - CET1_ratio_tr 
                          - T1_ratio
                          - TCAP_ratio
                          - LEVER_tr_ratio 
                           
                          - RORAC 
                          - RORWA
                           
                          - log(npl_0) 
                           -log(BankSize_tran) 
                           
                          - Cost_to_Income 
                           
                         -  NIM_tr 
                           -NFCI 
                          - NII
                          #-SSM
                        - CBDI_index
                        )     

#def_model_ALL_Year  <- update(def_model_ALL, . ~ . + factor(Year))
#def_model_BANK_Year <- update(def_model_BANK, . ~ . + factor(Year))
#def_model_MACR_Year <- update(def_model_MACR, . ~ . + factor(Year))

def_model_ALL_Year  <- update(def_model_ALL, . ~ . + Year)
def_model_BANK_Year <- update(def_model_BANK, . ~ . + Year)
def_model_MACR_Year <- update(def_model_MACR, . ~ . + Year)
def_model_ALL_diff <-  dynformula( def_model_ALL, diff.form = TRUE)
def_model_BANK_diff <-  dynformula( def_model_BANK, diff.form = TRUE)
def_model_MACR_diff <-  dynformula( def_model_MACR, diff.form = TRUE)

#DYNAMIC PANEL MODELS

 def_model_ALL_gmm <-  NPL_ratio ~ lag(NPL_ratio) +
   CET1_ratio_tr +
   #T1_ratio+
  # TCAP_ratio+
   LEVER_tr_ratio +
   
   RORAC +
  # RORWA+
   
  # log(npl_0) +
   log(BankSize_tran) +
   
   Cost_to_Income +
   
   NIM_tr +
  # NFCI +
  # NII +
   
   #TimTOres_insol +
  Stgth_legal_index +
   Reco_rate_dol +
  # Reco_rate_dol_Score +
   
   infl_perc +
  # infl_avrg_imf+
   
   curr_acc_bal +
   
   GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
   unempl_rate_imf +
   
   gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
   
  # Public_Revenue+
  # Public_expenditure+
   
   SSM+
   CBDI_index | lag(NPL_ratio,2:99)|. -lag(NPL_ratio) - SSM
 
 def_model_ALL_gmmdd <-  NPL_ratio ~ lag(NPL_ratio) +
   CET1_ratio_tr +
   #T1_ratio+
   # TCAP_ratio+
   LEVER_tr_ratio +
   
   RORAC +
   # RORWA+
   
    #log(npl_0) +
   log(BankSize_tran) +
   
   Cost_to_Income +
   
   NIM_tr +
   # NFCI +
   # NII +
   
   #TimTOres_insol +
   Stgth_legal_index +
   Reco_rate_dol +
   # Reco_rate_dol_Score +
   
   infl_perc +
   # infl_avrg_imf+
   
  curr_acc_bal +
   
   GDP_growth_perc +
   # GDP_per_cap_growth_perc+
   # log(GDP_per_cap_ppp) +
   unempl_rate_imf +
   CBDI_index +
   gross_public_debt | lag(NPL_ratio,2:99)
 
 
 def_model_ALL_gmmdd_a <-  NPL_ratio ~ lag(NPL_ratio) +
   CET1_ratio_tr +
   #T1_ratio+
   # TCAP_ratio+
   LEVER_tr_ratio +
   
   RORAC +
   # RORWA+
   
   #log(npl_0) +
   log(BankSize_tran) +
   
   Cost_to_Income +
   
   NIM_tr +
   # NFCI +
   # NII +
   
   #TimTOres_insol +
   Stgth_legal_index +
   Reco_rate_dol +
   # Reco_rate_dol_Score +
   
   infl_perc +
   # infl_avrg_imf+
   
   curr_acc_bal +
   
   GDP_growth_perc +
   # GDP_per_cap_growth_perc+
   # log(GDP_per_cap_ppp) +
   unempl_rate_imf +
   CBDI_index +
   #Year+
   #loan_change_perc+
   gross_public_debt | lag(NPL_ratio,2:99)
 
 
 

   # net_public_debt+
   # Fiscal_Deficit +
   
   # Public_Revenue+
   # Public_expenditure+
   
   #SSM+
    
 #- SSM
 
 def_model_ALL_gmmdd_a_Year <-  NPL_ratio ~ lag(NPL_ratio) +
   CET1_ratio_tr +
   #T1_ratio+
   # TCAP_ratio+
   LEVER_tr_ratio +
   
   RORAC +
   # RORWA+
   
   #log(npl_0) +
   log(BankSize_tran) +
   
   Cost_to_Income +
   
   NIM_tr +
   # NFCI +
   # NII +
   
   #TimTOres_insol +
   Stgth_legal_index +
   Reco_rate_dol +
   # Reco_rate_dol_Score +
   
   infl_perc +
   # infl_avrg_imf+
   
   curr_acc_bal +
   
   GDP_growth_perc +
   # GDP_per_cap_growth_perc+
   # log(GDP_per_cap_ppp) +
   unempl_rate_imf +
   CBDI_index +
   Year+
   #loan_change_perc+
   gross_public_debt | lag(NPL_ratio,2:99)|.-Year
 
 
 def_model_ALL_gmmdd_mk_a <-  NPL_ratio ~ lag(NPL_ratio) +
  # CET1_ratio_tr +
   #T1_ratio+
   # TCAP_ratio+
   #LEVER_tr_ratio +
   
   #RORAC +
   # RORWA+
   
   #log(npl_0) +
   #log(BankSize_tran) +
   
   #Cost_to_Income +
   
  # NIM_tr +
   # NFCI +
   # NII +
   
   #TimTOres_insol +
   Stgth_legal_index +
   Reco_rate_dol +
   # Reco_rate_dol_Score +
   
   infl_perc +
   # infl_avrg_imf+
   
   curr_acc_bal +
   
   GDP_growth_perc +
   # GDP_per_cap_growth_perc+
   # log(GDP_per_cap_ppp) +
   unempl_rate_imf +
   #CBDI_index +
   #Year+
   #loan_change_perc+
   gross_public_debt | lag(NPL_ratio,2:99)
 
 
 
 def_model_ALL_bk_gmmdd_a <-  NPL_ratio ~ lag(NPL_ratio) +
   CET1_ratio_tr +
   #T1_ratio+
   # TCAP_ratio+
   LEVER_tr_ratio +
   
   RORAC +
   # RORWA+
   
   #log(npl_0) +
   log(BankSize_tran) +
   
   Cost_to_Income +
   
   NIM_tr +
   # NFCI +
   # NII +
   
   #TimTOres_insol +
   #Stgth_legal_index +
  # Reco_rate_dol +
   # Reco_rate_dol_Score +
   
  # infl_perc +
   # infl_avrg_imf+
   
  # curr_acc_bal +
   
   #GDP_growth_perc +
   # GDP_per_cap_growth_perc+
   # log(GDP_per_cap_ppp) +
  # unempl_rate_imf +
   CBDI_index | lag(NPL_ratio,2:99)
   #Year+
   #loan_change_perc+
  # gross_public_debt 
 
# def_model_ALL_gmmdd2 <- update(def_model_ALL,. ~ . -SSM |lag(NPL_ratio,2:99))
 
 def_model_ALL_gmmdd2 <-  NPL_ratio ~ lag(NPL_ratio) +
   CET1_ratio_tr +
   #T1_ratio+
   # TCAP_ratio+
   LEVER_tr_ratio +
   
   RORAC +
   # RORWA+
   
   # log(npl_0) +
   log(BankSize_tran) +
   
   Cost_to_Income +
   
   NIM_tr +
   # NFCI +
   # NII +
   
   #TimTOres_insol +
   Stgth_legal_index +
   Reco_rate_dol +
   # Reco_rate_dol_Score +
   
   infl_perc +
   # infl_avrg_imf+
   
   curr_acc_bal +
   
   GDP_growth_perc +
   # GDP_per_cap_growth_perc+
   # log(GDP_per_cap_ppp) +
   unempl_rate_imf +
   
   gross_public_debt +
   # net_public_debt+
   # Fiscal_Deficit +
   
   # Public_Revenue+
   # Public_expenditure+
   
  # SSM+
 
   CBDI_index | lag(NPL_ratio,2:99)
 
 def_model_ALL_gmmdd3 <-  NPL_ratio ~ lag(NPL_ratio) +
   CET1_ratio_tr +
   #T1_ratio+
   # TCAP_ratio+
   LEVER_tr_ratio +
   
   RORAC +
   # RORWA+
   
   # log(npl_0) +
   log(BankSize_tran) +
   
   Cost_to_Income +
   
   NIM_tr +
   # NFCI +
   # NII +
   
   #TimTOres_insol +
   Stgth_legal_index +
   Reco_rate_dol +
   # Reco_rate_dol_Score +
   
   infl_perc +
   # infl_avrg_imf+
   
   curr_acc_bal +
   
   GDP_growth_perc +
   # GDP_per_cap_growth_perc+
   # log(GDP_per_cap_ppp) +
   unempl_rate_imf +
   
   gross_public_debt +
   # net_public_debt+
   # Fiscal_Deficit +
   
   # Public_Revenue+
   # Public_expenditure+
   
   #SSM+
   CBDI_index | lag(NPL_ratio,2:99)| lag(Reco_rate_dol,1)
   
   #lag(CET1_ratio_tr,1) + lag(LEVER_tr_ratio,1)+ lag( RORAC,1) +  lag(Cost_to_Income,1) +  lag(NIM_tr,1)
 

def_model_BANK_gmm <-  NPL_ratio ~ lag(NPL_ratio) +
  CET1_ratio_tr +
  #T1_ratio+
  #TCAP_ratio+
  LEVER_tr_ratio +
  
  RORAC +
 # RORWA+
  
  #log(npl_0) +
  log(BankSize_tran) +
  
  Cost_to_Income +
  
  NIM_tr | lag(NPL_ratio,2:99)
  #NFCI +
 # NII +
  #SSM+
 # CBDI_index 
 

def_model_MACR_gmm <-   NPL_ratio ~ lag(NPL_ratio) +

  #TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
 # Reco_rate_dol_Score +
  
  infl_perc +
  #infl_avrg_imf+
  
  curr_acc_bal +
  
  GDP_growth_perc +
 # GDP_per_cap_growth_perc+
 # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  
  gross_public_debt +
  #net_public_debt+
 # Fiscal_Deficit +
  
  #Public_Revenue+
 # Public_expenditure+
  
  #SSM+
  CBDI_index | lag(NPL_ratio,2:99)



de_model_ALL_rqpd <-  NPL_ratio ~ 
  CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
  LEVER_tr_ratio +
  RORAC +
  # RORWA+
  # log(npl_0) +
  log(BankSize_tran) +
  Cost_to_Income +
  NIM_tr +
  # NFCI +
  # NII +
  # TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  # Reco_rate_dol_Score +
  infl_perc +
  # infl_avrg_imf+
  curr_acc_bal +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
  SSM+
  CBDI_index | name


de_model_ALL_rqpd_Year <-  NPL_ratio ~ 
  CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
  LEVER_tr_ratio +
  RORAC +
  # RORWA+
  # log(npl_0) +
  log(BankSize_tran) +
  Cost_to_Income +
  NIM_tr +
  # NFCI +
  # NII +
  # TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  # Reco_rate_dol_Score +
  infl_perc +
  # infl_avrg_imf+
  curr_acc_bal +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
  SSM+
  Year+
  CBDI_index | name







de_model_BANK_rqpd <-  NPL_ratio ~ 
  CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
  LEVER_tr_ratio +
  RORAC +
  # RORWA+
  # log(npl_0) +
  log(BankSize_tran) +
  Cost_to_Income +
  NIM_tr +
  # NFCI +
  # NII +
  # TimTOres_insol +
 # Stgth_legal_index +
 # Reco_rate_dol +
  # Reco_rate_dol_Score +
 # infl_perc +
  # infl_avrg_imf+
  #curr_acc_bal +
  #GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  #unempl_rate_imf +
  #gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
 # SSM+
  CBDI_index | name

de_model_MACR_rqpd <-  NPL_ratio ~ 
  #CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
 # LEVER_tr_ratio +
  #RORAC +
  # RORWA+
  # log(npl_0) +
  #log(BankSize_tran) +
 # Cost_to_Income +
 # NIM_tr +
  # NFCI +
  # NII +
  # TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  # Reco_rate_dol_Score +
  infl_perc +
  # infl_avrg_imf+
  curr_acc_bal +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
  SSM| name
 # CBDI_index 


de_model_MACR_rqpd <-  NPL_ratio ~ 
  #CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
  #LEVER_tr_ratio +
  #RORAC +
  # RORWA+
  # log(npl_0) +
  #log(BankSize_tran) +
 # Cost_to_Income +
  #NIM_tr +
  # NFCI +
  # NII +
  # TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  # Reco_rate_dol_Score +
  infl_perc +
  # infl_avrg_imf+
  curr_acc_bal +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
  SSM | name
  #CBDI_index 




de_model_ALL_rqpd_Year <-  NPL_ratio ~ 
  CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
  LEVER_tr_ratio +
  RORAC +
  # RORWA+
  # log(npl_0) +
  log(BankSize_tran) +
  Cost_to_Income +
  NIM_tr +
  # NFCI +
  # NII +
  #TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  # Reco_rate_dol_Score +
  infl_perc +
  # infl_avrg_imf+
 curr_acc_bal +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
  SSM+
  CBDI_index+ factor(Year) | name

de_model_ALL_rqpd_Year_mk <-  NPL_ratio ~ 
  #CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
 # LEVER_tr_ratio +
  #RORAC +
  # RORWA+
  # log(npl_0) +
  #log(BankSize_tran) +
  #Cost_to_Income +
 # NIM_tr +
  # NFCI +
  # NII +
  #TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  # Reco_rate_dol_Score +
  infl_perc +
  # infl_avrg_imf+
  curr_acc_bal +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
  SSM+
  #CBDI_index+
  factor(Year) | name

de_model_ALL_rqpd_Year_bk <-  NPL_ratio ~ 
  CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
  LEVER_tr_ratio +
  RORAC +
  # RORWA+
  # log(npl_0) +
  log(BankSize_tran) +
  Cost_to_Income +
  NIM_tr +
  # NFCI +
  # NII +
  #TimTOres_insol +
  #Stgth_legal_index +
  #Reco_rate_dol +
  # Reco_rate_dol_Score +
 # infl_perc +
  # infl_avrg_imf+
 # curr_acc_bal +
  #GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  #unempl_rate_imf +
  #gross_public_debt +
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
 # SSM+
  CBDI_index+ factor(Year) | name




de_model_ALL_rqpd_cre <-  NPL_ratio ~ 
  CET1_ratio_tr +
  #T1_ratio+
  # TCAP_ratio+
  #LEVER_tr_ratio +
  #RORAC +
  # RORWA+
  # log(npl_0) +
  #log(BankSize_tran) +
  #Cost_to_Income +
 # NIM_tr +
  # NFCI +
  # NII +
  #TimTOres_insol +
  #Stgth_legal_index +
  #Reco_rate_dol +
  # Reco_rate_dol_Score +
  #infl_perc +
  # infl_avrg_imf+
 # curr_acc_bal +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  #unempl_rate_imf +
  gross_public_debt | name|
  # net_public_debt+
  # Fiscal_Deficit +
  # Public_Revenue+
  # Public_expenditure+
  # SSM+
  #CBDI_index 

  CET1_ratio_tr 
  #T1_ratio+
  # TCAP_ratio+
  #LEVER_tr_ratio +
 # RORAC +
   #RORWA+
  # log(npl_0) +
  #log(BankSize_tran) +
 # Cost_to_Income +
  #NIM_tr 
 #  NFCI +
  # NII +
 # CBDI_index 


###Descriptive Statistics

def_model_ALL_descr <- NPL_ratio ~ 
  
  CET1_ratio_tr +
  # T1_ratio+
  #TCAP_ratio+
  LEVER_tr_ratio +
  
  RORAC +
  #RORWA+
  
  #log(npl_0) +
  log(BankSize_tran) +
  
  Cost_to_Income +
  
  NIM_tr +
  #NFCI +
  # NII +
  CBDI_index+
  SSM+
  # TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  # Reco_rate_dol_Score +
  
  infl_perc +
  #infl_avrg_imf+
  
  curr_acc_bal +
  
  #Country_Ori_exp+
 # npl_0 +
  GDP_growth_perc +
  # GDP_per_cap_growth_perc+
  # log(GDP_per_cap_ppp) +
  unempl_rate_imf +
 # loan_change_perc+
  gross_public_debt 
  #net_public_debt+
  # Fiscal_Deficit +
  
  # Public_Revenue+
  # Public_expenditure+
  

 
