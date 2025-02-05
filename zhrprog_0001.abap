REPORT zhrprog_0001.

*Crie um programa ABAP que liste os funcionários (tabela PA0001) com base em uma área de negócios (BUKRS).
*Use WRITE para exibir os dados na tela.

" Declara uma tabela interna baseada na estrutura da tabela PA0001 (dados organizacionais do empregado no SAP HCM)
DATA it_pa0001 TYPE TABLE OF pa0001.

PERFORM f_busca_dados.  " Chama a rotina para buscar os dados da tabela PA0001
PERFORM f_mostra_dados. " Chama a rotina para exibir os dados obtidos

" FORM para buscar dados da tabela PA0001 e armazenar na tabela interna
FORM f_busca_dados .
  " Seleciona todos os campos da tabela PA0001 onde a empresa (BUKRS) seja '2000'
  " Os resultados são armazenados na tabela interna it_pa0001
  SELECT *
    FROM pa0001
    INTO TABLE it_pa0001
    WHERE bukrs EQ '2000'.

  IF it_pa0001 IS NOT INITIAL.                 " Verifica se há registros na tabela interna
    DELETE ADJACENT DUPLICATES FROM it_pa0001. " Remove registros duplicados adjacentes com base em todos os campos da estrutura PA0001
  ENDIF.
ENDFORM.

" FORM para exibir os dados armazenados na tabela interna
FORM f_mostra_dados .
  LOOP AT it_pa0001 ASSIGNING FIELD-SYMBOL(<fs_pa0001>).   " Percorre a tabela interna usando FIELD-SYMBOL para melhorar a performance
    WRITE <fs_pa0001>.                                     " Escreve na tela o conteúdo do registro atual
  ENDLOOP.
ENDFORM.
