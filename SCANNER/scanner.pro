/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

*****************************************************************************/

% Лексический анализатор (сканер)
implement scanner
    open core

constants
    % Имя класса
    className = "com/visual-prolog/Scanner/scanner".
    % Версия класса
    classVersion = "$JustDate: 2008-05-01 $$Revision: 5 $".

clauses
    % Информация о классе
    classInfo( className, classVersion ).
    
constants
    % Заголовок ошибки
    errorTitle = "\n>> SCANNER ERROR: ".
    % Сообщение о недопустимых символах
    illegalSymbolsErrorMessage = "Illegal symbols".
    
class facts
    % Символ-пробел
    theSpaceChar : ( char ).       
    % Cимвол-знак пунктуации
    thePunctuationSignChar : ( char ).        
    % Cимвол-знак операции
    theOperationSignChar : ( char ).    

class predicates 
    % Проверка принадлежности символу-терминатору
    isTerminatorChar : ( char ) determ (i).

    % Получение строки после отбрасывания идущих подряд пробелов
    getStringWithSkipedFirstSpaces : ( string, string, core::integer32 )
        determ (i,o,o).
    % Получение длины первого слова в строке до встречи
    % с символом-терминатором, если он не встретится, слово - до конца строки
    getFirstWordLength : ( string, core::integer32 ) determ (i,o).
    
    % Получение первой лексемы в строке и после нее,
    % результирующие слово и результирующая длина слова
    getFirstLexeme : ( string, string, string, core::integer32 )
        determ (i,o,o,o).
    % Вывод сообщения об ошибке
    outputErrorMessage : ( string, cursorPosition ) procedure (i,i).
    % Распознавание лексемы
    recognizeLexeme : ( string, lexeme, cursorPosition ) determ (i,o,i).
    
    % Получение списка позиционированных лексем
    getPositionedLexemesList : ( string, positionedLexemesList,
        cursorPosition ) determ (i,o,i).

clauses
    /*-----------------------------------------------------------------------/
        theSpaceChar
        Символ-пробел
    /------------------------------------------------------------------------/
        char ParSpaceChar - символ пробела
    /-----------------------------------------------------------------------*/
    % Пробел
    theSpaceChar( base::spaceChar ).
    % Табуляция
    theSpaceChar( base::tabulationChar ).
    % Перевод на новую строку
    theSpaceChar( base::newLineChar ).
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        thePunctuationSignChar
        Cимвол-знак пунктуации
    /------------------------------------------------------------------------/
        char ParPunctuationSignChar - символ знака пунктуации
    /-----------------------------------------------------------------------*/
    % Открывающая круглая скобка
    thePunctuationSignChar( base::openningParenthesesChar ).
    % Закрывающая круглая скобка
    thePunctuationSignChar( base::closingParenthesesChar ).
    % Запятая
    thePunctuationSignChar( base::commaChar ).
    /*======================================================================*/    


    /*-----------------------------------------------------------------------/
        theOperationSignChar        
        Cимвол-знак операции
    /------------------------------------------------------------------------/        
        char ParOperationSignChar - символ знака операции
    /-----------------------------------------------------------------------*/
    % Отрицание
    theOperationSignChar( base::negationChar ).
    % Конъюнкция
    theOperationSignChar( base::conjunctionChar ).
    % Дизъюнкция
    theOperationSignChar( base::disjunctionChar ).
    % Импликация
    theOperationSignChar( base::implicationChar ).
    % Эквивалентность
    theOperationSignChar( base::equivalenceChar ).
    % Квантор существования
    theOperationSignChar( base::existenceChar ).
    % Квантор общности
    theOperationSignChar( base::generalityChar ).
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/
        isTerminatorChar
        Проверка принадлежности символу-терминатору
    /------------------------------------------------------------------------/
        char ParTerminatorChar - символ-терминатор
        determ (i)
    /-----------------------------------------------------------------------*/
    % Пробел
    isTerminatorChar( ParTerminatorChar ):-
        theSpaceChar( ParTerminatorChar ),
        !.
    % Знак пунктуации
    isTerminatorChar( ParTerminatorChar ):-
        thePunctuationSignChar( ParTerminatorChar ),
        !.
    % Знак операции
    isTerminatorChar( ParTerminatorChar ):-
        theOperationSignChar( ParTerminatorChar ),
        !.
    /*======================================================================*/        
    
    
    /*-----------------------------------------------------------------------/
        getStringWithSkipedFirstSpaces
        Получение строки после отбрасывания идущих подряд пробелов
    /------------------------------------------------------------------------/
        string ParString - строка
        string ParStringWithSkipedFirstSpaces - результат после отбрасывания пробелов           
        core::integer32 ParFirstSpacesLength - длина отброшенных пробелов    
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Из исходной строки выделяем первый символ и рекурсивно:
        если это пробел,
            то возвращаем результат после отбрасывания пробелов
            и длину отброшенных пробелов,
        затем рекурсивно обрабатываем оставшуюся часть строки
        и длину отброшенных пробелов увеличиваем */
    getStringWithSkipedFirstSpaces
    (
        ParString,
        ParStringWithSkipedFirstSpaces,
        ParFirstSpacesLength
    ):-
        string5x::frontChar
        (
            ParString,
            LocFirstChar,
            LocRestString
        ),
        theSpaceChar( LocFirstChar ),
        !,
        getStringWithSkipedFirstSpaces
        (
            LocRestString,
            ParStringWithSkipedFirstSpaces,
            LocCutFirstSpacesLength
        ),
        ParFirstSpacesLength = LocCutFirstSpacesLength + 1.
    /*
    Первый символ исходной строки не является пробелом,
        значит результирующая строка - исходная строка без изменений
        и количество отброшенных пробелов равно нулю */
    getStringWithSkipedFirstSpaces
    (
        ParStringWithSkipedFirstSpaces,
        ParStringWithSkipedFirstSpaces,
        0
    ).
    /*======================================================================*/       
      
    
    /*-----------------------------------------------------------------------/
        getFirstWordLength
        Получение длины первого слова в строке до встречи
        с символом-терминатором, если он не встретится, слово - до конца строки
    /------------------------------------------------------------------------/
        string ParString - строка
        core::integer32 ParFirstWordLength - длина первого слова
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Из исходной строки выделяем первый символ:
       если исходная строка не пуста,
           то проверяем первый символ:
           если он не терминатор,
               то увеличиваем длину слова,
           затем рекурсивно обрабатываем оставшуюся часть строки
           и длину первого слова увеличиваем */
    getFirstWordLength
    (
        ParString,
        ParFirstWordLength
    ):-
        string5x::frontChar
        (
            ParString,
            LocFirstChar,
            LocRestString
        ),
        not( isTerminatorChar( LocFirstChar ) ),
        !,
        getFirstWordLength
        (
            LocRestString,
            LocCutFirstWordLength
        ),
        ParFirstWordLength = LocCutFirstWordLength + 1.
    /*
    Первый символ исходной строки является терминатором,
        значит результирующее слово - пустое слово
        и количество символов в первом слове равно нулю */
    getFirstWordLength( _, 0 ).
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getFirstLexeme
        Получение первой лексемы в строке и после нее,
        результирующие слово и результирующая длина слова
    /------------------------------------------------------------------------/
        string ParString - строка
        string ParRestString - оставшаяся часть строки после лексемы
        string ParFirstLexeme - лексема
        core::integer32 ParFirstLexemeLength - длина лексемы        
        determ (i,o,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если строка пуста,
        то лексема не может быть получена */
    getFirstLexeme
    (
        base::emptyString,
        _,
        _,
        _
    ):- 
        !,
        fail.
    /*
    Из исходной строки выделяем первый символ и рекурсивно:
        если это терминатор,
            то слово состоит из одного символа - знака терминатора
            и оставшаяся строка - это хвост без первого символа
            и результирующая длина слова равна единице,
        затем возвращаем лексему и результирующие */
    getFirstLexeme
    (
        ParString,
        ParRestString,
        ParFirstLexeme,
        1        
    ):-
        string5x::frontChar
        (
            ParString,
            LocFirstChar,
            ParRestString
        ),
        isTerminatorChar( LocFirstChar ),
        !,
        conversion5x::str_char
        (
            ParFirstLexeme,
            LocFirstChar
        ).
    /*
    Определяем длину первого слова в строке
    и затем выделяем из строки это слово и остаток */       
    getFirstLexeme
    (
        ParString,
        ParRestString,
        ParFirstLexeme,
        ParFirstLexemeLength        
    ):-
        getFirstWordLength
        (
            ParString,
            ParFirstLexemeLength
        ),
        string5x::frontStr
        (
            ParFirstLexemeLength,
            ParString,
            ParFirstLexeme,
            ParRestString
        ).
    /*======================================================================*/                       
    

    /*-----------------------------------------------------------------------/
        outputErrorMessage
        Вывод сообщения об ошибке
    /------------------------------------------------------------------------/
        string ParErrorMessageString - строка сообщения об ошибке
        cursorPosition ParCursorPosition - позиция курсора
        procedure (i,i)
    /-----------------------------------------------------------------------*/
    /*
    Вывод сообщения об ошибке с указанием позиции
    в виде номера символа */
    outputErrorMessage
    (
        ParErrorMessageString,
        ParCursorPosition
    ):-
        file5x::write
        (
            errorTitle,
            ParErrorMessageString,
            cursorPositionTitle,
            ParCursorPosition + 1           
        ),
        file5x::nl.
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        recognizeLexeme
        Распознавание лексемы
    /------------------------------------------------------------------------/        
        string ParLexemeString - строка лексемы
        lexeme ParLexeme - лексема
        cursorPosition ParCursorPosition - позиция курсора
        determ (i,o,i)
    /-----------------------------------------------------------------------*/    
    % Открывающая круглая скобка
    recognizeLexeme
    (
        base::openningParenthesesString,
        openningParentheses,
        _
    ):- !.
	% Закрывающая круглая скобка
    recognizeLexeme
    (
        base::closingParenthesesString,
        closingParentheses,
        _
    ):- !.
  	% Запятая
    recognizeLexeme
    (
        base::commaString,
        comma,
        _
    ):- !.
    /*
    Если строка лексемы состоит из одного символа,
        и если он является знаком операции,
            то распознаем его как знак операции,
    затем возвращаем лексему и результирующие */
    recognizeLexeme
    (
        ParOperationSignString,
        operationSign( ParOperationSignString ),
        _
    ):-
        conversion5x::str_char
        (
            ParOperationSignString,
            LocOperationSignChar
        ),
        theOperationSignChar( LocOperationSignChar ),
        !.
    /*
    Из строки лексемы выделяем первый символ:
        если он является прописной буквой латинского алфавита,
            то данная строка лексемы является именем собственным
                    (последовательностью прописных букв, цифр
                    и знаков подчеркивания, начинающаяся с прописной буквы),
                и данная строка распознается как имя собственное,
    затем возвращаем лексему и результирующие */                
    recognizeLexeme
    (
        ParProperNameString,
        properName( ParProperNameString ),
        _
    ):-
        string5x::frontChar
        (
            ParProperNameString,
            LocFirstChar,
            _
        ),
        LocFirstChar >= 'A',
        LocFirstChar <= 'Z',
        string5x::isName( ParProperNameString ),
        !.
    /*
    Если данная строка лексемы является именем нарицательным
            (последовательностью строчных букв, цифр и знаков
            подчеркивания, начинающаяся со строчной буквы
            или знака подчеркивания),
        то данная строка распознается как имя нарицательное,
    затем возвращаем лексему и результирующие */               
    recognizeLexeme
    (
        ParCommonNounString,
        commonNoun( ParCommonNounString ),
        _
    ):-
        string5x::isName( ParCommonNounString ),
        !.
    /*
    Данная строка ни на что не похожа, содержит недопустимые символы,
    выводим информацию об ошибке с указанием позиции,
    и выходим с ошибкой */     
    recognizeLexeme
    (
        ParErrorString,
        _,
        ParCursorPosition        
    ):-
        file5x::nl,
        file5x::write( ParErrorString ),        
        outputErrorMessage
        (
            illegalSymbolsErrorMessage,
            ParCursorPosition
        ),
        !,
        fail.
    /*======================================================================*/    


    /*-----------------------------------------------------------------------/
        getPositionedLexemesList
        Получение списка позиционированных лексем
    /------------------------------------------------------------------------/
        string ParString - строка
        positionedLexemesList ParPositionedLexemesList -
            список позиционированных лексем
        cursorPosition ParCursorPosition - позиция курсора
        determ (i,o,i)
    /-----------------------------------------------------------------------*/    
    /*
    Из исходной строки выделяем первую лексему,
    удаляем первый пробел в начале строки перед ней,
    если строка не пуста,
        то из исходной строки получаем очередную лексему,
        и если она распознана,
            то помещаем в начало результирующего
                списка позиционированных лексем
                позиционированную лексему,
            вычисляем позицию лексемы в строке,
            и рекурсивно обрабатываем хвост строки
    затем возвращаем лексему и результирующие */    
    getPositionedLexemesList
    (
        ParString, 
        [
            positionedLexeme
            (
                ParFirstLexeme,
                ParFirstLexemeCursorPosition
            )
            |
            ParPositionedLexemesListTail
        ],
        ParCursorPosition        
    ):-
        getStringWithSkipedFirstSpaces
        (
            ParString,
            LocStringWithSkipedFirstSpaces,
            LocFirstSpacesLength
        ),
        ParFirstLexemeCursorPosition =
            ParCursorPosition + LocFirstSpacesLength,        
        getFirstLexeme
        (
            LocStringWithSkipedFirstSpaces,
            LocStringWithSkipedFirstLexeme,
            LocFirstLexemeString,
            LocFirstLexemeStringLength            
        ),
        recognizeLexeme
        (
            LocFirstLexemeString,
            ParFirstLexeme,
            ParFirstLexemeCursorPosition
        ),
        !,
        LocCursorPositionAfterFirstLexeme = 
            ParFirstLexemeCursorPosition + LocFirstLexemeStringLength,
        getPositionedLexemesList
        (
            LocStringWithSkipedFirstLexeme,
            ParPositionedLexemesListTail,
            LocCursorPositionAfterFirstLexeme
        ).
    /*
    Строка пуста, возвращаем пустой список лексем */        
    getPositionedLexemesList
    (
        _,
        [],
        _        
    ).
    /*======================================================================*/    
        
    
    /*-----------------------------------------------------------------------/
        getPositionedLexemesList
        Получение списка позиционированных лексем
    /------------------------------------------------------------------------/
        string ParString - строка
        positionedLexemesList ParPositionedLexemesList -
            список позиционированных лексем
        procedure (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Получение списка позиционированных лексем
    при начальной позиции курсора - равной нулю */
    getPositionedLexemesList
    (
        ParString, 
        ParPositionedLexemesList
    ):-
        getPositionedLexemesList
        (
            ParString,
            ParPositionedLexemesList,
            0
        ),
        !.
    /*
    Возвращаем пустой */
    getPositionedLexemesList( _, [] ).
    /*======================================================================*/                
    
end implement scanner