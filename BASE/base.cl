/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

% Класс
class base
    open core

predicates
    % Информация о классе
    classInfo : core::classInfo.
    % @short Class information predicate.
    % @detail This predicate represents information predicate of this class.
    % @end

constants
    % Пустая строка
    emptyString = "".


    /*-----------------------------------------------------------------------/
        Пробелы
    /-----------------------------------------------------------------------*/
    % Пробел
    spaceChar = ' '.
    spaceString = " ".    
    
    % Табуляция
    tabulationChar = '\t'.
    tabulationString = "\t".
    
    % Перевод на новую строку
    newLineChar = '\n'.
    newLineString = "\n".    
    /*======================================================================*/
    

    /*-----------------------------------------------------------------------/
        Знаки пунктуации    
    /-----------------------------------------------------------------------*/           
    % Открывающая фигурная скобка
    openningFiguredParenthesesChar = '{'.
    openningFiguredParenthesesString = "{".
    
    % Закрывающая фигурная скобка
    closingFiguredParenthesesChar = '}'.
    closingFiguredParenthesesString = "}".
        
    % Открывающая круглая скобка
    openningParenthesesChar = '('.
    openningParenthesesString = "(".
    
    % Закрывающая круглая скобка
    closingParenthesesChar = ')'.
    closingParenthesesString = ")".
    
    % Запятая
    commaChar = ','.
    commaString = ",".       
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        Знаки операций        
    /-----------------------------------------------------------------------*/               
    % Отрицание
    negationChar = '~'.
    negationString = "~".    
    
    % Конъюнкция
    conjunctionChar = '*'.
    conjunctionString = "*".    
    
    % Дизъюнкция
    disjunctionChar = '+'.
    disjunctionString = "+".    
    
    % Импликация
    implicationChar = '>'.
    implicationString = ">".
    
    % Эквивалентность
    equivalenceChar = '='.
    equivalenceString = "=".
    
    % Квантор существования
    existenceChar = '#'.
    existenceString = "#".
    
    % Квантор общности
    generalityChar = '@'.
    generalityString = "@".
    /*======================================================================*/
    
end class base