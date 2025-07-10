
Select
		DISTINCT
		web.APPL_SID
		,web.INS_LAST_INS_INST
		--,COM_INST.PENSION_IKA_INST_NAME
		
	--rownum AA
	--,REG.INSURED_ID
	,(case 
			When web.APPLICATION_KIND='MN' then '����� - ����� �������' --00001
			When web.APPLICATION_KIND='DS' then '����� - ���������' --00002
			When web.APPLICATION_KIND='DT'  and  web.Assign_Transf_Dt='TR' then '����� - M��������� ������� ������������'  --00004
			When web.APPLICATION_KIND='DT'  and  web.Assign_Transf_Dt='AS' then '����� - ������� ������������'  --00003
			When web.APPLICATION_KIND='AM' then '��� - ����� (���) �������' --00001
			When web.APPLICATION_KIND='SE' then '��� - ����� (��������.�� ��������) �������'  --00001
			When web.APPLICATION_KIND='AS' then '��� - ���������' --00002
			When web.APPLICATION_KIND='PA' then '��� - ����������� (�����)'  --00005
			When web.APPLICATION_KIND='AD'  and  web.Assign_Transf_Dt='TR' then '��� - ����� M��������� ������� ������������' --00004
			When web.APPLICATION_KIND='AD'  and  web.Assign_Transf_Dt='AS' then '��� - ����� ������� ������������' --00003
			When web.APPLICATION_KIND='EM' then '��� -  ���������� �������' --00001
			When web.APPLICATION_KIND='ES' then '��� - ���������� ��������� ' --00002
			When web.APPLICATION_KIND='ED'  and  web.Assign_Transf_Dt='TR' then '��� - ���������� - M��������� ������� ������������' --00004
			When web.APPLICATION_KIND='EG'  and  web.Assign_Transf_Dt='TR' then '��� - ���������� - M��������� ������� ������������ (��������)'
			When web.APPLICATION_KIND='ED'  and  web.Assign_Transf_Dt='AS' then '��� - ���������� - ������� ������������' --00003
			When web.APPLICATION_KIND='VM' then '��� - ����������������� (�����)'
			else '?? ' || web.APPLICATION_KIND || ' - ' || web.Assign_Transf_Dt end
	) Typos_Aithshs	
	,(case 
		when web.ORIGIN = 0 Then ' ������� ��� (������� ��� ������������)'  --��������
		when web.ORIGIN = 1  Then ' ������ �������' --��������
		when web.ORIGIN = 2  Then ' ������ ����' --�����
		when web.ORIGIN = 3  Then ' ������ ���' --�����
		when web.ORIGIN = 4  Then ' ������ ���' --�����
		when web.ORIGIN = 5  Then ' run ��� ��������� IT+NS'  --�����
		when web.ORIGIN = 6  Then ' ��������� ��� ' --��������
		when web.ORIGIN = 7  Then ' Support ������� - ������������ ��������' --�������� 
		when web.ORIGIN = 9  Then ' ��������� ��� �������������'  --�����
		else web.ORIGIN End
	) Phgh
    ,(case when web.application_status = 0 then '��������� ������������'
            when web.application_status = 1 then '�����������'
            when web.application_status = 2 then '��������� ��������� �������'
            when web.application_status = 3 then '������ ���������� ��������'
            else to_char(web.application_status) end) katastash
			
	,(case
                when web.process_status = 0 then '0 - ��� �������� �����/��� web-service'
                when web.process_status = 1 then '1 - ��� ���� �� ������� ��� web-service� ������������� ��������'
                when web.process_status = 2 then '2 - ��� ��� � �������� ������� ��� web-service� ���������� ��������'
                else to_char(web.process_status) end) web_process_status_
	,web.APPL_PROTOCOL_ORGBRA_CODE || '/'|| web.APPL_PROTOCOL_YEAR ||'/'|| web.APPL_PROTOCOL_NO     ��_�����������
	,web.INS_AMKA_ID	����_AITOYNTA	
	,web.INS_TAX_REGISTRATION_NUMBER ���_��������
	,web.INS_INSURED_ID_EFKA ���_��������
	,dead.DEAD_AMKA_ID ����_��������
	,dead.DEAD_TAX_REGISTRATION_NUMBER ���_��������
	,dead.DEAD_INSURED_ID_EFKA ���_��������
	--,web.INS_REST_INFO ������������
	
	-- ,(select kk.TYPE from  KK_METAB_ONE_AMKA_AFM_06_NEW2@RECALC_PROD kk  where dead.DEAD_AMKA_ID = kk.amka_id) typos
	-- ,(select ss.Reason from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) Reason
	-- ,(select ss.POS_APONOMIS from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) POS_APONOMIS
	-- ,(select ss.PENSION_START_DATE from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) PENSION_START_DATE
	-- ,(select ss.KOD_YPOLOGISMOU_NOMIKH_BASH from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) KOD_YPOLOGISMOU_NOMIKH_BASH
	-- ,(select SUBSTR(nvl(ss.KOD_YPOLOGISMOU_NOMIKH_BASH,'    '),2,1) from Senaria_Anapirias@RECALC_PROD ss where dead.DEAD_AMKA_ID = ss.amka_id) NOMIKH_BASH_2

	,WEB.APPL_PROTOCOL_DATE Hmeromhnia_Ypobolhs
	,WEB.NEAREST_ORGBRA_CODE || ' - ' || WEB.NEAREST_ORGBRA_NAME ������������_�������
	,WEB.USED_FLG USED_FLG__0_
	,web.SYNCH_FLG SYNCH_FLG__1_
	,web.process_status
	,web.status web_status
	,WEB.INS_LAST_INS_INST
	,Replace(Replace(Replace(web.AUTO_ERRORS, Chr(10), ' '), Chr(13), ' '), Chr(9), ' ')  web_AUTO_ERRORS
	,web.CREATED_BY web_CREATED_BY 
    ,web.CREATION_DATE web_CREATION_DATE
    ,web.APPLICATION_KIND
	,App.ORGBRA_CODE_IN_CHARGE ������������_�������
	,App.CREATED_BY App_CREATED_BY
	,App.CREATION_DATE App_CREATION_DATE
    ,InOut.PROTOCOL_NO eiserxomeno_protokolo
	,InOut.CREATED_BY prot_CREATED_BY 
	,InOut.CREATION_DATE prot_CREATION_DATE
	,InOut.status status_Protokolo -- 1=energo
		--,InOut.LOCATION_CODE --��� ���
		--,InOut.AM_IN_INSTITUTION --��� ���
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
    --FLG_PISTOP -> ���� �� ������������� 1=��� 0=���
    --FLG_NO_CHECK -> �˸���� ��� ��� ������� ��� ��� ����������� 1--��� ������� ��� ����������,0 � null �������
    
       -- ,ERRSD.FLG_PISTOP --���� �� ������������� 1=��� 0=���
       ,(case when ERRSD.FLG_PISTOP = 1 then '��� (1)' 
            when ERRSD.FLG_PISTOP = 0 then 'Oxi (0)'
            else to_char(ERRSD.FLG_PISTOP) end
    ) PISTOP_
    --,ERRSD.FLG_ERROR --�˸���� ��� ��� ������� ��� ��� ����������� ==>1 ERROR,  2 ���������
    ,(case when ERRSD.FLG_ERROR = 1 then 'ERROR (1)' 
            when ERRSD.FLG_ERROR = 0 then '��������� (2)'
            else to_char(ERRSD.FLG_ERROR) end
    ) ERROR_
	
    ,apofash.DEC_INCR_SEQ_NO apofash
	,apofash.DEC_UNIT_CODE_SR || ' / ' || apofash.DECISION_YEAR_SR || ' / ' || apofash.DEC_INCR_SEQ_NO Apofash_B_Y_AA
	,apofash.created_by apofash_created_by
	,apofash.LAST_UPDATED_BY apofash_LAST_UPDATED_BY
	,apofash.CREATION_DATE apofash_CREATION_DATE
	,apofash.STATUS STATUS_apofash --= 1 --������ �������
	,apofash.COMMIT_DATE  Hmeromhnia_oristikopoishw
	,apofash.COMMIT_user
    ,apofash.CAUTION_FLG  me_Epifulaksh  --�� ���������:
    ,(case 
				when apofash.DECISION_STATE_FLG = '0' then    '0 - ��������'
				when apofash.DECISION_STATE_FLG = '1' then    '1 - ����������������'   
				when apofash.DECISION_STATE_FLG = '7' then  '7 - ���� ��������������' 
				else apofash.DECISION_STATE_FLG end
	) katastash_apofashs        --1 - ����������������  7 - ���� ��������������
    ,(case 
			when apofash.DECISION_TYPE_FLG = '0' then    '���������'   
			when apofash.DECISION_TYPE_FLG = '1' then  '�����������' 
			when apofash.DECISION_TYPE_FLG = '2' then  '���� ���������' 
			else apofash.DECISION_TYPE_FLG end
			) Ekritikh_apporiptikh       --����/����.:  0 = ���������    1 = �����������
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
		,web.NEAREST_AWARD_ORGBRA_CODE --��� workflow (������ ������������ ??)
		,web.NEAREST_BRANCH_CODE --������� ��� ����� �� ��� ������� ��������
		,web.NEAREST_BRANCH_NAME --������� ��� ����� �� ��� ������� ��������
		,web.NEAREST_COUNTY_NAME --������� ��� ����� �� ��� ������� ��������
		,web.NEAREST_ORGBRA_CODE --������������ ��������� (�������)
		,web.NEAREST_ORGBRA_NAME --������������ ��������� (�������)
		,web.NEAREST_AWARD_BRANCH_CODE --������������ ��������
		,web.NEAREST_AWARD_BRANCH_NAME --������������ ��������
		,OAEE.FIRM_ZIP_CODE
		,OAEE.MAPPED_INSTIT
		 ,(case when web.ASSIGN_TO_CERTIFIED_PERSON = '1' then '���' 
					when web.ASSIGN_TO_CERTIFIED_PERSON = '2' then '���' 
					when web.ASSIGN_TO_CERTIFIED_PERSON = '3' then '�� ��������� �������' 
					else web.ASSIGN_TO_CERTIFIED_PERSON 
					end ) arxikh_pistopoihmenou_
		,(case when web.ASSIGN_TO_CERT_PERSON_CONSENT = '1' then '���' 
                when web.ASSIGN_TO_CERT_PERSON_CONSENT = '2' then '���' end
		) pistopoihmenos_anakefalaiwsh

		/*
		,AutoDebug.LOGIN_ID
		,AutoDebug.STEP
		,AutoDebug.MESSAGE || ' [ ' || AutoDebug.CHECK_CHAR_VALUE_1 || AutoDebug.CHECK_NUM_VALUE_1 || ' ] '
	*/
	
	
	
	---Activity - in workflow only
    ,(case 
		when act.ACTIVITY_STATUS = '00' THEN '00 - ��� ���� ��������� ��� �� ���' 
		when act.ACTIVITY_STATUS = '01' THEN '01 - ��� �������������� �� ACTIVITY_STATUS 01 ' 
        when act.ACTIVITY_STATUS = '02' THEN '02 - ������������' 
		when act.ACTIVITY_STATUS = '03' THEN '03 - ������������ (��� ��� daily)' 
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
				when act.activity_Type ='900' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - �����������'
				when act.activity_Type ='901' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ������������'
				when act.activity_Type ='910' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ������� �������'
				when act.activity_Type ='911' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - debt Monitoring'
				when act.activity_Type ='912' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - �������'
				when act.activity_Type ='904' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ���������� ��������'
				when act.activity_Type ='908' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ������� ��� �������'
				when act.activity_Type ='913' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ������� ����������� ������ ������� (debt monitoring, �������) '
				when act.activity_Type ='1000' and web.APPLICATION_KIND='AS' then act.activity_Type|| ' - ���� ����������� ��������'
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
        Inner join WORKFLOW.Web_Wrk_Appl_Efka web on (reg.INSURED_ID = web.INS_INSURED_ID_EFKA)   --Web ������
       
		Left Join WORKFLOW.Web_Wrk_Appl_Efka_Dead_Info dead on (web.Appl_Sid = dead.Appl_Sid)-- web (�����)
        Left Join OAEE_ZIP_APPLSID OAEE on web.Appl_Sid = OAEE.Appl_Sid
		
		Left Join WORKFLOW.Web_Auto_Pens_Data koubas on (web.Appl_Sid = KOUBAS.APPL_SID_WEB   /* and WEB.APPL_PROTOCOL_NO = KOUBAS.APPL_PROTOCOL_NO */ )--������ ��������������
        
		Left Join WORKFLOW.WRK_APPLICATION App on ( web.APPL_PROTOCOL_ORGBRA_CODE = App.APPL_PROTOCOL_ORGBRA_CODE  -- ������ WORKFLOW
                                                    AND web.APPL_PROTOCOL_YEAR = App.APPL_PROTOCOL_YEAR 
                                                    AND to_char(web.APPL_PROTOCOL_NO) = to_char(App.APPL_PROTOCOL_NO))   /*  REPLACE(web.APPL_PROTOCOL_NO,'-','')  */
													--AND REPLACE(web.APPL_PROTOCOL_NO,'-','')  = App.APPL_PROTOCOL_NO)   /*  ++++++++++++++++  */
													
		Left Join WORKFLOW.WRK_IN_OUT  InOut on (App.APPL_SID = InOut.REF_APPL_SID)-- ���������� ���������
       
/*	   left Join PEN_APPLICATION_INSTANCES ai on (AI.PDTA_APPLICATION_UNIT_CODE = InOut.PROTOCOL_ORGBRA_CODE 
                                            and ai.PDTA_APPLICATION_YEAR = InOut.protocol_year 
                                            and AI.APPLICATION_INCR_SEQ_NO =InOut.protocol_no)
*/
	   
	   
		Left Join PEN_DECISION_INSTANCE apofash  on (InOut.PROTOCOL_ORGBRA_CODE = apofash.PAI_PDTA_APPLICATION_UNIT_CODE  -- ������� ��������
                                                    AND InOut.PROTOCOL_YEAR = apofash.PAI_PDTA_APPLICATION_YEAR 
													AND to_char(InOut.PROTOCOL_NO) = to_char(apofash.PAI_APPLICATION_INCR_SEQ_NO) )
/*													   
		Left Join pen_ops.PEN_DECISION_PIST_LOG plog on (
		
												apofash.DEC_UNIT_CODE_SR = plog.DEC_UNIT_CODE_SR
												apofash.DECISION_YEAR_SR = plog.DECISION_YEAR_SR
												apofash.DEC_INCR_SEQ_NO = plog.INCR_SEQ_NO_SR
												
												) --log �������� ��������� ��������������� ��� ���������������
*/

/* -- 	Errors on Koubas
		Left Join WORKFLOW.WEB_AUTO_PENS_DATA_ERR_RES err_descr on (KOUBAS.APPL_SID_WEB =  err_descr.APPL_SID_WEB -- error Lookup (backend)
																													AND  reg.insured_id = ERR_DESCR.INS_INSURED_ID )
*/
																													
		Left Join PEN_TEXTS_PER_DEC_INSTANCE keimena on (	apofash.document_type_dec_code_sr = keimena.di_document_type_dec_code_sr
																								AND apofash.dec_unit_code_sr = keimena.di_dec_unit_code_sr
																								AND apofash.decision_year_sr = keimena.di_decision_year_sr
																								AND apofash.incr_seq_no_sr = keimena.di_dec_incr_seq_no_sr
																								AND apofash.dt_dec_unit_code = InOut.PROTOCOL_ORGBRA_CODE    --��������� ��������� 
																								AND apofash.dt_decision_year = InOut.PROTOCOL_YEAR
																								AND apofash.dec_incr_seq_no = apofash.DEC_INCR_SEQ_NO  -- ������� ��������--Keimena Apofashs
																								AND  keimena.RULE_OR_QUAL_FLG	= '0'  --0 = keimena 1= nomothesia 
																								)

		Left join WORKFLOW.WEB_WRK_APPL_EFKA_ERRS ERRS on web.appl_sid = errs.Appl_sid  -- �������� ��������������� ��������
		Left join WEB_APPL_EFKA_ERRORS ErrDescr on ERRS.ERROR_CODE = ErrDescr.code
		
		-- Left Join Ppin_Eseps_ReCalc_All_Pen_3Hst/*@Recalc_Prod*/  recalc1 on (recalc1.Taxation_Id = dead.DEAD_TAX_REGISTRATION_NUMBER
																						-- and recalc1.AMKA_ID =  dead.DEAD_AMKA_ID
																						-- and recalc1.ETOS_PLIROMIS = extract(year from dead.DEAD_DATE_OF_DEATH)  
																						-- and recalc1.MHNAS_PLIROMIS = extract(month from dead.DEAD_DATE_OF_DEATH) - 1 ) --epanypologismos 1 
		-- Left Join   Rcl_Pension_Payment_Info_Notes/*@Recalc_Prod*/  recalc2 on (recalc1.ReCalc_Global_Seq  = recalc2.ReCalc_Global_Seq  ) --epanypologismos 2
		
		
		-- Left join PEN_AUTO_DEBUGGING AutoDebug on web.appl_sid = AutoDebug.APPL_SID

	---Activity Joins- in workflow only
		left join  WORKFLOW.WEB_AUTO_PEN_CASE_ACTIVITIES act on (web.Appl_Sid = act.appl_sid_web) -- ���������� ���������������
		left join WEB_APPL_EFKA_ERRORS ErrsDescr on errs.ERROR_CODE = ErrsDescr.code -- ��������� ���������� ���������������
		left join web_Appl_efka_errors_d errsD on (errs.ERROR_CODE = ErrsD.Code and web.INS_LAST_INS_INST = ErrsD.INSTITUTION_CODE  and Web.Application_kind = ErrsD.Application_kind) -- ��������������� ���������� ���������������

		
		left join (
						--WEB_ACTIVITY_TYPES 
						Select '1000' ACTIVITY_TYPE, '�������' ACTIVITY_TYPE_DESC from dual
						Union Select '1001' ACTIVITY_TYPE, '���������� ��������������' ACTIVITY_TYPE_DESC from dual
						Union Select '801' ACTIVITY_TYPE, '������� ���� ���������� ��������� ����������� ' ACTIVITY_TYPE_DESC from dual
						Union Select '802' ACTIVITY_TYPE, '������� ������������' ACTIVITY_TYPE_DESC from dual
						Union Select '803' ACTIVITY_TYPE, 'Create Work Flow (paralavi)' ACTIVITY_TYPE_DESC from dual
						Union Select '900' ACTIVITY_TYPE, '�����������' ACTIVITY_TYPE_DESC from dual
						Union Select '901' ACTIVITY_TYPE, '��� ���������' ACTIVITY_TYPE_DESC from dual
						Union Select '903' ACTIVITY_TYPE, '�����������' ACTIVITY_TYPE_DESC from dual
						Union Select '904' ACTIVITY_TYPE, '���������� �������� ' ACTIVITY_TYPE_DESC from dual
						Union Select '905' ACTIVITY_TYPE, '���������� �������� ' ACTIVITY_TYPE_DESC from dual
						Union Select '906' ACTIVITY_TYPE, '������������ �������' ACTIVITY_TYPE_DESC from dual
						Union Select '908' ACTIVITY_TYPE, '������� ��� �������  ����' ACTIVITY_TYPE_DESC from dual
						Union Select '909' ACTIVITY_TYPE, '������ ����' ACTIVITY_TYPE_DESC from dual
						Union Select '910' ACTIVITY_TYPE, '������� �������' ACTIVITY_TYPE_DESC from dual
						Union Select '9100' ACTIVITY_TYPE, '������� �������' ACTIVITY_TYPE_DESC from dual
						Union Select '911' ACTIVITY_TYPE, 'debt Monitoring (������� ������� ��������� (������))' ACTIVITY_TYPE_DESC from dual
						Union Select '912' ACTIVITY_TYPE, '������� ������� ��������� (���� �� RF)' ACTIVITY_TYPE_DESC from dual
						Union Select '913' ACTIVITY_TYPE, '������� ����������� ������ ������� (debt monitoring, �������)' ACTIVITY_TYPE_DESC from dual
						Union Select '914' ACTIVITY_TYPE, '������� ����������� ������ ������� (debt monitoring, �������) ' ACTIVITY_TYPE_DESC from dual
						Union Select '915' ACTIVITY_TYPE, '�����������' ACTIVITY_TYPE_DESC from dual
						Union Select '916' ACTIVITY_TYPE, '������� �������' ACTIVITY_TYPE_DESC from dual
						Union Select '920' ACTIVITY_TYPE, '����������� ����������� �������' ACTIVITY_TYPE_DESC from dual
						Union Select '925' ACTIVITY_TYPE, '������ ��� Work Flow' ACTIVITY_TYPE_DESC from dual
						Union Select '931' ACTIVITY_TYPE, '������� ��������� ���������' ACTIVITY_TYPE_DESC from dual
						Union Select '933' ACTIVITY_TYPE, '������� �������� ��������� ������������' ACTIVITY_TYPE_DESC from dual
						Union Select '940' ACTIVITY_TYPE, '������� �����������' ACTIVITY_TYPE_DESC from dual
						Union Select '941' ACTIVITY_TYPE, '������������ �����������' ACTIVITY_TYPE_DESC from dual
						Union Select '945' ACTIVITY_TYPE, 'Create  KEPA Application  -- ���� �� ���� ���� ����������' ACTIVITY_TYPE_DESC from dual
						Union Select '946' ACTIVITY_TYPE, '������� �������� ���� �����������' ACTIVITY_TYPE_DESC from dual
						Union Select '948' ACTIVITY_TYPE, '������ ��� Workflow' ACTIVITY_TYPE_DESC from dual
						Union Select '950' ACTIVITY_TYPE, '������� �������' ACTIVITY_TYPE_DESC from dual
						Union Select '951' ACTIVITY_TYPE, '������� ����������� ������ ������� ��� ���� 1000' ACTIVITY_TYPE_DESC from dual
						Union Select '954' ACTIVITY_TYPE, '������������ �������' ACTIVITY_TYPE_DESC from dual
						Union Select '955' ACTIVITY_TYPE, 'CONTROL PANEL - ���������� WORKFLOW' ACTIVITY_TYPE_DESC from dual
						Union Select '958' ACTIVITY_TYPE, 'Control Panel-wrkflow ' ACTIVITY_TYPE_DESC from dual
						Union Select '959' ACTIVITY_TYPE, 'CONTROL PANEL - ���������� WORKFLOW' ACTIVITY_TYPE_DESC from dual
						Union Select '960' ACTIVITY_TYPE, 'CONTROL PANEL - ���������� WORKFLOW' ACTIVITY_TYPE_DESC from dual
						Union Select '961' ACTIVITY_TYPE, '������������ ��� �� ������ ������� ��� ���' ACTIVITY_TYPE_DESC from dual
						Union Select '962' ACTIVITY_TYPE, 'Transmission (���������)' ACTIVITY_TYPE_DESC from dual
						Union Select '970' ACTIVITY_TYPE, '���������� dummy web �������' ACTIVITY_TYPE_DESC from dual
						Union Select '971' ACTIVITY_TYPE, '������� ������������' ACTIVITY_TYPE_DESC from dual
						Union Select '972' ACTIVITY_TYPE, '������� �� - ������������' ACTIVITY_TYPE_DESC from dual
						Union Select '980' ACTIVITY_TYPE, '������� ������������' ACTIVITY_TYPE_DESC from dual
						Union Select '981' ACTIVITY_TYPE, '�������������' ACTIVITY_TYPE_DESC from dual
						Union Select '982' ACTIVITY_TYPE, '������ ��� Work Flow ��� ����' ACTIVITY_TYPE_DESC from dual
						Union Select '988' ACTIVITY_TYPE, '������� ����' ACTIVITY_TYPE_DESC from dual

						
						
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
--                                and Acc.DI_DEC_INCR_SEQ_NO = apofash.INCR_SEQ_NO_SR ) -- �����������	


--        Left join COM_PENSION_IKA_INSTITUTION COM_INST on web.INS_LAST_INS_INST = COM_INST.LAST_INSTITUTION_CODE and  nvl(decode(web.eseps_code,41003,21013,21017,21013,web.eseps_code),0) = nvl(COM_INST.eseps_code,web.eseps_code)  --PENSION_IKA_INST_CODE


/* #Enhmerwtika
-- ��������� �������� ��� �����������
Left Join WEB_WRK_APPL_GET_PENSIONS InfoNoteApp on (	web.INS_AMKA_ID	= 	InfoNoteApp.AMKA_ID 
																									and web.INS_TAX_REGISTRATION_NUMBER  = InfoNoteApp.TAXATION_ID
																									and InfoNoteApp.ETOS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(nvl(web.appl_protocol_date,SYSDATE)	, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'YYYY'))
																									and InfoNoteApp.MHNAS_PLIROMIS = TO_NUMBER(TO_CHAR(TO_DATE('01/'||TO_CHAR(nvl(web.appl_protocol_date,SYSDATE)	, 'MM/YYYY'),'DD/MM/YYYY') - 20, 'MM'))
																									)
																									
#Enhmerwtika */

																									
/*																									
-- ��������� ������� ��� �����������
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
--    AND APOFASH.STATUS = 1 --������ �������
 --   --AND web.Last_Updated_Date    Is Not Null
 
      AND web.status =1 --������ web ������
      AND web.Application_Status   = '1'  -- 0= ���������� 1=����������������
	 --and web.ins_amka_id not like '!#$%' 
	  --and web.origin = 1


--and apofash.DECISION_STATE_FLG = '1' --then    '1 - ����������������'   
--and apofash.DECISION_TYPE_FLG = '0' -- then    '���������' 
--and apofash.created_by in ( 'WEB_AUTO_PENS' ,'EFKA_N4611','WEB_DIR')
--and apofash.last_updated_by = 'WEB_AUTO_PENS' --EFKA_N4611
      
--	AND not exists (select 1 from WORKFLOW.Web_Auto_Pens_Data aaa where AAweb.AMKA_ID = web.INS_AMKA_ID ) -- den exei ginei paralabh

-- 	and web.appl_sid = 000000
-- and web.INS_INSURED_ID_EFKA in ('���_��������')	
--	and web.INS_AMKA_ID	in ('����_AITOYNTA')	
--	and dead.DEAD_INSURED_ID_EFKA in ('���_��������')
-- and dead.DEAD_AMKA_ID in ('����_��������')
	
--	and web.APPL_PROTOCOL_ORGBRA_CODE = '09904' and web.APPL_PROTOCOL_YEAR = 2020 and web.APPL_PROTOCOL_NO in ('��_�����������')
	
	
	--order by web.CREATION_DATE,reg.INSURED_ID
	
	
	