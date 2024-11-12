*use "C:\PAPERS\GOUVERNANCE ET EMISSIONS\BASE STATA UTILISEE_GOUVERNANCE.dta", clear

use  "C:\Users\peprc\Downloads\AVOCE VIAGANOU\RESULTATS DES ESTIMATIONS DANS LE PAPIER\RESULTATS DES ESTIMATIONS DANS LE PAPIER\BASE STATA UTILISEE_GOUVERNANCE.dta", clear

log using EstimationGovernance_12112024, text replace

xtset IDSTATE YEAR
encode REGION, gen(REG)
drop if IDSTATE == 24 
drop if IDSTATE == 35
**replace Trade = 108.59 if Trade > 290
**replace Trade = . if Trade == 0
 
sum Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop lnCO2 lnRec Trade
pca Goveff RuLaw RegQua Voice Polstab ContCorr
screeplot
screeplot, yline(1) ci(het)
predict pc1 pc2 pc3, score
correlate pc1 pc2 pc3
clonevar GOV = pc1
sum GOV

recode IDSTATE (1 2 3 6 9 11 12 13 15 17 20 21 27 30 32 36 37 38 41 42 45 = 1 "Middle Income countries")(4  5 7 8 10 14 16 18 19 22 23 24 25 26 28 29 31 33 34 35 39 40 43 44 = 0 "Low Income Countries"), gen(IncomeGroup)
tab IncomeGroup

gen ContCorr_lnPop = ContCorr*lnPop
gen RegQua_lnRec = RegQua*lnRec

logout, save(xtdescStat) word replace: xtsum Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop lnCO2 lnRec Trade
logout, save(descStat) word replace: sum Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop lnCO2 lnRec Trade,detail
logout, save(descStatNodetail) word replace: sum Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop lnCO2 lnRec Trade
help cdtest
help xtcdf

***Cross dependency tests
xtcdf Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp Urbpop Trade lnCO2 lnPop lnRec lnGdp
***Unit root test

foreach v in Goveff RuLaw RegQua Voice Polstab ContCorr GOV FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop lnCO2 lnRec Trade {
xtcips `v', maxlags (1) bglags (1) trend
xtcips d.`v', maxlags (1) bglags (1)
}

help xtcips
xtcips Goveff, maxlags (1) bglags (1)
xtcips Goveff, maxlags (1) bglags (1) trend
xtcips dGoveff , maxlags (1) bglags (1)
xtcips dGoveff , maxlags (1) bglags (1) trend
xtcips RuLaw, maxlags (1) bglags (1)
xtcips RuLaw, maxlags (1) bglags (1) trend
xtcips dRuLaw, maxlags (1) bglags (1)
xtcips dRuLaw, maxlags (1) bglags (1) trend
xtcips Voice, maxlags (1) bglags (1) trend
xtcips d.Voice , maxlags (1) bglags (1)
xtcips dVoice , maxlags (1) bglags (1) trend
xtcips Polstab, maxlags (1) bglags (1)
xtcips Polstab, maxlags (1) bglags (1) trend
xtcips d.Polstab, maxlags (1) bglags (1) trend
xtcips ContCorr, maxlags (1) bglags (1)

xtcips RegQua, maxlags (1) bglags (1)
xtcips d.RegQua, maxlags (1) bglags (1) trend

xtcips dContCorr, maxlags (1) bglags (1)
xtcips dContCorr, maxlags (1) bglags (1) trend
xtcips GOV, maxlags (1) bglags (1) trend
xtcips d.GOV, maxlags (1) bglags (1)

xtcips FDIgdp, maxlags (1) bglags (1)
xtcips FDIgdp, maxlags (1) bglags (1) trend
xtcips d.FDIgdp, maxlags (1) bglags (1) trend

xtcips Urbpop, maxlags (1) bglags (1)
xtcips dUrbpop, maxlags (1) bglags (1)
xtcips dUrbpop, maxlags (1) bglags (1) trend
xtcips Trade , maxlags (1) bglags (1)
xtcips dTrade , maxlags (1) bglags (1)
xtcips dTrade , maxlags (1) bglags (1) trend
xtcips lnCO2 , maxlags (1) bglags (1)
xtcips lnCO2 , maxlags (1) bglags (1) trend
xtcips d.lnCO2 , maxlags (1) bglags (1) 
xtcips lnPop , maxlags (1) bglags (1) trend
xtcips dlnPop , maxlags (3) bglags (3) 
xtcips dlnPop , maxlags (1) bglags (1) trend
xtcips lnRec, maxlags (1) bglags (1)
xtcips dlnRec, maxlags (1) bglags (1)
xtcips dlnRec, maxlags (1) bglags (1) trend
xtcips lnGdp , maxlags (1) bglags (1)
xtcips d.lnGdp , maxlags (1) bglags (1)

xtcips dlnGdp , maxlags (1) bglags (1)
xtcips dlnGdp , maxlags (1) bglags (1) trend
xtcips lnGdp2 , maxlags (1) bglags (1)
xtcips lnGdp2 , maxlags (1) bglags (1) trend
xtcips dlnGdp2 , maxlags (1) bglags (1)
xtcips dlnGdp2 , maxlags (1) bglags (1) trend
xtcips lnGdp3 , maxlags (1) bglags (1)
xtcips dlnGdp3 , maxlags (1) bglags (1)
xtcips dlnGdp3 , maxlags (1) bglags (1) trend

*****pescadf test

foreach v in Goveff  RegQua Voice Polstab ContCorr GOV FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop lnCO2 lnRec Trade {
pescadf `v', lags (1) trend
pescadf d.`v', lags (1)
}
pescadf FDIgdp, lags (1) trend
pescadf d.FDIgdp, lags (1) trend

****Cointegration test
xtcointtest kao Goveff Polstab RegQua ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop  lnRec Trade
xtcointtest westerlund  GOV FDIgdp lnGdp lnPop Urbpop  lnRec Trade
xtcointtest pedroni   GOV FDIgdp lnGdp lnPop Urbpop  lnRec Trade

/*
ssc install ltimbimata
findit cointreg
ssc install xtcointreg
which xtcointreg */

logout, save(pwcorr) word replace: pwcorr lnCO2 Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop  lnRec Trade, star(.50)

//xtdolshm (Performs Dynamic Ordinary Least Squares for Cointegrated Panel Data with homogeneous covariance structure)
/*

xtdolshm lnCO2 Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop  lnRec Trade 
outreg2 using xtdolshm.doc, dec(3) replace
xtdolshm lnCO2 Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop  lnRec Trade  ContCorr_lnPop 
outreg2 using xtdolshm.doc, dec(3) append
xtdolshm lnCO2 Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop  lnRec Trade RegQua_lnRec
outreg2 using xtdolshm.doc, dec(3) append
xtdolshm lnCO2 Goveff RuLaw RegQua Voice Polstab ContCorr FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop  lnRec Trade ContCorr_lnPop RegQua_lnRec
outreg2 using xtdolshm.doc, dec(3) append
xtdolshm lnCO2 GOV FDIgdp lnGdp lnGdp2 lnGdp3 lnPop Urbpop  lnRec Trade 
outreg2 using xtdolshm_gov.doc, dec(3) replace

 // calculate the linear prediction from the long-run coefficients.
    predict linpred, xb
  // We calculate the dols residuals.
    predict dolsresiduals, dolsres
logout, save(xtdolshmpredict) word replace:sum linpred dolsresiduals

*/

*****FMOLS GOOD
cointreg lnCO2 Polstab c.Polstab#c.lnCO2  lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols2.doc, dec(3) replace  //bon a prendre
outreg2 using fmolsGood.doc, dec(3) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols1.doc, dec(3) replace
outreg2 using fmolsGood.doc, dec(3) append  //bon a prendre

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsCC.doc, dec(3) replace
outreg2 using fmolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 Goveff c.Goveff#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols4.doc, dec(3) replace
outreg2 using fmolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 RuLaw c.RuLaw#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols5.doc, dec(3) replace
outreg2 using fmolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 Voice c.Voice#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols6.doc, dec(3) replace
outreg2 using fmolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 GOV c.GOV#c.lnCO2  lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols) 
outreg2 using fmols7.doc, dec(3) replace  //bon a prendre
outreg2 using fmolsGood.doc, dec(3) append  //bon a prendre

cointreg lnCO2 Polstab RegQua ContCorr Goveff RuLaw Voice GOV   /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols8.doc, dec(3) replace
outreg2 using fmolsGood.doc, dec(3) append //bon a prendre



***FMOLS:REG==1 a 4
*****FMOLS GOOD

forvalue i = 1/4 {
cointreg lnCO2 Polstab c.Polstab#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG == `i', est(fmols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsPolstab`i'.doc, dec(2) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(fmols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsRegQua`i'.doc, dec(2) replace

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i' , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsCC`i'.doc, dec(2) replace

cointreg lnCO2 Goveff  c.Goveff#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsGoveff`i'.doc, dec(2) replace

cointreg lnCO2 GOV c.GOV#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsGOV`i'.doc, dec(2) replace

cointreg lnCO2 Polstab ContCorr Goveff RegQua  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsAll`i'.doc, dec(2) replace
}


//Robustesse
//PDOLS //estimates panel data cointegrating relationships following the estimator of Mark and Sul (2003)


*****DOLS GOOD
cointreg lnCO2 Polstab c.Polstab#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(dols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols2.doc, dec(3) replace  //bon a prendre
outreg2 using dolsGood.doc, dec(3) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(dols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols1.doc, dec(3) replace
outreg2 using dolsGood.doc, dec(3) append  //bon a prendre

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsCC.doc, dec(3) replace
outreg2 using dolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 Goveff c.Goveff#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols4.doc, dec(3) replace
outreg2 using dolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 RuLaw c.RuLaw#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols5.doc, dec(3) replace
outreg2 using dolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 Voice c.Voice#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols6.doc, dec(3) replace
outreg2 using dolsGood.doc, dec(3) append //bon a prendre

cointreg lnCO2 GOV c.GOV#c.lnCO2 lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade  , est(dols) 
outreg2 using dols7.doc, dec(3) replace  //bon a prendre
outreg2 using dolsGood.doc, dec(3) append  //bon a prendre

cointreg lnCO2 Polstab ContCorr Goveff RegQua RuLaw Voice  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols8.doc, dec(3) replace
outreg2 using dolsGood.doc, dec(3) append //bon a prendre




***DOLS:REG==1 a 4
*****DOLS GOOD

forvalue i = 1/4 {
cointreg lnCO2 Polstab c.Polstab#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG == `i', est(dols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsPolstab`i'.doc, dec(2) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(dols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsRegQua`i'.doc, dec(2) replace

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i' , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsCC`i'.doc, dec(2) replace

cointreg lnCO2 Goveff c.Goveff#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsGoveff`i'.doc, dec(2) replace

cointreg lnCO2 GOV c.GOV#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsGOV`i'.doc, dec(2) replace

cointreg lnCO2 Polstab ContCorr Goveff RegQua GOV /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if REG ==`i', est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsAll`i'.doc, dec(2) replace
}


****Revenu interediare



*****FMOLS GOOD
cointreg lnCO2 Polstab c.Polstab#c.lnCO2  lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1, est(fmols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols2M.doc, dec(3) replace  //bon a prendre
outreg2 using fmolsGoodM.doc, dec(3) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(fmols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols1M.doc, dec(3) replace
outreg2 using fmolsGoodM.doc, dec(3) append  //bon a prendre

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsCCM.doc, dec(3) replace
outreg2 using fmolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 Goveff c.Goveff#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols4M.doc, dec(3) replace
outreg2 using fmolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 RuLaw c.RuLaw#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols5M.doc, dec(3) replace
outreg2 using fmolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 Voice c.Voice#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols6M.doc, dec(3) replace
outreg2 using fmolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 GOV c.GOV#c.lnCO2  lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1, est(fmols) 
outreg2 using fmols7M.doc, dec(3) replace  //bon a prendre
outreg2 using fmolsGoodM.doc, dec(3) append  //bon a prendre

cointreg lnCO2 Polstab RegQua ContCorr Goveff RuLaw Voice GOV   /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols8M.doc, dec(3) replace
outreg2 using fmolsGoodM.doc, dec(3) append //bon a prendre




****Revenu Faible

*****FMOLS GOOD
cointreg lnCO2 Polstab c.Polstab#c.lnCO2  lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0, est(fmols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols2L.doc, dec(3) replace  //bon a prendre
outreg2 using fmolsGoodL.doc, dec(3) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(fmols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols1L.doc, dec(3) replace
outreg2 using fmolsGoodL.doc, dec(3) append  //bon a prendre

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmolsCCL.doc, dec(3) replace
outreg2 using fmolsGoodL.doc, dec(3) append //bon a prendre

cointreg lnCO2 Goveff c.Goveff#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols4L.doc, dec(3) replace
outreg2 using fmolsGoodL.doc, dec(3) append //bon a prendre

cointreg lnCO2 RuLaw c.RuLaw#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols5L.doc, dec(3) replace
outreg2 using fmolsGoodL.doc, dec(3) append //bon a prendre

cointreg lnCO2 Voice c.Voice#c.lnCO2  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols6L.doc, dec(3) replace
outreg2 using fmolsGoodL.doc, dec(3) append //bon a prendre

cointreg lnCO2 GOV c.GOV#c.lnCO2  lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0, est(fmols) 
outreg2 using fmols7L.doc, dec(3) replace  //bon a prendre
outreg2 using fmolsGoodL.doc, dec(3) append  //bon a prendre

cointreg lnCO2 Polstab RegQua ContCorr Goveff RuLaw Voice GOV   /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(fmols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using fmols8L.doc, dec(3) replace
outreg2 using fmolsGoodL.doc, dec(3) append //bon a prendre




****DOLS PAYS A REVENU INTERMEDIAIRES

*****DOLS GOOD
cointreg lnCO2 Polstab c.Polstab#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(dols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols2M.doc, dec(3) replace  //bon a prendre
outreg2 using dolsGoodM.doc, dec(3) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(dols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols1M.doc, dec(3) replace
outreg2 using dolsGoodM.doc, dec(3) append  //bon a prendre

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsCCM.doc, dec(3) replace
outreg2 using dolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 Goveff c.Goveff#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols4M.doc, dec(3) replace
outreg2 using dolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 RuLaw c.RuLaw#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols5M.doc, dec(3) replace
outreg2 using dolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 Voice c.Voice#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols6M.doc, dec(3) replace
outreg2 using dolsGoodM.doc, dec(3) append //bon a prendre

cointreg lnCO2 GOV c.GOV#c.lnCO2 lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade  if IncomeGroup == 1 , est(dols) 
outreg2 using dols7M.doc, dec(3) replace  //bon a prendre
outreg2 using dolsGoodM.doc, dec(3) append  //bon a prendre

cointreg lnCO2 Polstab ContCorr Goveff RegQua RuLaw Voice  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 1  , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols8M.doc, dec(3) replace
outreg2 using dolsGoodM.doc, dec(3) append //bon a prendre



****DOLS PAYS A FAIBLE REVENU

*****DOLS GOOD
cointreg lnCO2 Polstab c.Polstab#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(dols) /* full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols2F.doc, dec(3) replace  //bon a prendre
outreg2 using dolsGoodF.doc, dec(3) replace  //bon a prendre

cointreg lnCO2 RegQua c.RegQua#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(dols) /*full   full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols1F.doc, dec(3) replace
outreg2 using dolsGoodF.doc, dec(3) append  //bon a prendre

cointreg lnCO2 ContCorr c.ContCorr#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dolsCCF.doc, dec(3) replace
outreg2 using dolsGoodF.doc, dec(3) append //bon a prendre

cointreg lnCO2 Goveff c.Goveff#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols4F.doc, dec(3) replace
outreg2 using dolsGoodF.doc, dec(3) append //bon a prendre

cointreg lnCO2 RuLaw c.RuLaw#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols5F.doc, dec(3) replace
outreg2 using dolsGoodF.doc, dec(3) append //bon a prendre

cointreg lnCO2 Voice c.Voice#c.lnCO2 /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0 , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols6F.doc, dec(3) replace
outreg2 using dolsGoodF.doc, dec(3) append //bon a prendre

cointreg lnCO2 GOV c.GOV#c.lnCO2 lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade  if IncomeGroup == 0 , est(dols) 
outreg2 using dols7F.doc, dec(3) replace  //bon a prendre
outreg2 using dolsGoodF.doc, dec(3) append  //bon a prendre

cointreg lnCO2 Polstab ContCorr Goveff RegQua RuLaw Voice  /*Goveff RuLaw RegQua RegQua_lnRec Voice Polstab ContCorr ContCorr ContCorr_lnPop lnGdp3*/ lnGdp lnGdp2 FDIgdp lnPop Urbpop  lnRec Trade /*FDIgdp  lnGdp3 lnPop Urbpop  lnRec Trade*/ if IncomeGroup == 0  , est(dols)   /* full eqtrend(0) xtrend(0)  stage(1) kernel(bartlett) bmeth(neweywest)*/
outreg2 using dols8F.doc, dec(3) replace
outreg2 using dolsGoodF.doc, dec(3) append //bon a prendre


log close




