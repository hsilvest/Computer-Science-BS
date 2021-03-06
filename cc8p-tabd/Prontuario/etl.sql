INSERT INTO PACIENTE
(COD_PACIENTE, NOME_PACIENTE)
(SELECT COD_PACIENTE, NOME_PACIENTE
   FROM HOSPITALAR.PACIENTE);
/
INSERT INTO PLANO_SAUDE
(COD_PLANO, NOME_PLANO, NOME_TIPO_PLANO)
(SELECT COD_PLANO, NOME_PLANO, NOME_PS
   FROM HOSPITALAR.PLANO_SAUDE, HOSPITALAR.TIPO_PS
  WHERE HOSPITALAR.PLANO_SAUDE.TIPO_PS = HOSPITALAR.TIPO_PS.TIPO_PS);
/
INSERT INTO PROC
(COD_PROC, DESC_PROC, VLR_PROC)
(SELECT COD_PROCEDIMENTO, DESC_PROCEDIMENTO, VLR_PROCEDIMENTO
   FROM HOSPITALAR.PROCEDIMENTO);
/
INSERT INTO EXAME
(COD_EXAME, DESC_EXAME, VLR_EXAME)
(SELECT COD_EXAME, DESC_EXAME, VLR_EXAME
   FROM HOSPITALAR.EXAME);
/
INSERT INTO MEDICAMENTO
(COD_MED, DESC_MED, VLR_MEDICAMENTO)
(SELECT COD_MEDICAMENTO, DESC_MEDICAMENTO, VLR_MEDICAMENTO
   FROM HOSPITALAR.MEDICAMENTO);
/
INSERT INTO MEDICO
(CRM, NOME_MEDICO, COD_ESP, NOME_ESP)
(SELECT HOSPITALAR.MEDICO.CRM, 
        HOSPITALAR.MEDICO.NOME_MEDICO, 
        HOSPITALAR.ESPECIALIDADE.COD_ESPECIALIDADE, 
        HOSPITALAR.ESPECIALIDADE.DESC_ESPECIALIDADE
   FROM HOSPITALAR.MEDICO, 
        HOSPITALAR.MEDICO_ESPECIALIDADE, 
        HOSPITALAR.ESPECIALIDADE
  WHERE HOSPITALAR.MEDICO.CRM = HOSPITALAR.MEDICO_ESPECIALIDADE.CRM
    AND HOSPITALAR.ESPECIALIDADE.COD_ESPECIALIDADE = HOSPITALAR.MEDICO_ESPECIALIDADE.COD_ESPECIALIDADE);
/    
INSERT INTO PERIODO 
(ANO_MES)
(SELECT DISTINCT TO_NUMBER(TO_CHAR(DATA, 'YYYY')|| TO_CHAR(DATA, 'MM') )
   FROM HOSPITALAR.CONSULTA);
/
INSERT INTO CONSULTA
(COD_CONSULTA, ANO_MES, COD_PACIENTE, CRM, COD_ESP, COD_PLANO, VLR_CONSULTA,
 COD_PROC, VLR_PROC, COD_EXAME, VLR_EXAME, COD_MED, VLR_MED)
(SELECT HOSPITALAR.CONSULTA.COD_CONSULTA,
        TO_NUMBER(TO_CHAR(CONSULTA.DATA, 'YYYY')|| TO_CHAR(CONSULTA.DATA, 'MM') ),
        HOSPITALAR.CONSULTA.COD_PACIENTE,
        HOSPITALAR.CONSULTA.CRM,
        HOSPITALAR.CONSULTA.COD_ESPECIALIDADE,        
        HOSPITALAR.PACIENTE.COD_PLANO,
        0.00,  --VLR_CONSULTA,        
        HOSPITALAR.PROCEDIMENTO.COD_PROCEDIMENTO,
        HOSPITALAR.PROCEDIMENTO.VLR_PROCEDIMENTO,        
        HOSPITALAR.EXAME.COD_EXAME,
        HOSPITALAR.EXAME.VLR_EXAME,        
        HOSPITALAR.MEDICAMENTO.COD_MEDICAMENTO,
        HOSPITALAR.MEDICAMENTO.VLR_MEDICAMENTO
   FROM HOSPITALAR.CONSULTA,
        HOSPITALAR.PACIENTE,        
        HOSPITALAR.CONSULTA_PROCEDIMENTO,
        HOSPITALAR.PROCEDIMENTO,        
        HOSPITALAR.CONSULTA_EXAME,
        HOSPITALAR.EXAME,
        HOSPITALAR.CONSULTA_MEDICAMENTO,
        HOSPITALAR.MEDICAMENTO
  WHERE HOSPITALAR.CONSULTA.COD_PACIENTE =  HOSPITALAR.PACIENTE.COD_PACIENTE    
    AND HOSPITALAR.CONSULTA.COD_CONSULTA = HOSPITALAR.CONSULTA_PROCEDIMENTO.COD_CONSULTA(+)
    AND HOSPITALAR.CONSULTA.DATA = HOSPITALAR.CONSULTA_PROCEDIMENTO.DATA(+)
    AND HOSPITALAR.CONSULTA_PROCEDIMENTO.COD_PROCEDIMENTO = HOSPITALAR.PROCEDIMENTO.COD_PROCEDIMENTO(+)    
    AND HOSPITALAR.CONSULTA.COD_CONSULTA = HOSPITALAR.CONSULTA_EXAME.COD_CONSULTA(+)
    AND HOSPITALAR.CONSULTA.DATA = HOSPITALAR.CONSULTA_EXAME.DATA(+)    
    AND HOSPITALAR.CONSULTA_EXAME.COD_EXAME = HOSPITALAR.EXAME.COD_EXAME(+)    
    AND HOSPITALAR.CONSULTA.COD_CONSULTA = HOSPITALAR.CONSULTA_MEDICAMENTO.COD_CONSULTA(+)
    AND HOSPITALAR.CONSULTA.DATA = HOSPITALAR.CONSULTA_MEDICAMENTO.DATA(+)    
    AND  HOSPITALAR.CONSULTA_MEDICAMENTO.COD_MEDICAMENTO = HOSPITALAR.MEDICAMENTO.COD_MEDICAMENTO(+)) 