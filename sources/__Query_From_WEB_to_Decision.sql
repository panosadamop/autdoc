
Select
		DISTINCT
		web.APPL_SID
		,web.INS_LAST_INS_INST
		--,COM_INST.PENSION_IKA_INST_NAME
		
	--rownum AA
	--,REG.INSURED_ID
	,(case 
			When web.APPLICATION_KIND='MN' then 'Παλιά - Κύρια Γηρατος' --00001
			When web.APPLICATION_KIND='DS' then 'Παλιά - Αναπηρίας' --00002
			When web.APPLICATION_KIND='DT'  and  web.Assign_Transf_Dt='TR' then 'Παλιά - Mεταβιβαση Θανάτου Συνταξιουχου'  --00004
			When web.APPLICATION_KIND='DT'  and  web.Assign_Transf_Dt='AS' then 'Παλιά - Θάνατος Ασφαλισμένου'  --00003
			When web.APPLICATION_KIND='AM' then 'Νέα - Κύρια (ΟΓΑ) Γηρατος' --00001
			When web.APPLICATION_KIND='SE' then 'Νέα - Κύρια (μισθωτοι.μη μισθωτοι) Γηρατος'  --00001
			When web.APPLICATION_KIND='AS' then 'Νέα - Αναπηρίας' --00002
			When web.APPLICATION_KIND='PA' then 'Νέα - Παραπληγικό (Κύρια)'  --00005
			When web.APPLICATION_KIND='AD'  and  web.Assign_Transf_Dt='TR' then 'Νέα - Κύρια Mεταβιβαση Θανάτου Συνταξιουχου' --00004
			When web.APPLICATION_KIND='AD'  and  web.Assign_Transf_Dt='AS' then 'Νέα - Κύρια Θάνατος Ασφαλισμένου' --00003
			When web.APPLICATION_KIND='EM' then 'Νέα -  Επικουρική Γηρατος' --00001
			When web.APPLICATION_KIND='ES' then 'Νέα - Επικουρική Αναπηρίας ' --00002
			When web.APPLICATION_KIND='ED'  and  web.Assign_Transf_Dt='TR' then 'Νέα - Επικουρική - Mεταβιβαση Θανάτου Συνταξιουχου' --00004
			When web.APPLICATION_KIND='EG'  and  web.Assign_Transf_Dt='TR' then 'Νέα - Επικουρική - Mεταβιβαση Θανάτου Συνταξιουχου (Δημοσιου)'
			When web.APPLICATION_KIND='ED'  and  web.Assign_Transf_Dt='AS' then 'Νέα - Επικουρική - Θάνατος Ασφαλισμένου' --00003
			When web.APPLICATION_KIND='VM' then 'Νέα - Προσυνταξιοδοτική (Κύρια)'
			else '?? ' || web.APPLICATION_KIND || ' - ' || web.Assign_Transf_Dt end
	) Typos_Aithshs	
	,(case 
		when web.ORIGIN = 0 Then ' Χρήστης ΟΠΣ (Υποβολή απο υποκατάστημα)'  --Φαινεται
		when web.ORIGIN = 1  Then ' ΦΥΣΙΚΟ ΠΡΟΣΩΠΟ' --Φαινεται
		when web.ORIGIN = 2  Then ' ΑΡΧΕΙΟ ΕΦΚΑ' --Κρυφο
		when web.ORIGIN = 3  Then ' ΑΡΧΕΙΟ ΓΛΚ' --Κρυφο
		when web.ORIGIN = 4  Then ' ΑΡΧΕΙΟ ΟΓΑ' --Κρυφο
		when web.ORIGIN = 5  Then ' run για εκκρεμείς IT+NS'  --Κρυφο
		when web.ORIGIN = 6  Then ' Υπάλληλος ΚΕΠ ' --Φαινεται
		when web.ORIGIN = 7  Then ' Support χρήστης - Δοκιμαστικές αιτήσεις' --Φαινεται 
		when web.ORIGIN = 9  Then ' Μετατροπη για αυτοματοποιση'  --Κρυφο
		else web.ORIGIN End
	) Phgh
    ,(case when web.application_status = 0 then 'Προσωρινά Αποθηκευμένη'
            when web.application_status = 1 then 'Υποβληθείσα'
            when web.application_status = 2 then 'Ενημέρωση Στοιχείων Μητρώου'
            when web.application_status = 3 then 'Έκδοση προσωρινής σύνταξης'
            else to_char(web.application_status) end) katastash
			
	,(case
                when web.process_status = 0 then '0 - Εαν εκκρεμεί κλήση/εις web-service'
                when web.process_status = 1 then '1 - Εαν όλες οι κλήσεις στα web-serviceς ολοκληρώθηκαν επιτυχώς'
                when web.process_status = 2 then '2 - Εαν μια η παραπάνω κλήσεις στα web-serviceς επέστρεψαν σφάλματα'
                else to_char(web.process_status) end) web_process_status_
	,web.APPL_PROTOCOL_ORGBRA_CODE || '/'|| web.APPL_PROTOCOL_YEAR ||'/'|| web.APPL_PROTOCOL_NO     ΑΡ_ΠΡΩΤΟΚΟΛΛΟΥ
	,web.INS_AMKA_ID	ΑΜΚΑ_AITOYNTA	
	,web.INS_TAX_REGISTRATION_NUMBER ΑΦΜ_ΑΙΤΟΥΝΤΑ
	,web.INS_INSURED_ID_EFKA ΑΜΑ_ΑΙΤΟΥΝΤΑ
	,dead.DEAD_AMKA_ID ΑΜΚΑ_ΘΑΝΟΝΤΟΣ
	,dead.DEAD_TAX_REGISTRATION_NUMBER ΑΦΜ_ΘΑΝΟΝΤΟΣ
	,dead.DEAD_INSURED_ID_EFKA ΑΜΑ_ΘΑΝΟΝΤΟΣ
	--,web.INS_REST_INFO Παρατηρισεις
	
	-- ,(select kk.TYPE from  KK_METAB_ONE_AMKA_AFM_06_NEW2@RECALC_PROD kk  where dead.DEAD_AMKA_ID = kk.amka_id) typos
	-- ,(select ss.Reason from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) Reason
	-- ,(select ss.POS_APONOMIS from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) POS_APONOMIS
	-- ,(select ss.PENSION_START_DATE from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) PENSION_START_DATE
	-- ,(select ss.KOD_YPOLOGISMOU_NOMIKH_BASH from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) KOD_YPOLOGISMOU_NOMIKH_BASH
	-- ,(select SUBSTR(nvl(ss.KOD_YPOLOGISMOU_NOMIKH_BASH,'    '),2,1) from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) NOMIKH_BASH_2

	,WEB.APPL_PROTOCOL_DATE Hmeromhnia_Ypobolhs
	,WEB.NEAREST_ORGBRA_CODE || ' - ' || WEB.NEAREST_ORGBRA_NAME υποκαταστημα_Αιτησης
	,WEB.USED_FLG USED_FLG__0_
	,web.SYNCH_FLG SYNCH_FLG__1_
	,web.process_status
	,web.status web_status
	,WEB.INS_LAST_INS_INST
	,Replace(Replace(Replace(web.AUTO_ERRORS, Chr(10), ' '), Chr(13), ' '), Chr(9), ' ')  web_AUTO_ERRORS
	,web.CREATED_BY web_CREATED_BY 
    ,web.CREATION_DATE web_CREATION_DATE
    ,web.APPLICATION_KIND
	,App.ORGBRA_CODE_IN_CHARGE υποκαταστημα_χρεωσης
	,App.CREATED_BY App_CREATED_BY
	,App.CREATION_DATE App_CREATION_DATE
    ,InOut.PROTOCOL_NO eiserxomeno_protokolo
	,InOut.CREATED_BY prot_CREATED_BY 
	,InOut.CREATION_DATE prot_CREATION_DATE
	,InOut.status status_Protokolo -- 1=energo
		--,InOut.LOCATION_CODE --για ΓΛΚ
		--,InOut.AM_IN_INSTITUTION --για ΓΛΚ
    ,KOUBAS.AMKA_ID
	,KOUBAS.status status_Koubas
    ,KOUBAS.Product_Code Product_Code_0004
	,KOUBAS.group_id OMADA
    ,KOUBAS.RECORD_TYPE
    ,KOUBAS.NOTIFICATION_DATE
    ,KOUBAS.NOTIFICATION_DESCRIPTION KOUBAS_error
	,KOUBAS.CREATION_DATE KOUBAS_CREATION_DATE
	
	,errs.ERROR_CODE
    ,ErrsDescr.descr
    --  ,'[FLG_PISTOP= ' || ERRSDESCR.FLG_PISTOP || ' - COMMENTS= ' || ERRSDESCR.COMMENTS || ' - FLG_NO_CHECK= ' || FLG_NO_CHECK || ' - FLG_POST_CHECK = ' || FLG_POST_CHECK ||']' oldParam
    --FLG_PISTOP -> παει σε πιστοποιημενο 1=ΝΑΙ 0=οχι
    --FLG_NO_CHECK -> ΕΛΈΓΧΟΣ ΠΟΥ ΔΕΝ ΕΞΑΙΡΕΙ ΑΠΟ ΤΗΝ ΔΡΟΜΟΛΟΓΗΣΗ 1--ΔΕΝ ΕΞΑΙΡΕΙ ΑΠΟ ΔΡΟΜΟΛΟΓΗΣ,0 ή null ΕΞΑΙΡΕΙ
    
       -- ,ERRSD.FLG_PISTOP --παει σε πιστοποιημενο 1=ΝΑΙ 0=οχι
       ,(case when ERRSD.FLG_PISTOP = 1 then 'ΝΑΙ (1)' 
            when ERRSD.FLG_PISTOP = 0 then 'Oxi (0)'
            else to_char(ERRSD.FLG_PISTOP) end
    ) PISTOP_
    --,ERRSD.FLG_ERROR --ΕΛΈΓΧΟΣ ΠΟΥ ΔΕΝ ΕΞΑΙΡΕΙ ΑΠΟ ΤΗΝ ΔΡΟΜΟΛΟΓΗΣΗ ==>1 ERROR,  2 ΕΠΙΦΥΛΑΞΗ
    ,(case when ERRSD.FLG_ERROR = 1 then 'ERROR (1)' 
            when ERRSD.FLG_ERROR = 0 then 'ΕΠΙΦΥΛΑΞΗ (2)'
            else to_char(ERRSD.FLG_ERROR) end
    ) ERROR_
	
    ,apofash.DEC_INCR_SEQ_NO apofash
	,apofash.DEC_UNIT_CODE_SR || ' / ' || apofash.DECISION_YEAR_SR || ' / ' || apofash.DEC_INCR_SEQ_NO Apofash_B_Y_AA
	,apofash.created_by apofash_created_by
	,apofash.LAST_UPDATED_BY apofash_LAST_UPDATED_BY
	,apofash.CREATION_DATE apofash_CREATION_DATE
	,apofash.STATUS STATUS_apofash --= 1 --ενεργη αποφαση
	,apofash.COMMIT_DATE  Hmeromhnia_oristikopoishw
	,apofash.COMMIT_user
    ,apofash.CAUTION_FLG  me_Epifulaksh  --Με Επιφύλαξη:
    ,(case 
				when apofash.DECISION_STATE_FLG = '0' then    '0 - Εκκρεμής'
				when apofash.DECISION_STATE_FLG = '1' then    '1 - Οριστικοποιημένη'   
				when apofash.DECISION_STATE_FLG = '7' then  '7 - Προς οριστικοποίηση' 
				else apofash.DECISION_STATE_FLG end
	) katastash_apofashs        --1 - Οριστικοποιημένη  7 - Προς οριστικοποίηση
    ,(case 
			when apofash.DECISION_TYPE_FLG = '0' then    'Εγκριτική'   
			when apofash.DECISION_TYPE_FLG = '1' then  'Απορριπτική' 
			when apofash.DECISION_TYPE_FLG = '2' then  'Προς Θεμελίωση' 
			else apofash.DECISION_TYPE_FLG end
			) Ekritikh_apporiptikh       --Εγκρ/Απορ.:  0 = Εγκριτική    1 = Απορριπτική
	,keimena.Txt_Code keimena_code
    ,keimena.Txt_Descr keimena_descr
	,keimena.QUAL_TERM_CODE || '_' ||keimena.QUALIFYING_SUBTERM_CODE TermSubTerm
    -- ,ERR_DESCR.CHECK_NUMBER
    -- ,ERR_DESCR.STATUS
    -- ,ERR_DESCR.CHECK_DESCRIPTION 
    -- ,ERR_DESCR.ERRTXT
--	,recalc2.Product_Description  || ' - ' || recalc2.Eseps_Description eidos_syntaksis
	,dead.DEAD_DATE_OF_DEATH
	-- ,err.ERROR_CODE InternalErrorCode
	-- ,err.INTERNAL_DESCR InternalErrorDescription
		,web.NEAREST_AWARD_ORGBRA_CODE --για workflow (σημειο επεξεργασίας ??)
		,web.NEAREST_BRANCH_CODE --επιλογη απο λιστα αν δεν χρεωθει αυτοματα
		,web.NEAREST_BRANCH_NAME --επιλογη απο λιστα αν δεν χρεωθει αυτοματα
		,web.NEAREST_COUNTY_NAME --επιλογη απο λιστα αν δεν χρεωθει αυτοματα
		,web.NEAREST_ORGBRA_CODE --υποκαταστημα Παραλαβής (χρεωσης)
		,web.NEAREST_ORGBRA_NAME --υποκαταστημα Παραλαβής (χρεωσης)
		,web.NEAREST_AWARD_BRANCH_CODE --υποκαταστημα απονομης
		,web.NEAREST_AWARD_BRANCH_NAME --υποκαταστημα απονομης
		,OAEE.FIRM_ZIP_CODE
		,OAEE.MAPPED_INSTIT
		 ,(case when web.ASSIGN_TO_CERTIFIED_PERSON = '1' then 'ΝΑΙ' 
					when web.ASSIGN_TO_CERTIFIED_PERSON = '2' then 'ΟΧΙ' 
					when web.ASSIGN_TO_CERTIFIED_PERSON = '3' then 'Μη Επιτρεπτη Αναθεση' 
					else web.ASSIGN_TO_CERTIFIED_PERSON 
					end ) arxikh_pistopoihmenou_
		,(case when web.ASSIGN_TO_CERT_PERSON_CONSENT = '1' then 'ΝΑΙ' 
                when web.ASSIGN_TO_CERT_PERSON_CONSENT = '2' then 'ΟΧΙ' end
		) pistopoihmenos_anakefalaiwsh

		/*
		,AutoDebug.LOGIN_ID
		,AutoDebug.STEP
		,AutoDebug.MESSAGE || ' [ ' || AutoDebug.CHECK_CHAR_VALUE_1 || AutoDebug.CHECK_NUM_VALUE_1 || ' ] '
	*/
	
	
	
	---Activity - in workflow only
    ,(case 
		when act.ACTIVITY_STATUS = '00' THEN '00 - Δεν εχει διαβαστει απο τη ροή' 
		when act.ACTIVITY_STATUS = '01' THEN '01 - Δεν χρισιμοποιηται το ACTIVITY_STATUS 01 ' 
        when act.ACTIVITY_STATUS = '02' THEN '02 - Ολοκληρωμενο' 
		when act.ACTIVITY_STATUS = '03' THEN '03 - Ολοκληρωμενο (για ροή daily)' 
		else  act.ACTIVITY_STATUS || ' - ?? '	end) Activity_KATASTASI
	,act_types.ACTIVITY_TYPE || ' - ' || act_types.ACTIVITY_TYPE_DESC Activity_
	--,act_types.NEXT_ACTIVITY_TYPE || ' - ' || (select ACTIVITY_TYPE_DESC from WEB_ACTIVITY_TYPES where ACTIVITY_TYPE = act_types.NEXT_ACTIVITY_TYPE) NEXT_ACTIVITY_
	,act.CREATION_DATE ACTIVITY_CREATION_DATE
	,act.COMPLETION_DATE ACTIVITY_COMPLETION_DATE
	,Replace(Replace(Replace(Activity_err.ERRTXT, Chr(10), ' '), Chr(13), ' '), Chr(9), ' ')   Activity_err_
	,ACTIVITY_ERR.CREATION_DATE ACTIVITY_ERR_CREATION_DATE
	
	/*
	
	,ACTIVITYINFO.COLUMN_TYPE
	,ACTIVITYINFO.CREATION_DATE
	,ACTIVITYINFO.COMPLETION_DATE
	,ACTIVITYINFO.ERRNO
	,ACTIVITYINFO.ERRTXT
	,ACTIVITYINFO.AUTO_DIRECTION
	,ACTIVITYINFO.KEPA_ID
	,ACTIVITYINFO.EPIFILAKSI
	
	*/
	
	
		/*
		,(case  
				when act.activity_Type ='900' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - Δρομολόγηση'
				when act.activity_Type ='901' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - Προθεμελίωση'
				when act.activity_Type ='910' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - Ελεγχος Οφειλών'
				when act.activity_Type ='911' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - debt Monitoring'
				when act.activity_Type ='912' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ακροαση'
				when act.activity_Type ='904' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - Δημιουργία Αιτήσεων'
				when act.activity_Type ='908' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - Έλεγχος για απόφαση'
				when act.activity_Type ='913' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ελεγχος ολοκλήρωσης κύκλου οφειλών (debt monitoring, ακρόαση) '
				when act.activity_Type ='1000' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - Προς επιβεβαίωση Απονομής'
				end
		) TyposActivity
	,act.*
    ,cas.*
	*/
/* #Enhmerwtika
	,INFONOTEAPP.ESEPS_CODE
	,INFONOTEAPP.ESEPS_DESCRIPTION
	,INFONOTEAPP.ETOS_PLIROMIS
	,INFONOTEAPP.MHNAS_PLIROMIS
	,INFONOTEAPP.PENSION_INFO_FORM_TYPE
	,INFONOTEAPP.INFO_FROM_TYPE_DESCR
	,INFONOTEAPP.PRODUCT_CODE
	,INFONOTEAPP.PRODUCT_DESCRIPTION
	,INFONOTEAPP.PEN_DEC_KEYS
 #Enhmerwtika */ 
  
From    reg_insured reg
        Inner join WORKFLOW.Web_Wrk_Appl_Efka web on (reg.INSURED_ID = web.INS_INSURED_ID_EFKA)   --Web Αιτηση
       
		Left Join WORKFLOW.Web_Wrk_Appl_Efka_Dead_Info dead on (web.Appl_Sid = dead.Appl_Sid)-- web (θανων)
        Left Join OAEE_ZIP_APPLSID OAEE on web.Appl_Sid = OAEE.Appl_Sid
		
		Left Join WORKFLOW.Web_Auto_Pens_Data koubas on (web.Appl_Sid = KOUBAS.APPL_SID_WEB   /* and WEB.APPL_PROTOCOL_NO = KOUBAS.APPL_PROTOCOL_NO */ )--κουβας αυτοματοποισης
        
		Left Join WORKFLOW.WRK_APPLICATION App on ( web.APPL_PROTOCOL_ORGBRA_CODE = App.APPL_PROTOCOL_ORGBRA_CODE  -- ΑΙΤΗΣΗ WORKFLOW
                                                    AND web.APPL_PROTOCOL_YEAR = App.APPL_PROTOCOL_YEAR 
                                                    AND to_char(web.APPL_PROTOCOL_NO) = to_char(App.APPL_PROTOCOL_NO))   /*  REPLACE(web.APPL_PROTOCOL_NO,'-','')  */
													--AND REPLACE(web.APPL_PROTOCOL_NO,'-','')  = App.APPL_PROTOCOL_NO)   /*  ++++++++++++++++  */
													
		Left Join WORKFLOW.WRK_IN_OUT  InOut on (App.APPL_SID = InOut.REF_APPL_SID)-- ΠΡΩΤΟΚΟΛΛΟ ΠΑΡΑΛΑΒΗΣ
       
/*	   left Join PEN_APPLICATION_INSTANCES ai on (AI.PDTA_APPLICATION_UNIT_CODE = InOut.PROTOCOL_ORGBRA_CODE 
                                            and ai.PDTA_APPLICATION_YEAR = InOut.protocol_year 
                                            and AI.APPLICATION_INCR_SEQ_NO =InOut.protocol_no)
*/
	   
	   
		Left Join PEN_DECISION_INSTANCE apofash  on (InOut.PROTOCOL_ORGBRA_CODE = apofash.PAI_PDTA_APPLICATION_UNIT_CODE  -- ΑΠΟΦΑΣΗ ΣΥΝΤΑΞΗΣ
                                                    AND InOut.PROTOCOL_YEAR = apofash.PAI_PDTA_APPLICATION_YEAR 
													AND to_char(InOut.PROTOCOL_NO) = to_char(apofash.PAI_APPLICATION_INCR_SEQ_NO) )
/*													   
		Left Join pen_ops.PEN_DECISION_PIST_LOG plog on (
		
												apofash.DEC_UNIT_CODE_SR = plog.DEC_UNIT_CODE_SR
												apofash.DECISION_YEAR_SR = plog.DECISION_YEAR_SR
												apofash.DEC_INCR_SEQ_NO = plog.INCR_SEQ_NO_SR
												
												) --log κινησεων διευθηντη υποκαταστηματος για πιστοποιημένους
*/

/* -- 	Errors on Koubas
		Left Join WORKFLOW.WEB_AUTO_PENS_DATA_ERR_RES err_descr on (KOUBAS.APPL_SID_WEB =  err_descr.APPL_SID_WEB -- error Lookup (backend)
																													AND  reg.insured_id = ERR_DESCR.INS_INSURED_ID )
*/
																													
		Left Join PEN_TEXTS_PER_DEC_INSTANCE keimena on (	apofash.document_type_dec_code_sr = keimena.di_document_type_dec_code_sr
																								AND apofash.dec_unit_code_sr = keimena.di_dec_unit_code_sr
																								AND apofash.decision_year_sr = keimena.di_decision_year_sr
																								AND apofash.incr_seq_no_sr = keimena.di_dec_incr_seq_no_sr
																								AND apofash.dt_dec_unit_code = InOut.PROTOCOL_ORGBRA_CODE    --καταστημα παραλαβης 
																								AND apofash.dt_decision_year = InOut.PROTOCOL_YEAR
																								AND apofash.dec_incr_seq_no = apofash.DEC_INCR_SEQ_NO  -- ΑΠΟΦΑΣΗ ΣΥΝΤΑΞΗΣ--Keimena Apofashs
																								AND  keimena.RULE_OR_QUAL_FLG	= '0'  --0 = keimena 1= nomothesia 
																								)

		Left join WORKFLOW.WEB_WRK_APPL_EFKA_ERRS ERRS on web.appl_sid = errs.Appl_sid  -- εξαιρεση αυτοματοποιησης αιτησεις
		Left join WEB_APPL_EFKA_ERRORS ErrDescr on ERRS.ERROR_CODE = ErrDescr.code
		
		-- Left Join Ppin_Eseps_ReCalc_All_Pen_3Hst/*@Recalc_Prod*/  recalc1 on (recalc1.Taxation_Id = dead.DEAD_TAX_REGISTRATION_NUMBER
																						-- and recalc1.AMKA_ID =  dead.DEAD_AMKA_ID
																						-- and recalc1.ETOS_PLIROMIS = extract(year from dead.DEAD_DATE_OF_DEATH)  
																						-- and recalc1.MHNAS_PLIROMIS = extract(month from dead.DEAD_DATE_OF_DEATH) - 1 ) --epanypologismos 1 
		-- Left Join   Rcl_Pension_Payment_Info_Notes/*@Recalc_Prod*/  recalc2 on (recalc1.ReCalc_Global_Seq  = recalc2.ReCalc_Global_Seq  ) --epanypologismos 2
		
		
		-- Left join PEN_AUTO_DEBUGGING AutoDebug on web.appl_sid = AutoDebug.APPL_SID

	---Activity Joins- in workflow only
		left join  WORKFLOW.WEB_AUTO_PEN_CASE_ACTIVITIES act on (web.Appl_Sid = act.appl_sid_web) -- εξαιρεσεις αυτοματοποιησης
		left join WEB_APPL_EFKA_ERRORS ErrsDescr on errs.ERROR_CODE = ErrsDescr.code -- περιγραφη εξαιρεσεων αυτοματοποισηςη
		left join web_Appl_efka_errors_d errsD on (errs.ERROR_CODE = ErrsD.Code and web.INS_LAST_INS_INST = ErrsD.INSTITUTION_CODE  and Web.Application_kind = ErrsD.Application_kind) -- παραμετροποιηση εξαιρεσεων αυτοματοποιησης

		
		left join (
						--WEB_ACTIVITY_TYPES 
						Select '1000' ACTIVITY_TYPE, 'απονομή' ACTIVITY_TYPE_DESC from dual
						Union Select '1001' ACTIVITY_TYPE, 'ΔΗΜΙΟΥΡΓΙΑ ΤΡΟΠΟΠΟΙΗΤΙΚΗΣ' ACTIVITY_TYPE_DESC from dual
						Union Select '801' ACTIVITY_TYPE, 'ελεγχος ΚΕΠΑ παρατάσεις αναπηρίας παραπληγίας ' ACTIVITY_TYPE_DESC from dual
						Union Select '802' ACTIVITY_TYPE, 'Κανόνες Δρομολόγησης' ACTIVITY_TYPE_DESC from dual
						Union Select '803' ACTIVITY_TYPE, 'Create Work Flow (paralavi)' ACTIVITY_TYPE_DESC from dual
						Union Select '900' ACTIVITY_TYPE, 'Δρομολόγηση' ACTIVITY_TYPE_DESC from dual
						Union Select '901' ACTIVITY_TYPE, 'Προ θεμελίωση' ACTIVITY_TYPE_DESC from dual
						Union Select '903' ACTIVITY_TYPE, 'Δρομολόγηση' ACTIVITY_TYPE_DESC from dual
						Union Select '904' ACTIVITY_TYPE, 'Δημιουργία Αιτήσεων ' ACTIVITY_TYPE_DESC from dual
						Union Select '905' ACTIVITY_TYPE, 'Δημιουργία Αιτήσεων ' ACTIVITY_TYPE_DESC from dual
						Union Select '906' ACTIVITY_TYPE, 'ΠΡΟΘΕΜΕΛΙΩΣΗ ΓΗΡΑΤΟΣ' ACTIVITY_TYPE_DESC from dual
						Union Select '908' ACTIVITY_TYPE, 'Έλεγχος για απόφαση  κεπα' ACTIVITY_TYPE_DESC from dual
						Union Select '909' ACTIVITY_TYPE, 'ΑΙΤΗΜΑ ΚΕΠΑ' ACTIVITY_TYPE_DESC from dual
						Union Select '910' ACTIVITY_TYPE, 'Ελεγχος Οφειλών' ACTIVITY_TYPE_DESC from dual
						Union Select '9100' ACTIVITY_TYPE, 'ελεγχος οφειλών' ACTIVITY_TYPE_DESC from dual
						Union Select '911' ACTIVITY_TYPE, 'debt Monitoring (ελεγχος οφειλων ημερισιος (παλιος))' ACTIVITY_TYPE_DESC from dual
						Union Select '912' ACTIVITY_TYPE, 'ελεγχος οφειλων ημερισιος (νεος με RF)' ACTIVITY_TYPE_DESC from dual
						Union Select '913' ACTIVITY_TYPE, 'έλεγχος ολοκλήρωσης κύκλου οφειλών (debt monitoring, ακρόαση)' ACTIVITY_TYPE_DESC from dual
						Union Select '914' ACTIVITY_TYPE, 'ελεγχος ολοκλήρωσης κύκλου οφειλών (debt monitoring, ακρόαση) ' ACTIVITY_TYPE_DESC from dual
						Union Select '915' ACTIVITY_TYPE, 'Δρομολόγηση' ACTIVITY_TYPE_DESC from dual
						Union Select '916' ACTIVITY_TYPE, 'έλεγχος οφειλών' ACTIVITY_TYPE_DESC from dual
						Union Select '920' ACTIVITY_TYPE, 'Δρομολόγηση επικουρικού ιδιώτες' ACTIVITY_TYPE_DESC from dual
						Union Select '925' ACTIVITY_TYPE, 'Αίτηση στο Work Flow' ACTIVITY_TYPE_DESC from dual
						Union Select '931' ACTIVITY_TYPE, 'ελεχγος προσθετης εμπειριας' ACTIVITY_TYPE_DESC from dual
						Union Select '933' ACTIVITY_TYPE, 'Ελέγχος πρόθετης εμπειρίας εβδομαδιαιος' ACTIVITY_TYPE_DESC from dual
						Union Select '940' ACTIVITY_TYPE, 'Κανόνες Δρομολόγηση' ACTIVITY_TYPE_DESC from dual
						Union Select '941' ACTIVITY_TYPE, 'ΠΡΟΘΕΜΕΛΙΩΣΗ ΠΑΡΑΠΛΗΓΙΑΣ' ACTIVITY_TYPE_DESC from dual
						Union Select '945' ACTIVITY_TYPE, 'Create  KEPA Application  -- ΑΥΤΟ ΤΟ ΒΗΜΑ ΕΧΕΙ ΚΑΤΑΡΓΗΘΕΙ' ACTIVITY_TYPE_DESC from dual
						Union Select '946' ACTIVITY_TYPE, 'ελεγχος απόφασης κεπα παραπληγίας' ACTIVITY_TYPE_DESC from dual
						Union Select '948' ACTIVITY_TYPE, 'Αίτηση στο Workflow' ACTIVITY_TYPE_DESC from dual
						Union Select '950' ACTIVITY_TYPE, 'ελεγχος οφειλών' ACTIVITY_TYPE_DESC from dual
						Union Select '951' ACTIVITY_TYPE, 'Ελεγχος ολοκλήρωσης κύκλου οφειλών ΚΑΙ ΜΕΤΑ 1000' ACTIVITY_TYPE_DESC from dual
						Union Select '954' ACTIVITY_TYPE, 'ΠΡΟΘΕΜΕΛΙΩΣΗ ΓΗΡΑΤΟΣ' ACTIVITY_TYPE_DESC from dual
						Union Select '955' ACTIVITY_TYPE, 'CONTROL PANEL - ΔΗΜΙΟΥΡΓΙΑ WORKFLOW' ACTIVITY_TYPE_DESC from dual
						Union Select '958' ACTIVITY_TYPE, 'Control Panel-wrkflow ' ACTIVITY_TYPE_DESC from dual
						Union Select '959' ACTIVITY_TYPE, 'CONTROL PANEL - ΔΗΜΙΟΥΡΓΙΑ WORKFLOW' ACTIVITY_TYPE_DESC from dual
						Union Select '960' ACTIVITY_TYPE, 'CONTROL PANEL - ΔΗΜΙΟΥΡΓΙΑ WORKFLOW' ACTIVITY_TYPE_DESC from dual
						Union Select '961' ACTIVITY_TYPE, 'προθεμελίωση για τη βασική διάταξη του ΙΚΑ' ACTIVITY_TYPE_DESC from dual
						Union Select '962' ACTIVITY_TYPE, 'Transmission (Διαβίβαση)' ACTIVITY_TYPE_DESC from dual
						Union Select '970' ACTIVITY_TYPE, 'Δημιουργία dummy web αίτησης' ACTIVITY_TYPE_DESC from dual
						Union Select '971' ACTIVITY_TYPE, 'Κανόνες Δρομολόγησης' ACTIVITY_TYPE_DESC from dual
						Union Select '972' ACTIVITY_TYPE, 'Φόρτωση ΑΙ - Προθεμελίωση' ACTIVITY_TYPE_DESC from dual
						Union Select '980' ACTIVITY_TYPE, 'Κανόνες Δρομολόγησης' ACTIVITY_TYPE_DESC from dual
						Union Select '981' ACTIVITY_TYPE, 'προθεμελείωση' ACTIVITY_TYPE_DESC from dual
						Union Select '982' ACTIVITY_TYPE, 'Αίτηση στο Work Flow και ΚΕΠΑ' ACTIVITY_TYPE_DESC from dual
						Union Select '988' ACTIVITY_TYPE, 'έλεγχος ΚΕΠΑ' ACTIVITY_TYPE_DESC from dual

						
						
					) act_types on act.activity_Type = act_types.ACTIVITY_TYPE
		left join WEB_AUTO_ERR Activity_err on web.appl_sid = Activity_err.APPL_SID_WEB
		left join WEB_AUTO_PEN_CASE_ACTIVITYINFO ACTIVITYINFO on (web.appl_sid = ACTIVITYINFO.APPL_SID_WEB and  act.activity_Type = ACTIVITYINFO.ACTIVITY_TYPE)
		
		/*
		--Left Join  WORKFLOW.web_auto_pen_case_typeactivity atype on act.ACTIVITY_TYPE = atype.CASE_TYPE_ACTIVITY
		left join  WORKFLOW.web_auto_pen_cases cas on web.Appl_Sid = cas.appl_sid_web
		--Left Join  WORKFLOW.web_auto_pen_case_types ctype on cas.CASE_TYPE = ctype.CASE_TYPE
		LEFT Join  WORKFLOW.web_wrk_Appl_EFKA_Errs err on web.Appl_Sid = Err.Appl_Sid
	*/
		
		
	/* 
	-- Syntakseis apo paraplhgiko
	Left Join (SELECT A.ESEPS_DESCRIPTION,
                    A.AM_IN_INSTITUTION,
                    A.PRODUCT_DESCRIPTION,
                    A.ESEPS_CODE,
                    a.MHNAS_PLIROMIS,
                    A.ETOS_PLIROMIS,
                    A.AMKA_ID
                    FROM WEB_WRK_APPL_GET_PENSIONS A
          )  syntaxeis on (syntaxeis.AMKA_ID = web.ins_amka_id 
                            and syntaxeis.ETOS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(web.appl_protocol_date, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'YYYY'))
                            AND syntaxeis.MHNAS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(web.appl_protocol_date, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'MM')))
	
	*/	
		
	--Left join  pen_account Acc on (
--                                Acc.DI_DT_DEC_UNIT_CODE = apofash.DEC_UNIT_CODE_SR
--                                and Acc.DI_DT_DECISION_YEAR = apofash.DECISION_YEAR_SR
--                                and Acc.DI_DEC_INCR_SEQ_NO = apofash.INCR_SEQ_NO_SR ) -- Λογαριασμος	


--        Left join COM_PENSION_IKA_INSTITUTION COM_INST on web.INS_LAST_INS_INST = COM_INST.LAST_INSTITUTION_CODE and  nvl(decode(web.eseps_code,41003,21013,21017,21013,web.eseps_code),0) = nvl(COM_INST.eseps_code,web.eseps_code)  --PENSION_IKA_INST_CODE


/* #Enhmerwtika
-- Συνταξεις Αιτουντα απο ενημερωτικα
Left Join WEB_WRK_APPL_GET_PENSIONS InfoNoteApp on (	web.INS_AMKA_ID	= 	InfoNoteApp.AMKA_ID 
																									and web.INS_TAX_REGISTRATION_NUMBER  = InfoNoteApp.TAXATION_ID
																									and InfoNoteApp.ETOS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(nvl(web.appl_protocol_date,SYSDATE)	, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'YYYY'))
																									and InfoNoteApp.MHNAS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(nvl(web.appl_protocol_date,SYSDATE)	, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'MM'))
																									)
																									
#Enhmerwtika */

																									
/*																									
-- Συνταξεις Θανωντα απο ενημερωτικα
Left Join WEB_WRK_APPL_GET_PENSIONS InfoNoteDead on (	Dead.DEAD_AMKA_ID	= 	InfoNoteDead.AMKA_ID 
																									and Dead.DEAD_TAX_REGISTRATION_NUMBER  = InfoNoteDead.TAXATION_ID
																									and InfoNoteDead.ETOS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(nvl(web.appl_protocol_date,SYSDATE)	, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'YYYY'))
																									and InfoNoteDead.MHNAS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(nvl(web.appl_protocol_date,SYSDATE)	, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'MM'))
																									)
*/																									
																									
																									
--nvl(extract(year from web.appl_protocol_date),extract(year from web.SYSDATE),																									
--nvl(web.appl_protocol_date,SYSDATE)	
		
 
 
 Where  1 =1
    --AND	InOut.TYPE_FLG = '1'
   -- AND	InOut.RECEIVE_APPL_FLG = '1'
	-- AND InOut.STATUS = 1 -- energo protokolo
--    AND APOFASH.STATUS = 1 --ενεργη αποφαση
 --   --AND web.Last_Updated_Date    Is Not Null
 
      AND web.status =1 --ενεργο web αιτημα
      AND web.Application_Status   = '1'  -- 0= αποθηκευση 1=οριστικοποιημενο
	 --and web.ins_amka_id not like '!#$%' 
	  --and web.origin = 1


--and apofash.DECISION_STATE_FLG = '1' --then    '1 - Οριστικοποιημένη'   
--and apofash.DECISION_TYPE_FLG = '0' -- then    'Εγκριτική' 
--and apofash.created_by in ( 'WEB_AUTO_PENS' ,'EFKA_N4611','WEB_DIR')
--and apofash.last_updated_by = 'WEB_AUTO_PENS' --EFKA_N4611
      
--	AND not exists (select 1 from WORKFLOW.Web_Auto_Pens_Data aaa where AAweb.AMKA_ID = web.INS_AMKA_ID ) -- den exei ginei paralabh

-- 	and web.appl_sid = 000000
-- and web.INS_INSURED_ID_EFKA in ('ΑΜΑ_ΑΙΤΟΥΝΤΑ')	
--	and web.INS_AMKA_ID	in ('ΑΜΚΑ_AITOYNTA')	
--	and dead.DEAD_INSURED_ID_EFKA in ('ΑΜΑ_ΘΑΝΟΝΤΟΣ')
-- and dead.DEAD_AMKA_ID in ('ΑΜΚΑ_ΘΑΝΟΝΤΟΣ')
	
--	and web.APPL_PROTOCOL_ORGBRA_CODE = '09904' and web.APPL_PROTOCOL_YEAR = 2020 and web.APPL_PROTOCOL_NO in ('ΑΡ_ΠΡΩΤΟΚΟΛΛΟΥ')
	
	
	--order by web.CREATION_DATE,reg.INSURED_ID
	
	
	