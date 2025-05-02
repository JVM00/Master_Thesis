
 /************************IMPORT_MODUL*****************************************/

%LET import_dir = /mnt/sasshare/RISK/RiskStrategy/Adhocs/Javier_V/ECB;
%PUT &import_dir;
%LET list = "tr_oth tr_sov tr_mrk tr_cre tr_sov_201906 tr_sov_201812"; 
*%LET list = "tr_cre"; 
%PUT &list;

%LET year_beg= 2015;
*%LET year_beg= 2019;
%PUT &year_beg;

%LET year_end= 2020;
%PUT &year_end;

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

*SDD;
%LET list_2 = "SDD"; 

%MACRO EBA_exercise2();

%DO i = 1 %TO %SYSFUNC(countw(&list_2.));

	%DO y = &year_end. %TO &year_end. %BY 1;

			DATA _NULL_;

		    type =  compress(SCAN(&list_2.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list_2.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;

			%put &ty. &y.;

		%if %sysfunc(fileexist("&import_dir./&y./&ty..xlsx")) %then %do;

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= &ty._&y.
			dbms=xlsx
			replace;
			getnames=yes;
		    *guessingrows=10000;
			run;

			DATA EBA.&ty._&y.;

			SET &ty._&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

		%end;
		%else %do;
			%put -------------------------------------------------------------------------------------------------;
			%put  Folder &import_dir./&y./&ty..xlsx;
			%put  not found!;
			%put  ;
			%put -------------------------------------------------------------------------------------------------;
		%end;

	

	%END;

%END;

%MEND EBA_exercise2;
%EBA_exercise2();


*TR_Metadata;

%LET list_3 = "TR_Metadata"; 

%MACRO EBA_exercise3();

%DO i = 1 %TO %SYSFUNC(countw(&list_3.));

	%DO y = &year_end. %TO &year_end. %BY 1;

			DATA _NULL_;

		    type =  compress(SCAN(&list_3.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list_3.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;

			%put &ty. &y.;

		%if %sysfunc(fileexist("&import_dir./&y./&ty..xlsx")) %then %do;
	 /*
			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Banks_list_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Banks list$A2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Banks_list_&y.;
			SET Banks_list_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 
*/
			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Other_Banks_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Other Banks$A2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Other_Banks_&y.;
			SET Other_Banks_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Dimensions_used_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Dimensions used$A1:0";
			*guessingrows=10000;
			run;

			DATA EBA.Dimensions_used_&y.;
			SET Dimensions_used_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Portfolio_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Portfolio$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Portfolio_&y.;
			SET Portfolio_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 
			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Country_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Country$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Country_&y.;
			SET Country_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Financial_instruments_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Financial_instruments$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Financial_instruments_&y.;
			SET Financial_instruments_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN;

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Exposure_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Exposure$C3:0";
			*guessingrows=10000;
			run;

			DATA EBA.Exposure_&y.;
			SET Exposure_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 
 
			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Status_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Status$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Status_&y.;
			SET Status_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 
 
			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Perf_status_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Perf_status$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Perf_status_&y.;
			SET Perf_status_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= MKT_Modprod_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="MKT_Modprod$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.MKT_Modprod_&y.;
			SET MKT_Modprod_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= MKT_Risk_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="MKT_Risk$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.MKT_Risk_&y.;
			SET MKT_Risk_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Accounting_portfolio_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Accounting_portfolio$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Accounting_portfolio_&y.;
			SET Accounting_portfolio_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Maturity_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Maturity$B3:0";
			*guessingrows=10000;
			run;

			DATA EBA.Maturity_&y.;
			SET Maturity_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= ASSETS_Stages_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="ASSETS_Stages$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.ASSETS_Stages_&y.;
			SET ASSETS_Stages_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			
			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= ASSETS_FV_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="ASSETS_FV$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.ASSETS_FV_&y.;
			SET ASSETS_FV_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= NACE_codes_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="NACE_codes$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.NACE_codes_&y.;
			SET NACE_codes_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Fin_end_year_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Fin_end_year$B2:0";
			*guessingrows=10000;
			run;

			DATA EBA.Fin_end_year_&y.;
			SET Fin_end_year_&y.;
			IF _N_ = 1 THEN DELETE;
			RUN; 
		%end;
		%else %do;
			%put -------------------------------------------------------------------------------------------------;
			%put  Folder &import_dir./&y./&ty..xlsx;
			%put  not found!;
			%put  ;
			%put -------------------------------------------------------------------------------------------------;
		%end;


	%END;

%END;

%MEND EBA_exercise3;
%EBA_exercise3();


*TR_Metadata;

%LET list_3 = "TR_Metadata"; 

%MACRO EBA_exercise3b();

%IF %SYSFUNC(exist( banks_list)) %THEN %DO; 
			PROC DATASETS LIB = work nolist nowarn;
			DELETE banks_list;
			quit;
			%END;
			

%DO i = 1 %TO %SYSFUNC(countw(&list_3.));

	%DO y = &year_end. %TO &year_beg. %BY - 1;

			DATA _NULL_;

		    type =  compress(SCAN(&list_3.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list_3.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;

			%put &ty. &y.;

		%if %sysfunc(fileexist("&import_dir./&y./&ty..xlsx")) %then %do;

			proc import datafile="&import_dir./&y./&ty..xlsx"
			out= Banks_list_&y.
			dbms=xlsx
			replace;
			getnames=yes;
			range="Banks list$A2:0";
			*guessingrows=10000;
			run;

			DATA Banks_list1_&y.;
				length name $100. TE_15-TE_20 $1. SSM $1.;
				FORMAT name $100. TE_15-TE_20 $1. SSM $1.;
				*length ;
			SET Banks_list_&y.;
		
			IF _N_ = 1 THEN DELETE;
			ID_TE= &y.;
			RUN; 

		PROC APPEND BASE= banks_list DATA=  Banks_list1_&y. FORCE;RUN;
		
		%end;
		%else %do;
			%put -------------------------------------------------------------------------------------------------;
			%put  Folder &import_dir./&y./&ty..xlsx;
			%put  not found!;
			%put  ;
			%put -------------------------------------------------------------------------------------------------;
		%end;

     
		



	%END;

%END;

PROC SORT DATA= banks_list  NODUPKEY; BY _ALL_; RUN;

PROC SORT DATA= banks_list ; BY name descending id_TE; RUN;
PROC SORT DATA= banks_list  OUT= banks_list_nodup NODUPKEY; BY name; RUN;



%MEND EBA_exercise3b;
%EBA_exercise3b();



%MACRO EBA_bank_list();

	DATA EBA.banks_list_nodup1;

	SET  banks_list_nodup;

	RUN; 

	%DO y = &year_end. %TO &year_beg. %BY  - 1;
	PROC SORT DATA=	EBA.banks_list_nodup1 ; BY LEI_Code_TE&y. descending ID_TE; RUN;	

	DATA EBA.banks_list_nodup1;
	SET EBA.banks_list_nodup1;

	IF  missing(LEI_Code_TE&y.)= 0 AND compress(LEI_Code_TE&y.)= compress(lag1(LEI_Code_TE&y.)) THEN DELETE;
	*lag_LEI_Code_TE&y.= compress(lag1(LEI_Code_TE&y.));
	RUN; 
	
*	PROC SORT DATA=	EBA.banks_list_nodup ; *BY LEI_Code_TE&y. descending ID_TE; *RUN;	
	*PROC SORT DATA=	EBA.banks_list_nodup nodupkey; *BY LEI_Code_TE&y.; *RUN;	

	
		%END;

	

 %MEND EBA_bank_list;
%EBA_bank_list();

PROC SORT DATA= EBA.banks_list_nodup1; BY name; RUN;

DATA EBA.banks_list_nodup1 (Drop= i);
SET EBA.banks_list_nodup1;
array TE{6} TE_15-TE_20;
do i=1 to dim(TE);
IF missing(TE[i])=1 THEN TE[i]= 'N';
end;

RUN;


*PROC SORT DATA=	EBA.banks_list_nodup ; *BY LEI_Code_TE2020-LEI_Code_TE2015 ;* RUN;
/*
PROC SORT DATA= EBA.banks_list_nodup; BY name ID_TE;RUN; 

PROC FREQ DATA=EBA.banks_list_nodup ;
TABLE Name;
RUN;

PROC FREQ DATA=EBA.banks_list;
TABLE id_te;
RUN;

PROC FREQ DATA=EBA.banks_list_nodup ;
TABLE (TE_:);
RUN;
PROC FREQ DATA=EBA.banks_list_nodup ;
WHERE TE_20  = "Y" AND TE_19  = "Y" AND TE_18  = "Y" AND TE_17  = "Y" AND TE_16  = "Y" AND TE_15  = "Y" ;
TABLE TE_20;
RUN;
*/
%MACRO EBA_exercise();

%DO i = 1 %TO %SYSFUNC(countw(&list.));

	%DO y = &year_beg. %TO &year_end. %BY 1;

		DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			%put &ty. &y.;
			%PUT &import_dir./&y./&ty..csv;
		%IF %SYSFUNC(fileexist("&import_dir./&y./&ty..csv")) %THEN %DO;	

		/****************IMPORTS ALL FIELDS AS CHARACTER FROM CSV FILES*********************/
			  filename holdit "&import_dir./&y./&ty.1.csv" lrecl=32000;
		 
		   * Point to the csv file;
		   filename rawcsv "&import_dir./&y./&ty..csv"  lrecl=32000;
		 
		   data _null_;
		      file holdit;
		      infile rawcsv end=done;
		 
		      * Read the first observation (variable names);
		      input;
		 
		      * Write the var names;
		      put _infile_;
		      * Count the variables (the names are comma separated);
		      wcount = countw(_infile_,',');
		      * Write an asterisk for each variable - forces each to be character;
		      * but will not set the var length;
		       string = catt('*',repeat(',*',wcount-2));
		      put string;
		 
		      * Read and write the data portion of the raw data;
		      do until(done);
		         input;
		         **********
		         *  Pre processing of the data could be done here
		         **********;
		         * Write the record;
		         put _infile_;
		      end;
		      stop;
		      run;


			  * Read the Altered CSV file into a SAS dataset;
		   PROC IMPORT OUT= &ty.1_&y. 
		               DATAFILE= holdit 
		               DBMS=CSV 
		               REPLACE;
		      guessingrows=10000;
		      GETNAMES=YES;
		      DATAROW=2; 
		      run;
		   * Clear the filerefs for the next data set;
		  * filename holdit;
		   *filename rawcsv;


		/****************DATA CLEANSING FOR FIELDS INCONSISTENCIES/ERRORS*********************/
			 DATA &ty._&y. (DROP= 	Amount_0 Amount_1 z1  	Amount_2  Amount_e_notation t1 re_: Amount_tx: multiplier Period_cha month year);

			 SET &ty.1_&y. ;
			FORMAT Amount_3 COMMA15.14;

			*AMOUNT CLEANSING;
			Amount_0= prxchange('s/\,//',-1,strip(Amount));*Eliminate "," as thousands from variable Amount;
			Amount_1= Strip(prxchange('s/E(\-|\+)\d+//',-1,strip(Amount_0)));*Eliminate e_notacion (+/-) characters;

			z1= strip(prxmatch('/.\d+/i',Amount_2)) ;* Identify amounts with '.' decimals;
			IF z1 > 0 THEN DO;
			Amount_2= input(Amount_1,15.14);
			END;
			ELSE DO;
			Amount_2= input(Amount_1,15.);
			END;

			*t1= strip(prxmatch('/E\-\d/i',Amount)) ;
		*	t1= strip(prxmatch('/E/i',Amount)) ;


			Amount_e_notation=0;
			t1= strip(prxmatch('/E(\-|\+)\d+/i',Amount)) ;

			IF t1 > 0 THEN Amount_e_notation=1;
			ELSE Amount_e_notation=0;
			
			 if _n_=1 then do;

			retain re_dec;

			re_dec = prxparse('/E(\-|\+)\d+/i');

			end;


			call prxsubstr(re_dec,Amount,re_start,re_end);
			Amount_tx = substrn(Amount, re_start, re_end);*EXTRACT e_notation from FIELD;
			Amount_tx1= prxchange('s/E//',-1,strip(Amount_tx)); *Extract numeric part from expresion E;
			Amount_tx2= input(Amount_tx1,3.);

			multiplier=0;
			IF Amount_e_notation=1 THEN DO;
			multiplier=10**(Amount_tx2);
			Amount_3= 	Amount_2*(multiplier);
			END;
			ELSE DO;
			Amount_3 = 	Amount_2;
			END;

			
			*Character to date format;
			Period_cha= Period;
			year= input(substr(Strip(Period_cha),1,4),4.);
			Month=input(substr(Period_cha,5,6),2.);
			Period_nm= mdy(Month,1,year)*1 ; format Period_nm  yymmn6.;

			 IF _N_ = 1 THEN DELETE;*Delete artificial asterisks line for importing all fields as characters;

			 RUN;

			PROC DATASETS LIB = work nolist nowarn;
			DELETE &ty.1_:;
			quit; 




		/****************DELETE AUXIALIARY CSV FILES*********************/
			%if %sysfunc(fileexist("&import_dir./&y./&ty.1.csv")) %then %do;
			filename weg "&import_dir./&y./&ty.1.csv";

			data _null_;
			rc = fdelete('weg');
			call symput("rc",rc);
			run;
			%if &rc = 0 %then %put File &import_dir./&y./&ty.1.csv deleted!;
			           %else %put File &import_dir./&y./&ty.1.csv NOT deleted!;
			%end;
			%else %do;
			%put File &import_dir./&y./&ty.1.csv not available!;
			%end;


				 * Clear the filerefs for the next data set;
		   filename holdit;
		   filename rawcsv;

		%END;
	%END;

%END;

%MEND EBA_exercise;
%EBA_exercise();


/**********************COMMON ITEM IDENTIFIER***********************/
%put &list.;
%MACRO EBA_exercise1();

%DO i = 1 %TO %SYSFUNC(countw(&list.));

	%DO y = &year_beg. %TO &year_end. %BY 1;

		DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			%put &ty. &y.;
			%PUT &import_dir./&y./&ty..csv;

			%IF %SYSFUNC(exist(&ty._&y.)) %THEN %DO;

			PROC SQL;
			CREATE TABLE &ty._&y. AS
			SELECT a.*, b.Item_TR_2020 AS Item_current
			FROM  &ty._&y.  AS a
				LEFT JOIN EBA.SDD_2020 AS b
				ON a.Item =b.Item_TR_&y.;
			QUIT;

					%IF &y. = 2015 %THEN %DO;
						
					PROC SORT DATA= &ty._&y.  (DROP= item Amount Period /*label footnote*/)
							NODUPKEY ; 
							BY 
							_ALL_;
							RUN;
							
							
					%END;

					%IF &y. = 2016 %THEN %DO;

					
					PROC SORT DATA= &ty._&y.  (DROP= item Amount Period label /*footnote*/)
							NODUPKEY ; 
							BY 
							_ALL_;
							RUN;
							
					%END;

					%IF &y. = 2017 %THEN %DO;

					
					PROC SORT DATA= &ty._&y.  (DROP= item Amount Period label footnote)
							NODUPKEY ; 
							BY 
							_ALL_;
							RUN;
							
					%END;

					
					%IF &y. = 2018 %THEN %DO;

					
					PROC SORT DATA= &ty._&y.  (DROP= item Amount Period label footnote)
							NODUPKEY ; 
							BY 
							_ALL_;
							RUN;
							
					%END;

					
					%IF &y. = 2019 %THEN %DO;

					
					PROC SORT DATA= &ty._&y.  (DROP= item Amount Period label footnote)
							NODUPKEY ; 
							BY 
							_ALL_;
							RUN;
							
					%END;

					
					%IF &y. = 2020 %THEN %DO;

					PROC SORT DATA= &ty._&y.  (DROP= item Amount Period label footnote)
							NODUPKEY ; 
							BY 
							_ALL_;
							RUN;
							
					%END;



		    %END;

	%END;

%END;

%MEND EBA_exercise1;
%EBA_exercise1();

/*
proc contents data= TR_CRE_2020 (read=green) out= TR_CRE_2020_var (KEEP= LIBNAME MEMNAME NAME LENGTH FORMAT FORMATL FORMATD INFORMAT INFORML INFORMD) ;

run;
*/

/*

Amount_3
Country
Country_rank
Exposure
Item_current
LEI_Code
Month
NACE_codes
NSA
Perf_Status
Period_nm
Portfolio
Status



*/
*%LET list = "tr_oth tr_sov tr_mrk tr_cre tr_sov_201906 tr_sov_201812"; 
%put &list.;

%MACRO EBA_exercise4();

%DO i = 1 %TO %SYSFUNC(countw(&list.));

	%DO y = &year_beg. %TO &year_end. %BY 1;

		DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			%put &ty. &y.;
			%PUT &import_dir./&y./&ty..csv;

			%IF %SYSFUNC(exist(&ty._&y.)) %THEN %DO;

				proc contents data = &ty._&y. (Drop= Amount_3) out = varname (keep = name) noprint;
				run;

				proc sql noprint;
				  select name into :textlist separated by " " from varname;
				quit;

				%put &textlist.;	
				PROC SORT DATA=&ty._&y.  OUT= &ty._&y._sort; 
					BY 
							&textlist.;
					RUN;



				   PROC MEANS DATA = &ty._&y._sort sum n nway noprint ;
					CLASS  &textlist.;
					VAR  
					Amount_3;
					OUTPUT OUT= &ty._&y._sort1 (DROP = _TYPE_ _FREQ_)  sum = n=n;
					RUN;

					DATA &ty._&y._sort2 (DROP= n);
					SET &ty._&y._sort1;
					IF n >1 THEN DELETE;
					RUN; 


				proc contents data = &ty._&y. (Drop= Amount_3 Item_current) out = varname1 (keep = name) noprint;
				run;

				proc sql noprint;
				  select name into :textlist1 separated by " " from varname1;
				quit;

				%put &textlist1.;	

				PROC SORT DATA=&ty._&y._sort2; 
					BY 	&textlist1.;
					RUN;

				PROC TRANSPOSE DATA= &ty._&y._sort2 
						
								OUT= &ty._&y._hor;
				   BY   
							&textlist1.;
				   ID Item_current;
				   RUN;

			%END;
	%END;

%END;

%MEND EBA_exercise4;
%EBA_exercise4();


*%LET list = "tr_oth tr_sov tr_mrk tr_cre tr_sov_201906 tr_sov_201812"; 
%put &list.;

%MACRO EBA_exercise5();

%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			/*
			DATA &ty._hor;

			SET _NULL_;
		    RUN;
			*/
			%IF %SYSFUNC(exist(EBA.&ty._hor)) %THEN %DO; 
			PROC DATASETS LIB = EBA nolist nowarn;
			DELETE &ty._hor;
			quit;
			%END;

			%IF %SYSFUNC(exist(EBA.&ty._ver )) %THEN %DO; 
			PROC DATASETS LIB = EBA nolist nowarn;
			DELETE &ty._ver;
			quit;
			%END;
			



	%DO y = &year_end. %TO &year_beg. %BY  - 1;
		
			%put &ty. &y.;

			DATA _NULL_;
			LEI_id =   compress("TE"||put(&y.,4.));
			CALL SYMPUT("LEI_id", LEI_id);
		
			RUN;
		

			%IF %SYSFUNC(exist(&ty._&y._sort2)) %THEN %DO;

			DATA &ty._&y._sort2_1;

			SET &ty._&y._sort2 ;
			*Length id $.;

			id= &y.;

			RUN;

		/*HERE*/
				%PUT &LEI_id.; 
			
									PROC SQL; 
									CREATE TABLE &ty._&y._sort2_2 AS
									SELECT a.*,b.SSM, b.Name, b.Finrep,b.ID_TE
									FROM &ty._&y._sort2_1 As a
									LEFT JOIN EBA.banks_list_nodup1 AS b
									ON a.LEI_code=b.LEI_code_&LEI_id.;
									QUIT;

									
		
				/*HERE MORE METADATA*/

			*PROC SQL; *DELETE FROM &ty._hor WHERE id= "&ty._&y." ;*QUIT;
			PROC APPEND BASE= EBA.&ty._ver DATA=  &ty._&y._sort2_2 FORCE;RUN;
			PROC SORT DATA= EBA.&ty._ver  NODUPKEY; BY _ALL_; RUN;

			%END;

			
			%IF %SYSFUNC(exist(&ty._&y._hor)) %THEN %DO;

			DATA &ty._&y._hor1;

			SET &ty._&y._hor ;
			*Length id $15.;

			id= &y.;

			RUN;

		/*HERE*/
%PUT &LEI_id.; 
					
									PROC SQL; 
									CREATE TABLE &ty._&y._hor2 AS
									SELECT a.*,b.SSM, b.Name, b.Finrep,b.ID_TE
									FROM &ty._&y._hor1 As a
									LEFT JOIN EBA.banks_list_nodup1 AS b
									ON a.LEI_code=b.LEI_code_&LEI_id.;
									QUIT;

								
	/*HERE MORE METADATA*/

			*PROC SQL; *DELETE FROM &ty._hor WHERE id= "&ty._&y." ;*QUIT;
			PROC APPEND BASE= EBA.&ty._hor DATA=  &ty._&y._hor2  FORCE;RUN;
			PROC SORT DATA= EBA.&ty._hor  NODUPKEY; BY _ALL_; RUN;

			%END;

	%END;

		
%END;

PROC APPEND BASE= EBA.tr_sov_hor DATA=  EBA.tr_sov_201812_hor  FORCE;RUN; 
PROC APPEND BASE= EBA.tr_sov_hor DATA=  EBA.tr_sov_201906_hor  FORCE;RUN; 


PROC APPEND BASE= EBA.tr_sov_ver DATA=  EBA.tr_sov_201812_ver  FORCE;RUN; 
PROC APPEND BASE= EBA.tr_sov_ver DATA=  EBA.tr_sov_201906_ver  FORCE;RUN; 



%MEND EBA_exercise5;
%EBA_exercise5();
/*
PROC SORT DATA= EBA.tr_cre_hor   OUT= cre_test NODUPKEY; BY name id; RUN;

PROC FREQ DATA= cre_test;
TABLE id*ID_te;
RUN;
*/

	PROC DATASETS LIB = EBA nolist nowarn;
			DELETE tr_sov_201812_hor;
			quit;
	PROC DATASETS LIB = EBA nolist nowarn;
		DELETE tr_sov_201906_hor;
		quit;
	PROC DATASETS LIB = EBA nolist nowarn;
		DELETE tr_sov_201812_ver;
		quit;
	PROC DATASETS LIB = EBA nolist nowarn;
		DELETE tr_sov_201906_ver;
		quit;

proc datasets library=work kill nolist;
quit;




%LET list = "tr_oth tr_sov tr_mrk tr_cre"; 
%MACRO EBA_exercise8();
Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			


		
			%put &ty. &y.;
								%IF %SYSFUNC(exist(EBA.&ty._hor)) %THEN %DO;

								    PROC SORT DATA= EBA.&ty._hor; BY LEI_code period_nm; RUN;	
	
								%END;
 

						%IF %SYSFUNC(exist(EBA.&ty._ver)) %THEN %DO;


									PROC SQL; 
									CREATE TABLE EBA.&ty._ver AS
									SELECT a.*,b.Label as Item_label
									FROM EBA.&ty._ver As a
									LEFT JOIN EBA.SDD_2020 AS b
									ON a.Item_current=b.Item_TR_2020;
									QUIT;

									PROC SORT DATA= EBA.&ty._ver  NODUPKEY; BY _ALL_; RUN;

							PROC SORT DATA= EBA.&ty._ver; BY LEI_code period_nm ; RUN;	

							
								%END;

	

%END;

 %MEND EBA_exercise8;
%EBA_exercise8();


%LET list = "tr_oth tr_sov tr_mrk tr_cre"; 
%MACRO EBA_exercise9();
Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			


		
			%put &ty.;
								%IF %SYSFUNC(exist(EBA.&ty._hor)) %THEN %DO;

									DATA EBA.&ty._hor /*(DROP= nsa_label)*/;

									SET EBA.&ty._hor;

									 IF strip(NSA) = 'UK' THEN NSA= 'GB';

									RUN; 


									PROC SQL; 
									CREATE TABLE EBA.&ty._hor AS
									SELECT a.*,b.Country_Label as nsa_label
									FROM EBA.&ty._hor As a
									LEFT JOIN EBA.country_2020 AS b
									ON a.NSA=b.ISO_code;
									QUIT;

									PROC SORT DATA= EBA.&ty._hor  NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.&ty._hor; BY LEI_code period_nm; RUN;	
	
								%END;
 

						%IF %SYSFUNC(exist(EBA.&ty._ver)) %THEN %DO;

									DATA EBA.&ty._ver /*(DROP= nsa_label)*/;

									SET EBA.&ty._ver;

									IF strip(NSA) = 'UK' THEN NSA= 'GB';


									RUN; 



									PROC SQL; 
									CREATE TABLE EBA.&ty._ver AS
									SELECT a.*,b.Country_Label as nsa_label
									FROM EBA.&ty._ver As a
									LEFT JOIN EBA.country_2020 AS b
									ON a.NSA=b.ISO_code;
									QUIT;

									PROC SORT DATA= EBA.&ty._ver  NODUPKEY; BY _ALL_; RUN;

							PROC SORT DATA= EBA.&ty._ver; BY LEI_code period_nm ; RUN;	

							
								%END;

	

%END;

 %MEND EBA_exercise9;
%EBA_exercise9();

/*
PROC FREQ DATA= EBA.tr_cre_ver  ;
WHERE nsa= 'GB';
TABLE nsa*period_nm;
RUN; 


PROC FREQ DATA= EBA.tr_cre_hor  ;
WHERE nsa= 'GB';
TABLE nsa*name;
RUN; 
*/

/*
PROC FREQ DATA= EBA.TR_CRE_HOR;
TABLE nsa*nsa_label;
RUN;
*/



%LET list = "tr_oth tr_sov tr_mrk tr_cre"; 
*%LET list = "tr_cre"; 
%MACRO EBA_exercise12();
Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			


		
			%put &ty. ;
								%IF %SYSFUNC(exist(EBA.&ty._hor)) %THEN %DO;

								    PROC SORT DATA= EBA.&ty._hor; BY LEI_code period_nm; RUN;	
	
								%END;
 

						%IF %SYSFUNC(exist(EBA.&ty._ver)) %THEN %DO;


									PROC SQL; 
									CREATE TABLE EBA.&ty._ver AS
									SELECT a.*,b.category,b.template
									FROM EBA.&ty._ver As a
									LEFT JOIN EBA.SDD_2020 AS b
									ON a.Item_current=b.Item_TR_2020;
									QUIT;


									PROC SORT DATA= EBA.&ty._ver  NODUPKEY; BY _ALL_; RUN;

											
									PROC SORT DATA= EBA.&ty._ver; BY LEI_code period_nm ; RUN;	

							
								%END;

	

%END;

	%IF %SYSFUNC(exist(EBA.tr_cre_ver)) %THEN %DO;

DATA EBA.tr_cre_ver;
SET EBA.tr_cre_ver;

IF strip(template) in ('Credit Risk_IRB_b','Credit Risk_STA_b') THEN DELETE;

RUN;
	%END;
	
 %MEND EBA_exercise12;
%EBA_exercise12();

							

/*
PROC FREQ DATA= EBA.tr_cre_ver;
TABLE template;
RUN;
*/

%MACRO EBA_exercise10();
Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

/**********************tr_cre**********************/
*Country	Country_rank	Perf_Status	Exposure	Portfolio	Status	NACE_codes	Finrep;
								%IF %SYSFUNC(exist(EBA.tr_cre_hor)) %THEN %DO;


									PROC SQL; 
									CREATE TABLE EBA.tr_cre_hor AS
									SELECT a.*,b.Country_Label,b.ISO_code as ISO_code_dest,c.Perf_Status_Label,d.Exposure_Label,
											e.Portfolio_Label,f.Status_Label,g.Nace_codes_Label
									FROM EBA.tr_cre_hor As a
										LEFT JOIN EBA.country_2020 AS b
										ON a.country=b.country
											LEFT JOIN EBA.Perf_Status_2020 AS c
											ON a.Perf_Status=c.Perf_Status
												LEFT JOIN EBA.Exposure_2020 AS d
												ON a.Exposure=d.Exposure
													LEFT JOIN EBA.Portfolio_2020 AS e
													ON a.Portfolio=e.Portfolio
														LEFT JOIN EBA.Status_2020 AS f
														ON a.Status=f.Status
															LEFT JOIN EBA.Nace_codes_2020 AS g
															ON a.Nace_codes=g.Nace_codes;
									QUIT;

									PROC SORT DATA= EBA.tr_cre_hor  NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.tr_cre_hor; BY LEI_code period_nm; RUN;	
	
								%END;
 

								%IF %SYSFUNC(exist(EBA.tr_cre_ver)) %THEN %DO;


								
									PROC SQL; 
									CREATE TABLE EBA.tr_cre_ver AS
									SELECT a.*,b.Country_Label,b.ISO_code as ISO_code_dest,c.Perf_Status_Label,d.Exposure_Label,
											e.Portfolio_Label,f.Status_Label,g.Nace_codes_Label
									FROM EBA.tr_cre_ver As a
										LEFT JOIN EBA.country_2020 AS b
										ON a.country=b.country
											LEFT JOIN EBA.Perf_Status_2020 AS c
											ON a.Perf_Status=c.Perf_Status
												LEFT JOIN EBA.Exposure_2020 AS d
												ON a.Exposure=d.Exposure
													LEFT JOIN EBA.Portfolio_2020 AS e
													ON a.Portfolio=e.Portfolio
														LEFT JOIN EBA.Status_2020 AS f
														ON a.Status=f.Status
															LEFT JOIN EBA.Nace_codes_2020 AS g
															ON a.Nace_codes=g.Nace_codes;
									QUIT;

									PROC SORT DATA= EBA.tr_cre_ver  NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.tr_cre_ver; BY LEI_code period_nm; RUN;	

							
								%END;


/**********************tr_mrk**********************/
*Portfolio			Finrep	MKT_Modprod	Mkt_risk;

								%IF %SYSFUNC(exist(EBA.tr_mrk_hor)) %THEN %DO;

									PROC SQL; 
									CREATE TABLE EBA.tr_mrk_hor AS
									SELECT a.*,b.Portfolio_Label,c.MKT_Modprod_Label,d.MKT_Risk_Label
									FROM EBA.tr_mrk_hor As a
									LEFT JOIN EBA.Portfolio_2020 AS b
									ON a.Portfolio=b.Portfolio
											LEFT JOIN EBA.MKT_Modprod_2020 AS c
										ON a.MKT_Modprod=c.MKT_Modprod
												LEFT JOIN EBA.MKT_Risk_2020 AS d
											ON a.MKT_Risk=d.MKT_Risk;
									QUIT;

									PROC SORT DATA= EBA.tr_mrk_hor NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.tr_mrk_hor; BY LEI_code period_nm; RUN;	
	
								%END;
 

								%IF %SYSFUNC(exist(EBA.tr_mrk_ver)) %THEN %DO;


										PROC SQL; 
									CREATE TABLE EBA.tr_mrk_ver AS
									SELECT a.*,b.Portfolio_Label,c.MKT_Modprod_Label,d.MKT_Risk_Label
									FROM EBA.tr_mrk_ver As a
									LEFT JOIN EBA.Portfolio_2020 AS b
									ON a.Portfolio=b.Portfolio
											LEFT JOIN EBA.MKT_Modprod_2020 AS c
										ON a.MKT_Modprod=c.MKT_Modprod
												LEFT JOIN EBA.MKT_Risk_2020 AS d
											ON a.MKT_Risk=d.MKT_Risk;
									QUIT;

									PROC SORT DATA= EBA.tr_mrk_ver NODUPKEY; BY _ALL_; RUN;

								    PROC SORT DATA= EBA.tr_mrk_ver; BY LEI_code period_nm; RUN;	

								%END;

*/
/**********************tr_oth**********************/
*Exposure				Finrep			ASSETS_FV	ASSETS_Stages	Financial_instruments	Fin_end_year	n_quarters;
	
								%IF %SYSFUNC(exist(EBA.tr_oth_hor)) %THEN %DO;

									PROC SQL; 
									CREATE TABLE EBA.tr_oth_hor AS
									SELECT a.*,b.Exposure_Label, c.ASSETS_FV_Label,d.ASSETS_Stages_Label,
											e.Financial_instruments_Label,f.Fin_end_year_Label
									FROM EBA.tr_oth_hor As a
									LEFT JOIN EBA.Exposure_2020 AS b
									ON a.Exposure=b.Exposure
										LEFT JOIN EBA.ASSETS_FV_2020 AS c
										ON a.ASSETS_FV=c.ASSETS_FV
											LEFT JOIN EBA.ASSETS_Stages_2020 AS d
											ON a.ASSETS_Stages=d.ASSETS_Stages
												LEFT JOIN EBA.Financial_instruments_2020 AS e
												ON a.Financial_instruments=e.Financial_instruments
													LEFT JOIN EBA.Fin_end_year_2020 AS f
													ON a.Fin_end_year=f.Fin_end_year;

									QUIT;

									PROC SORT DATA= EBA.tr_oth_hor NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.tr_oth_hor; BY LEI_code period_nm; RUN;	
	
								%END;
 

								%IF %SYSFUNC(exist(EBA.tr_oth_ver)) %THEN %DO;


											PROC SQL; 
									CREATE TABLE EBA.tr_oth_ver AS
									SELECT a.*,b.Exposure_Label, c.ASSETS_FV_Label,d.ASSETS_Stages_Label,
											e.Financial_instruments_Label,f.Fin_end_year_Label
									FROM EBA.tr_oth_ver As a
									LEFT JOIN EBA.Exposure_2020 AS b
									ON a.Exposure=b.Exposure
										LEFT JOIN EBA.ASSETS_FV_2020 AS c
										ON a.ASSETS_FV=c.ASSETS_FV
											LEFT JOIN EBA.ASSETS_Stages_2020 AS d
											ON a.ASSETS_Stages=d.ASSETS_Stages
												LEFT JOIN EBA.Financial_instruments_2020 AS e
												ON a.Financial_instruments=e.Financial_instruments
													LEFT JOIN EBA.Fin_end_year_2020 AS f
													ON a.Fin_end_year=f.Fin_end_year;

									QUIT;

									PROC SORT DATA= EBA.tr_oth_ver NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.tr_oth_ver; BY LEI_code period_nm; RUN;	

								%END;	

/**********************tr_sov**********************/

*Country							Finrep								Accounting_portfolio	Maturity;
	
 
								%IF %SYSFUNC(exist(EBA.tr_sov_hor)) %THEN %DO;

									PROC SQL; 
									CREATE TABLE EBA.tr_sov_hor AS
									SELECT a.*,b.Country_Label,c.Accounting_portfolio_Label,d.Maturity_Label
									FROM EBA.tr_sov_hor As a
									LEFT JOIN EBA.country_2020 AS b
									ON a.country=b.country
										LEFT JOIN EBA.Accounting_portfolio_2020 AS c
									ON a.Accounting_portfolio=c.Accounting_portfolio
										LEFT JOIN EBA.Maturity_2020 AS d
									ON a.Maturity=d.Maturity;
									QUIT;

									PROC SORT DATA= EBA.tr_sov_hor NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.tr_sov_hor; BY LEI_code period_nm; RUN;	
	
								%END;
 

								%IF %SYSFUNC(exist(EBA.tr_sov_ver)) %THEN %DO;


									PROC SQL; 
									CREATE TABLE EBA.tr_sov_ver AS
									SELECT a.*,b.Country_Label,c.Accounting_portfolio_Label,d.Maturity_Label
									FROM EBA.tr_sov_ver As a
									LEFT JOIN EBA.country_2020 AS b
									ON a.country=b.country
										LEFT JOIN EBA.Accounting_portfolio_2020 AS c
									ON a.Accounting_portfolio=c.Accounting_portfolio
										LEFT JOIN EBA.Maturity_2020 AS d
									ON a.Maturity=d.Maturity;
									QUIT;

									PROC SORT DATA= EBA.tr_sov_ver NODUPKEY; BY _ALL_; RUN;


								    PROC SORT DATA= EBA.tr_sov_ver; BY LEI_code period_nm; RUN;	

								%END;	
			

 %MEND EBA_exercise10;
%EBA_exercise10();





%LET list = "tr_oth tr_sov tr_mrk tr_cre"; 
%MACRO EBA_exercise15();
Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;
			


		
			%put &ty.;
								%IF %SYSFUNC(exist(EBA.&ty._hor)) %THEN %DO;

								    PROC SORT DATA= EBA.&ty._hor NODUPKEY; BY _ALL_; RUN;	
	
								%END;
 

						%IF %SYSFUNC(exist(EBA.&ty._ver)) %THEN %DO;


								
									PROC SORT DATA= EBA.&ty._ver  NODUPKEY; BY _ALL_; RUN;


							
								%END;

	

%END;

RUN;

 %MEND EBA_exercise15;
%EBA_exercise15();









Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
/*********************/
/********tr_oth**********/
%LET KEEP= 

id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
/*_NAME_*/
Finrep
_NUMERIC_

/*
2020101	2020102	2020103	2020104	2020105	2020106	2020107	2020108	2020109
2020110	2020111	2020112	2020113	2020114	2020115	2020116	2020117	2020118
2020119	2020120	2020121	2020122	2020123	2020124	2020125	2020126	2020127
2020128	2020129	2020130	2020131	2020132	2020133	2020134	2020135	2020136	
2020137	2020138	2020139	2020140	2020141	2020142	2020143	2020146	2020147
2020148	2020149	2020150	2020201	2020202	2020203	2020204	2020205	2020206
2020207	2020208	2020209	2020210	2020211	2020212	2020213	2020214	2020215	
2020216	2020217	2020218	2020219	2020220	2020301	2020302	2020303	2020304	
2020305	2020306	2020307	2020308	2020309	2020310	2020311	2020312	2020313	
2020314	2020315	2020316	2020317	2020318	2020319	2020320	2020321	2020324	
2020325	2020326	2020327	2020328	2020329	2020330	2020331	2020332	2020333	
2020334	2020335	2020336	2020337	2020338	2020901	2020902	2020903	2020904	
2020905	2020906	2021001	2021002	2021003	2021004	2021005	2021006	2021007	
2021008	2021009	2021010	2021101	2021102	2021103	2021104	2021105	2021106	
2021107	2021108	2021109	2021110	2021111	2021112	2021113	2021114	2021115	
2021116	2021201	2021202	2021203	2021204	2021205	2021206	2021207	2021208	
2021209	2021210	2021211	2021212	2021213	2021214	2021215	2020322	2020323
2021016	2021017	2021018	2021019	2021026	2021027	2021028	2021029	
*/
; 
%PUT &KEEP;
	DATA EBA.tr_oth_hor;
	RETAIN &KEEP.;
	SET  EBA.tr_oth_hor (KEEP = &KEEP.);
	RUN; 


%LET KEEP=

id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters	
Finrep
category 
template
Item_current
Item_label	
Amount_3	
; 
%PUT &KEEP;

		DATA EBA.tr_oth_ver (RENAME=(Amount_3= Amount));
	RETAIN &KEEP.;
	SET  EBA.tr_oth_ver (KEEP = &KEEP.);
	RUN; 


/*	
%LET KEEP=

id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters	
Finrep
category 
template
Item_current
Item_label	
Amount	
; 
%PUT &KEEP;
		DATA EBA.tr_oth_ver;
	RETAIN &KEEP.;
	SET  EBA.tr_oth_ver (KEEP = &KEEP.);
	RUN; 
*/


/********tr_sov**********/

%LET KEEP= 

id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Accounting_portfolio
Accounting_portfolio_label
Country
Country_label
Maturity
Maturity_label
/*_NAME_*/	
Finrep
_NUMERIC_
/*
20208102020811	2020812	2020813	2020814	2020815	2020816	
2020817	2020818	2020819	2020820	2020821	2020822	
*/
; 
%PUT &KEEP;
	DATA EBA.tr_sov_hor;
	RETAIN &KEEP.;
	SET  EBA.tr_sov_hor (KEEP = &KEEP.);
	RUN; 


%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Accounting_portfolio
Accounting_portfolio_label
Country
Country_label
Maturity
Maturity_label
Finrep
category 
template
Item_current
Item_label
Amount_3
; 
%PUT &KEEP;

		DATA EBA.tr_sov_ver (RENAME=(Amount_3= Amount));
	RETAIN &KEEP.;
	SET  EBA.tr_sov_ver (KEEP = &KEEP.);
	RUN; 



/*
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Accounting_portfolio
Accounting_portfolio_label
Country
Country_label
Maturity
Maturity_label
Finrep
category 
template
Item_current
Item_label
Amount
; 
%PUT &KEEP;
		DATA EBA.tr_sov_ver ;
	RETAIN &KEEP.;
	SET  EBA.tr_sov_ver (KEEP = &KEEP.);
	RUN; 
*/
/********tr_mrk**********/

%LET KEEP= 	
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Portfolio
Portfolio_label
MKT_Modprod	
MKT_Modprod_label
Mkt_risk
Mkt_risk_label
/*_NAME_*/	
Finrep
_NUMERIC_
/*
2020401	2020411	2020421	2020431	2020441	2020451	2020461	2020471	2020481	
2020491	2020402	2020412	2020422	2020432	2020442	2020403	2020413	2020423
2020433	2020443	2020404	2020414	2020424	2020434	2020444
*/
; 
%PUT &KEEP;
	DATA EBA.tr_mrk_hor;
	RETAIN &KEEP.;
	SET  EBA.tr_mrk_hor (KEEP = &KEEP.);
	RUN; 


%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Portfolio
Portfolio_label
MKT_Modprod	
MKT_Modprod_label
Mkt_risk
Mkt_risk_label
Finrep
category 
template
Item_current
Item_Label
Amount_3
; 
%PUT &KEEP;

		DATA EBA.tr_mrk_ver (RENAME=(Amount_3= Amount));
	RETAIN &KEEP.;
	SET  EBA.tr_mrk_ver (KEEP = &KEEP.);
	RUN; 



/*
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Portfolio
Portfolio_label
MKT_Modprod	
MKT_Modprod_label
Mkt_risk
Mkt_risk_label
Finrep
category 
template



Item_current
Item_Label
Amount
; 
%PUT &KEEP;
		DATA EBA.tr_mrk_ver;
	RETAIN &KEEP.;
	SET  EBA.tr_mrk_ver (KEEP = &KEEP.);
	RUN; 

*/



/********tr_cre**********/
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Country
ISO_code_dest
Country_label	
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label	
Status
Status_label	
/*_NAME_*/
NACE_codes
NACE_codes_label
Finrep
_NUMERIC_
/*
2020601	2020602	2020603	2020606	2020701	2020702	2020703	2020706	
2020711	2020712	2020713	2020716	2020721	2020722	2020723	2020726	2021301	2021302	2021303	2020501
2020521	2020531	2020551	2020611	2020612	2020613	2020616	2020621	2020622	2020623	2020626	2020604	
2020605	2020704	2020705	2020714	2020715	2020724	2020725	2020614	2020615	2020624	2020625	2020502	
2020522	2020532	2020552	2020512	2020542	2020607	2020707	2020717	2020727	2020617	2020627	2020503	
2020523	2020533	2020553	2020513	2020543	2020504	2020524	2020534	2020554	2020514	2020544	2020505	
2020525	2020535	2020555	2020515	2020545	2020506	2020526	2020536	2020556	2020516	2020546	*/
						; 
%PUT &KEEP;
	DATA EBA.tr_cre_hor;
	RETAIN &KEEP.;
	SET  EBA.tr_cre_hor (KEEP = &KEEP.);
	RUN; 


%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Country
ISO_code_dest
Country_label	
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label	
Status
Status_label	
NACE_codes
NACE_codes_label
Finrep
category 
template
Item_current
Item_Label
Amount_3
; 
%PUT &KEEP;


	DATA EBA.tr_cre_ver (RENAME=(Amount_3= Amount)) ;
	RETAIN &KEEP.;
	SET  EBA.tr_cre_ver (KEEP = &KEEP.);
	RUN; 



/*
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Country
ISO_code_dest
Country_label	
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label	
Status
Status_label	
NACE_codes
NACE_codes_label
Finrep
category 
template
Item_current
Item_Label
Amount
; 
%PUT &KEEP;
	DATA EBA.tr_cre_ver ;
	RETAIN &KEEP.;
	SET  EBA.tr_cre_ver (KEEP = &KEEP.);
	RUN; 

*/



Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

PROC SORT DATA= EBA.tr_cre_ver;

BY

	id
	Period_nm
	NSA
	nsa_label
	LEI_Code 
	name
	SSM	
	ID_TE
	Country
	ISO_code_dest
	Country_label	
	Country_rank
	Perf_Status
	Perf_Status_label
	Exposure
	Exposure_label
	Portfolio
	Portfolio_label	
	Status
	Status_label	
	NACE_codes
	NACE_codes_label
	Finrep
	category 
	template
	Item_current
	Item_Label
	Amount;

RUN;

PROC SORT DATA= EBA.tr_cre_ver NODUPKEY;

BY

	id
	Period_nm
	NSA
	nsa_label
	LEI_Code 
	name
	SSM	
	ID_TE
	Country
	ISO_code_dest
	Country_label	
	Country_rank
	Perf_Status
	Perf_Status_label
	Exposure
	Exposure_label
	Portfolio
	Portfolio_label	
	Status
	Status_label	
	NACE_codes
	NACE_codes_label
	Finrep
	category 
	/*template*/
	Item_current
	Item_Label
	Amount;

RUN;




/********tr_cre**********/
/*
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Country
ISO_code_dest
Country_label	
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label	
Status
Status_label
	
*_NAME_:
NACE_codes
NACE_codes_label
Finrep
_NUMERIC_
/*
2020601	2020602	2020603	2020606	2020701	2020702	2020703	2020706	
2020711	2020712	2020713	2020716	2020721	2020722	2020723	2020726	2021301	2021302	2021303	2020501
2020521	2020531	2020551	2020611	2020612	2020613	2020616	2020621	2020622	2020623	2020626	2020604	
2020605	2020704	2020705	2020714	2020715	2020724	2020725	2020614	2020615	2020624	2020625	2020502	
2020522	2020532	2020552	2020512	2020542	2020607	2020707	2020717	2020727	2020617	2020627	2020503	
2020523	2020533	2020553	2020513	2020543	2020504	2020524	2020534	2020554	2020514	2020544	2020505	
2020525	2020535	2020555	2020515	2020545	2020506	2020526	2020536	2020556	2020516	2020546	
						; 
%PUT &KEEP;

*/


%LET list = "tr_oth tr_mrk tr_cre"; 
*%LET list = "tr_cre"; 
%MACRO EBA_exercise7();

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

	%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;



 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2015)) OUTFILE="&xls_dir./&ty._hor1.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2016)) OUTFILE="&xls_dir./&ty._hor2.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor  (WHERE= (id= 2017)) OUTFILE="&xls_dir./&ty._hor3.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor  (WHERE= (id= 2018)) OUTFILE="&xls_dir./&ty._hor4.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2019)) OUTFILE="&xls_dir./&ty._hor5.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2020)) OUTFILE="&xls_dir./&ty._hor6.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 
 PROC EXPORT DATA= EBA.&ty._ver (WHERE= (id= 2015)) OUTFILE="&xls_dir./&ty._ver1.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver (WHERE= (id= 2016)) OUTFILE="&xls_dir./&ty._ver2.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2017)) OUTFILE="&xls_dir./&ty._ver3.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2018)) OUTFILE="&xls_dir./&ty._ver4.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2019)) OUTFILE="&xls_dir./&ty._ver5.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2020)) OUTFILE="&xls_dir./&ty._ver6.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;

%END;

 

 %MEND EBA_exercise7;
%EBA_exercise7();


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA= EBA.SDD_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="SDD";RUN;
PROC EXPORT DATA= EBA.Dimensions_used_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="dimensions_used";RUN;

PROC EXPORT DATA= EBA.banks_list_nodup1  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="banks_list";RUN;

PROC EXPORT DATA= EBA.country_2020 OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="country";RUN;


PROC EXPORT DATA= EBA.exposure_2020 OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="exposure";RUN;

PROC EXPORT DATA= EBA.perf_status_2020 OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="perf_status";RUN;

PROC EXPORT DATA= EBA.portfolio_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="portfolio";RUN;

PROC EXPORT DATA= EBA.nace_codes_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="nace_codes_2020";RUN;

PROC EXPORT DATA= EBA.status_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="status";RUN;



PROC EXPORT DATA= EBA.accounting_portfolio_2020 OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="accounting_portfolio";RUN;

PROC EXPORT DATA= EBA.assets_fv_2020 OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="assets_fv";RUN;

PROC EXPORT DATA= EBA.assets_stages_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="assets_stages";RUN;

PROC EXPORT DATA= EBA.fin_end_year_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="fin_end_year";RUN;

PROC EXPORT DATA= EBA.financial_instruments_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="financial_instruments";RUN;



PROC EXPORT DATA= EBA.maturity_2020 OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="maturity";RUN;

PROC EXPORT DATA= EBA.mkt_modprod_2020 OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="mkt_modprod";RUN;

PROC EXPORT DATA= EBA.mkt_risk_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="mkt_risk";RUN;

PROC EXPORT DATA= EBA.fin_end_year_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="fin_end_year";RUN;

PROC EXPORT DATA= EBA.financial_instruments_2020  OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="financial_instruments";RUN;



%LET list = "tr_sov"; 
%MACRO EBA_exercise7();

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

	%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;

			
 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2015)) OUTFILE="&xls_dir./&ty._hor1.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2016)) OUTFILE="&xls_dir./&ty._hor2.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor  (WHERE= (id= 2017)) OUTFILE="&xls_dir./&ty._hor3.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor  (WHERE= (id= 2018)) OUTFILE="&xls_dir./&ty._hor4.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2019)) OUTFILE="&xls_dir./&ty._hor5.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._hor (WHERE= (id= 2020)) OUTFILE="&xls_dir./&ty._hor6.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 
 PROC EXPORT DATA= EBA.&ty._ver (WHERE= (id= 2015)) OUTFILE="&xls_dir./&ty._ver1.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver (WHERE= (id= 2016)) OUTFILE="&xls_dir./&ty._ver2.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2017)) OUTFILE="&xls_dir./&ty._ver3.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2018)) OUTFILE="&xls_dir./&ty._ver4.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;


 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2019 AND period_nm < '01JAN2019'd)) OUTFILE="&xls_dir./&ty._ver5.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2019 AND period_nm >= '01JAN2019'd)) OUTFILE="&xls_dir./&ty._ver6.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;

 PROC EXPORT DATA= EBA.&ty._ver  (WHERE= (id= 2020)) OUTFILE="&xls_dir./&ty._ver7.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;

 %END;

 

 %MEND EBA_exercise7;
%EBA_exercise7();



%LET list = "tr_oth tr_mrk tr_cre tr_sov"; 

%MACRO EBA_exercise11();

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

	%DO i = 1 %TO %SYSFUNC(countw(&list.));
			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;

	PROC SORT DATA= EBA.&ty._hor OUT= &ty._hor_dt (KEEP=period_nm) NODUPKEY; BY period_nm; RUN;
		PROC SORT DATA= EBA.&ty._ver OUT= &ty._ver_dt(KEEP=period_nm) NODUPKEY; BY period_nm; RUN;

			
 PROC EXPORT DATA= &ty._hor_dt OUTFILE="&xls_dir./map_list.xlsx" DBMS= XLSX REPLACE; SHEET="&ty._hor";RUN;
 
 PROC EXPORT DATA= &ty._ver_dt  OUTFILE="&xls_dir./map_list.xlsx" DBMS= XLSX REPLACE; SHEET= "&ty._ver";RUN;

	PROC DATASETS LIB = work nolist nowarn;
	DELETE &ty._hor_dt &ty._ver_dt ;
	quit;

 %END;

 

 %MEND EBA_exercise11;
%EBA_exercise11();






/*Country Weights based on country-destination original exposure*/


Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';


/********tr_cre**********/

/*
Item_current	2020502
Item_Label	Original Exposure - by exposure class (SA_and_IRB)
*/

/*SA*/
options validvarname=any;
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Country
ISO_code_dest
Country_label	
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label	
Status
Status_label	
NACE_codes
NACE_codes_label
Finrep

'2020502'n;

%PUT &KEEP;


	DATA cre_exp_country_weight;
	RETAIN &KEEP.;
	SET EBA.tr_cre_hor (KEEP = &KEEP.) ;

	IF Status='0';
	IF country_rank in('0','1','2','3','4','5','6','7','8','9','10');
	If missing('2020502'n)= 1 THEN DELETE;
	If portfolio = '1'; /*ONLY STANDARD APPROACH (SA)*/
	*If portfolio = '2'; /*ONLY  INTERNAL RATINGS BASED APPROACH(IRB)*/

	RUN; 


	PROC MEANS DATA = cre_exp_country_weight nway noprint;
	CLASS  
/*id*/
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
/*ID_TE*/
Country
ISO_code_dest
Country_label	
Country_rank

/*
Perf_Status
Perf_Status_label

Exposure
Exposure_label
Portfolio
Portfolio_label	

Status
Status_label	
Finrep*/;
	VAR '2020502'n;
	OUTPUT OUT= sum_cre_exp_country_weight (DROP = _TYPE_ _FREQ_)  sum =;
	RUN;



PROC SORT DATA= sum_cre_exp_country_weight; 

BY 
Period_nm
NSA
nsa_label
name
/*ID_TE*/
Country_rank; 

RUN; 



*PROC FREQ DATA= sum_cre_exp_country_weight ;
*TABLE 
/*id*/
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
/*ID_TE*/
Country
ISO_code_dest
Country_label	
Country_rank
/*
Perf_Status
Perf_Status_label

Exposure
Exposure_label
Portfolio
Portfolio_label	

Status
Status_label	
Finrep*/;

*RUN;


*PROC FREQ DATA= sum_cre_exp_country_weight ;
*TABLE 
/*id*/

name*period_nm;

*RUN;

	DATA sum_cre_exp_country_weight1;

	SET sum_cre_exp_country_weight;

	IF strip(country_rank) ne '0' AND strip(ISO_code_dest)= '00' THEN DELETE;*ISO_code_dest = '00' for Total/not breakdown, amount= .00000;
	IF strip(country_rank) ne '0' AND '2020502'n <= 0 THEN DELETE;
	IF upcase(strip(ISO_code_dest))= 'X28' THEN DELETE;
    IF strip(country_rank) =  '0' THEN DO;
	ISO_code_dest= NSA;
	country_label= nsa_label;
	END; 
	RUN; 
/*
	DATA test ;

	SET sum_cre_exp_country_weight1;

	IF '2020502'n <= 0;
	RUN;

*/
	/*IDENTIFY BANKS WITH NOT FOREIGN EXPOSURE IN DATA FOR RESPECTIVE PERIOD*/

PROC MEANS DATA = sum_cre_exp_country_weight1 nway noprint;
			CLASS  period_nm nsa name;
			VAR '2020502'n;
			OUTPUT OUT= sum_cre_exp_country_weight_n (DROP = _TYPE_ _FREQ_)   n=n;
RUN;

PROC SORT DATA= sum_cre_exp_country_weight1; BY period_nm nsa name; RUN; 
PROC SORT DATA= sum_cre_exp_country_weight_n ; BY period_nm nsa name; RUN; 

DATA sum_cre_exp_country_weight2; 
MERGE sum_cre_exp_country_weight1 (IN= _a) sum_cre_exp_country_weight_n (IN= _b);
BY period_nm nsa name;

IF _a;

RUN;



PROC SQL;
   
CREATE TABLE sum_cre_exp_country_weight_tot AS
SELECT period_nm, nsa, name, sum('2020502'n) AS Total_Ori_exposure
FROM ( SELECT * FROM  sum_cre_exp_country_weight2 WHERE n > 1 AND country_rank <> '0')
GROUP BY  period_nm, nsa, name;
QUIT;


PROC SORT DATA= sum_cre_exp_country_weight2; BY period_nm nsa name; RUN; 
PROC SORT DATA= sum_cre_exp_country_weight_tot ; BY period_nm nsa name; RUN; 

DATA sum_cre_exp_country_weight3; 
MERGE sum_cre_exp_country_weight2 (IN= _a) sum_cre_exp_country_weight_tot (IN= _b);
BY period_nm nsa name;

IF _a;

IF _a AND NOT _b  AND country_rank = '0' THEN DO;

Total_Ori_exposure= '2020502'n;

END;

IF _a AND  _b  AND country_rank = '0' THEN DELETE;



*IF n > 1 AND country_rank = '0' THEN DELETE;
IF n > 1 THEN DO;
n= n-1; 
END;

RUN;

DATA sum_cre_exp_country_weight4;

SET sum_cre_exp_country_weight3;

*IF Total_Ori_exposure <= 0  AND country_rank = '0' THEN ori_exposure_wg= 1;
IF Total_Ori_exposure <= 0  AND country_rank = '0' THEN DELETE;
ori_exposure_wg='2020502'n/Total_Ori_exposure;
Country_Ori_exposure= '2020502'n;

RUN;


%LET KEEP= 
Period_nm
Name
LEI_Code
NSA
nsa_label
name
SSM
ISO_code_dest
Country_label
Country_rank
n
Country_Ori_exposure
Total_Ori_exposure
ori_exposure_wg

;

%PUT &KEEP.;

DATA cre_exp1_country_weight_SA ;
RETAIN &KEEP.;
SET sum_cre_exp_country_weight4 (KEEP= &KEEP.);

RUN; 


/*SET LIST OF  DESTINATION-COUNTRIES*/

PROC SORT DATA=  cre_exp1_country_weight_SA (KEEP= ISO_code_dest Country_label)  OUT= country1_dest_list_SA NODUPKEY;
BY ISO_code_dest Country_label;
RUN; 

%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=  country1_dest_list_SA OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="country_dest_SA";RUN;


/*IRB*/
options validvarname=any;
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Country
ISO_code_dest
Country_label	
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label	
Status
Status_label	
NACE_codes
NACE_codes_label
Finrep

'2020502'n;

%PUT &KEEP;


	DATA cre_exp_country_weight;
	RETAIN &KEEP.;
	SET EBA.tr_cre_hor (KEEP = &KEEP.) ;

	IF Status='0';
	IF country_rank in('0','1','2','3','4','5','6','7','8','9','10');
	If missing('2020502'n)= 1 THEN DELETE;
	*If portfolio = '1'; /*ONLY STANDARD APPROACH (SA)*/
	If portfolio = '2'; /*ONLY  INTERNAL RATINGS BASED APPROACH(IRB)*/

	RUN; 


	PROC MEANS DATA = cre_exp_country_weight nway noprint;
	CLASS  
/*id*/
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
/*ID_TE*/
Country
ISO_code_dest
Country_label	
Country_rank

/*
Perf_Status
Perf_Status_label

Exposure
Exposure_label
Portfolio
Portfolio_label	

Status
Status_label	
Finrep*/;
	VAR '2020502'n;
	OUTPUT OUT= sum_cre_exp_country_weight (DROP = _TYPE_ _FREQ_)  sum =;
	RUN;



PROC SORT DATA= sum_cre_exp_country_weight; 

BY 
Period_nm
NSA
nsa_label
name
/*ID_TE*/
Country_rank; 

RUN; 



*PROC FREQ DATA= sum_cre_exp_country_weight ;
*TABLE 
/*id*/
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
/*ID_TE*/
Country
ISO_code_dest
Country_label	
Country_rank
/*
Perf_Status
Perf_Status_label

Exposure
Exposure_label
Portfolio
Portfolio_label	

Status
Status_label	
Finrep*/;

*RUN;


*PROC FREQ DATA= sum_cre_exp_country_weight ;
*TABLE 
/*id*/

name*period_nm;

*RUN;

	DATA sum_cre_exp_country_weight1;

	SET sum_cre_exp_country_weight;

	IF strip(country_rank) ne '0' AND strip(ISO_code_dest)= '00' THEN DELETE;*ISO_code_dest = '00' for Total/not breakdown, amount= .00000;
	IF strip(country_rank) ne '0' AND '2020502'n <= 0 THEN DELETE;
	IF upcase(strip(ISO_code_dest))= 'X28' THEN DELETE;
    IF strip(country_rank) =  '0' THEN DO;
	ISO_code_dest= NSA;
	country_label= nsa_label;
	END; 
	RUN; 
/*
	DATA test ;

	SET sum_cre_exp_country_weight1;

	IF '2020502'n <= 0;
	RUN;

*/
	/*IDENTIFY BANKS WITH NOT FOREIGN EXPOSURE IN DATA FOR RESPECTIVE PERIOD*/

PROC MEANS DATA = sum_cre_exp_country_weight1 nway noprint;
			CLASS  period_nm nsa name;
			VAR '2020502'n;
			OUTPUT OUT= sum_cre_exp_country_weight_n (DROP = _TYPE_ _FREQ_)   n=n;
RUN;

PROC SORT DATA= sum_cre_exp_country_weight1; BY period_nm nsa name; RUN; 
PROC SORT DATA= sum_cre_exp_country_weight_n ; BY period_nm nsa name; RUN; 

DATA sum_cre_exp_country_weight2; 
MERGE sum_cre_exp_country_weight1 (IN= _a) sum_cre_exp_country_weight_n (IN= _b);
BY period_nm nsa name;

IF _a;

RUN;



PROC SQL;
   
CREATE TABLE sum_cre_exp_country_weight_tot AS
SELECT period_nm, nsa, name, sum('2020502'n) AS Total_Ori_exposure
FROM ( SELECT * FROM  sum_cre_exp_country_weight2 WHERE n > 1 AND country_rank <> '0')
GROUP BY  period_nm, nsa, name;
QUIT;


PROC SORT DATA= sum_cre_exp_country_weight2; BY period_nm nsa name; RUN; 
PROC SORT DATA= sum_cre_exp_country_weight_tot ; BY period_nm nsa name; RUN; 

DATA sum_cre_exp_country_weight3;
MERGE sum_cre_exp_country_weight2 (IN= _a) sum_cre_exp_country_weight_tot (IN= _b);
BY period_nm nsa name;

IF _a;

IF _a AND NOT _b  AND country_rank = '0' THEN DO;

Total_Ori_exposure= '2020502'n;

END;

IF _a AND  _b  AND country_rank = '0' THEN DELETE;

*IF n > 1 AND country_rank = '0' THEN DELETE;
IF n > 1 THEN DO;
n= n-1; 
END;

RUN;

DATA sum_cre_exp_country_weight4;

SET sum_cre_exp_country_weight3;

*IF Total_Ori_exposure <= 0  AND country_rank = '0' THEN ori_exposure_wg= 1;
IF Total_Ori_exposure <= 0  AND country_rank = '0' THEN DELETE;
ori_exposure_wg='2020502'n/Total_Ori_exposure;
Country_Ori_exposure= '2020502'n;

RUN;


%LET KEEP= 
Period_nm
Name
LEI_Code
NSA
nsa_label
name
SSM
ISO_code_dest
Country_label
Country_rank
n
Country_Ori_exposure
Total_Ori_exposure
ori_exposure_wg

;

%PUT &KEEP.;

DATA cre_exp1_country_weight_IRB ;
RETAIN &KEEP.;
SET sum_cre_exp_country_weight4 (KEEP= &KEEP.);

RUN; 


/*SET LIST OF  DESTINATION-COUNTRIES*/

PROC SORT DATA=  cre_exp1_country_weight_IRB (KEEP= ISO_code_dest Country_label)  OUT= country1_dest_list_IRB NODUPKEY;
BY ISO_code_dest Country_label;
RUN; 

%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=  country1_dest_list_IRB OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="country_dest_IRB";RUN;


/*ISA AND IRB*/
options validvarname=any;
%LET KEEP= 
id
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
ID_TE
Country
ISO_code_dest
Country_label	
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label	
Status
Status_label	
NACE_codes
NACE_codes_label
Finrep

'2020502'n;

%PUT &KEEP;




	DATA cre_exp_country_weight;
	RETAIN &KEEP.;
	SET EBA.tr_cre_hor (KEEP = &KEEP.) ;

	IF Status='0';
	IF country_rank in('0','1','2','3','4','5','6','7','8','9','10');
	If missing('2020502'n)= 1 THEN DELETE;

	IF portfolio= '1' OR portfolio = '2';
	*If portfolio = '1'; /*ONLY STANDARD APPROACH (SA)*/
	*If portfolio = '2'; /*ONLY  INTERNAL RATINGS BASED APPROACH(IRB)*/

	RUN; 


	PROC MEANS DATA = cre_exp_country_weight nway noprint;
	CLASS  
/*id*/
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
/*ID_TE*/
Country
ISO_code_dest
Country_label	
Country_rank

/*
Perf_Status
Perf_Status_label

Exposure
Exposure_label
Portfolio
Portfolio_label	

Status
Status_label	
Finrep*/;
	VAR '2020502'n;
	OUTPUT OUT= sum_cre_exp_country_weight (DROP = _TYPE_ _FREQ_)  sum =;
	RUN;



PROC SORT DATA= sum_cre_exp_country_weight; 

BY 
Period_nm
NSA
nsa_label
name
/*ID_TE*/
Country_rank; 

RUN; 



*PROC FREQ DATA= sum_cre_exp_country_weight ;
*TABLE 
/*id*/
Period_nm
NSA
nsa_label
LEI_Code 
name
SSM	
/*ID_TE*/
Country
ISO_code_dest
Country_label	
Country_rank
/*
Perf_Status
Perf_Status_label

Exposure
Exposure_label
Portfolio
Portfolio_label	

Status
Status_label	
Finrep*/;

*RUN;


*PROC FREQ DATA= sum_cre_exp_country_weight ;
*TABLE 
/*id*/

name*period_nm;

*RUN;

	DATA sum_cre_exp_country_weight1;

	SET sum_cre_exp_country_weight;

	IF strip(country_rank) ne '0' AND strip(ISO_code_dest)= '00' THEN DELETE;*ISO_code_dest = '00' for Total/not breakdown, amount= .00000;
	IF strip(country_rank) ne '0' AND '2020502'n <= 0 THEN DELETE;
	IF upcase(strip(ISO_code_dest))= 'X28' THEN DELETE;
    IF strip(country_rank) =  '0' THEN DO;
	ISO_code_dest= NSA;
	country_label= nsa_label;
	END; 
	RUN; 
/*
	DATA test ;

	SET sum_cre_exp_country_weight1;

	IF '2020502'n <= 0;
	RUN;

*/
	/*IDENTIFY BANKS WITH NOT FOREIGN EXPOSURE IN DATA FOR RESPECTIVE PERIOD*/

PROC MEANS DATA = sum_cre_exp_country_weight1 nway noprint;
			CLASS  period_nm nsa name;
			VAR '2020502'n;
			OUTPUT OUT= sum_cre_exp_country_weight_n (DROP = _TYPE_ _FREQ_)   n=n;
RUN;

PROC SORT DATA= sum_cre_exp_country_weight1; BY period_nm nsa name; RUN; 
PROC SORT DATA= sum_cre_exp_country_weight_n ; BY period_nm nsa name; RUN; 

DATA sum_cre_exp_country_weight2; 
MERGE sum_cre_exp_country_weight1 (IN= _a) sum_cre_exp_country_weight_n (IN= _b);
BY period_nm nsa name;

IF _a;

RUN;



PROC SQL;
   
CREATE TABLE sum_cre_exp_country_weight_tot AS
SELECT period_nm, nsa, name, sum('2020502'n) AS Total_Ori_exposure
FROM ( SELECT * FROM  sum_cre_exp_country_weight2 WHERE n > 1 AND country_rank <> '0')
GROUP BY  period_nm, nsa, name;
QUIT;


PROC SORT DATA= sum_cre_exp_country_weight2; BY period_nm nsa name; RUN; 
PROC SORT DATA= sum_cre_exp_country_weight_tot ; BY period_nm nsa name; RUN; 

DATA sum_cre_exp_country_weight3; 
MERGE sum_cre_exp_country_weight2 (IN= _a) sum_cre_exp_country_weight_tot (IN= _b);
BY period_nm nsa name;

IF _a;

IF _a AND NOT _b  AND country_rank = '0' THEN DO;

Total_Ori_exposure= '2020502'n;

END;

IF _a AND  _b  AND country_rank = '0' THEN DELETE;

*IF n > 1 AND country_rank = '0' THEN DELETE;
IF n > 1 THEN DO;
n= n-1; 
END;

RUN;

DATA sum_cre_exp_country_weight4;

SET sum_cre_exp_country_weight3;

*IF Total_Ori_exposure <= 0  AND country_rank = '0' THEN ori_exposure_wg= 1;
IF Total_Ori_exposure <= 0  AND country_rank = '0' THEN DELETE;
ori_exposure_wg='2020502'n/Total_Ori_exposure;
Country_Ori_exposure= '2020502'n;



RUN;


%LET KEEP= 
Period_nm
Name
LEI_Code
NSA
nsa_label
name
SSM
ISO_code_dest
Country_label
Country_rank
n
Country_Ori_exposure
Total_Ori_exposure
ori_exposure_wg

;

%PUT &KEEP.;

DATA cre_exp1_country_wgt_SAIRB ;
RETAIN &KEEP.;
SET sum_cre_exp_country_weight4 (KEEP= &KEEP.);

RUN; 


/*SET LIST OF  DESTINATION-COUNTRIES*/

PROC SORT DATA=  cre_exp1_country_wgt_SAIRB (KEEP= ISO_code_dest Country_label)  OUT= country1_dest_list_SAIRB NODUPKEY;
BY ISO_code_dest Country_label;
RUN; 


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=  country1_dest_list_SAIRB OUTFILE="&xls_dir./Metadata_sas.xlsx" DBMS= XLSX REPLACE; SHEET="cntry_dest_SAIRB";RUN;




Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

DATA  cre_exp1_country_weight_SA;
SET   cre_exp1_country_weight_SA ;

RENAME 
Country_Ori_exposure= Country_Ori_exp_SA
Total_Ori_exposure= Total_Ori_exp_SA 
ori_exposure_wg= ori_exp_wg_SA
; 
RUN; 

DATA cre_exp1_country_weight_IRB;
SET  cre_exp1_country_weight_IRB;

RENAME 
Country_Ori_exposure= Country_Ori_exp_IRB 
Total_Ori_exposure= Total_Ori_exp_IRB 
ori_exposure_wg= ori_exp_wg_IRB 
; 
RUN;
 
DATA cre_exp1_country_wgt_SAIRB;
SET  cre_exp1_country_wgt_SAIRB;

RENAME 
Country_Ori_exposure= Country_Ori_exp_SAIRB 
Total_Ori_exposure= Total_Ori_exp_SAIRB 
ori_exposure_wg= ori_exp_wg_SAIRB 
; 
RUN; 


Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';

PROC SORT DATA= cre_exp1_country_wgt_SAIRB; BY 
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
Country_label
Country_rank
n
; RUN; 
PROC SORT DATA= cre_exp1_country_weight_IRB; BY
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
Country_label
Country_rank
n
; RUN; 
PROC SORT DATA= cre_exp1_country_weight_SA; BY
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
Country_label
Country_rank
n
; RUN; 

DATA cre_exp_country_weight_all; *INCLUDED ALL COUNTRIES OF DESTINATION;

MERGE cre_exp1_country_wgt_SAIRB (IN= _a) cre_exp1_country_weight_IRB (IN =_b) cre_exp1_country_weight_SA (IN= _c) ; 
BY
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
Country_label
Country_rank
n
; 

IF _a;

/*
IF missing(Country_Ori_exp_SA)=1 AND missing(Country_Ori_exp_IRB)=0  THEN DO;*Standard Approach as default, if missing then IRB is used;
Country_Ori_exp= Country_Ori_exp_IRB;
Total_Ori_exp=  Total_Ori_exp_IRB;
ori_exp_wg= ori_exp_wg_IRB;
END;
ELSE DO;
Country_Ori_exp= Country_Ori_exp_SA;
Total_Ori_exp=  Total_Ori_exp_SA;
ori_exp_wg= ori_exp_wg_SA;
END;

*/


IF missing(Country_Ori_exp_SA)=0 AND missing(Country_Ori_exp_IRB)=1  THEN DO;*IRB Approach as default, if missing then SA is used;
Country_Ori_exp= Country_Ori_exp_SA;
Total_Ori_exp=  Total_Ori_exp_SA;
ori_exp_wg= ori_exp_wg_SA;
END;
ELSE DO;
Country_Ori_exp= Country_Ori_exp_IRB;
Total_Ori_exp=  Total_Ori_exp_IRB;
ori_exp_wg= ori_exp_wg_IRB;
END;

IF missing(Country_Ori_exp_SA)=1 AND missing(Country_Ori_exp_IRB)=1   AND missing(Country_Ori_exp_SAIRB)= 0 THEN DO;*IF IRB and SA are missing then SAIRB is used;
Country_Ori_exp= Country_Ori_exp_SAIRB;
Total_Ori_exp=  Total_Ori_exp_SAIRB;
ori_exp_wg= ori_exp_wg_SAIRB;
END;


RUN;



/*MISSING*/
/*
DATA EBA.cre_exp1_country_weight_missing;
SET EBA.cre_exp1_country_weight_all;

IF missing(ori_exp_wg)=1;
RUN; 
*/

/*STATES TO EXCLUDE COUNTRY EXPOSURES FROM COUNTRIES WITH NOT MACRO DATA AVAILABLE*/

%LET KEEP= 
	Name
	Period_nm
	Name
	LEI_Code
	NSA
	nsa_label
	SSM
	ISO_code_dest
	Country_label
	Country_Ori_exp_SAIRB
	Country_Ori_exp_IRB
	Country_Ori_exp_SA
	Country_Ori_exp
; 


/*
NOTE:
ISO_code_dest	Country_label
VG	VIRGIN ISLANDS, BRITISH
MH	Marshall Islands
KY	Cayman Islands
CK	Cook Islands
BM	Bermuda
VI	VIRGIN ISLANDS, U.S.
GG	GUERNSEY
BZ	Belize
JE	JERSEY
*/


DATA  cre_exp1_country_weight_excl ;

SET  cre_exp_country_weight_all (KEEP= &KEEP.);

IF strip(ISO_code_dest) in
('VG',
'MH',
'KY',
'CK',
'BM',
'VI',
'GG',
'BZ',
'JE')
 THEN DELETE;

RUN;

PROC SQL;
CREATE TABLE cre_exp2_country_weight_excl AS
SELECT
	Name,
	Period_nm,
	LEI_Code,
	NSA,
	nsa_label,
	SSM,
	ISO_code_dest,
	Country_label,

	Country_Ori_exp_SAIRB,
	Country_Ori_exp_IRB,
	Country_Ori_exp_SA,
	Country_Ori_exp,

 sum(Country_Ori_exp_SAIRB) AS Total_Ori_exp_SAIRB,
 sum(Country_Ori_exp_IRB) AS Total_Ori_exp_IRB,
 sum(Country_Ori_exp_SA) AS Total_Ori_exp_SA,
 sum(Country_Ori_exp) AS Total_Ori_exp
FROM cre_exp1_country_weight_excl 
GROUP BY
	Name,
	Period_nm,
	LEI_Code,
	NSA,
	nsa_label
;
QUIT;

DATA cre_exp3_country_weight_excl;

SET cre_exp2_country_weight_excl;

ori_exp_wg_SAIRB= Country_Ori_exp_SAIRB/Total_Ori_exp_SAIRB;

ori_exp_wg_IRB= 	Country_Ori_exp_IRB/Total_Ori_exp_IRB;

ori_exp_wg_SA= Country_Ori_exp_SA/Total_Ori_exp_SA; 

ori_exp_wg= 	Country_Ori_exp/Total_Ori_exp ;

RUN;


%LET KEEP=
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
Country_label 
Country_Ori_exp_SAIRB
Country_Ori_exp_IRB
Country_Ori_exp_SA
Country_Ori_exp
Total_Ori_exp_SAIRB
Total_Ori_exp_IRB
Total_Ori_exp_SA
Total_Ori_exp
ori_exp_wg_SAIRB
ori_exp_wg_IRB
ori_exp_wg_SA
ori_exp_wg

;

%PUT &KEEP.;

DATA cre_exp_country_weight_excl;
RETAIN &KEEP.;
SET cre_exp3_country_weight_excl (KEEP= &KEEP.);

RUN; 



%LET path= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB;

%LET xls_temp = &path./xlsx;
%PUT &xls_temp;

PROC IMPORT	datafile = "&xls_temp./ISO_Codes.xlsx"  DBMS = XLSX OUT= ISO_codes

replace;

SHEET= "ISO_codes";

getnames = Yes;

RUN;

DATA ISO_codes1 (KEEP= ISO_code_dest ISO_code3_dest Country );

Length  ISO_code_dest $3.;
Format ISO_code_dest $3.;
Informat ISO_code_dest  $3.; 

Length  ISO_code3_dest $3.;
Format ISO_code3_dest $3.;
Informat ISO_code3_dest $3.; 

SET ISO_codes;

ISO_code_dest= Alpha_2_code;
ISO_code3_dest= Alpha_3_code;

RUN; 


PROC SORT DATA= ISO_codes1; BY ISO_code_dest; RUN; 

PROC SORT DATA=  cre_exp_country_weight_all ; BY ISO_code_dest; RUN; 

PROC SORT DATA=  cre_exp_country_weight_excl ; BY ISO_code_dest; RUN; 

DATA cre_exp_country_weight_all_1 ;

MERGE  cre_exp_country_weight_all (IN= _a) ISO_codes1 (IN= _b KEEP= ISO_code_dest ISO_code3_dest) ;
BY ISO_code_dest;

RUN; 

PROC SORT DATA= cre_exp_country_weight_all_1  NODUPKEY; BY
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
Country_label
;
RUN;

DATA EBA.cre_exp_country_weight_all;

SET cre_exp_country_weight_all_1;

IF missing(period_nm)= 1 OR missing(Name) = 1 THEN DELETE;

RUN; 

DATA cre_exp_country_weight_excl_1;

MERGE  cre_exp_country_weight_excl(IN= _a) ISO_codes1(IN= _b KEEP= ISO_code_dest ISO_code3_dest) ; ;
BY ISO_code_dest;


RUN; 



PROC SORT DATA= cre_exp_country_weight_excl_1 NODUPKEY; BY
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
Country_label
;
RUN;

DATA  EBA.cre_exp_country_weight_excl;

SET cre_exp_country_weight_excl_1;

IF missing(period_nm)= 1 OR missing(Name) = 1 THEN DELETE;

RUN; 


%LET KEEP=
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label
Country_Ori_exp_SAIRB
Country_Ori_exp_IRB
Country_Ori_exp_SA
Country_Ori_exp
Total_Ori_exp_SAIRB
Total_Ori_exp_IRB
Total_Ori_exp_SA
Total_Ori_exp
ori_exp_wg_SAIRB
ori_exp_wg_IRB
ori_exp_wg_SA
ori_exp_wg

;

%PUT &KEEP.;

DATA EBA.cre_exp_country_weight_excl;
RETAIN &KEEP.;
SET EBA.cre_exp_country_weight_excl (KEEP= &KEEP.);

RUN; 


/*
NOTE:
EBA.cre_exp1_country_weight_all -> ALL COUNTRIES OF DESTINATION ARE INCLUDED
EBA.cre_exp3_country_weight_excl-> EXCLUDING COUNTRIES OF DESTINATION WITH NOT MACRO DATA AVAILABLE
*/

/*EXPORT WEIGHTS*/

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=   EBA.cre_exp_country_weight_all OUTFILE="&xls_dir./country_weights.xlsx" DBMS= XLSX REPLACE; SHEET="cntry_wgt";RUN;

PROC EXPORT DATA=   EBA.cre_exp_country_weight_excl OUTFILE="&xls_dir./country_weights_excl.xlsx" DBMS= XLSX REPLACE; SHEET="cntry_wgt";RUN;


Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';


%macro get_filenames(location,regex,filestable);
	filename _dir_ "%bquote(&location.)";
data &filestable._&regex. (keep=fname);
	handle=dopen( '_dir_' );
	if handle > 0 then do;
		count=dnum(handle);
		do i=1 to count;
			fname=dread(handle,i);

			/*
			date_1= strip(prxchange('s/(\D*)(\d*)(\D*)/$2/i',-1,fname));
			year= input(substr(date_1,1,4),4.);
			Month=input(substr(date_1,5,6),2.);
			day=  input(substr(date_1,7,8),2.);
			date_f= mdy(Month,day,year)*1 ; format date_f date9.;
			*/

			patternID = prxparse('m/' || "&regex." || '/i');
			position = input(prxmatch(patternID, fname) - 1, best32.);
			fname = strip("&location." || fname);
			
			if position ne -1 /*and date_f >= &Start_date. */ then do;*;
				output &filestable._&regex. ;
			end;
			%PUT &filestable.;
		end;
	end;
	rc=dclose(handle);


run;


PROC SORT data= &filestable._&regex. ; by descending fname; run;


filename _dir_ clear;
 
DATA &filestable._&regex. (DROP= t3);

SET &filestable._&regex.;

 t3= strip(prxmatch('/\$/i',	fname ));

IF t3 > 0 THEN DELETE;



RUN;

DATA  Macrdata.&filestable._&regex. ;

SET &filestable._&regex. ;


if _n_=1 then do;

retain re_dec;
*retain re_dec2;
*retain re_ndec;

re_dec = prxparse('/\/([^\/]*)\.xlsx/i');
*re_dec2 = prxparse('/\\\w+\./i');
*re_ndec = prxparse('/((\d+)(\.)?\d+)+/i');

end;

call prxsubstr(re_dec,fname,re_start_1,re_end_1);
name_file = substrn(fname, re_start_1, re_end_1);
name_file= prxchange('s/(\/)|(.xlsx)//',-1,strip(name_file));

*call prxsubstr(re_dec2,name_file,re_start_2,re_end_2);

*name_file2= substrn(name_file, re_start_2, re_end_2);


RUN; 

%mend;


%LET folder= World_Bank;
%LET path= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx/Macro_data;

%LET xls_temp = &path./&folder./;
%PUT &xls_temp;

%LET location= &xls_temp.;
%LET regex= xlsx;
%PUT &location. &regex.;




*%LET output= "WorldBank_Data";

%get_filenames(location=&location, regex=&regex, filestable=&folder.);


/* Import the Excel sheets that are located in the filestable_regex table with the given sheet. */


%macro import_excel_1(filestable, regex);
	%local nobs iter;
	proc sql noprint;
		select count(*) into : nobs
	from &filestable._&regex. ;
	quit;

	%let iter=1;

DATA macrdata.&folder._all;

LENGTH 
'Country Name'n $52
'Country Code'n $3
'Indicator Name'n $70
'Indicator Code'n $17
'2014'n-'2019'n 8;
FORMAT
'Country Name'n $52.
'Country Code'n $3.
'Indicator Name'n $70.
'Indicator Code'n $17.
'2014'n-'2019'n Best.;

CALL missing(of _all_);
 if _N_ = 0 THEN OUTPUT;

RUN;

	%do %while (&iter. <= &nobs.);



		data _NULL_;
			set &filestable._&regex.  (firstobs=&iter. obs=&iter.);
			call symput("fname", fname);
			*call symput("output", substrn(name_file,1,6));
			call symput("output", "&folder.");
		run;

		PROC IMPORT	datafile = "&fname."  DBMS = xlsx OUT= &output._&iter.
			
			
		replace;
			
		getnames = YES;
		range="Data$A4:0";
		RUN;

		proc append base = macrdata.&folder._all data= &output._&iter. FORCE;quit;

		%let iter=%eval(&iter.+1);
	%end;

	
%mend;


%import_excel_1(filestable=&folder., regex=&regex);

PROC FREQ DATA=  macrdata.&folder._all ;
TABLE 'Indicator Name'n;
RUN; 


%LET folder= IMF;
%LET path= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx/Macro_data;

%LET xls_temp = &path./&folder./;
%PUT &xls_temp;

%LET location= &xls_temp.;
%LET regex= xlsx;
%PUT &location. &regex.;


*%LET output= "WorldBank_Data";

%get_filenames(location=&location, regex=&regex, filestable=&folder.);



/* Import the Excel sheets that are located in the filestable_regex table with the given sheet. */

%macro import_excel_2(filestable, regex);
	%local nobs iter;
	proc sql noprint;
		select count(*) into : nobs
	from &filestable._&regex. ;
	quit;

	%let iter=1;

		DATA macrdata.&folder._all;

		LENGTH 
		'ISO'n $3
		'Country'n $32
		'Subject Descriptor'n $75
		'Units'n $28		
		'Country/Series-specific Notes'n $900
		'2014'n-'2019'n $20;
		FORMAT
		'ISO'n $3.
		'Country'n $32.
		'Subject Descriptor'n $75.
		'Units'n $28.		
		'Country/Series-specific Notes'n $900.
		'2014'n-'2019'n $20.;

		CALL missing(of _all_);
		if _N_ = 0 THEN OUTPUT;

		RUN;


	%do %while (&iter. <= &nobs.);



		data _NULL_;
			set &filestable._&regex.  (firstobs=&iter. obs=&iter.);
			call symput("fname", fname);
			*call symput("output", substrn(name_file,1,6));
			call symput("output", "&folder.");
		run;

		PROC IMPORT	datafile = "&fname."  DBMS = xlsx OUT= &output._&iter.
			
			
		replace;
			
		getnames = YES;
		*range="Data$A4:0";
		RUN;


	proc append base = macrdata.&folder._all data= &output._&iter. FORCE;quit;
	
		%let iter=%eval(&iter.+1);
	%end;




%mend;


%import_excel_2(filestable=&folder., regex=&regex);

PROC FREQ DATA=  macrdata.&folder._all ;
TABLE 'Subject Descriptor'n;
RUN; 


proc contents
	data = macrdata.&folder._all
	out = vars2 (keep = name type length)
	noprint;

	run;

proc sql noprint;
     * create macro list of the numeric variables' names;
     select cats("'" ,name,"'n")
     into :numerics
          separated by ' '
     from vars2
     where  type= 2  AND length = 20;

	  * create macro list of the numeric variables' names with the suffix "C";
     select cats("'" ,trim(name),'C',"'n")
     into :characters
          separated by ' '
     from vars2
    where  type= 2  AND length = 20;

     * create macro list of the conversion from the original name to the new name with the suffix "C";
     select cats("'" ,name,"'n", ' = ' ,"'" ,trim(name),'C',"'n")
     into :conversions
          separated by ' '
     from vars2
    where  type= 2  AND length = 20;
quit;


	 %put &numerics. &characters &conversions;

	 * use the macro list "&conversions" to add the suffix "C" to the numeric variables' names;
		proc datasets 
		library = macrdata 
		nolist;
		modify &folder._all;
		rename &conversions;
		quit;


		* some of the character variables in "basketball1" are character, but should actually be numeric;
* let's convert them into numeric format;
data macrdata.&folder._all;
     set macrdata.&folder._all;

     array nums[*] &numerics;
     array chars[*] &characters;

     do i = 1 to dim(nums);
          nums[i] = input(chars[i], 8.);
     end;

     drop i &characters;

	 IF missing('country'n)= 1 THEN DELETE;
run;





/*
*input(char_var, 8.);
proc datasets library= Macrdata  memtype=data;	
run;

*/



%LET folder= World_Justice_Project;
%LET path= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx/Macro_data;

%LET xls_temp = &path./&folder./;
%PUT &xls_temp;

%LET location= &xls_temp.;
%LET regex= xlsx;
%PUT &location. &regex.;



*%LET output= "WorldBank_Data";

%get_filenames(location=&location, regex=&regex, filestable=&folder.);


*https://www.listendata.com/2015/08/sas-proc-transpose-explained.html;
Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';


%LET folder= World_Bank;
%LET path= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx/Macro_data;

%LET xls_temp = &path./&folder./;
%PUT &xls_temp;

%LET location= &xls_temp.;
%LET regex= xlsx;
%PUT &location. &regex.;



%LET exclude= '2014'n-'2019'n ; 
%put &exclude;

proc contents data = macrdata.&folder._all  (Drop= &exclude. ) out = varname1 (keep = name) noprint;
run;

proc sql noprint;
select cats("'",name,"'n") into :textlist1 separated by " " from varname1;
quit;

%put &textlist1.;	

PROC SORT DATA= macrdata.&folder._all;
BY 	&textlist1.;
RUN;

	proc transpose data= macrdata.&folder._all out= macrdata.&folder._all_ver (RENAME=(Col1=Value _Name_= Year));
	   by 
	&textlist1.;
	run;

	PROC SORT DATA= macrdata.&folder._all_ver ; BY 	&textlist1. year descending value; RUN; 
	PROC SORT DATA= macrdata.&folder._all_ver NODUPKEY ; BY 	&textlist1. year ; RUN; 

	%LET exclude2= 'Indicator Code'n   Value ;
	%LET exclude3= 'Indicator Name'n; 
	%put &exclude2 &exclude3 ;

	proc contents data = macrdata.&folder._all_ver  (Drop= &exclude2. &exclude3.) out = varname2 (keep = name) noprint;
	run;

	proc sql noprint;
	select cats("'",name,"'n") into :textlist2 separated by " " from varname2;
	quit;
	%put &textlist2.;	

	PROC SORT DATA= macrdata.&folder._all_ver ;
	BY 	&textlist2.;
	RUN;

	PROC TRANSPOSE DATA= macrdata.&folder._all_ver (DROP=&exclude3.)

	OUT= &folder._all_hor;
	BY   
	&textlist2.;
	VAR Value;
	ID 'Indicator Code'n;
	RUN;

	PROC SORT DATA= macrdata.&folder._all_ver (Keep= 'Indicator Code'n 'Indicator Name'n) Out= macrdata.&folder._all_map Nodupkey;
	BY  'Indicator Code'n 'Indicator Name'n	;
	RUN;


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

	PROC EXPORT DATA=  macrdata.&folder._all_map  OUTFILE="&xls_dir./&folder._all_map.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;



	
	DATA Recovery_data 
	(KEEP=
	'Country Code'n
	'Country Name'n
	 year 
	'RESLV.ISV.DFRN.RC'n
	'RESLV.ISV.RCOV.RT'n
);

	SET &folder._all_hor;

	IF 'Country Name'n = "Côte d'Ivoire" THEN 'Country Name'n = "Cote d'Ivoire" ;

	miss= input(cats('RESLV.ISV.DFRN.RC'n,'RESLV.ISV.RCOV.RT'n),10.);*ERROR HERE IT DELETe TOO MANY ENTRIES;
	IF miss <= 0 then delete;

	RUN ;
  

DATA &folder._all_hor 
(DROP= 
'RESLV.ISV.DFRN.RC'n
'RESLV.ISV.RCOV.RT'n);

SET &folder._all_hor;

IF 'Country Name'n = "Côte d'Ivoire" THEN DELETE;
IF 'Country Name'n = "Hong Kong, China" THEN DELETE;

IF 'Country Name'n = "Hong Kong SAR, China" THEN 'Country Name'n = "Hong Kong, China" ;

RUN; 

PROC SORT DATA= &folder._all_hor ; BY 'Country Code'n 'Country Name'n year; RUN; 

PROC SORT DATA= Recovery_data; BY 'Country Code'n 'Country Name'n year; RUN; 

DATA &folder._all_hor;
MERGE &folder._all_hor (IN= a) Recovery_data (IN= b);
BY 'Country Code'n 'Country Name'n year;
IF a;
RUN; 


DATA macrdata.&folder._all_hor;

SET &folder._all_hor;

IF strip('Country Code'n) = 'RUS' and strip('Country Name'n) ne 'Russian Federation' THEN DELETE;
IF strip('Country Code'n)= 'BRA' and strip('Country Name'n) ne 'Brazil' THEN DELETE;*;
IF strip('Country Code'n) = 'CHN' and strip('Country Name'n)ne 'China' THEN DELETE;*;
IF strip('Country Code'n) = 'USA' and strip('Country Name'n) ne 'United States' THEN DELETE;
IF strip('Country Code'n) = 'BGD' and strip('Country Name'n) ne 'Bangladesh' THEN DELETE;*;
IF strip('Country Code'n) = 'IDN' and strip('Country Name'n) ne 'Indonesia' THEN DELETE;*;
IF strip('Country Code'n) = 'IND' and strip('Country Name'n) ne 'India' THEN DELETE;*;
IF strip('Country Code'n) = 'JPN' and strip('Country Name'n) ne 'Japan' THEN DELETE;*;
IF strip('Country Code'n) = 'MEX' and strip('Country Name'n) ne 'Mexico' THEN DELETE;*;
IF strip('Country Code'n) = 'NGA' and strip('Country Name'n) ne 'Nigeria' THEN DELETE;*;
IF strip('Country Code'n) = 'PAK' and strip('Country Name'n) ne 'Pakistan' THEN DELETE;*;
IF strip('Country Code'n) = 'STP' and strip('Country Name'n) ne 'Sao Tome and Principe' THEN DELETE;*;

RUN; 

PROC FREQ DATA= macrdata.&folder._all_hor;
TABLE 'Country code'n;
RUN;

*CIV	Cote d'Ivoire
HKG	Hong Kong SAR, China
see Taiwan as well-missing data.
;

%LET folder= IMF;
%LET path= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx/Macro_data;

%LET xls_temp = &path./&folder./;
%PUT &xls_temp;

%LET location= &xls_temp.;
%LET regex= xlsx;
%PUT &location. &regex.;


%LET exclude= '2014'n-'2019'n ; 
%put &exclude;

proc contents data = macrdata.&folder._all  (Drop= &exclude. ) out = varname1 (keep = name) noprint;
run;

proc sql noprint;
select cats("'",name,"'n") into :textlist1 separated by " " from varname1;
quit;

%put &textlist1.;	

PROC SORT DATA= macrdata.&folder._all;
BY 	&textlist1.;
RUN;

proc transpose data= macrdata.&folder._all out= macrdata.&folder._all_ver (RENAME=(Col1=Value _Name_= Year));
   by 

&textlist1.;

run;

PROC SORT DATA= macrdata.&folder._all_ver ; BY 	&textlist1. year descending value; RUN; 
PROC SORT DATA= macrdata.&folder._all_ver NODUPKEY ; BY 	&textlist1. year ; RUN; 

%LET exclude2= 'Subject Descriptor'n   Value ;
	%LET exclude3= 'Units'n 'Country/Series-specific Notes'n; 
	%put &exclude2 &exclude3 ;

	proc contents data = macrdata.&folder._all_ver  (Drop= &exclude2. &exclude3.) out = varname2 (keep = name) noprint;
	run;

	proc sql noprint;
	select cats("'",name,"'n") into :textlist2 separated by " " from varname2;
	quit;
	%put &textlist2.;	

	PROC SORT DATA= macrdata.&folder._all_ver ;
	BY 	&textlist2.;
	RUN;

	PROC TRANSPOSE DATA= macrdata.&folder._all_ver (DROP=&exclude3.)

	OUT= macrdata.&folder._all_hor;
	BY   
	&textlist2.;
	VAR Value;
	ID 'Subject Descriptor'n;
	RUN;

	PROC SORT DATA= macrdata.&folder._all_ver (Keep= 'Subject Descriptor'n 'Units'n 'Country/Series-specific Notes'n ) Out= macrdata.&folder._all_map Nodupkey;
	BY  'Subject Descriptor'n 'Units'n 'Country/Series-specific Notes'n	;
	RUN;

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';


PROC FREQ DATA= EBA.CRE_EXP_COUNTRY_WEIGHT_EXCL; TABLE period_nm; RUN; 

%LET year_beg= 2014;
%LET year_end= 2019;

DATA COUNTRY_WEIGHT_Anal;

SET EBA.CRE_EXP_COUNTRY_WEIGHT_EXCL;

Year= year(period_nm) ;
IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;

RUN; 

PROC FREQ DATA= COUNTRY_WEIGHT_Anal; TABLE period_nm year; RUN; 


%LET KEEP=
Year
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label
ori_exp_wg;

%PUT &KEEP.;

DATA COUNTRY_WEIGHT_Anal_1 (drop=year);
RETAIN &KEEP.;
SET COUNTRY_WEIGHT_Anal (KEEP= &KEEP.);
YearC=put(year,$8.);
*Rename YearC=year;

RUN; 

DATA COUNTRY_WEIGHT_Anal_2 (DROP= yearC);
SET COUNTRY_WEIGHT_Anal_1;
year=strip(yearC);
ISO_code3_dest=strip(ISO_code3_dest);

RUN; 


PROC SQL;
CREATE TABLE COUNTRY_WEIGHT_Anal_3 AS
SELECT
a.*,
b.year As year_b,
b.'Country Code'n,
b.'FP.CPI.TOTL.ZG'n,
b.'FR.INR.RINR'n,
b.'IC.ISV.DURS'n,
b.'IC.LGL.CRED.XQ'n,
b.'NY.GDP.MKTP.KD.ZG'n,
b.'NY.GDP.PCAP.CD'n,
b.'NY.GDP.PCAP.KD.ZG'n,
b.'NY.GDP.PCAP.PP.CD'n,
b.'NY.GDP.PCAP.PP.KD'n,
b.'NY.TTF.GNFS.KN'n,
b.'TT.PRI.MRCH.XD.WD'n,
b.'RESLV.ISV.DFRN.RC'n,
b.'RESLV.ISV.RCOV.RT'n,
c.year as year_c,
c.ISO,
c.'Unemployment rate'n,
c.'General government net lending/b'n,
c.'Inflation, average consumer pric'n,
c.'Inflation, end of period consume'n,
c.'Current account balance'n

FROM COUNTRY_WEIGHT_Anal_2  AS a
	LEFT JOIN macrdata.WORLD_BANK_ALL_HOR  AS b
	ON a.Year =b.Year AND a.ISO_code3_dest=b.'Country Code'n
		LEFT JOIN macrdata.IMF_ALL_HOR AS c
		ON a.Year=c.Year AND a.ISO_code3_dest=c.ISO;

QUIT; 

PROC SORT DATA= COUNTRY_WEIGHT_Anal_2  OUT= COUNTRY_WEIGHT_mg; BY YEAR ISO_code3_dest; RUN;

PROC SORT DATA= macrdata.WORLD_BANK_ALL_HOR OUT= WORLD_BANK_ALL_mg (RENAME=('Country Code'n= ISO_code3_dest)); BY YEAR  'Country Code'n; RUN;

*PROC SORT DATA= WORLD_BANK_ALL_mg  ; *BY year ISO_code3_dest Descending 'FP.CPI.TOTL.ZG'n-'RESLV.ISV.RCOV.RT'n;* RUN; 

PROC SORT DATA= WORLD_BANK_ALL_mg (KEEP= ISO_code3_dest 'Country Name'n)   OUT= woldbank_countries nodupkey; BY ISO_code3_dest 'Country Name'n ; RUN; 



PROC SORT DATA= macrdata.IMF_ALL_HOR OUT= IMF_ALL_mg (RENAME=(ISO = ISO_code3_dest)); BY YEAR ISO; RUN;

DATA COUNTRY_WEIGHT_Anal_3_1 missing_worldbank missing_IMF ;
MERGE COUNTRY_WEIGHT_mg(IN=_A) WORLD_BANK_ALL_mg(IN=_B) IMF_ALL_mg (IN=_C);
BY YEAR ISO_code3_dest;
IF _A THEN OUTPUT COUNTRY_WEIGHT_Anal_3_1; 
IF _A AND NOT _B THEN OUTPUT missing_worldbank;
IF _A AND NOT _C THEN OUTPUT missing_IMF;
RUN;




PROC SORT DATA=  COUNTRY_WEIGHT_Anal_3_1 OUT= macrdata.COUNTRY_MACRO_WEIGHT_Data NODUPKEY; BY period_nm LEI_code ISO_code3_dest; RUN;

/*
DATA macrdata.COUNTRY_MACRO_WEIGHT_Data_cp;

SET macrdata.COUNTRY_MACRO_WEIGHT_Data;

RUN;

*/

%LET KEEP=
year
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label
ori_exp_wg
'FP.CPI.TOTL.ZG'n
'FR.INR.RINR'n
'IC.ISV.DURS'n
'IC.LGL.CRED.XQ'n
'NY.GDP.MKTP.KD.ZG'n
'NY.GDP.PCAP.CD'n
'NY.GDP.PCAP.KD.ZG'n
'NY.GDP.PCAP.PP.CD'n
'NY.GDP.PCAP.PP.KD'n
'NY.TTF.GNFS.KN'n
'TT.PRI.MRCH.XD.WD'n
'RESLV.ISV.DFRN.RC'n
'RESLV.ISV.RCOV.RT'n
'Unemployment rate'n
/*'General government net lending/b'n*/
'Inflation, average consumer pric'n
'Inflation, end of period consume'n
'Current account balance'n;

%PUT &KEEP.;

DATA macrdata.COUNTRY_MACRO_WEIGHT_Data;
RETAIN &KEEP.;
SET macrdata.COUNTRY_MACRO_WEIGHT_Data (KEEP= &KEEP.);

RUN; 

PROC SORT DATA= macrdata.COUNTRY_MACRO_WEIGHT_Data; BY year NSA LEI_code ISO_code3_dest; RUN; 


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;


PROC EXPORT DATA=  macrdata.COUNTRY_MACRO_WEIGHT_Data  OUTFILE="&xls_dir./COUNTRY_MACRO_WEIGHT_Data.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;



data COUNTRY_MACRO(drop = i);
   set macrdata.COUNTRY_MACRO_WEIGHT_Data;
   array vars{*} 
'FP.CPI.TOTL.ZG'n
'FR.INR.RINR'n
'IC.ISV.DURS'n
'IC.LGL.CRED.XQ'n
'NY.GDP.MKTP.KD.ZG'n
'NY.GDP.PCAP.CD'n
'NY.GDP.PCAP.KD.ZG'n
'NY.GDP.PCAP.PP.CD'n
'NY.GDP.PCAP.PP.KD'n
'NY.TTF.GNFS.KN'n
'TT.PRI.MRCH.XD.WD'n
'RESLV.ISV.DFRN.RC'n
'RESLV.ISV.RCOV.RT'n
'Unemployment rate'n
/*'General government net lending/b'n*/
'Inflation, average consumer pric'n
'Inflation, end of period consume'n
'Current account balance'n;
;

   do i = 1 to dim(vars);
      vars[i] = vars[i] * ori_exp_wg;
   end;
run;

Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';

	PROC MEANS DATA = COUNTRY_MACRO sum n nway noprint ;
	CLASS 
	year
	Period_nm
	Name
	LEI_Code
	NSA
	nsa_label
	SSM
;
	VAR 
	ori_exp_wg
	'FP.CPI.TOTL.ZG'n
	'FR.INR.RINR'n
	'IC.ISV.DURS'n
	'IC.LGL.CRED.XQ'n
	'NY.GDP.MKTP.KD.ZG'n
	'NY.GDP.PCAP.CD'n
	'NY.GDP.PCAP.KD.ZG'n
	'NY.GDP.PCAP.PP.CD'n
	'NY.GDP.PCAP.PP.KD'n
	'NY.TTF.GNFS.KN'n
	'TT.PRI.MRCH.XD.WD'n
	'RESLV.ISV.DFRN.RC'n
	'RESLV.ISV.RCOV.RT'n
	'Unemployment rate'n
/*	'General government net lending/b'n*/
	'Inflation, average consumer pric'n
	'Inflation, end of period consume'n
	'Current account balance'n;
	OUTPUT OUT= Macrdata.COUNTRY_MACRO_weighted (DROP = _TYPE_ _FREQ_)  sum = n= NO_Coutries_dest;
	RUN;


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;


PROC EXPORT DATA=  Macrdata.COUNTRY_MACRO_weighted OUTFILE="&xls_dir./COUNTRY_MACRO_WEIGHT_Final.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;




	PROC SORT DATA= macrdata.IMF_all_ver (Keep= 'Subject Descriptor'n 'Units'n ) Out= IMF_all_map1 Nodupkey;
	BY  'Subject Descriptor'n 'Units'n;
	RUN;

	
PROC EXPORT DATA=  IMF_all_map1 OUTFILE="&xls_dir./IMF_all_map.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;



/* DATA PREPARETION FOR FINAL TABLE*/

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';


/*Macro_Variables -> macrdata.COUNTRY_MACRO_weighted*/
/*Bank_Specific_Variables-> EBA.TR_CRE_HOR EBA.TR_OTH_HOR*/

/*General:
Granurality: Bank level
Dates: dec2014 dec015 dec2016 dec2017 dec2017 dec2019*/

/*Key-variables for merging:
Year and LEI_Code (Legal Entity Identifier)
*/





/*BEGIN:--------------------NPL ratio per exposure--------------------*/

/*	Name :NPL ratio per exposure 
	Type: NPL ratio (Credit Risk and Asset Quality)
	Table: Tr_Cre 
	Item_number:	2020605	 
	Description: Gross carrying amount on Loans and advances (including at amortised cost  and fair value) 
	Calculation:Perf_Status={'2'}[Non Performing] 2020605 / Perf_Status={'0'}[No breakdown by Perf_status] 2020605

	Exposure_types:
		101	Central banks
		102	Credit institutions
		201	Financial corporations other than credit institutions
		202	General governments
		301	Households
		401	Non-financial corporations
*/



DATA NPL_ratios ;

SET EBA.TR_CRE_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Country
ISO_code_dest
Country_label
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label
Status
Status_label
NACE_codes
NACE_codes_label
Finrep
'2020605'n
);


IF perf_status in ( '0', '2');
IF Country_rank= '0';
*IF NACE_codes= '0';
IF Exposure in ('101','102','201','202','301','401');
IF Portfolio= '0';
IF Status= '0';
RUN; 

/*
PROC FREQ DATA= EBA.TR_CRE_HOR;
TABLE period_nm;
RUN; 
*/

PROC FREQ DATA= NPL_ratios;
TABLE 
period_nm 
nsa_label
Country_rank
Perf_Status_label
Exposure_label
Portfolio_label
Status_label
NACE_codes_label
Finrep
SSM
;
RUN; 




%LET textlist4=
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Country
ISO_code_dest
Country_label
Country_rank
/*
Perf_Status
Perf_Status_label
*/

Exposure
Exposure_label
Portfolio
Portfolio_label
Status
Status_label
/*
NACE_codes
NACE_codes_label
*/
Finrep
;

PROC SORT DATA= NPL_ratios;
BY
&textlist4.
; 
RUN; 

PROC TRANSPOSE DATA= NPL_ratios(DROP= Perf_Status_label NACE_codes NACE_codes_label)

	OUT= NPL_ratios_2 prefix= npl_;
	BY   
	&textlist4.;
	VAR'2020605'n ;
	ID Perf_Status;

	RUN;

DATA NPL_ratios_3;

SET NPL_ratios_2;
NPL_ratio=  npl_2 /npl_0; 
RUN; 




DATA NPL_miss_SSM;
SET NPL_ratios_3;
IF missing(SSM) THEN OUTPUT;
RUN;
PROC FREQ DATA= NPL_ratios_3;
TABLE period_nm*SSM;
RUN; 

/*NPL_CLEAN_UP:
Eliminate NSA= 'OTR' [Others] and SSM [Single Supervisory Mechanism] missing
*/

DATA BankSpec.NPL_ratios;
SET NPL_ratios_3;


IF NSA= 'OT' THEN DELETE;*Eliminate all other banks*;

IF LEI_CODE= 'EFHQAFG69S4HKHLIZA14' THEN DELETE; * Wrong/missing data in: WGZ BANK AG Westdeutsche Genossenschafts-Zentralbank;
IF LEI_CODE=  '815600D79C96B9661149' THEN DELETE; *Wrong/missing data in: ICCREA Banca S.p.A. – Istituto Centrale del Credito Cooperativo:

IF missing(SSM)=1 THEN DELETE;

RUN;


%LET year_beg= 2014;
%LET year_end= 2019;

DATA BankSpec.NPL_ratios;

SET BankSpec.NPL_ratios;
*Year= year(period_nm) ;
 *IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 



PROC FREQ DATA= BankSpec.NPL_ratios;
TABLE period_nm*SSM;
RUN; 




/*DATA_CHECKS*/
	PROC MEANS DATA = BankSpec.NPL_ratios  sum n nway  noprint;
	CLASS 
	Period_nm
	NSA
	nsa_label
	LEI_Code
	name;

	VAR 
	NPL_ratio;
	OUTPUT OUT= NPL_ratios_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;


	DATA missing_NPL ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET NPL_ratios_sum ;

	IF  missing(NPL_ratio)= 1;

	RUN; 


%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_NPL1;*TAKE ONLY YEAR END MONTHS;

SET missing_NPL;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_NPL noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NPL_sum2b; 

	RUN;

	PROC FREQ DATA= missing_NPL1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NPL_sum2; 

	RUN;


	PROC FREQ DATA= missing_NPL_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_NPL_sum3; 

	RUN;


	PROC MEANS DATA = missing_NPL_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;

	VAR  Count;
	OUTPUT OUT= missing_NPL_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	



	PROC SORT DATA= BankSpec.NPL_ratios  OUT= NPL_no_banks (KEEP=LEI_Code name NSA_label) NODUPKEY; BY LEI_Code name NSA_label; RUN; 

	PROC FREQ DATA= NPL_no_banks noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE LEI_Code*name*NSA_label/ out= NPL_no_banks1; 

	RUN;

	PROC MEANS DATA = NPL_no_banks1 sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;

	VAR  Count;
	OUTPUT OUT= NPL_no_banks_sum (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;

/*END:--------------------NPL ratio per exposure--------------------*/

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';
/*BEGIN:--------------------NPL ratio (no breakdown per exposure)--------------------*/

/*	Name :NPL ratio per exposure 
	Type: NPL ratio (Credit Risk and Asset Quality)
	Table: Tr_Cre 
	Item_number:	2020605	 
	Description: Gross carrying amount on Loans and advances (including at amortised cost  and fair value) 
	Calculation:Perf_Status={'2'}[Non Performing] 2020605 / Perf_Status={'0'}[No breakdown by Perf_status] 2020605

*/

DATA NPL_ratios_nb ;

SET EBA.TR_CRE_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Country
ISO_code_dest
Country_label
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label
Status
Status_label
NACE_codes
NACE_codes_label
Finrep
'2020605'n
);


IF perf_status in ( '0', '2');
IF Country_rank= '0';
*IF NACE_codes= '0';
IF Exposure in ('101','102','201','202','301','401');
IF Portfolio= '0';
IF Status= '0';
RUN; 

/*
PROC FREQ DATA= EBA.TR_CRE_HOR;
TABLE period_nm;
RUN; 
*/

PROC FREQ DATA= NPL_ratios_nb;
TABLE 
period_nm 
nsa_label
Country_rank
Perf_Status_label
Exposure_label
Portfolio_label
Status_label
NACE_codes_label
Finrep
SSM
;
RUN; 




%LET textlist4=
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Country
ISO_code_dest
Country_label
Country_rank
/*
Perf_Status
Perf_Status_label
*/

Exposure
Exposure_label
Portfolio
Portfolio_label
Status
Status_label
/*
NACE_codes
NACE_codes_label
*/
Finrep
;

PROC SORT DATA= NPL_ratios_nb;
BY
&textlist4.
; 
RUN; 

PROC TRANSPOSE DATA= NPL_ratios_nb(DROP= Perf_Status_label NACE_codes NACE_codes_label)

	OUT= NPL_ratios_2_nb prefix= npl_;
	BY   
	&textlist4.;
	VAR'2020605'n ;
	ID Perf_Status;

	RUN;



PROC MEANS DATA = NPL_ratios_2_nb max min nway noprint ;

		CLASS   
		Period_nm
		NSA
		nsa_label
		LEI_Code
		name
		SSM
		ID_TE
		Country
		ISO_code_dest
		Country_label
		Country_rank
		/*
		Perf_Status
		Perf_Status_label
		*/
		/*
		Exposure
		Exposure_label
		*/

		Portfolio
		Portfolio_label
		Status
		Status_label
		/*
		NACE_codes
		NACE_codes_label
		*/
		Finrep;

		VAR  npl_0 npl_2;

		OUTPUT OUT= NPL_ratios_2_1_nb  (DROP = _TYPE_ _FREQ_) SUM=;

		RUN;


PROC SORT 
		DATA= NPL_ratios_2_1_nb
		; 
		BY
		NSA
		nsa_label
		name
		LEI_Code
		Period_nm; 
RUN; 

DATA NPL_ratios_3_nb;

SET NPL_ratios_2_1_nb;
NPL_ratio=  npl_2 /npl_0; 
RUN; 



DATA NPL_miss_SSM_nb;
SET NPL_ratios_3_nb;
IF missing(SSM) THEN OUTPUT;
RUN;
PROC FREQ DATA= NPL_ratios_3_nb;
TABLE period_nm*SSM;
RUN; 

/*NPL_CLEAN_UP:
Eliminate NSA= 'OTR' [Others] and SSM [Single Supervisory Mechanism] missing
*/

DATA BankSpec.NPL_ratios_nb;
SET NPL_ratios_3_nb;


IF NSA= 'OT' THEN DELETE;*Eliminate all other banks*;

IF LEI_CODE= 'EFHQAFG69S4HKHLIZA14' THEN DELETE; * Wrong/missing data in: WGZ BANK AG Westdeutsche Genossenschafts-Zentralbank;
IF LEI_CODE=  '815600D79C96B9661149' THEN DELETE; *Wrong/missing data in: ICCREA Banca S.p.A. – Istituto Centrale del Credito Cooperativo:

IF missing(SSM)=1 THEN DELETE;

RUN;


%LET year_beg= 2014;
%LET year_end= 2019;

DATA BankSpec.NPL_ratios_nb;

SET BankSpec.NPL_ratios_nb;
*Year= year(period_nm) ;
 *IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 



PROC FREQ DATA= BankSpec.NPL_ratios_nb;
TABLE period_nm*SSM;
RUN; 


/*END:--------------------NPL ratio (no breakdown per exposure)--------------------*/
	

/*BEGIN:--------------------COMMON EQUITY TIER 1 RATIO (fully loaded)--------------------*/

/*	Name: COMMON EQUITY TIER 1 RATIO-(fully loaded)
  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:	2020146	 
	Description: COMMON EQUITY TIER 1 RATIO-(fully loaded)
	Calculation: sum of 2020146	 

*/


DATA CET1_ratio ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020146'n
);

RUN; 

PROC SORT DATA= CET1_ratio OUT= CET1_ratio_2;
BY
LEI_Code
name
period_nm
descending '2020146'n
;
RUN; 


PROC SORT DATA= CET1_ratio_2 OUT= CET1_ratio (RENAME= ('2020146'n= CET1_ratio)) NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.CET1_ratio;
SET CET1_ratio;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.CET1_ratio;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = BankSpec.CET1_ratio  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	CET1_ratio;
	OUTPUT OUT= CET1_ratio_3_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;


/*END:--------------------COMMON EQUITY TIER 1 RATIO (fully loaded)--------------------*/



/*BEGIN:--------------------COMMON EQUITY TIER 1 RATIO -CALCULATED--(fully loaded)--------------------*/

/*	Name: COMMON EQUITY TIER 1 RATIO-(fully loaded)
  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020143	COMMON EQUITY TIER 1 CAPITAL (fully loaded)
2020220/2020138	Total Risk exposure amount
 
	Description: COMMON EQUITY TIER 1 RATIO -CALCULATED--(fully loaded)
	Calculation: Sum([2020143])/Sum([2020220])	 

*/


DATA CET1_rt_calc ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020143'n
'2020220'n
);

CET1_rt_calc= ('2020143'n /'2020220'n); 

RUN; 

PROC SORT DATA= CET1_rt_calc OUT= CET1_rt_calc_2;
BY
LEI_Code
name
period_nm
descending CET1_rt_calc
;
RUN; 


PROC SORT DATA= CET1_rt_calc_2 OUT= CET1_rt_calc NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.CET1_rt_calc;
SET CET1_rt_calc;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.CET1_rt_calc;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.CET1_rt_calc  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	CET1_rt_calc;
	OUTPUT OUT= CET1_rt_calc_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;


/*END:--------------------COMMON EQUITY TIER 1 RATIO -CALCULATED--(fully loaded)--------------------*/


/*BEGIN:--------------------CCOMMON EQUITY TIER 1 CAPITAL RATIO (transitional period)--------------------*/

/*	Name: COMMON EQUITY TIER 1 CAPITAL RATIO (transitional period)
  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:	2020140	 
	Description: COMMON EQUITY TIER 1 CAPITAL RATIO (transitional period)
	Calculation: sum of 2020140	 

*/


DATA CET1_ratio_tr ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020140'n
);

RUN; 

PROC SORT DATA= CET1_ratio_tr OUT= CET1_ratio_2_tr;
BY
LEI_Code
name
period_nm
descending '2020140'n
;
RUN; 


PROC SORT DATA= CET1_ratio_2_tr OUT= CET1_ratio_tr (RENAME= ('2020140'n= CET1_ratio_tr)) NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.CET1_ratio_tr;
SET CET1_ratio_tr;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.CET1_ratio_tr;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = BankSpec.CET1_ratio_tr  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	CET1_ratio_tr;
	OUTPUT OUT= CET1_ratio_3_tr_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;


	DATA ssm_miss;
	SET  BankSpec.CET1_ratio_tr;
	IF missing(SSM)=1;
	RUN;
/*END:--------------------COMMON EQUITY TIER 1 CAPITAL RATIO (transitional period)--------------------*/


/*BEGIN:--------------------COMMON EQUITY TIER 1 RATIO  -CALCULATED--(transitional period)--------------------*/

/*	Name: COMMON EQUITY TIER 1 RATIO-(fully loaded)
  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020102	COMMON EQUITY TIER 1 CAPITAL (net of deductions and after applying transitional adjustments)
2020220	Total Risk exposure amount

 
	Description: CCOMMON EQUITY TIER 1 RATIO  -CALCULATED--(transitional period)
	Calculation: Sum([2020102])/Sum([2020220])	 

*/


DATA CET1_rt_tr_calc ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020102'n
'2020220'n
);

CET1_rt_tr_calc= ('2020102'n /'2020220'n); 

RUN; 

PROC SORT DATA= CET1_rt_tr_calc OUT= CET1_rt_tr_calc_2;
BY
LEI_Code
name
period_nm
descending CET1_rt_tr_calc
;
RUN; 


PROC SORT DATA= CET1_rt_tr_calc_2 OUT= CET1_rt_tr_calc NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.CET1_rt_tr_calc;
SET CET1_rt_tr_calc;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.CET1_rt_tr_calc;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.CET1_rt_tr_calc  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	CET1_rt_tr_calc;
	OUTPUT OUT= CET1_rt_tr_calc_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;


/*END:--------------------COMMON EQUITY TIER 1 RATIO  -CALCULATED--(transitional period)--------------------*/

/*BEGIN:--------------------TIER 1 CAPITAL RATIO (transitional period)--------------------*/

/*	Name: TIER 1 CAPITAL RATIO (transitional period)
  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020141	TIER 1 CAPITAL RATIO (transitional period)
 
	Description: TIER 1 CAPITAL RATIO (transitional period)
	Calculation: Calculation: Sum([2020141])	 

*/


DATA T1_ratio ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020141'n

);


RUN; 

PROC SORT DATA= T1_ratio OUT= T1_ratio_2;
BY
LEI_Code
name
period_nm
descending '2020141'n
;
RUN; 


PROC SORT DATA= T1_ratio_2 OUT= T1_ratio_3 (RENAME=('2020141'n= T1_ratio))NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.T1_ratio;
SET T1_ratio_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.T1_ratio;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.T1_ratio  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	T1_ratio;
	OUTPUT OUT= T1_ratio_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------TIER 1 CAPITAL RATIO(transitional period))--------------------*/



/*BEGIN:--------------------TIER 1 CAPITAL RATIO  -CALCULATED- (transitional period)--------------------*/

/*	Name: TIER 1 CAPITAL RATIO  -CALCULATED- (transitional period)

  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020133	TIER 1 CAPITAL (net of deductions and after transitional adjustments)
2020220 Total Risk exposure amount

 
	Description: TIER 1 CAPITAL RATIO  -CALCULATED- (transitional period)
	 Calculation: Sum([2020133])/Sum([2020220])	 	 

*/


DATA T1_ratio_calc;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020133'n
'2020220'n
);

T1_ratio_calc= ('2020133'n/ '2020220'n);
RUN; 

PROC SORT DATA= T1_ratio_calc OUT= T1_ratio_calc_2;
BY
LEI_Code
name
period_nm
descending T1_ratio_calc
;
RUN; 


PROC SORT DATA= T1_ratio_calc_2 OUT= T1_ratio_calc_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.T1_ratio_calc;
SET T1_ratio_calc_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.T1_ratio_calc;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.T1_ratio_calc  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
T1_ratio_calc;
	OUTPUT OUT= T1_ratio_calc_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------TIER 1 CAPITAL RATIO  -CALCULATED- (transitional period)--------------------*/

/*BEGIN:--------------------TOTAL CAPITAL RATIO   (transitional period)--------------------*/

/*	Name: TOTAL CAPITAL RATIO   (transitional period)
  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020142	TOTAL CAPITAL RATIO (transitional period)
 
	Description: TOTAL CAPITAL RATIO   (transitional period)
	Calculation:  Sum([2020142])

*/


DATA TCAP_ratio ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020142'n

);


RUN; 

PROC SORT DATA= TCAP_ratio OUT= TCAP_ratio_2;
BY
LEI_Code
name
period_nm
descending '2020142'n
;
RUN; 


PROC SORT DATA= TCAP_ratio_2 OUT= TCAP_ratio_3 (RENAME=('2020142'n= TCAP_ratio))NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.TCAP_ratio;
SET TCAP_ratio_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.TCAP_ratio;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.TCAP_ratio  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	TCAP_ratio;
	OUTPUT OUT= T1_ratio_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------TOTAL CAPITAL RATIO   (transitional period)--------------------*/


/*BEGIN:--------------------Leverage ratio - using a fully phased-in definition of Tier 1 capital--------------------*/

/*	Name: Leverage ratio - using a fully phased-in definition of Tier 1 capital
  type: Leverage Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020906	Leverage ratio - using a fully phased-in definition of Tier 1 capital

 
	Description: Leverage ratio - using a fully phased-in definition of Tier 1 capital 
	Calculation:  Sum([2020906])

*/


DATA LEVER_ratio ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020906'n

);


RUN; 

PROC SORT DATA= LEVER_ratio OUT= LEVER_ratio_2;
BY
LEI_Code
name
period_nm
descending '2020906'n
;
RUN; 


PROC SORT DATA= LEVER_ratio_2 OUT= LEVER_ratio_3 (RENAME=('2020906'n= LEVER_ratio))NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.LEVER_ratio;
SET LEVER_ratio_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.LEVER_ratio;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.LEVER_ratio sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	LEVER_ratio;
	OUTPUT OUT= LEVER_ratio_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------Leverage ratio - using a fully phased-in definition of Tier 1 capital--------------------*/

/*BEGIN:--------------------Leverage ratio - using a fully phased-in definition of Tier 1 capital -CALCULATED---------------------*/

/*	Name: Leverage ratio - using a fully phased-in definition of Tier 1 capital -CALCULATED-

  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020902	Tier 1 capital - fully phased-in definition
2020904	Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital

 
	Description: Leverage ratio - using a fully phased-in definition of Tier 1 capital -CALCULATED-
	 Calculation: Sum([2020902])/Sum([2020904])	 	 
*/


DATA LEVER_ratio_calc;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020902'n
'2020904'n
);

LEVER_ratio_calc= ('2020902'n/ '2020904'n);
RUN; 

PROC SORT DATA= LEVER_ratio_calc OUT= LEVER_ratio_calc_2;
BY
LEI_Code
name
period_nm
descending LEVER_ratio_calc
;
RUN; 


PROC SORT DATA= LEVER_ratio_calc_2 OUT= LEVER_ratio_calc_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.LEVER_ratio_calc;
SET LEVER_ratio_calc_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.LEVER_ratio_calc;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.LEVER_ratio_calc  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
LEVER_ratio_calc;
	OUTPUT OUT= LEVER_ratio_calc_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------Leverage ratio - using a fully phased-in definition of Tier 1 capital -CALCULATED---------------------*/


/*BEGIN:--------------------Leverage ratio - using a transitional definition of Tier 1 capital--------------------*/

/*	Name: Leverage ratio - using a transitional definition of Tier 1 capital
  type: Leverage Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020905	Leverage ratio - using a transitional definition of Tier 1 capital


 
	Description: Leverage ratio - using a transitional definition of Tier 1 capital
	Calculation:  Sum([2020905])

*/

DATA LEVER_tr_ratio ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020905'n

);


RUN; 

PROC SORT DATA= LEVER_tr_ratio OUT= LEVER_tr_ratio_2;
BY
LEI_Code
name
period_nm
descending '2020905'n
;
RUN; 


PROC SORT DATA= LEVER_tr_ratio_2 OUT= LEVER_tr_ratio_3 (RENAME=('2020905'n= LEVER_tr_ratio))NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.LEVER_tr_ratio;
SET LEVER_tr_ratio_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.LEVER_tr_ratio;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.LEVER_tr_ratio sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	LEVER_tr_ratio;
	OUTPUT OUT= LEVER_tr_ratio_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------Leverage ratio - using a transitional definition of Tier 1 capital--------------------*/


/*BEGIN:--------------------Leverage ratio - using a transitional definition of Tier 1 capital-CALCULATED----------------------*/

/*	Name: Leverage ratio - using a transitional definition of Tier 1 capital-CALCULATED-

  type: capital Ratio (solvency)
	Table: Tr_oth 
	Item_number:

2020901	Tier 1 capital - transitional definition
2020903	Total leverage ratio exposures - using a transitional definition of Tier 1 capital

	Description: Leverage ratio - using a transitional definition of Tier 1 capital-CALCULATED-
	 Calculation: Sum([2020901])/Sum([2020903])	 	 
*/


DATA LEVER_tr_ratio_calc;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020901'n
'2020903'n
);

LEVER_tr_ratio_calc= ('2020901'n/ '2020903'n);
RUN; 

PROC SORT DATA= LEVER_tr_ratio_calc OUT= LEVER_tr_ratio_calc_2;
BY
LEI_Code
name
period_nm
descending LEVER_tr_ratio_calc
;
RUN; 


PROC SORT DATA= LEVER_tr_ratio_calc_2 OUT= LEVER_tr_ratio_calc_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.LEVER_tr_ratio_calc;
SET LEVER_tr_ratio_calc_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.LEVER_tr_ratio_calc;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.LEVER_tr_ratio_calc  sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
LEVER_tr_ratio_calc;
	OUTPUT OUT= LEVER_tr_ratio_calc_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------Leverage ratio - using a transitional definition of Tier 1 capital-CALCULATED----------------------*/

/*BEGIN:--------------------Bank_size (using a fully phased)-> Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital--------------------*/

/*	Name: Bank_size (using a fully phased)-> Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital
  type:  Bank_size (control)
	Table: Tr_oth 
	Item_number:


2020904 Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital

 
	Description: Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital
	Calculation:  Sum([2020904])
*/

DATA bankSize_full ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020904'n

);


RUN; 

PROC SORT DATA= bankSize_full OUT= bankSize_full_2;
BY
LEI_Code
name
period_nm
descending '2020904'n
;
RUN; 


PROC SORT DATA= bankSize_full_2 OUT= bankSize_full_3 (RENAME=('2020904'n= bankSize_full))NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.bankSize_full;
SET bankSize_full_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.bankSize_full;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.bankSize_full sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	bankSize_full;
	OUTPUT OUT= bankSize_full_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------Bank_size (using a fully phased)-> Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital--------------------*/


/*BEGIN:--------------------Bank_size (using a transitional definition)-> Total leverage ratio exposures - using a transitional definition of Tier 1 capital--------------------*/

/*	Name: Bank_size (using a fully phased)-> Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital
  type:  Bank_size (control)
	Table: Tr_oth 
	Item_number:


2020903 Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital

 
	Description: Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital
	Calculation:  Sum([2020903])
*/

DATA bankSize_tran ;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020903'n

);


RUN; 

PROC SORT DATA= BankSize_tran OUT= BankSize_tran_2;
BY
LEI_Code
name
period_nm
descending '2020903'n
;
RUN; 


PROC SORT DATA= BankSize_tran_2 OUT= BankSize_tran_3 (RENAME=('2020903'n= BankSize_tran))NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.BankSize_tran;
SET BankSize_tran_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.BankSize_tran;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*NPL_DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.BankSize_tran sum n nway  noprint;
	CLASS 
LEI_Code
name
period_nm;
	VAR 
	BankSize_tran;
	OUTPUT OUT= BankSize_tran_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

/*END:--------------------Bank_size (using a transitional definition)-> Total leverage ratio exposures - using a transitional definition of Tier 1 capital--------------------*/

/*BEGIN:--------------------Cost-to_Income----------------------*/

/*	Name: Cost-to_Income

  type: P&L (Profitability)
	Table: Tr_oth 
	Item_number:

2020317	(Administrative expenses)
2020318	(Depreciation)
2020316	TOTAL OPERATING INCOME_ NET


	Description:Cost-to_Income
	Calculation: (Sum([2020317]) + Sum([2020318]))/ Sum([2020316])	 	 
				((Administrative expenses) + (Depreciation)) / TOTAL OPERATING INCOME_ NET

*/

DATA Cost_to_Income;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020317'n
'2020318'n
'2020316'n
);

Cost= ('2020317'n + '2020318'n);
Income= '2020316'n;
Cost_to_Income= (Cost/Income);
RUN; 

PROC SORT DATA= Cost_to_Income OUT= Cost_to_Income_2;
BY
LEI_Code
name
period_nm
descending Cost_to_Income
;
RUN; 


PROC SORT DATA= Cost_to_Income_2 OUT= Cost_to_Income_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.Cost_to_Income;
SET Cost_to_Income_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.Cost_to_Income;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.Cost_to_Income  sum n nway  noprint;
	CLASS 
LEI_Code
name
NSA_label
period_nm;
	VAR 
Cost_to_Income;
	OUTPUT OUT= Cost_to_Income_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

	DATA missing_CtoI;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET Cost_to_Income_sum;

	IF  missing(Cost_to_Income)= 1;

	RUN; 


%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_CtoI1;*TAKE ONLY YEAR END MONTHS;

SET missing_CtoI;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_CtoI noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_CtoI_sum2b; 

	RUN;

	PROC FREQ DATA= missing_CtoI1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_CtoI_sum2; 

	RUN;


	PROC FREQ DATA= missing_CtoI_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_CtoI_sum3; 

	RUN;


	PROC MEANS DATA = missing_CtoI_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;

	VAR  Count;
	OUTPUT OUT= missing_CtoI_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;

/*END:--------------------Cost-to_Income----------------------*/

/*BEGIN:--------------------Return on Regulatory (Risk-Adjusted) Capital (RORC-RORAC)----------------------*/

/*	Name: Return on Regulatory (Risk-Adjusted) Capital (RORC-RORAC)

  type: P&L (Profitability)
	Table: Tr_oth 
	Item_number:

2020335	PROFIT OR (-) LOSS FOR THE YEAR
2020133	TIER 1 CAPITAL (net of deductions and after transitional adjustments)


	Description: Return on Regulatory (Risk-Adjusted) Capital (RORC-RORAC)
	Calculation: (Sum(2020335)/ Sum([2020133])	 	 
				(PROFIT OR (-) LOSS FOR THE YEAR) / TIER 1 CAPITAL (net of deductions and after transitional adjustments)

*/

DATA RORAC;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020335'n
'2020133'n
);

RORAC= ('2020335'n /'2020133'n);

RUN; 

PROC SORT DATA= RORAC OUT= RORAC_2;
BY
LEI_Code
name
period_nm
descending RORAC
;
RUN; 


PROC SORT DATA= RORAC_2 OUT= RORAC_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.RORAC;
SET RORAC_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.RORAC;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.RORAC  sum n nway  noprint;
	CLASS 
LEI_Code
name
NSA_label
period_nm;
	VAR 
RORAC ;
	OUTPUT OUT= RORAC_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

	DATA missing_RORAC ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET RORAC_sum;

	IF  missing(RORAC)= 1;

	RUN; 


%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_RORAC1;*TAKE ONLY YEAR END MONTHS;

SET missing_RORAC;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_RORAC noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_RORAC_sum2b; 

	RUN;

	PROC FREQ DATA= missing_RORAC1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_RORAC_sum2; 

	RUN;


	PROC FREQ DATA= missing_RORAC_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_RORAC_sum3; 

	RUN;


	PROC MEANS DATA = missing_RORAC_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;

	VAR  Count;
	OUTPUT OUT= missing_RORAC_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	


/*END:--------------------Return on Regulatory (Risk-Adjusted) Capital (RORC-RORAC)----------------------*/

/*BEGIN:--------------------Return on Risk_weighted Assets(RORWA)----------------------*/

/*	Name:Return on Risk_weighted Assets(RORWA)

  type: P&L (Profitability)
	Table: Tr_oth 
	Item_number:

2020335	PROFIT OR (-) LOSS FOR THE YEAR
2020220/2020138	Total Risk exposure amount


	Description: Return on Risk_weighted Assets(RORWA)
	Calculation: (Sum(2020335)/ Sum([2020220])	 	 
				(PROFIT OR (-) LOSS FOR THE YEAR) / Total Risk exposure amount

*/


DATA RORWA;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020335'n
'2020220'n
);

RORWA= ('2020335'n /'2020220'n);

RUN; 

PROC SORT DATA= RORWA OUT= RORWA_2;
BY
LEI_Code
name
period_nm
descending RORWA
;
RUN; 


PROC SORT DATA= RORWA_2 OUT= RORWA_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.RORWA;
SET RORWA_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.RORWA;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.RORWA  sum n nway  noprint;
	CLASS 
LEI_Code
name
NSA_label
period_nm;
	VAR 
RORWA ;
	OUTPUT OUT= RORWA_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

	DATA missing_RORWA ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET RORWA_sum;

	IF  missing(RORWA)= 1;

	RUN; 


%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_RORWA1;*TAKE ONLY YEAR END MONTHS;

SET missing_RORWA;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_RORWA noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_RORWA_sum2b; 

	RUN;

	PROC FREQ DATA= missing_RORWA1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_RORWA_sum2; 

	RUN;


	PROC FREQ DATA= missing_RORWA_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_RORWA_sum3; 

	RUN;


	PROC MEANS DATA = missing_RORWA_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;

	VAR  Count;
	OUTPUT OUT= missing_RORWA_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	

/*END:--------------------Return on Risk_weighted Assets(RORWA))----------------------*/


/*BEGIN:--------------------Net Interest Margin (NIM)[using a fully phased]----------------------*/

/*	Name:Net Interest Margin (NIM)

  type: P&L (Profitability)
	Table: Tr_oth 
	Item_number:

2020304	Interest expenses
2020301	Interest income
2020904	Total leverage ratio exposures - using a fully phased-in definition of Tier 1 capital

	Description: Net Interest Margin (NIM)
	Calculation: (Sum(2020301)-Sum(2020304))/ Sum([2020904])	 	 
				(Interest Income -Interest expenses)/Total assets (using Total leverage ratio exposures)


*/

DATA NIM;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020304'n
'2020301'n
'2020904'n
);

NIM= ('2020301'n - '2020304'n)/('2020904'n);

RUN; 

PROC SORT DATA= NIM OUT= NIM_2;
BY
LEI_Code
name
period_nm
descending NIM
;
RUN; 


PROC SORT DATA= NIM_2 OUT= NIM_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.NIM;
SET NIM_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.NIM;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.NIM  sum n nway  noprint;
	CLASS 
LEI_Code
name
NSA_label
period_nm;
	VAR 
NIM ;
	OUTPUT OUT= NIM_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

	DATA missing_NIM ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET NIM_sum;

	IF  missing(NIM)= 1;

	RUN; 

%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_NIM1;*TAKE ONLY YEAR END MONTHS;

SET missing_NIM;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_NIM noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NIM_sum2b; 

	RUN;

	PROC FREQ DATA= missing_NIM1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NIM_sum2; 

	RUN;

	PROC FREQ DATA= missing_NIM_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_NIM_sum3; 

	RUN;

	PROC MEANS DATA = missing_NIM_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;
	VAR  Count;
	OUTPUT OUT= missing_NIM_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	
/*END:--------------------Net Interest Margin (NIM)[using a fully phased]----------------------*/


/*BEGIN:--------------------Net Interest Margin (NIM)[using a transitional definition]----------------------*/

/*	Name:Net Interest Margin (NIM)

  type: P&L (Profitability)
	Table: Tr_oth 
	Item_number:

2020304	Interest expenses
2020301	Interest income
2020903	 Total leverage ratio exposures - using a transitional definition of Tier 1 capital

	Description: Net Interest Margin (NIM)
	Calculation: (Sum(2020301)-Sum(2020304))/ Sum([2020220])	 	 
				(Interest Income -Interest expenses)/Total assets (using Total leverage ratio exposures)


*/

DATA NIM_tr;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020304'n
'2020301'n
'2020903'n
);

NIM_tr= ('2020301'n - '2020304'n)/('2020903'n);

RUN; 

PROC SORT DATA= NIM_tr OUT= NIM_tr_2;
BY
LEI_Code
name
period_nm
descending NIM_tr
;
RUN; 


PROC SORT DATA= NIM_tr_2 OUT= NIM_tr_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.NIM_tr;
SET NIM_tr_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.NIM_tr;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.NIM_tr  sum n nway  noprint;
	CLASS 
LEI_Code
name
NSA_label
period_nm;
	VAR 
NIM_tr ;
	OUTPUT OUT= NIM_tr_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

	DATA missing_NIM_tr ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET NIM_tr_sum;

	IF  missing(NIM_tr)= 1;

	RUN; 

%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_NIM_tr1;*TAKE ONLY YEAR END MONTHS;

SET missing_NIM_tr;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_NIM_tr noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NIM_tr_sum2b; 

	RUN;

	PROC FREQ DATA= missing_NIM_tr1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NIM_tr_sum2; 

	RUN;

	PROC FREQ DATA= missing_NIM_tr_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_NIM_tr_sum3; 

	RUN;

	PROC MEANS DATA = missing_NIM_tr_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;
	VAR  Count;
	OUTPUT OUT= missing_NIM_tr_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;

/*END:--------------------Net Interest Margin (NIM_tr)[using a transitional definition]----------------------*/


/*BEGIN:--------------------Net Interest Income (NII)----------------------*/

/*	Name:Net Interest Income (NII)

  type: P&L (Profitability)
	Table: Tr_oth 
	Item_number:

2020304	Interest expenses
2020301	Interest income
2020316	TOTAL OPERATING INCOME_ NET


	Description: Net Interest Income (NII)
	Calculation: (Sum(2020301)-Sum(2020304))/ Sum([2020316])	 	 
				(Interest Income -Interest expenses)/TOTAL OPERATING INCOME_ NET

*/

DATA NII;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020304'n
'2020301'n
'2020316'n
);

NII= ('2020301'n - '2020304'n)/('2020316'n);

RUN; 

PROC SORT DATA= NII OUT= NII_2;
BY
LEI_Code
name
period_nm
descending NII
;
RUN; 


PROC SORT DATA= NII_2 OUT= NII_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.NII;
SET NII_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.NII;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.NII  sum n nway  noprint;
	CLASS 
LEI_Code
name
NSA_label
period_nm;
	VAR 
NII ;
	OUTPUT OUT= NII_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

	DATA missing_NII ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET NII_sum;

	IF  missing(NII)= 1;

	RUN; 

%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_NII1;*TAKE ONLY YEAR END MONTHS;

SET missing_NII;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_NII noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NII_sum2b; 

	RUN;

	PROC FREQ DATA= missing_NII1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NII_sum2; 

	RUN;

	PROC FREQ DATA= missing_NII_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_NII_sum3; 

	RUN;

	PROC MEANS DATA = missing_NII_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;
	VAR  Count;
	OUTPUT OUT= missing_NII_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	
/*END:--------------------Net Interest Income (NII)----------------------*/

/*BEGIN:--------------------Net Fee and Commission Income (NFCI)----------------------*/

/*	Name:Net net fee and commission income (NFCI)


  type: P&L (Profitability)
	Table: Tr_oth 
	Item_number:

2020309	Net Fee and commission income
2020316	TOTAL OPERATING INCOME_ NET


	Description: Net Fee and Commission Income (NFCI)

	Calculation: Sum(2020309)/ Sum([2020316])	 	 
				Net Fee and commission income/TOTAL OPERATING INCOME_ NET

*/

DATA NFCI;

SET EBA.TR_OTH_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Exposure
Exposure_label
ASSETS_FV
ASSETS_FV_label
ASSETS_Stages
ASSETS_Stages_label
Financial_instruments
Financial_instruments_label
Fin_end_year
Fin_end_year_label
n_quarters
Finrep
'2020309'n
'2020316'n
);

NFCI= ('2020309'n)/('2020316'n);

RUN; 

PROC SORT DATA= NFCI OUT= NFCI_2;
BY
LEI_Code
name
period_nm
descending NFCI
;
RUN; 


PROC SORT DATA= NFCI_2 OUT= NFCI_3 NODUPKEY;
BY
LEI_Code
name
period_nm
;
RUN;
 
/*
DATA miss_test;
SET CET1_ratio;

RUN;
*/

DATA Bankspec.NFCI;
SET NFCI_3;
IF NSA = 'OT' THEN DELETE;*delete nsa_label= all other banks;
RUN; 

PROC FREQ DATA= Bankspec.NFCI;
TABLE
NSA
period_nm
SSM
;
RUN; 

/*DATA_CHECKS*/
	PROC MEANS DATA = Bankspec.NFCI  sum n nway  noprint;
	CLASS 
LEI_Code
name
NSA_label
period_nm;
	VAR 
NFCI ;
	OUTPUT OUT= NFCI_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;

	DATA missing_NFCI ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET NFCI_sum;

	IF  missing(NFCI)= 1;

	RUN; 

%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_NFCI1;*TAKE ONLY YEAR END MONTHS;

SET missing_NFCI;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_NFCI noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NFCI_sum2b; 

	RUN;

	PROC FREQ DATA= missing_NFCI1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_NFCI_sum2; 

	RUN;

	PROC FREQ DATA= missing_NFCI_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_NFCI_sum3; 

	RUN;

	PROC MEANS DATA = missing_NFCI_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;
	VAR  Count;
	OUTPUT OUT= missing_NFCI_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	
/*END:--------------------Net Fee and Commission Income (NFCI)----------------------*/

/*BEGIN:--------------------Forbearance ratio for loans and advances----------------------*/

/*	Name:Forbearance ratio for Loans and Advances (Forbear_ratio)


  type: NPE/Forborne exposures
 Credit Risk and Asset Quality
	Table: Tr_cre
	Item_number:

2020705	xposures with forbearance measures - Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure
2020605	Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure



	Description: Forbearance ratio for loans and advances

	Calculation: Perf_Status={'0'} Sum(2020705)/ Perf_Status={'0'}Sum([2020605])	 	

				Nxposures with forbearance measures - Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure
				/Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure
*/


DATA Forbear_ratio ;

SET EBA.TR_CRE_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Country
ISO_code_dest
Country_label
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label
Status
Status_label
NACE_codes
NACE_codes_label
Finrep
'2020705'n
'2020605'n
);


IF perf_status in ('0');
IF Country_rank= '0';
*IF NACE_codes= '0';
IF Exposure in ('101','102','201','202','301','401');
IF Portfolio= '0';
IF Status= '0';
RUN; 

/*
PROC FREQ DATA= EBA.TR_CRE_HOR;
TABLE period_nm;
RUN; 
*/

PROC FREQ DATA= Forbear_ratio;
TABLE 
period_nm 
nsa_label
Country_rank
Perf_Status_label
Exposure_label
Portfolio_label
Status_label
NACE_codes_label
Finrep
SSM
;
RUN; 



DATA Forbear_ratio_2;

SET Forbear_ratio;
Forbear_ratio= ('2020705'n /'2020605'n); 
RUN; 



DATA Forbear_miss_SSM;
SET Forbear_ratio_2;
IF missing(SSM) THEN OUTPUT;
RUN;
PROC FREQ DATA= Forbear_ratio_2;
TABLE period_nm*SSM;
RUN; 

/*NPL_CLEAN_UP:
Eliminate NSA= 'OTR' [Others] and SSM [Single Supervisory Mechanism] missing
*/

DATA BankSpec.Forbear_ratio;
SET Forbear_ratio_2;


IF NSA= 'OT' THEN DELETE;*Eliminate all other banks*;

IF LEI_CODE= 'EFHQAFG69S4HKHLIZA14' THEN DELETE; * Wrong/missing data in: WGZ BANK AG Westdeutsche Genossenschafts-Zentralbank;
IF LEI_CODE=  '815600D79C96B9661149' THEN DELETE; *Wrong/missing data in: ICCREA Banca S.p.A. – Istituto Centrale del Credito Cooperativo:

IF missing(SSM)=1 THEN DELETE;

RUN;


%LET year_beg= 2014;
%LET year_end= 2019;

DATA BankSpec.Forbear_ratio;

SET BankSpec.Forbear_ratio;
*Year= year(period_nm) ;
 *IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 



PROC FREQ DATA= BankSpec.Forbear_ratio;
TABLE period_nm*SSM;
RUN; 


/*DATA_CHECKS*/
	PROC MEANS DATA = BankSpec.Forbear_ratio  sum n nway  noprint;
	CLASS 
	Period_nm
	NSA
	nsa_label
	LEI_Code
	name;

	VAR 
	Forbear_ratio;
	OUTPUT OUT= Forbear_ratio_sum (DROP = _TYPE_ _FREQ_)  sum =  n= n;
	RUN;


	DATA missing_FOR ;*TAKE ONLY BANKS-DATES WIT MISSING CtoI;

	SET Forbear_ratio_sum ;

	IF  missing(NPL_ratio)= 1;

	RUN; 


%LET year_beg= 2014;
%LET year_end= 2019;

DATA missing_FOR1;*TAKE ONLY YEAR END MONTHS;

SET missing_FOR;
Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

	PROC FREQ DATA= missing_FOR noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_FOR_sum2b; 

	RUN;

	PROC FREQ DATA= missing_FOR1 noprint; *TOTAL OF DATES MISSING CtoU FOR  EACH BANK (AT LEST A YEAR_END DATE MISSING);
	TABLE LEI_Code*name*NSA_label/ out= missing_FOR_sum2; 

	RUN;


	PROC FREQ DATA= missing_FOR_sum2 noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE NSA_label/ out= missing_FOR_sum3; 

	RUN;


	PROC MEANS DATA = missing_FOR_sum3  sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;

	VAR  Count;
	OUTPUT OUT= missing_FOR_sum4 (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	



	PROC SORT DATA= BankSpec.Forbear_ratio  OUT= FOR_no_banks (KEEP=LEI_Code name NSA_label) NODUPKEY; BY LEI_Code name NSA_label; RUN; 

	PROC FREQ DATA= FOR_no_banks noprint; *TOTAL BANKS (AT LEST A YEAR_END DATE MISSING) WHICH MAY BE EXCLUDED PER COUNTRY;
	TABLE LEI_Code*name*NSA_label/ out= FOR_no_banks1; 

	RUN;

	PROC MEANS DATA = FOR_no_banks1 sum n nway  noprint;*TOTAL BANKS WHICH MAY BE EXCLUDED ALL SET;

	VAR  Count;
	OUTPUT OUT= FOR_no_banks_sum (DROP = _TYPE_ _FREQ_)  sum = sum;
	RUN;
	
/*END:--------------------Forbearance ratio for loans and advances----------------------*/


/*BEGIN:--------------------Forbearance ratio for loans and advances (NO BREAKDOWN)----------------------*/

/*	Name:Forbearance ratio for Loans and Advances (Forbear_ratio)


  type: NPE/Forborne exposures
 Credit Risk and Asset Quality
	Table: Tr_cre
	Item_number:

2020705	xposures with forbearance measures - Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure
2020605	Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure



	Description: Forbearance ratio for loans and advances

	Calculation: Perf_Status={'0'} Sum(2020705)/ Perf_Status={'0'}Sum([2020605])	 	

				Nxposures with forbearance measures - Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure
				/Gross carrying amount on Loans and advances (including at amortised cost  and fair value) - by exposure
*/


DATA Forbear_ratio_nb ;

SET EBA.TR_CRE_HOR
(KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
ID_TE
Country
ISO_code_dest
Country_label
Country_rank
Perf_Status
Perf_Status_label
Exposure
Exposure_label
Portfolio
Portfolio_label
Status
Status_label
NACE_codes
NACE_codes_label
Finrep
'2020705'n
'2020605'n
);


IF perf_status in ('0');
IF Country_rank= '0';
*IF NACE_codes= '0';
IF Exposure in ('101','102','201','202','301','401');
IF Portfolio= '0';
IF Status= '0';
RUN; 

/*
PROC FREQ DATA= EBA.TR_CRE_HOR;
TABLE period_nm;
RUN; 
*/

PROC FREQ DATA= Forbear_ratio_nb;
TABLE 
period_nm 
nsa_label
Country_rank
Perf_Status_label
Exposure_label
Portfolio_label
Status_label
NACE_codes_label
Finrep
SSM
;
RUN; 

PROC MEANS DATA = Forbear_ratio_nb max min nway noprint ;

		CLASS   
		Period_nm
		NSA
		nsa_label
		LEI_Code
		name
		SSM
		ID_TE
		Country
		ISO_code_dest
		Country_label
		Country_rank
		/*
		Perf_Status
		Perf_Status_label
		*/
		/*
		Exposure
		Exposure_label
		*/

		Portfolio
		Portfolio_label
		Status
		Status_label
		/*
		NACE_codes
		NACE_codes_label
		*/
		Finrep;

		VAR 
		'2020705'n 
		'2020605'n;

		OUTPUT OUT= Forbear_ratio_2_nb  (DROP = _TYPE_ _FREQ_) SUM=;

		RUN;


PROC SORT 
		DATA= Forbear_ratio_2_nb
		; 
		BY
		NSA
		nsa_label
		name
		LEI_Code
		Period_nm; 
RUN; 



DATA Forbear_ratio_3_nb;

SET Forbear_ratio_2_nb;
Forbear_ratio= ('2020705'n /'2020605'n); 
RUN; 



DATA Forbear_miss_SSM_nb;
SET Forbear_ratio_3_nb;
IF missing(SSM) THEN OUTPUT;
RUN;
PROC FREQ DATA= Forbear_ratio_2_nb;
TABLE period_nm*SSM;
RUN; 

/*NPL_CLEAN_UP:
Eliminate NSA= 'OTR' [Others] and SSM [Single Supervisory Mechanism] missing
*/

DATA BankSpec.Forbear_ratio_nb;
SET Forbear_ratio_3_nb;


IF NSA= 'OT' THEN DELETE;*Eliminate all other banks*;

IF LEI_CODE= 'EFHQAFG69S4HKHLIZA14' THEN DELETE; * Wrong/missing data in: WGZ BANK AG Westdeutsche Genossenschafts-Zentralbank;
IF LEI_CODE=  '815600D79C96B9661149' THEN DELETE; *Wrong/missing data in: ICCREA Banca S.p.A. – Istituto Centrale del Credito Cooperativo:

IF missing(SSM)=1 THEN DELETE;

RUN;


%LET year_beg= 2014;
%LET year_end= 2019;

DATA BankSpec.Forbear_ratio_nb;

SET BankSpec.Forbear_ratio_nb;
*Year= year(period_nm) ;
 *IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 



PROC FREQ DATA= BankSpec.Forbear_ratio_nb;
TABLE period_nm*SSM;
RUN; 


/*END:--------------------Forbearance ratio for loans and advances (NO BREAKDOWN)----------------------*/



/*INFORMATION:
Yearly data for 2015 only available up to june 2015 in  bankspec.banksize_tran and bankspec.lever_tr_ratio  bankspec.lever_tr_ratio_calc
For this reason a change from 201506 t0 201512 is needed in these tables for year 2015
Modified Names: work.banksize_tran_mod work.lever_tr_ratio_mod  work.lever_tr_ratio_calc_mod;
*/

%MACRO EBA_list(list=,lib= BankSpec);


Libname &lib. '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';
	
%DO i = 1 %TO %SYSFUNC(countw(&list.));



			DATA _NULL_;

		    type =  compress(SCAN(&list.,&i.));
			lgth=lengthn(type);
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. ;

			DATA _NULL_;
			ty =   input(substr(SCAN(&list.,&i.),1,&lgth.),&format_type.);
			CALL SYMPUT("ty", ty);
		
			RUN;

			%put &ty.;

			DATA &ty._mod;
			SET  &lib..&ty.;
			Year= year(period_nm) ;

			IF   Year= 2015  AND month(period_nm)=12 THEN DELETE;

			IF   Year= 2015  AND month(period_nm)=6 THEN DO;

				period_nm= mdy(12,1,2015) ;format  period_nm yymmn6.;

			END;

			IF   Year= 2016  AND month(period_nm)=6 THEN DELETE;


			RUN; 
			*work.banksize_tran_mod work.lever_tr_ratio_mod  work.lever_tr_ratio_calc_mod;
			

	

%END;

%MEND EBA_list;
%EBA_list(list= "banksize_tran lever_tr_ratio lever_tr_ratio_calc",lib= BankSpec);


/*LINKING FIELDS*/

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';

/*
Macrdata.country_macro_weighted;

*/


%LET year_beg= 2014;
%LET year_end= 2019;


/*NPL RATIOS PER EXPOSURE*/
DATA NPL_ratios
(
KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
Country
ISO_code_dest
Country_label
Country_rank
Exposure
Exposure_label
NPL_ratio
Year
)
;

SET BankSpec.NPL_ratios;

*IF NPL_ratio= 0  THEN NPL_ratio = .;

Year= year(period_nm) ;

IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;

END;

RUN; 

PROC FREQ DATA=  NPL_ratios;

TABLE

Period_nm
NSA
nsa_label
LEI_Code
name
SSM
Country
ISO_code_dest
Country_label
Country_rank
Exposure
Exposure_label
NPL_ratio
Year
;

RUN; 

DATA NPL_ratios1
(KEEP=
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
Exposure
Exposure_label
NPL_ratio
Year
)
;

SET NPL_ratios;

RUN; 

PROC SQL;
CREATE TABLE npl_analysis AS 
SELECT
a.*,

b.'FP.CPI.TOTL.ZG'n AS infl_perc,
b.'FR.INR.RINR'n AS interest_perc,
b.'IC.ISV.DURS'n AS TimTOres_insol,
b.'IC.LGL.CRED.XQ'n AS Stgth_legal_index,
b.'NY.GDP.MKTP.KD.ZG'n AS GDP_growth_perc,
b.'NY.GDP.PCAP.CD'n AS GDP_per_cap_dol,
b.'NY.GDP.PCAP.KD.ZG'n AS GDP_per_cap_growth_perc,
b.'NY.GDP.PCAP.PP.CD'n AS GDP_per_cap_ppp,
b.'NY.GDP.PCAP.PP.KD'n AS GDP_per_cap_PPP_2017,
b.'NY.TTF.GNFS.KN'n AS Termsoftrade_adj_cnst,
b.'TT.PRI.MRCH.XD.WD'n AS Ne_termsoftrad_indx_2000,
b.'RESLV.ISV.DFRN.RC'n AS Reco_rate_dol_Score,
b.'RESLV.ISV.RCOV.RT'n AS Reco_rate_dol,
b.'Unemployment rate'n AS unempl_rate_imf,
b.'General government net lending/b'n AS gov_net_lend_bor_imf,
b.'Inflation, average consumer pric'n AS infl_avrg_imf,
b.'Inflation, end of period consume'n AS infl_eop_imf,
b.'Current account balance'n AS curr_acc_bal,

c.bankSize_tran,

d.cet1_ratio,

e.cet1_ratio_tr,

f.cet1_rt_calc,

g.cet1_rt_tr_calc,

h.cost_to_income,

i.forbear_ratio,

j.lever_ratio,

k.lever_ratio_calc,

l.lever_tr_ratio,

m.lever_tr_ratio_calc,

n.nfci,

o.nii,

p.nim,

q.nim_tr,

r.rorac,

s.rorwa,

t.t1_ratio,

u.t1_ratio_calc,

v.tcap_ratio,

w.banksize_full
	
FROM NPL_ratios1 AS a
	LEFT JOIN MACRDATA.COUNTRY_MACRO_WEIGHTED AS b 
	ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code
		LEFT JOIN banksize_tran_mod AS   c /*banksize_tran_mod*/ 
		ON a.Period_nm=c.Period_nm AND a.LEI_Code= c.LEI_Code
			LEFT JOIN bankspec.cet1_ratio AS d
			ON a.Period_nm=d.Period_nm AND a.LEI_Code= d.LEI_Code
				LEFT JOIN bankspec.cet1_ratio_tr AS e
				ON a.Period_nm=e.Period_nm AND a.LEI_Code= e.LEI_Code
					LEFT JOIN bankspec.cet1_rt_calc AS f
					ON a.Period_nm=f.Period_nm AND a.LEI_Code= f.LEI_Code
						LEFT JOIN bankspec.cet1_rt_tr_calc AS g
						ON a.Period_nm=g.Period_nm AND a.LEI_Code= g.LEI_Code
							LEFT JOIN bankspec.cost_to_income  AS h
							ON a.Period_nm=h.Period_nm AND a.LEI_Code= h.LEI_Code
								LEFT JOIN  bankspec.forbear_ratio_nb AS i
								ON a.Period_nm=i.Period_nm AND a.LEI_Code= i.LEI_Code AND a.exposure=i.exposure
									LEFT JOIN  bankspec.lever_ratio AS j
									ON a.Period_nm=j.Period_nm AND a.LEI_Code= j.LEI_Code
										LEFT JOIN bankspec.lever_ratio_calc AS k
										ON a.Period_nm=k.Period_nm AND a.LEI_Code= k.LEI_Code
											LEFT JOIN lever_tr_ratio_mod  AS l /*work.lever_tr_ratio_mod*/ 
											ON a.Period_nm=l.Period_nm AND a.LEI_Code= l.LEI_Code
												LEFT JOIN lever_tr_ratio_calc_mod  AS m /*work.lever_tr_ratio_calc_mod*/ 
												ON a.Period_nm=m.Period_nm AND a.LEI_Code= m.LEI_Code
													LEFT JOIN bankspec.nfci  AS n
													ON a.Period_nm=n.Period_nm AND a.LEI_Code= n.LEI_Code
														LEFT JOIN  bankspec.nii AS o
														ON a.Period_nm=o.Period_nm AND a.LEI_Code= o.LEI_Code
															LEFT JOIN  bankspec.nim AS p
															ON a.Period_nm=p.Period_nm AND a.LEI_Code= p.LEI_Code
																LEFT JOIN bankspec.nim_tr AS q
																ON a.Period_nm=q.Period_nm AND a.LEI_Code= q.LEI_Code
																	LEFT JOIN bankspec.rorac  AS r
																	ON a.Period_nm=r.Period_nm AND a.LEI_Code= r.LEI_Code
																		LEFT JOIN bankspec.rorwa  AS s
																		ON a.Period_nm=s.Period_nm AND a.LEI_Code= s.LEI_Code
																			LEFT JOIN  bankspec.t1_ratio AS t
																			ON a.Period_nm=t.Period_nm AND a.LEI_Code= t.LEI_Code
																				LEFT JOIN bankspec.t1_ratio_calc AS u
																				ON a.Period_nm=u.Period_nm AND a.LEI_Code= u.LEI_Code
																					LEFT JOIN bankspec.tcap_ratio  AS v
																					ON a.Period_nm=v.Period_nm AND a.LEI_Code= v.LEI_Code
																						LEFT JOIN bankspec.bankSize_full  AS w
																						ON a.Period_nm= w.Period_nm AND a.LEI_Code= w.LEI_Code;
																					
QUIT;






data npl_analysis1(drop = i);
   set npl_analysis;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.npl_dataset;

SET npl_analysis1;

period_cha=PUT(period_nm, YYMMN6. );

RUN; 


/*NPL RATIOS(NO BREAKDOWN)*/
DATA NPL_ratios_nb
(
KEEP= 
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
Country
ISO_code_dest
Country_label
Country_rank
/*
Exposure
Exposure_label
*/
NPL_ratio
Year
)
;

SET BankSpec.NPL_ratios_nb;

*IF NPL_ratio= 0  THEN NPL_ratio = .;

Year= year(period_nm) ;
 IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;
RUN; 

PROC FREQ DATA=  NPL_ratios_nb;

TABLE

Period_nm
NSA
nsa_label
LEI_Code
name
SSM
Country
ISO_code_dest
Country_label
Country_rank
/*
Exposure
Exposure_label
*/
NPL_ratio
Year
;

RUN; 

DATA NPL_ratios1_nb
(KEEP=
Period_nm
NSA
nsa_label
LEI_Code
name
SSM
/*
Exposure
Exposure_label
*/
NPL_ratio
Year
)
;

SET NPL_ratios_nb;

RUN; 

PROC SQL;
CREATE TABLE npl_analysis_nb AS 
SELECT
a.*,

b.'FP.CPI.TOTL.ZG'n AS infl_perc,
b.'FR.INR.RINR'n AS interest_perc,
b.'IC.ISV.DURS'n AS TimTOres_insol,
b.'IC.LGL.CRED.XQ'n AS Stgth_legal_index,
b.'NY.GDP.MKTP.KD.ZG'n AS GDP_growth_perc,
b.'NY.GDP.PCAP.CD'n AS GDP_per_cap_dol,
b.'NY.GDP.PCAP.KD.ZG'n AS GDP_per_cap_growth_perc,
b.'NY.GDP.PCAP.PP.CD'n AS GDP_per_cap_ppp,
b.'NY.GDP.PCAP.PP.KD'n AS GDP_per_cap_PPP_2017,
b.'NY.TTF.GNFS.KN'n AS Termsoftrade_adj_cnst,
b.'TT.PRI.MRCH.XD.WD'n AS Ne_termsoftrad_indx_2000,
b.'RESLV.ISV.DFRN.RC'n AS Reco_rate_dol_Score,
b.'RESLV.ISV.RCOV.RT'n AS Reco_rate_dol,
b.'Unemployment rate'n AS unempl_rate_imf,
b.'General government net lending/b'n AS gov_net_lend_bor_imf,
b.'Inflation, average consumer pric'n AS infl_avrg_imf,
b.'Inflation, end of period consume'n AS infl_eop_imf,
b.'Current account balance'n AS curr_acc_bal,

c.bankSize_tran,

d.cet1_ratio,

e.cet1_ratio_tr,

f.cet1_rt_calc,

g.cet1_rt_tr_calc,

h.cost_to_income,

i.forbear_ratio,

j.lever_ratio,

k.lever_ratio_calc,

l.lever_tr_ratio,

m.lever_tr_ratio_calc,

n.nfci,

o.nii,

p.nim,

q.nim_tr,

r.rorac,

s.rorwa,

t.t1_ratio,

u.t1_ratio_calc,

v.tcap_ratio,

w.banksize_full
	
FROM NPL_ratios1_nb AS a
	LEFT JOIN MACRDATA.COUNTRY_MACRO_WEIGHTED AS b 
	ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code
		LEFT JOIN banksize_tran_mod AS   c /*banksize_tran_mod*/ 
		ON a.Period_nm=c.Period_nm AND a.LEI_Code= c.LEI_Code
			LEFT JOIN bankspec.cet1_ratio AS d
			ON a.Period_nm=d.Period_nm AND a.LEI_Code= d.LEI_Code
				LEFT JOIN bankspec.cet1_ratio_tr AS e
				ON a.Period_nm=e.Period_nm AND a.LEI_Code= e.LEI_Code
					LEFT JOIN bankspec.cet1_rt_calc AS f
					ON a.Period_nm=f.Period_nm AND a.LEI_Code= f.LEI_Code
						LEFT JOIN bankspec.cet1_rt_tr_calc AS g
						ON a.Period_nm=g.Period_nm AND a.LEI_Code= g.LEI_Code
							LEFT JOIN bankspec.cost_to_income  AS h
							ON a.Period_nm=h.Period_nm AND a.LEI_Code= h.LEI_Code
								LEFT JOIN  bankspec.forbear_ratio_nb AS i
								ON a.Period_nm=i.Period_nm AND a.LEI_Code= i.LEI_Code /*****AND a.exposure=i.exposure*******/
									LEFT JOIN  bankspec.lever_ratio AS j
									ON a.Period_nm=j.Period_nm AND a.LEI_Code= j.LEI_Code
										LEFT JOIN bankspec.lever_ratio_calc AS k
										ON a.Period_nm=k.Period_nm AND a.LEI_Code= k.LEI_Code
											LEFT JOIN lever_tr_ratio_mod  AS l /*work.lever_tr_ratio_mod*/ 
											ON a.Period_nm=l.Period_nm AND a.LEI_Code= l.LEI_Code
												LEFT JOIN lever_tr_ratio_calc_mod  AS m /*work.lever_tr_ratio_calc_mod*/ 
												ON a.Period_nm=m.Period_nm AND a.LEI_Code= m.LEI_Code
													LEFT JOIN bankspec.nfci  AS n
													ON a.Period_nm=n.Period_nm AND a.LEI_Code= n.LEI_Code
														LEFT JOIN  bankspec.nii AS o
														ON a.Period_nm=o.Period_nm AND a.LEI_Code= o.LEI_Code
															LEFT JOIN  bankspec.nim AS p
															ON a.Period_nm=p.Period_nm AND a.LEI_Code= p.LEI_Code
																LEFT JOIN bankspec.nim_tr AS q
																ON a.Period_nm=q.Period_nm AND a.LEI_Code= q.LEI_Code
																	LEFT JOIN bankspec.rorac  AS r
																	ON a.Period_nm=r.Period_nm AND a.LEI_Code= r.LEI_Code
																		LEFT JOIN bankspec.rorwa  AS s
																		ON a.Period_nm=s.Period_nm AND a.LEI_Code= s.LEI_Code
																			LEFT JOIN  bankspec.t1_ratio AS t
																			ON a.Period_nm=t.Period_nm AND a.LEI_Code= t.LEI_Code
																				LEFT JOIN bankspec.t1_ratio_calc AS u
																				ON a.Period_nm=u.Period_nm AND a.LEI_Code= u.LEI_Code
																					LEFT JOIN bankspec.tcap_ratio  AS v
																					ON a.Period_nm=v.Period_nm AND a.LEI_Code= v.LEI_Code
																						LEFT JOIN bankspec.bankSize_full  AS w
																						ON a.Period_nm= w.Period_nm AND a.LEI_Code= w.LEI_Code;
																					
QUIT;






data npl_analysis1_nb(drop = i);
   set npl_analysis_nb;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.npl_dataset_nb;

SET npl_analysis1_nb;

period_cha=PUT(period_nm, YYMMN6. );

RUN; 


/*SORTING DATA SETS*/

PROC SORT DATA= EBA.NPL_DATASET;
BY 
NSA
nsa_label
name
LEI_Code
Period_nm
exposure
;
RUN; 

PROC SORT DATA= EBA.NPL_DATASET_nb;
BY 
NSA
nsa_label
name
LEI_Code
Period_nm
/*exposure*/
;
RUN; 



Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';


/***BEGIN----AD-Hoc Introduction of bank-specific fields-----***/
	*
i.forbear_ratio,
LEFT JOIN  bankspec.forbear_ratio_nb AS i
	ON a.Period_nm=i.Period_nm AND a.LEI_Code= i.LEI_Code AND a.exposure=i.exposure;

DATA NPL_DATASET (DROP=forbear_ratio);

SET EBA.NPL_DATASET;

RUN; 

PROC SQL;
CREATE TABLE npl_dataset1 AS
SELECT a.*,b.npl_0,b.npl_2,c.forbear_ratio
FROM NPL_DATASET As a
LEFT JOIN BankSpec.NPL_ratios  As b 
ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code AND a.exposure=b.exposure
LEFT JOIN bankspec.forbear_ratio  As c 
ON a.Period_nm=c.Period_nm AND a.LEI_Code= c.LEI_Code AND a.exposure=c.exposure;
QUIT;

data NPL_DATASET2(drop = i);
   set NPL_DATASET1;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.NPL_DATASET;

SET NPL_DATASET2;

RUN; 


/*nb*/

DATA NPL_DATASET_nb (DROP=forbear_ratio);

SET EBA.NPL_DATASET_nb;

RUN; 




PROC SQL;
CREATE TABLE npl_dataset_nb1 AS
SELECT a.*,b.npl_0,b.npl_2,c.forbear_ratio
FROM NPL_DATASET_nb As a
LEFT JOIN BankSpec.NPL_ratios_nb  As b 
ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code 
LEFT JOIN bankspec.forbear_ratio_nb  As c 
ON a.Period_nm=c.Period_nm AND a.LEI_Code= c.LEI_Code;
QUIT;


data NPL_DATASET_nb2(drop = i);
   set NPL_DATASET_nb1;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;


DATA EBA.NPL_DATASET_nb;

SET  NPL_DATASET_nb2;

RUN; 

/***END----AD-Hoc Introduction of bank-specific fields-----***/



/***BEGIN----AD-Hoc Introduction of macro fields-----***/

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';

*To introduce new macro variables you need: 

MACRDATA.COUNTRY_MACRO_WEIGHTED -> final table
EBA.cre_exp_country_weight_excl-> only the weigthed exposures;

DATA cre_exp_country_weight_excl;
SET EBA.cre_exp_country_weight_excl;
RUN; 

DATA COUNTRY_MACRO_WEIGHTED;
SET MACRDATA.COUNTRY_MACRO_WEIGHTED;
RUN; 



%LET folder= IMF_Public_Debt;
%LET path= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx/Macro_data;

%LET xls_temp = &path./&folder./;
%PUT &xls_temp;

%LET location= &xls_temp.;
%LET regex= csv;
%PUT &location. &regex.;

%macro get_filenames(location,regex,filestable);
	filename _dir_ "%bquote(&location.)";
data &filestable._&regex. (keep=fname);
	handle=dopen( '_dir_' );
	if handle > 0 then do;
		count=dnum(handle);
		do i=1 to count;
			fname=dread(handle,i);

			/*
			date_1= strip(prxchange('s/(\D*)(\d*)(\D*)/$2/i',-1,fname));
			year= input(substr(date_1,1,4),4.);
			Month=input(substr(date_1,5,6),2.);
			day=  input(substr(date_1,7,8),2.);
			date_f= mdy(Month,day,year)*1 ; format date_f date9.;
			*/

			patternID = prxparse('m/' || "&regex." || '/i');
			position = input(prxmatch(patternID, fname) - 1, best32.);
			fname = strip("&location." || fname);
			
			if position ne -1 /*and date_f >= &Start_date. */ then do;*;
				output &filestable._&regex. ;
			end;
			%PUT &filestable.;
		end;
	end;
	rc=dclose(handle);


run;


PROC SORT data= &filestable._&regex. ; by descending fname; run;


filename _dir_ clear;
 
DATA &filestable._&regex. (DROP= t3);

SET &filestable._&regex.;

 t3= strip(prxmatch('/\$/i',	fname ));

IF t3 > 0 THEN DELETE;



RUN;

DATA  Macrdata.&filestable._&regex. ;

SET &filestable._&regex. ;


if _n_=1 then do;

retain re_dec;
*retain re_dec2;
*retain re_ndec;

re_dec = prxparse('/\/([^\/]*)\.xlsx/i');
*re_dec2 = prxparse('/\\\w+\./i');
*re_ndec = prxparse('/((\d+)(\.)?\d+)+/i');

end;

call prxsubstr(re_dec,fname,re_start_1,re_end_1);
name_file = substrn(fname, re_start_1, re_end_1);
name_file= prxchange('s/(\/)|(.xlsx)//',-1,strip(name_file));

*call prxsubstr(re_dec2,name_file,re_start_2,re_end_2);

*name_file2= substrn(name_file, re_start_2, re_end_2);


RUN; 

%mend;


*%LET output= "WorldBank_Data";

%get_filenames(location=&location, regex=&regex, filestable=&folder.);



/* Import the Excel sheets that are located in the filestable_regex table with the given sheet. */

%macro import_excel_2(filestable, regex);
	%local nobs iter;
	proc sql noprint;
		select count(*) into : nobs
	from &filestable._&regex. ;
	quit;

	%let iter=1;

		DATA macrdata.&folder.;

		LENGTH 
		/*'ISO'n $3*/
		'Country'n $32
		'Subject Descriptor'n $75
		'Units'n $28		
		'Country/Series-specific Notes'n $900
		'2014'n-'2019'n $20;
		FORMAT
		/*'ISO'n $3.*/
		'Country'n $32.
		'Subject Descriptor'n $75.
		'Units'n $28.		
		'Country/Series-specific Notes'n $900.
		'2014'n-'2019'n $20.;

		CALL missing(of _all_);
		if _N_ = 0 THEN OUTPUT;

		RUN;






		data _NULL_;
			set &filestable._&regex.  (firstobs=&iter. obs=&iter.);
			call symput("fname", strip(fname));
			*call symput("output", substrn(name_file,1,6));
			call symput("output", "&folder.");
		run;

			/****************IMPORTS ALL FIELDS AS CHARACTER FROM CSV FILES*********************/
			  filename holdit "&xls_temp.&output.2.csv" lrecl=32000;
		 
		   * Point to the csv file;
		   filename rawcsv "&fname."  lrecl=32000;
		 
		   data _NULL_ ;
		      file holdit;
		      infile rawcsv end=done;
		 
		      * Read the first observation (variable names);
		      input;
		 
		      * Write the var names;
		      put _infile_;
		      * Count the variables (the names are comma separated);
		      wcount = countw(_infile_,';');
		      * Write an asterisk for each variable - forces each to be character;
		      * but will not set the var length;
		       string = catt('*',repeat(';*',wcount-2));
		      put string;
		 
		      * Read and write the data portion of the raw data;
		      do until(done);
		         input;
		         **********
		         *  Pre processing of the data could be done here
		         **********;
		         * Write the record;
		         put _infile_;
		      end;
		      stop;
		      run;


			  * Read the Altered CSV file into a SAS dataset;
		   PROC IMPORT OUT= &output.
		               DATAFILE= holdit 
		               DBMS= CSV 
		               REPLACE;
					   delimiter=';';
		      guessingrows=10000;
		      GETNAMES=YES;
		      DATAROW=2; 
		      run;
		   * Clear the filerefs for the next data set;
		  * filename holdit;
		   *filename rawcsv;

		


	proc append base = macrdata.&folder. data= &output. FORCE;quit;
	
DATA macrdata.&folder.;
SET macrdata.&folder.;
IF _N_ = 1 THEN DELETE;
RUN; 


PROC SORT DATA= macrdata.&folder. ; BY country;RUN;

%mend;


%import_excel_2(filestable=&folder., regex=&regex);


PROC SORT DATA= MACRDATA.IMF_ALL OUT= IMF_ALL_np NODUPKEY; BY ISO country;RUN;

PROC SORT DATA= MACRDATA.IMF_PUBLIC_DEBT OUT=IMF_PUBLIC_DEBT_1 ; BY country;RUN;
PROC SORT DATA= IMF_ALL_np ; BY country;RUN;

DATA IMF_PUBLIC_DEBT_2  miss miss2;
MERGE IMF_PUBLIC_DEBT_1 (IN=_a) IMF_ALL_np(IN=_b KEEP= ISO country);
BY country;
IF _a and _b THEN OUTPUT  IMF_PUBLIC_DEBT_2;
IF NOT _a and _B THEN OUTPUT miss;
IF  _a and NOT _B THEN OUTPUT miss2;
RUN; 



%LET list1 = "General government gross debt,General government net debt,General government net lending/borrowing,General government revenue,General government total expenditure"; 

%MACRO publicdebt();

%DO i = 1 %TO %SYSFUNC(countw(&list1.,','));

	

			DATA _NULL_;

		    type =  strip(SCAN(&list1.,&i.,','));
			lgth=compress(lengthn(type));
		
		    format_type= compress('$'||lgth||.);
			CALL SYMPUT("type",type); 
			CALL SYMPUT("format_type",format_type); 
			CALL SYMPUT("lgth",lgth); 

			RUN; 

			%put &format_type. &lgth. &type.;

			DATA _NULL_;
			ty =   strip(input(substr(SCAN(&list1.,&i.,','),1,&lgth.),&format_type.));
			CALL SYMPUT("ty", ty);

			ty_txt =tranwrd(ty,' ', '_');
			ty_txt =tranwrd(ty_txt,'/', '_');
			ty_txt= substr(ty_txt,1,32);

			CALL SYMPUT("ty_txt", ty_txt);

			RUN;

			%put &ty. &ty_txt.;

	
DATA &ty_txt.;

SET IMF_PUBLIC_DEBT_2;

IF 'Subject Descriptor'n = %tslit(&ty.);

RUN; 


 
data _NULL_;
  if 0 then set &ty_txt.  nobs=n;
 put "no. of observations =" n;
  stop;
 run;

%END;

%MEND publicdebt;

%publicdebt();

PROC FREQ DATA= IMF_PUBLIC_DEBT_2;
TABLE 'Subject Descriptor'n ;
RUN; 

DATA macrdata.IMF_PUBLIC_DEBT;

SET IMF_PUBLIC_DEBT_2;

RUN;


data macrdata.IMF_PUBLIC_DEBT (drop = i);
   set macrdata.IMF_PUBLIC_DEBT ;
   array vars{*}  '2014'n-'2019'n;
;

   do i = 1 to dim(vars);

      IF vars[i] = 'n/a' THEN DELETE;
	  vars[i] =tranwrd(vars[i],'.', ',');


   end;
run;



proc contents
	data = macrdata.IMF_PUBLIC_DEBT
	out = vars2 (keep = name type length)
	noprint;

	run;

proc sql noprint;
     * create macro list of the numeric variables' names;
     select cats("'" ,name,"'n")
     into :numerics
          separated by ' '
     from vars2
     where  type= 2  AND length = 20;

	  * create macro list of the numeric variables' names with the suffix "C";

     select cats("'" ,trim(name),'C',"'n")
     into :characters
          separated by ' '
     from vars2
    where  type= 2  AND length = 20;

     * create macro list of the conversion from the original name to the new name with the suffix "C";
     select cats("'" ,name,"'n", ' = ' ,"'" ,trim(name),'C',"'n")
     into :conversions
          separated by ' '
     from vars2
    where  type= 2  AND length = 20;
quit;


	 %put &numerics. &characters &conversions;

	 * use the macro list "&conversions" to add the suffix "C" to the numeric variables' names;
	 
		proc datasets 
		library = macrdata 
		nolist;
		modify IMF_PUBLIC_DEBT;
		rename &conversions;
		quit;


		* some of the character variables in "basketball1" are character, but should actually be numeric;
* let's convert them into numeric format;
data macrdata.IMF_PUBLIC_DEBT_all;
     set macrdata.IMF_PUBLIC_DEBT;

     array nums[*] &numerics;
     array chars[*] &characters;

     do i = 1 to dim(nums);
          nums[i] = input(chars[i], commax8.4);
     end;

     drop i &characters;

	 IF missing('country'n)= 1 THEN DELETE;
run;


%LET exclude= '2014'n-'2019'n ; 
%put &exclude;

proc contents data = macrdata.IMF_PUBLIC_DEBT_all  (Drop= &exclude. ) out = varname1 (keep = name) noprint;
run;

proc sql noprint;
select cats("'",name,"'n") into :textlist1 separated by " " from varname1;
quit;

%put &textlist1.;	

PROC SORT DATA= macrdata.IMF_PUBLIC_DEBT_all;
BY 	&textlist1.;
RUN;

proc transpose data= macrdata.IMF_PUBLIC_DEBT_all out= macrdata.IMF_PUBLIC_DEBT_ver (RENAME=(Col1=Value _Name_= Year));
   by 

&textlist1.;

run;

PROC SORT DATA= macrdata.IMF_PUBLIC_DEBT_ver ; BY 	&textlist1. year descending value; RUN; 
PROC SORT DATA= macrdata.IMF_PUBLIC_DEBT_ver NODUPKEY ; BY 	&textlist1. year ; RUN; 

%LET exclude2= 'Subject Descriptor'n   Value ;
	%LET exclude3= 'Units'n 'Country/Series-specific Notes'n; 
	%put &exclude2 &exclude3 ;

	proc contents data = macrdata.IMF_PUBLIC_DEBT_ver  (Drop= &exclude2. &exclude3.) out = varname2 (keep = name) noprint;
	run;

	proc sql noprint;
	select cats("'",name,"'n") into :textlist2 separated by " " from varname2;
	quit;
	%put &textlist2.;	

	PROC SORT DATA= macrdata.IMF_PUBLIC_DEBT_ver ;
	BY 	&textlist2.;
	RUN;

	PROC TRANSPOSE DATA= macrdata.IMF_PUBLIC_DEBT_ver (DROP=&exclude3.)

	OUT= macrdata.IMF_PUBLIC_DEBT_hor;
	BY   
	&textlist2.;
	VAR Value;
	ID 'Subject Descriptor'n;
	RUN;

	PROC SORT DATA= macrdata.IMF_PUBLIC_DEBT_ver (Keep= 'Subject Descriptor'n 'Units'n ) Out= macrdata.IMF_PUBLIC_DEBT_map Nodupkey;
	BY  'Subject Descriptor'n 'Units'n;
	RUN;



%LET year_beg= 2014;
%LET year_end= 2019;

DATA COUNTRY_WEIGHT_Anal;

SET EBA.CRE_EXP_COUNTRY_WEIGHT_EXCL;

Year= year(period_nm) ;
IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;

RUN; 

PROC FREQ DATA= COUNTRY_WEIGHT_Anal; TABLE period_nm year; RUN; 


%LET KEEP=
Year
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label
ori_exp_wg;

%PUT &KEEP.;

DATA COUNTRY_WEIGHT_Anal_1 (drop=year);
RETAIN &KEEP.;
SET COUNTRY_WEIGHT_Anal (KEEP= &KEEP.);
YearC=put(year,$8.);
*Rename YearC=year;

RUN; 

DATA COUNTRY_WEIGHT_Anal_2 (DROP= yearC);
SET COUNTRY_WEIGHT_Anal_1;
year=strip(yearC);
ISO_code3_dest=strip(ISO_code3_dest);

RUN; 


PROC SQL;
CREATE TABLE COUNTRY_WEIGHT_Anal_3 AS
SELECT
a.*,
b.'General government net debt'n AS net_public_debt,
b.'General government gross debt'n AS gross_public_debt,
b.'General government net lending/b'n AS Fiscal_Deficit,
b.'General government revenue'n AS Public_Revenue,
b.'General government total expendi'n AS Public_expenditure

FROM COUNTRY_WEIGHT_Anal_2  AS a
	LEFT JOIN MACRDATA.IMF_PUBLIC_DEBT_HOR  AS b
	ON a.Year =b.Year AND a.ISO_code3_dest=b.ISO;

QUIT; 

PROC SORT DATA= COUNTRY_WEIGHT_Anal_3  OUT= COUNTRY_WEIGHT_mg; BY YEAR ISO_code3_dest; RUN;

PROC SORT DATA= MACRDATA.IMF_PUBLIC_DEBT_HOR OUT= IMF_PUBLIC_DEBT_HOR_mg (RENAME=(ISO= ISO_code3_dest)); BY YEAR  ISO; RUN;

*PROC SORT DATA= WORLD_BANK_ALL_mg  ; *BY year ISO_code3_dest Descending 'FP.CPI.TOTL.ZG'n-'RESLV.ISV.RCOV.RT'n;* RUN; 

*PROC SORT DATA= IMF_PUBLIC_DEBT_HOR_mg (KEEP= ISO_code3_dest Country YEAR)   OUT= IMF_PD_countries nodupkey; *BY YEAR ISO_code3_dest  ; *RUN; 



DATA COUNTRY_WEIGHT_Anal_3_1 missing_IMF ;
MERGE COUNTRY_WEIGHT_mg(IN=_A) IMF_PUBLIC_DEBT_HOR_mg (IN=_B);
BY YEAR ISO_code3_dest;
IF _A THEN OUTPUT COUNTRY_WEIGHT_Anal_3_1; 
IF _A AND NOT _B THEN OUTPUT missing_IMF;

RUN;




PROC SORT DATA=  COUNTRY_WEIGHT_Anal_3_1 OUT= macrdata.COUNTRY_MACRO_WEIGHT_Data2 NODUPKEY; BY period_nm LEI_code ISO_code3_dest; RUN;


%LET KEEP=
year
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label
ori_exp_wg
 net_public_debt
gross_public_debt
 Fiscal_Deficit
 Public_Revenue
Public_expenditure;

%PUT &KEEP.;

DATA macrdata.COUNTRY_MACRO_WEIGHT_Data2;
RETAIN &KEEP.;
SET macrdata.COUNTRY_MACRO_WEIGHT_Data2(KEEP= &KEEP.);

RUN; 

PROC SORT DATA= macrdata.COUNTRY_MACRO_WEIGHT_Data2; BY year NSA LEI_code ISO_code3_dest; RUN; 



data COUNTRY_MACRO(drop = i);
   set macrdata.COUNTRY_MACRO_WEIGHT_Data2;
   array vars{*} 

net_public_debt
gross_public_debt
Fiscal_Deficit
Public_Revenue
Public_expenditure;

   do i = 1 to dim(vars);
      vars[i] = vars[i] * ori_exp_wg;
   end;
run;

Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';

	PROC MEANS DATA = COUNTRY_MACRO sum n nway noprint ;
	CLASS 
	year
	Period_nm
	Name
	LEI_Code
	NSA
	nsa_label
	SSM
;
	VAR 
	ori_exp_wg	
	net_public_debt
	gross_public_debt
	Fiscal_Deficit
	Public_Revenue
	Public_expenditure
;
	OUTPUT OUT= Macrdata.COUNTRY_MACRO_weighted2 (DROP = _TYPE_ _FREQ_)  sum = n= NO_Coutries_dest;
	RUN;




DATA NPL_DATASET (DROP= gov_net_lend_bor_imf);

SET EBA.NPL_DATASET;

RUN; 

PROC SQL;
CREATE TABLE npl_dataset1 AS
SELECT a.*,
b.net_public_debt,
b.gross_public_debt,
b.Fiscal_Deficit,
b.Public_Revenue,
b.Public_expenditure
FROM NPL_DATASET As a
LEFT JOIN Macrdata.COUNTRY_MACRO_weighted2  As b 
ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code
;
QUIT;

data NPL_DATASET2(drop = i);
   set NPL_DATASET1;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.NPL_DATASET;

SET NPL_DATASET2;

RUN; 


/*nb*/

DATA NPL_DATASET_nb (DROP= gov_net_lend_bor_imf);

SET EBA.NPL_DATASET_nb;

RUN; 




PROC SQL;
CREATE TABLE npl_dataset_nb1 AS
SELECT a.*,
b.net_public_debt,
b.gross_public_debt,
b.Fiscal_Deficit,
b.Public_Revenue,
b.Public_expenditure
FROM NPL_DATASET_nb As a
LEFT JOIN Macrdata.COUNTRY_MACRO_weighted2  As b 
ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code
;
QUIT;

data NPL_DATASET_nb2(drop = i);
   set NPL_DATASET_nb1;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;


DATA EBA.NPL_DATASET_nb;

SET  NPL_DATASET_nb2;

RUN; 



/***END----AD-Hoc Introduction of macro fields-----***/




%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=  EBA.npl_dataset OUTFILE="&xls_dir./npl_dataset.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
PROC EXPORT DATA=  EBA.npl_dataset_nb OUTFILE="&xls_dir./npl_dataset_nb.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;




/**********************  BEGIN-Introduce total values for bank-specific variables*******************************/

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';

DATA NPL_DATASET;

SET EBA.NPL_DATASET;

RUN; 

PROC SQL;
CREATE TABLE npl_analysis AS 
SELECT
a.*,

b.'2020605'n AS forbear_ratio_deno,
b.'2020705'n As forbear_ratio_nume
FROM NPL_DATASET AS a
	LEFT JOIN  bankspec.forbear_ratio AS B
	ON a.Period_nm=B.Period_nm AND a.LEI_Code= B.LEI_Code AND a.exposure=B.exposure	;
																																																			
QUIT;


data npl_analysis1(drop = i);
   set npl_analysis;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.npl_dataset;

SET npl_analysis1;

period_cha=PUT(period_nm, YYMMN6. );

RUN; 


/*NPL RATIOS(NO BREAKDOWN)*/

DATA NPL_DATASET_nb;

SET EBA.NPL_DATASET_nb;

RUN; 


PROC SQL;
CREATE TABLE npl_analysis_nb AS 
SELECT
a.*,

b.'2020220'n As cet1_calc_deno,
b.'2020143'n AS cet1_calc_nume,

c.'2020220'n AS cet1_tr_calc_deno,
c.'2020102'n AS cet1_tr_calc_nume,

d.cost,
d.income,

e.'2020605'n AS forbear_ratio_deno,
e.'2020705'n As forbear_ratio_nume,

f.'2020904'n AS lever_calc_deno,
f.'2020902'n AS lever_calc_nume,

g.'2020903'n AS lever_tr_calc_deno,
g.'2020901'n AS lever_tr_calc_nume,

h.'2020316'n AS nfci_deno,
h.'2020309'n AS nfci_nume,

i.'2020316'n AS  nii_deno,
(i.'2020301'n - i.'2020304'n) AS  nii_nume,

j.'2020904'n AS  nim_deno,
(j.'2020301'n - j.'2020304'n) AS  nim_nume,

k.'2020903'n AS  nim_tr_deno,
(k.'2020301'n - k.'2020304'n) AS  nim_tr_nume,

l.'2020133'n AS rorac_deno,
l.'2020335'n AS rorac_nume,

m.'2020220'n AS rorwa_deno,
m.'2020335'n AS rorwa_nume,

n.'2020220'n AS t1_calc_deno, 
n.'2020133'n AS t1_calc_nume
	
FROM NPL_DATASET_nb AS a	
					LEFT JOIN bankspec.cet1_rt_calc AS b
					ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code
						LEFT JOIN bankspec.cet1_rt_tr_calc AS c
						ON a.Period_nm=c.Period_nm AND a.LEI_Code= c.LEI_Code
							LEFT JOIN bankspec.cost_to_income  AS d
							ON a.Period_nm=d.Period_nm AND a.LEI_Code= d.LEI_Code
								LEFT JOIN  bankspec.forbear_ratio_nb AS e
								ON a.Period_nm=e.Period_nm AND a.LEI_Code= e.LEI_Code /*****AND a.exposure=i.exposure*******/	
										LEFT JOIN bankspec.lever_ratio_calc AS f
										ON a.Period_nm=f.Period_nm AND a.LEI_Code= f.LEI_Code									
												LEFT JOIN bankspec.lever_tr_ratio_calc  AS g /*work.lever_tr_ratio_calc_mod*/ 
												ON a.Period_nm=g.Period_nm AND a.LEI_Code= g.LEI_Code
													LEFT JOIN bankspec.nfci  AS h
													ON a.Period_nm=h.Period_nm AND a.LEI_Code= h.LEI_Code
														LEFT JOIN  bankspec.nii AS i
														ON a.Period_nm=i.Period_nm AND a.LEI_Code= i.LEI_Code
															LEFT JOIN  bankspec.nim AS j
															ON a.Period_nm=j.Period_nm AND a.LEI_Code= j.LEI_Code
																LEFT JOIN bankspec.nim_tr AS k
																ON a.Period_nm=k.Period_nm AND a.LEI_Code= k.LEI_Code
																	LEFT JOIN bankspec.rorac  AS l
																	ON a.Period_nm=l.Period_nm AND a.LEI_Code= l.LEI_Code
																		LEFT JOIN bankspec.rorwa  AS m
																		ON a.Period_nm=m.Period_nm AND a.LEI_Code= m.LEI_Code
																				LEFT JOIN bankspec.t1_ratio_calc AS n
																				ON a.Period_nm=n.Period_nm AND a.LEI_Code= n.LEI_Code;
																	
																				
																					
QUIT;






data npl_analysis1_nb(drop = i);
   set npl_analysis_nb;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.npl_dataset_nb;

SET npl_analysis1_nb;

period_cha=PUT(period_nm, YYMMN6. );

RUN; 


/*SORTING DATA SETS*/

PROC SORT DATA= EBA.NPL_DATASET;
BY 
NSA
nsa_label
name
LEI_Code
Period_nm
exposure
;
RUN; 

PROC SORT DATA= EBA.NPL_DATASET_nb;
BY 
NSA
nsa_label
name
LEI_Code
Period_nm
/*exposure*/
;
RUN; 




%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=  EBA.npl_dataset OUTFILE="&xls_dir./npl_dataset.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
PROC EXPORT DATA=  EBA.npl_dataset_nb OUTFILE="&xls_dir./npl_dataset_nb.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;



/**********************  END-Introduce total values for bank-specific variables*******************************/

/**********************  BEGIN-Create Geographic diversification Index/Hirschman-Herfindahl (HHI) Index and introduce it into Datasets*******************************/

Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';


%LET year_beg= 2014;
%LET year_end= 2019;

DATA COUNTRY_WEIGHT_Anal;

SET EBA.CRE_EXP_COUNTRY_WEIGHT_EXCL;

Year= year(period_nm) ;
IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;

RUN; 

*PROC FREQ DATA= COUNTRY_WEIGHT_Anal; *TABLE period_nm year;* RUN; 


%LET KEEP=
Year
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label

Country_Ori_exp
Total_Ori_exp
ori_exp_wg;

%PUT &KEEP.;

DATA COUNTRY_WEIGHT_Anal_1 (drop=year);
RETAIN &KEEP.;
SET COUNTRY_WEIGHT_Anal (KEEP= &KEEP.);
YearC=put(year,$8.);
*Rename YearC=year;

RUN; 

DATA COUNTRY_WEIGHT_Anal_2 (DROP= yearC);
SET COUNTRY_WEIGHT_Anal_1;

year=strip(yearC);
ISO_code3_dest=strip(ISO_code3_dest);

IF ISO_code_dest= NSA THEN home_country=1;
ELSE home_country=0 ;

ori_exp_wg_2= (ori_exp_wg)**2; format ori_exp_wg_2 commax20.10
RUN; 

PROC SORT DATA= COUNTRY_WEIGHT_Anal_2 ; BY Year LEI_Code  descending ori_exp_wg; RUN; 

DATA BankSpec.COUNTRY_diversification ;
RETAIN count; 
SET COUNTRY_WEIGHT_Anal_2;
BY Year LEI_Code;
IF first.year OR first.LEI_Code then count=0;

count+1;

RUN;

PROC SORT DATA= BankSpec.COUNTRY_diversification; BY NSA name year descending ori_exp_wg; RUN; 


	PROC MEANS DATA = BankSpec.COUNTRY_diversification sum n nway noprint ;
	CLASS 
	year
	period_nm
	Name
	LEI_Code
	NSA
	nsa_label
	SSM
;
	VAR 
	ori_exp_wg	
	ori_exp_wg_2
	Country_Ori_exp
;
	OUTPUT OUT= BankSpec.HHI_Index (DROP = _TYPE_ _FREQ_)  sum = n= NO_Countries_Ori_exp;
	RUN;

 PROC  SORT DATA= BankSpec.HHI_Index (RENAME =(ori_exp_wg_2=HHI_index)) ;BY nsa nsa_label name year; RUN; 

	*PROC  SORT DATA= HHI_Index OUT= BankSpec.banks_names (KEEP=name lei_code nsa nsa_label) NODUPKEY;*BY name; *RUN; 
	*PROC  SORT DATA= BankSpec.banks_names ;*BY nsa nsa_label name; *RUN; 

 	
DATA NPL_DATASET;

SET EBA.NPL_DATASET;

RUN; 

PROC SQL;
CREATE TABLE npl_analysis AS 
SELECT
a.*,

b.HHI_index,
b.Country_Ori_exp,
b.NO_Countries_Ori_exp 
FROM NPL_DATASET AS a
	LEFT JOIN  BankSpec.HHI_Index AS B
	ON a.Period_nm=B.Period_nm AND a.LEI_Code= B.LEI_Code;
																																																			
QUIT;


data npl_analysis1(drop = i);
   set npl_analysis;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.npl_dataset;

SET npl_analysis1;

period_cha=PUT(period_nm, YYMMN6. );

RUN; 

/*NPL RATIOS(NO BREAKDOWN)*/

DATA NPL_DATASET_nb;

SET EBA.NPL_DATASET_nb;

RUN; 


PROC SQL;
CREATE TABLE npl_analysis_nb AS 
SELECT
a.*,

b.HHI_index,
b.Country_Ori_exp,
b.NO_Countries_Ori_exp 
FROM NPL_DATASET_nb AS a
	LEFT JOIN  BankSpec.HHI_Index AS B
	ON a.Period_nm=B.Period_nm AND a.LEI_Code= B.LEI_Code;
																																																			
QUIT;


data npl_analysis_nb1(drop = i);
   set npl_analysis_nb;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.npl_dataset_nb;

SET npl_analysis_nb1;

period_cha=PUT(period_nm, YYMMN6. );

RUN; 


/*SORTING DATA SETS*/

PROC SORT DATA= EBA.NPL_DATASET;
BY 
NSA
nsa_label
name
LEI_Code
Period_nm
exposure
;
RUN; 

PROC SORT DATA= EBA.NPL_DATASET_nb;
BY 
NSA
nsa_label
name
LEI_Code
Period_nm
/*exposure*/
;
RUN; 



%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=  EBA.npl_dataset OUTFILE="&xls_dir./npl_dataset.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
PROC EXPORT DATA=  EBA.npl_dataset_nb OUTFILE="&xls_dir./npl_dataset_nb.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
	


PROC EXPORT DATA=  BankSpec.HHI_Index OUTFILE="&xls_dir./HHI_Index.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
PROC EXPORT DATA=  BankSpec.COUNTRY_diversification OUTFILE="&xls_dir./COUNTRY_diversification.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;

/**********************  END-Create Geographic diversification Index/Hirschman-Herfindahl (HHI) Index and introduce it into Datasets*******************************/

/***************** BEGIN: AD-HOC RESOLVING ISSUE MISSING DATA FROM RECOVERY_RATES: RESLV.ISV.DFRN.RC	RESLV.ISV.RCOV.RT***************************/



Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';

*To introduce new macro variables you need: 

MACRDATA.COUNTRY_MACRO_WEIGHTED -> final table
EBA.cre_exp_country_weight_excl-> only the weigthed exposures;

DATA cre_exp_country_weight_excl;
SET EBA.cre_exp_country_weight_excl;
RUN; 

DATA COUNTRY_MACRO_WEIGHTED;
SET MACRDATA.COUNTRY_MACRO_WEIGHTED;
RUN; 

*macrdata.WORLD_BANK_ALL_VER;

DATA MACRDATA.Recovery_rates_ver ;

SET MACRDATA.WORLD_BANK_ALL_VER;

IF   'Indicator Code'n in ("RESLV.ISV.DFRN.RC",	"RESLV.ISV.RCOV.RT") ;
RUN; 

%LET exclude2= 'Indicator Code'n   Value ;
	%LET exclude3= 'Indicator Name'n; 
	%put &exclude2 &exclude3 ;
	proc contents data = MACRDATA.Recovery_rates_ver  (Drop= &exclude2. &exclude3.) out = varname2 (keep = name) noprint;
	run;

	proc sql noprint;
	select cats("'",name,"'n") into :textlist2 separated by " " from varname2;
	quit;
	%put &textlist2.;	

	PROC SORT DATA= MACRDATA.Recovery_rates_ver ;
	BY 	&textlist2.;
	RUN;

	PROC TRANSPOSE DATA= MACRDATA.Recovery_rates_ver (DROP=&exclude3.)

	OUT= MACRDATA.Recovery_rates_hor;
	BY   
	&textlist2.;
	VAR Value;
	ID 'Indicator Code'n;
	RUN;


	
	DATA Recovery_data
	(KEEP=
	'Country Code'n
	'Country Name'n
	 year 
	'RESLV.ISV.DFRN.RC'n
	'RESLV.ISV.RCOV.RT'n
);

	SET MACRDATA.Recovery_rates_hor;

	IF 'Country Name'n = "Côte d'Ivoire" THEN 'Country Name'n = "Cote d'Ivoire" ;

	*miss= input(cats('RESLV.ISV.DFRN.RC'n,'RESLV.ISV.RCOV.RT'n),10.);
	*IF miss <= 0 then delete;

	RUN ;

	
DATA MACRDATA.Recovery_rates_hor 
(DROP= 
'RESLV.ISV.DFRN.RC'n
'RESLV.ISV.RCOV.RT'n);

SET &folder._all_hor;

IF 'Country Name'n = "Côte d'Ivoire" THEN DELETE;
IF 'Country Name'n = "Hong Kong, China" THEN DELETE;

IF 'Country Name'n = "Hong Kong SAR, China" THEN 'Country Name'n = "Hong Kong, China" ;

RUN; 

PROC SORT DATA= MACRDATA.Recovery_rates_hor ; BY 'Country Code'n 'Country Name'n year; RUN; 

PROC SORT DATA= Recovery_data; BY 'Country Code'n 'Country Name'n year; RUN; 

DATA MACRDATA.Recovery_rates_hor;
MERGE MACRDATA.Recovery_rates_hor (IN= a) Recovery_data (IN= b);
BY 'Country Code'n 'Country Name'n year;
IF a;
RUN; 


DATA MACRDATA.Recovery_rates_hor;

SET MACRDATA.Recovery_rates_hor;

IF strip('Country Code'n) = 'RUS' and strip('Country Name'n) ne 'Russian Federation' THEN DELETE;
IF strip('Country Code'n)= 'BRA' and strip('Country Name'n) ne 'Brazil' THEN DELETE;*;
IF strip('Country Code'n) = 'CHN' and strip('Country Name'n)ne 'China' THEN DELETE;*;
IF strip('Country Code'n) = 'USA' and strip('Country Name'n) ne 'United States' THEN DELETE;
IF strip('Country Code'n) = 'BGD' and strip('Country Name'n) ne 'Bangladesh' THEN DELETE;*;
IF strip('Country Code'n) = 'IDN' and strip('Country Name'n) ne 'Indonesia' THEN DELETE;*;
IF strip('Country Code'n) = 'IND' and strip('Country Name'n) ne 'India' THEN DELETE;*;
IF strip('Country Code'n) = 'JPN' and strip('Country Name'n) ne 'Japan' THEN DELETE;*;
IF strip('Country Code'n) = 'MEX' and strip('Country Name'n) ne 'Mexico' THEN DELETE;*;
IF strip('Country Code'n) = 'NGA' and strip('Country Name'n) ne 'Nigeria' THEN DELETE;*;
IF strip('Country Code'n) = 'PAK' and strip('Country Name'n) ne 'Pakistan' THEN DELETE;*;
IF strip('Country Code'n) = 'STP' and strip('Country Name'n) ne 'Sao Tome and Principe' THEN DELETE;*;

RUN; 

/*PROC FREQ DATA= MACRDATA.Recovery_rates_hor;
TABLE 'Country code'n;
RUN;



PROC FREQ DATA= EBA.CRE_EXP_COUNTRY_WEIGHT_EXCL; TABLE period_nm; RUN; 
*/
%LET year_beg= 2014;
%LET year_end= 2019;

DATA COUNTRY_WEIGHT_Anal;

SET EBA.CRE_EXP_COUNTRY_WEIGHT_EXCL;

Year= year(period_nm) ;
IF   (&year_beg. <= Year <= &year_end.) AND month(period_nm)=12;

RUN; 

*PROC FREQ DATA= COUNTRY_WEIGHT_Anal; *TABLE period_nm year; *RUN; 


%LET KEEP=
Year
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label
ori_exp_wg;

%PUT &KEEP.;

DATA COUNTRY_WEIGHT_Anal_1 (drop=year);
RETAIN &KEEP.;
SET COUNTRY_WEIGHT_Anal (KEEP= &KEEP.);
YearC=put(year,$8.);
*Rename YearC=year;

RUN; 

DATA COUNTRY_WEIGHT_Anal_2 (DROP= yearC);
SET COUNTRY_WEIGHT_Anal_1;
year=strip(yearC);
ISO_code3_dest=strip(ISO_code3_dest);

RUN; 


PROC SQL;
CREATE TABLE COUNTRY_WEIGHT_Anal_3 AS
SELECT
a.*,
b.year As year_b,
b.'Country Code'n,
b.'RESLV.ISV.DFRN.RC'n,
b.'RESLV.ISV.RCOV.RT'n

FROM COUNTRY_WEIGHT_Anal_2  AS a
	LEFT JOIN MACRDATA.Recovery_rates_hor  AS b
	ON a.Year =b.Year AND a.ISO_code3_dest=b.'Country Code'n;
	
QUIT; 

PROC SORT DATA= COUNTRY_WEIGHT_Anal_2  OUT= COUNTRY_WEIGHT_mg; BY YEAR ISO_code3_dest; RUN;

PROC SORT DATA= MACRDATA.Recovery_rates_hor OUT= Recovery_rates_ALL_mg (RENAME=('Country Code'n= ISO_code3_dest)); BY YEAR  'Country Code'n; RUN;

*PROC SORT DATA= WORLD_BANK_ALL_mg  ; *BY year ISO_code3_dest Descending 'FP.CPI.TOTL.ZG'n-'RESLV.ISV.RCOV.RT'n;* RUN; 

PROC SORT DATA= Recovery_rates_ALL_mg (KEEP= ISO_code3_dest 'Country Name'n)   OUT= Recovery_rates_countries nodupkey; BY ISO_code3_dest 'Country Name'n ; RUN; 


DATA COUNTRY_WEIGHT_Anal_3_1 missing_recov;
MERGE COUNTRY_WEIGHT_mg(IN=_A) Recovery_rates_ALL_mg(IN=_B);
BY YEAR ISO_code3_dest;
IF _A THEN OUTPUT COUNTRY_WEIGHT_Anal_3_1; 
IF _A AND NOT _B THEN OUTPUT missing_recov;

RUN;




PROC SORT DATA=  COUNTRY_WEIGHT_Anal_3_1 OUT= MACRDATA.Recovery_rates_Data NODUPKEY; BY period_nm LEI_code ISO_code3_dest; RUN;


%LET KEEP=
year
Period_nm
Name
LEI_Code
NSA
nsa_label
SSM
ISO_code_dest
ISO_code3_dest
Country_label
ori_exp_wg
'RESLV.ISV.DFRN.RC'n
'RESLV.ISV.RCOV.RT'n;

%PUT &KEEP.;

DATA MACRDATA.Recovery_rates_Data;
RETAIN &KEEP.;
SET MACRDATA.Recovery_rates_Data (KEEP= &KEEP.);

RUN; 

PROC SORT DATA= MACRDATA.Recovery_rates_Data; BY year NSA LEI_code ISO_code3_dest; RUN; 


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;


PROC EXPORT DATA=  MACRDATA.Recovery_rates_Data  OUTFILE="&xls_dir./Recovery_rates_Data.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;


data COUNTRY_MACRO(drop = i);
   set MACRDATA.Recovery_rates_Data;
   array vars{*} 
'RESLV.ISV.DFRN.RC'n
'RESLV.ISV.RCOV.RT'n;



   do i = 1 to dim(vars);
      vars[i] = vars[i] * ori_exp_wg;
   end;
run;


	PROC MEANS DATA = COUNTRY_MACRO sum n nway noprint ;
	CLASS 
	year
	Period_nm
	Name
	LEI_Code
	NSA
	nsa_label
	SSM
;
	VAR 
	ori_exp_wg
'RESLV.ISV.DFRN.RC'n
'RESLV.ISV.RCOV.RT'n;

	OUTPUT OUT= MACRDATA.Recovery_rates_weigthed (DROP = _TYPE_ _FREQ_)  sum = n= NO_Coutries_dest;
	RUN;


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;


PROC EXPORT DATA=  MACRDATA.Recovery_rates_weigthed  OUTFILE="&xls_dir./Recovery_rates_weigth_final.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;




DATA NPL_DATASET (DROP= Reco_rate_dol_Score Reco_rate_dol);

SET EBA.NPL_DATASET;

RUN; 

PROC SQL;
CREATE TABLE npl_dataset1 AS
SELECT a.*,
b.'RESLV.ISV.DFRN.RC'n AS Reco_rate_dol_Score ,
b.'RESLV.ISV.RCOV.RT'n AS Reco_rate_dol
FROM NPL_DATASET As a
LEFT JOIN MACRDATA.Recovery_rates_weigthed  As b 
ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code
;
QUIT;

data NPL_DATASET2(drop = i);
   set NPL_DATASET1;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.NPL_DATASET;

SET NPL_DATASET2;

RUN; 


/*nb*/


DATA NPL_DATASET_nb (DROP= Reco_rate_dol_Score Reco_rate_dol);

SET EBA.NPL_DATASET_nb;

RUN; 

PROC SQL;
CREATE TABLE npl_dataset_nb1 AS
SELECT a.*,
b.'RESLV.ISV.DFRN.RC'n AS Reco_rate_dol_Score ,
b.'RESLV.ISV.RCOV.RT'n AS Reco_rate_dol
FROM NPL_DATASET_nb As a
LEFT JOIN MACRDATA.Recovery_rates_weigthed  As b 
ON a.Period_nm=b.Period_nm AND a.LEI_Code= b.LEI_Code
;
QUIT;

data NPL_DATASET_nb2(drop = i);
   set NPL_DATASET_nb1;
   array vars{*}  _NUMERIC_;
;

   do i = 1 to dim(vars);

      IF vars[i] = 0 THEN vars[i]= .;

   end;
run;

DATA EBA.NPL_DATASET_nb;

SET NPL_DATASET_nb2;

RUN; 




%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

PROC EXPORT DATA=  EBA.npl_dataset OUTFILE="&xls_dir./npl_dataset.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
PROC EXPORT DATA=  EBA.npl_dataset_nb OUTFILE="&xls_dir./npl_dataset_nb.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;

/***************** END: AD-HOC RESOLVING ISSUE MISSING DATA FROM RECOVERY_RATES: RESLV.ISV.DFRN.RC	RESLV.ISV.RCOV.RT***************************/



/***CREATE BALANCE DATA***/


Libname EBA '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data';
Libname Macrdata '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/MacroData';
Libname BankSpec '/mnt/sasshare/DWH/Adhocs/Javier_V/ECB/sas_data/BankSpecData';


PROC SORT DATA= EBA.npl_dataset_nb OUT= banks_no NODUPKEY;BY name; RUN; 
data _NULL_;
  if 0 then set banks_no  nobs=n;
 put "no. of observations =" n;*n=;
  stop;
 run;

PROC FREQ DATA= EBA.npl_dataset_nb noprint;TABLE name/ out= count_set; RUN; 


PROC SQL;
CREATE TABLE npl_dataset_nb_bl AS
SELECT a.*
FROM EBA.npl_dataset_nb As a
INNER JOIN (SELECT name FROM count_set WHERE count=6) As b 
ON a.name=b.name;
QUIT;

DATA EBA.npl_dataset_nb_bl;
SET npl_dataset_nb_bl;
RUN;

data _NULL_;
  if 0 then set EBA.npl_dataset_nb  nobs=n;
 put "no. of observations =" n;*n=701;
  stop;
 run;

 PROC SORT DATA= EBA.npl_dataset_nb OUT= banks_no NODUPKEY;BY name; RUN; 

data _NULL_;
  if 0 then set banks_no  nobs=n;
 put "no. of observations =" n;*no_of_banks=156;
  stop;
 run;


 
data _NULL_;
  if 0 then set npl_dataset_nb_bl  nobs=n;
 put "no. of observations =" n;*n=444;
  stop;
 run;

 PROC SORT DATA=  npl_dataset_nb_bl OUT= banks_no1 NODUPKEY;BY name; RUN; 

data _NULL_;
  if 0 then set banks_no1  nobs=n;
 put "no. of observations =" n;*no_of_banks=74;
  stop;
 run;



PROC SQL;
CREATE TABLE npl_dataset_bl AS
SELECT a.*
FROM EBA.npl_dataset As a
INNER JOIN (SELECT name FROM count_set WHERE count=6) As b 
ON a.name=b.name;
QUIT;

DATA EBA.npl_dataset_bl;
SET npl_dataset_bl;
RUN;

data _NULL_;
  if 0 then set EBA.npl_dataset  nobs=n;
 put "no. of observations =" n;*n=4206;
  stop;
 run;

  PROC SORT DATA=  EBA.npl_dataset OUT= banks_no2 NODUPKEY;BY name; RUN; 

data _NULL_;
  if 0 then set banks_no2  nobs=n;
 put "no. of observations =" n;*no_of_banks=156;
  stop;
 run;


 
data _NULL_;
  if 0 then set npl_dataset_bl  nobs=n;
 put "no. of observations =" n;*n=2664;
  stop;
 run;

  PROC SORT DATA=  npl_dataset_bl OUT= banks_no3 NODUPKEY;BY name; RUN; 

data _NULL_;
  if 0 then set banks_no3  nobs=n;
 put "no. of observations =" n;*no_of_banks=74;
  stop;
 run;




PROC EXPORT DATA=  EBA.npl_dataset_bl OUTFILE="&xls_dir./npl_dataset_bl.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
PROC EXPORT DATA=  EBA.npl_dataset_nb_bl OUTFILE="&xls_dir./npl_dataset_nb_bl.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;


%LET path_coll= /mnt/sasshare/DWH/Adhocs/Javier_V/ECB/xlsx;
%LET xls_dir = &path_coll.;
%PUT &xls_dir;

/**DETERMINE BANKING NAMES FOR APPENDIX**/
PROC  SORT DATA= EBA.npl_dataset_bl  OUT= BankSpec.banks_names_bl (KEEP=name lei_code nsa nsa_label) NODUPKEY;BY name; RUN; 
*PROC  SORT DATA= EBA.npl_dataset_nb_bl  OUT= BankSpec.banks_names_nb_bl (KEEP=name lei_code nsa nsa_label) NODUPKEY;*BY name; *RUN; 

PROC  SORT DATA= EBA.npl_dataset OUT= BankSpec.banks_names (KEEP=name lei_code nsa nsa_label) NODUPKEY;BY name; RUN; 
*PROC  SORT DATA= EBA.npl_dataset_nb  OUT= BankSpec.banks_names_nb (KEEP=name lei_code nsa nsa_label) NODUPKEY;*BY name; *RUN;

	
PROC EXPORT DATA=  BankSpec.banks_names_bl OUTFILE="&xls_dir./banks_names_bl.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
*PROC EXPORT DATA=  BankSpec.banks_names_nb_bl OUTFILE="&xls_dir./npl_dataset_nb_bl.xlsx" DBMS= XLSX REPLACE; *SHEET="Data";*RUN;

PROC EXPORT DATA=  BankSpec.banks_names OUTFILE="&xls_dir./banks_names.xlsx" DBMS= XLSX REPLACE; SHEET="Data";RUN;
*PROC EXPORT DATA=  BankSpec.banks_names_nb OUTFILE="&xls_dir./npl_dataset_nb_bl.xlsx" DBMS= XLSX REPLACE; *SHEET="Data";*RUN;






