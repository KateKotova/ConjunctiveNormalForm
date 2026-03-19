/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

*****************************************************************************/

/*===========================================================================/    

        Л Е К С И Ч Е С К И Й   А Н А Л И З А Т О Р   ( С К А Н Е Р )        
                
    Назначение: разбиение строки на лексемы и привязка их к позициям

    Типы лексем:
        openningParentheses     - ( - открывающая круглая скобка
        closingParentheses      - ) - закрывающая круглая скобка
        comma                   - , - запятая
        operationSign( string )     - знак операции
        properName( string )        - имя собственное
        commonNoun( string )        - имя нарицательное
        
    Знаки операций:
        ~ - отрицание
        * - конъюнкция
        + - дизъюнкция
        > - импликация
        = - эквивалентность
        # - квантор существования
        @ - квантор общности
    
    Имя собственное - последовательность прописных букв, цифр и знаков
        подчеркивания, начинающаяся с прописной буквы
        
    Имя нарицательное - последовательность строчных букв, цифр и знаков
        подчеркивания, начинающаяся со строчной буквы
        или знака подчеркивания 

/===========================================================================*/    

% Лексический анализатор (сканер)
class scanner
    open core

predicates
    % Информация о классе
    classInfo : core::classInfo.
    % @short Class information predicate.
    % @detail This predicate represents information predicate of this class.
    % @end
    
constants
    % Заголовок позиции курсора
    cursorPositionTitle = " at position ".    
    
domains
    % Лексема
    lexeme =
        % Открывающая круглая скобка
        openningParentheses;
        % Закрывающая круглая скобка
        closingParentheses;
        % Запятая
        comma;
        % Знак операции
		operationSign( string );        
		% Имя собственное
		properName( string );
		% Имя нарицательное
		commonNoun( string ).		

    % Позиция курсора
    cursorPosition = integer.
    % Позиционированная лексема
    positionedLexemeDomain = positionedLexeme( lexeme, cursorPosition ).
    % Список позиционированных лексем
    positionedLexemesList = positionedLexemeDomain*.

predicates
    % Получение списка позиционированных лексем
    getPositionedLexemesList : ( string, positionedLexemesList )
        procedure (i,o).
        
end class scanner