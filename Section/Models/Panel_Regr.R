
source(file= paste(path_main,"Dataset_setup.r", sep = ""))

lapply(sets,pdim)
lapply(sets,class)

def_model_ALL <-  NPL_ratio ~ 
  
  CET1_ratio_tr +
  T1_ratio+
  TCAP_ratio+
  LEVER_tr_ratio_imput +
  
  RORAC +
  RORWA+
  
  log(npl_0) +
  log(BankSize_tran_imput) +
  
  Cost_to_Income +

  NIM_tr_imput +
  NFCI +
  NII +
  
  TimTOres_insol +
  Stgth_legal_index +
  Reco_rate_dol +
  Reco_rate_dol_Score +
  
  infl_perc +
  infl_avrg_imf+
  
  curr_acc_bal +
  
  GDP_growth_perc +
  GDP_per_cap_growth_perc+
  log(GDP_per_cap_ppp) +
  unempl_rate_imf +
  
  gross_public_debt +
  net_public_debt+
  Fiscal_Deficit +
  
  Public_Revenue+
  Public_expenditure+
  
  SSM+
  CBDI_index+
  
  def_model_Macro


def_model_BANK <- update(def_model_ALL, . ~ .
                         
                        - TimTOres_insol 
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
                          - Public_expenditure)     

def_model_MACR <- update(def_model_ALL, . ~ .
                        - CET1_ratio_tr 
                          - T1_ratio
                          - TCAP_ratio
                          - LEVER_tr_ratio_imput 
                           
                          - RORAC 
                          - RORWA
                           
                          - log(npl_0) 
                           -log(BankSize_tran_imput) 
                           
                          - Cost_to_Income 
                           
                         -  NIM_tr_imput 
                           -NFCI 
                          - NII )     

def_model_ALL_Year  <- update(def_model_ALL, . ~ . + factor(Year))
def_model_BANK_Year <- update(def_model_BANK_Year, . ~ . + factor(Year))
def_model_MACR_Year <- update(def_model_MACR_Year, . ~ . + factor(Year))
