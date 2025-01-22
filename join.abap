REPORT zhrt_join_0742.

TYPES: BEGIN OF ty_emp,
         id    TYPE int4,
         nome  TYPE char120,
         valor TYPE int4,
       END OF ty_emp.

DATA: it_emp            TYPE TABLE OF ty_emp,
      lv_title          TYPE string,
      lv_primeira_letra TYPE c LENGTH 1.

" Selecionar dados com JOIN
SELECT t1~id, t1~nome, t1~cargo, t2~valor
  INTO TABLE @DATA(it_result)
  FROM zrt0742_emp AS t1
  INNER JOIN zrt0742_salario AS t2
  ON t1~id = t2~id
  WHERE t1~nome LIKE 'J%' " Filtra nomes que começam com 'A'
  AND t2~valor > 1000.
*  = ( SELECT MAX( valor ) FROM zrt0742_salario WHERE id = t1~id ).

" Loop para armazenar resultados em lt_emp
LOOP AT it_result ASSIGNING FIELD-SYMBOL(<fs_result>).
  APPEND INITIAL LINE TO it_emp ASSIGNING FIELD-SYMBOL(<fs_emp>).
  <fs_emp>-id    = <fs_result>-id.
  <fs_emp>-nome  = <fs_result>-nome.
  <fs_emp>-valor = <fs_result>-valor.
ENDLOOP.
