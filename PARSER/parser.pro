/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

% Синтаксический анализатор
implement parser
    open core
      
constants
    % Имя класса
    className = "com/visual-prolog/Parser/parser".
    % Версия класса
    classVersion = "$JustDate: 2008-05-01 $$Revision: 5 $".
    
clauses
    % Информация о классе
    classInfo( className, classVersion ). 
    
constants
    % Заголовок ошибки
    errorTitle = "\n>> PARSER ERROR: ".
    
    /*-----------------------------------------------------------------------/
        Сообщения об ошибках
    /-----------------------------------------------------------------------*/    
    % Несбалансированность закрывающих скобок
    unbalancedClosingParenthesesErrorMessage = 
        "Unbalanced closing parentheses".
    % Несбалансированность открывающих скобок
    unbalancedOpenningParenthesesesErrorMessage =
        "Unbalanced openning parentheseses".   
        
    % Недопустимая лексема в списке переменных
    variablesListIllegalLexemeErrorMessage =
        "Illegal lexeme in variables list".
    % Недопустимое выражение в списке переменных
    variablesListIllegalExpressionErrorMessage =
        "Illegal expression in variables list".

    % Некорректный список переменных
    incorrectVariablesListErrorMessage = "Incorrect variables list".     
    % Недопустимая запятая вне списка переменных
    illegalCommaOutOfVariablesListErrorMessage =
        "Illegal comma out of variables list".
    % Недопустимая переменная вне списка переменных    
    illegalVariableOutOfVariablesListErrorMessage =
        "Illegal variable out of variables list". 
          
    % Недопустимый квантор без переменной
    illegalQuantifierWithoutVariableErrorMessage = 
        "Illegal quantifier without variable".

    % Недопустимая лексема в списке элементов
    elementsListIllegalLexemeErrorMessage = "Illegal lexeme in elements list".
    % Недопустимое выражение в списке элементов
    elementsListIllegalExpressionErrorMessage =
        "Illegal expression in elements list".
        
    % Недопустимое выражение под квантором
    illegalUngerQuantifierExpressionErrorMessage =
        "Illegel unger quantifier expression".
    % Необъявленные переменные в списке переменных предиката
    undeclaredPredicateVariablesErrorMessage = 
        "Undeclared variables in variables list of predicate".    
        
    % Недопустимое отрицательное выражение    
    illegalNegatedExpressionErrorMessage = "Illegal negated expression".    
    % Некорректный список аргументов и знаков операций
    incorrectArgumentsAndOperationsSignsListErrorMessage =
        "Incorrect arguments and operations signs list".
    /*======================================================================*/
    
domains
    % Вид квантора
    quantifierKind =
        % Существования
        existence;
        % Общности
        generality.        

    % Элемент
    element =
        % Позиционированная лексема
        positionedLexeme( scanner::lexeme, scanner::cursorPosition );
        % Выражение-элемент
        expressionElement( expression );
        % Переменная
        variable( string );
        % Квантор c переменной
        quantifierAndVariable( quantifierKind, variableDomain );         
        % Квантор
        quantifier( quantifierKind, variableDomain, variablesList,
            elementsList );
        % Отрицание
        negation( elementsList );
        % Вложенные элементы
        subElements( elementsList );
        % Эквивалентность
        equivalence( elementsList, elementsList );
        % Импликация
        implication( elementsList, elementsList );
        % Дизъюнкция
        disjunction( elementsList );
        % Конъюнкция
        conjunction( elementsList ).        

    % Список элементов
    elementsList = element*.                   

class facts
    % Строка квантора
    theQuantifierString : ( string ).       
    % Знаки пунктуации, не являющиеся кванторами
    theNotQuantifierPunctuationSignLexeme : ( scanner::lexeme ).
    % Вид и строка квантора
    theQuantifierKindAndString : ( quantifierKind, string ).
    
class predicates 
    /*-----------------------------------------------------------------------/
        Работа со скобками
    /-----------------------------------------------------------------------*/
    % Получение количества идущих подряд открывающих скобок
    getFirstOpenningParenthesesesNumber : ( elementsList, elementsList,
        core::integer32, core::integer32 ) determ (i,o,i,o).
    getFirstOpenningParenthesesesNumber : ( elementsList, elementsList,
        core::integer32 ) determ (i,o,o).
    
    % Получение количества идущих подряд закрывающих скобок
    getFirstClosingParenthesesesNumber : ( elementsList, elementsList,
        core::integer32, core::integer32 ) determ (i,o,i,o).
    getFirstClosingParenthesesesNumber : ( elementsList, elementsList,
        core::integer32 ) determ (i,o,o).
    
    % Вывод сообщения об ошибке
    outputErrorMessage : ( string, scanner::cursorPosition ) procedure (i,i).
    outputErrorMessage : ( string ) procedure (i).
    
    % Получение баланса открывающих и закрывающих скобок
    getParenthesesesBalance : ( elementsList, elementsList, core::integer32,
        core::integer32, core::integer32, core::integer32 )
        determ (i,o,i,o,i,o).
    getParenthesesesBalance : ( elementsList, core::integer32,
        core::integer32, core::integer32, core::integer32 )
        determ (i,i,o,i,o).
    getParenthesesesBalance : ( elementsList, core::integer32,
        core::integer32 ) determ (i,o,o).

    % Проверка сбалансированности открывающих и закрывающих скобок
    parenthesesesAreBalanced : ( elementsList, core::integer32,
        core::integer32 ) determ (i,i,i).
    parenthesesesAreBalanced : ( elementsList ) determ (i).
    
    % Получение списка элементов после первой встречной закрывающей скобки
    getElementsListAfterFirstClosingParentheseses : ( elementsList,
        elementsList, core::integer32, core::integer32 ) determ (i,o,o,o).
    % Получение списка элементов без внешних открывающих скобок
    getElementsListWithoutExternalOpenningParentheseses : ( elementsList,
        elementsList, core::integer32 ) determ (i,o,i).
    % Конкатенация первого и второго списков в третий
    concatenateElementsLists : ( elementsList, elementsList, elementsList )
        determ anyflow.
    % Получение списка элементов без внешних закрывающих скобок
    getElementsListWithoutExternalClosingParentheseses : ( elementsList,
        elementsList, core::integer32 ) determ (i,o,i).
    
    % Получение списка элементов без внешних скобок
    getElementsListWithoutExternalParentheseses : ( elementsList,
        elementsList, core::integer32 ) determ (i,o,i).
    getElementsListWithoutExternalParentheseses : ( elementsList,
        elementsList, elementsList, core::integer32, core::integer32 )
        determ (i,i,o,i,i).
    getElementsListWithoutExternalParentheseses : ( elementsList,
        elementsList ) determ (i,o).
    
    % Получение первого заключенного в скобки списка элементов
    % и оставшегося списка элементов
    getFirstParentheticallyElementsList : ( elementsList, elementsList,
        elementsList, core::integer32 ) determ (i,o,o,i).
    getFirstParentheticallyElementsList : ( elementsList, elementsList,
        elementsList ) determ (i,o,o).
    /*======================================================================*/  
      
    
    /*-----------------------------------------------------------------------/
        Переменные и списки из них
    /-----------------------------------------------------------------------*/    
    % Проверка принадлежности к классу переменной
    isVariableElement : ( element, variableDomain ) determ (i,o).    
    % Получение единственной переменной, содержащейся в списке,
    % как единого целого элемента
    getSingleVariable : ( elementsList, variableDomain ) determ (i,o).      
    % Получение первой переменной, встречающейся в списке
    getFirstVariable : ( elementsList, elementsList, variableDomain )
        determ (i,o,o).
    
    % Получение списка переменных и запятых из исходного списка
    getVariablesAndCommasElementsList : ( elementsList, elementsList )
        determ (i,o).
    % Проверка корректности списка, состоящего из переменных и запятых,
    % которые чередуются в правильном порядке
    isCorrectVariablesAndCommasElementsList : ( elementsList ) determ (i).    
    
    % Получение списка переменных из исходного списка элементов,
    % состоящего из переменных и запятых
    getVariablesList : ( elementsList, variablesList ) determ (i,o).
    % Проверка вхождения переменной в список переменных
    variableIsInVariablesList : ( variableDomain, variablesList )
        determ (i,i).
    % Проверка вхождения списка переменных в другой список
    variableListIsInVariablesList : ( variablesList, variablesList )
        determ (i,i).
    
    % Получение списка без повторяющихся переменных из исходного списка   
    getVariablesListWithoutReiterativeVariables : ( variablesList,
        variablesList, variablesList ) determ (i,i,o).
    getVariablesListWithoutReiterativeVariables : ( variablesList,
        variablesList ) determ (i,o).
    
    % Добавление переменной в список без повторения её
    addVariableToVariablesListWithoutRepetition : ( variablesList,
        variablesList, variableDomain ) procedure (i,o,i).
    % Получение первого списка переменных из исходного списка элементов
    getFirstVariablesList : ( elementsList, elementsList, variablesList )
        determ (i,o,o).
    /*======================================================================*/      
    
    
    /*-----------------------------------------------------------------------/
        Предикаты
    /-----------------------------------------------------------------------*/        
    % Проверка принадлежности списка к классу предиката
    isPredicateElementsList : ( elementsList, expression ) determ (i,o).
    % Получение единственного предиката, содержащегося в списке,
    % как единого целого элемента
    getSinglePredicate : ( elementsList, expression ) determ (i,o).
    % Получение первого предиката, встречающегося в списке
    getFirstPredicate : ( elementsList, elementsList, expression )
        determ (i,o,o).
    /*======================================================================*/ 
                
    
    /*-----------------------------------------------------------------------/
        Кванторы
    /-----------------------------------------------------------------------*/            
    % Проверка принадлежности списка к классу квантора с переменной
    isQuantifierAndVariableElementsList : ( elementsList, element )
        determ (i,o).
    % Получение единственного квантора с переменной, содержащегося в списке,
    % как единого целого элемента
    getSingleQuantifierAndVariable : ( elementsList, element ) determ (i,o).
    % Получение первого квантора с переменной, встречающегося в списке
    getFirstQuantifierAndVariable : ( elementsList, elementsList, element )
        determ (i,o,o).

    % Получение всех предикатов, кванторов и переменных
    getAllPredicatesAndQuantifiersAndVariables : ( elementsList,
        elementsList ) determ (i,o).

    % Проверка принадлежности списка к классу квантора
    isQuantifierElementsList : ( elementsList, element ) determ (i,o).
    % Получение единственного квантора, содержащегося в списке,
    % как единого целого элемента
    getSingleQuantifier : ( elementsList, element ) determ (i,o).
    % Получение первого квантора, встречающегося в списке
    getFirstQuantifier : ( elementsList, elementsList, element )
        determ (i,o,o).
    
    % Получение всех кванторов
    getAllQuantifiers : ( elementsList, elementsList ) determ (i,o).
    % Получение списка элементов без пустых кванторов -
    % удаление кванторов из пустых подвыражений
    getElementsListWithoutEmptyQuantifiers : ( elementsList, elementsList )
        determ (i,o).
    
    % Получение связанных переменных кванторов
    getQuantifiersVariablesLists : ( elementsList, elementsList,
        variablesList ) determ (i,o,i).
    getQuantifiersVariablesLists : ( elementsList, elementsList )
        determ (i,o).
    
    % Получение всех предикатов и кванторов
    getAllPredicatesAndQuantifiers : ( elementsList, elementsList )
        determ (i,o).
    /*======================================================================*/ 


    /*-----------------------------------------------------------------------/
        Отрицания
    /-----------------------------------------------------------------------*/        
    % Проверка принадлежности списка к классу отрицания
    isNegationElementsList : ( elementsList, element ) determ (i,o).
    % Получение единственного отрицания, содержащегося в списке,
    % как единого целого элемента
    getSingleNegation : ( elementsList, element ) determ (i,o).
    % Получение первого отрицания, встречающегося в списке
    getFirstNegation : ( elementsList, elementsList, element ) determ (i,o,o).
    
    % Проверка принадлежности знака к знаку бинарной операции
    isBinaryOperationPunctuationSignLexeme : ( scanner::lexeme ) determ (i).
    % Получение всех отрицаний
    getAllNegations : ( elementsList, elementsList ) determ (i,o).
    % Получение списка элементов без пустых отрицаний -
    % удаление отрицаний из пустых подвыражений
    getElementsListWithoutEmptyNegations : ( elementsList, elementsList )
        determ (i,o).
    /*======================================================================*/     


    /*-----------------------------------------------------------------------/
        Вложенные выражения
    /-----------------------------------------------------------------------*/
    % Проверка принадлежности списка к классу вложенного выражения
    isSubElementsList : ( elementsList, element ) determ (i,o).
    % Получение единственного вложенного выражения, содержащегося в списке,
    % как единого целого элемента
    getSingleSubElements : ( elementsList, element ) determ (i,o).
    % Получение первого вложенного выражения, встречающегося в списке
    getFirstSubElements : ( elementsList, elementsList, element )
        determ (i,o,o).
    
    % Проверка принадлежности знака к знаку бинарной операции
    isBinaryOperationSignLexeme : ( scanner::lexeme ) determ (i).
    % Получение всех вложенных выражений
    getAllSubElements : ( elementsList, elementsList ) determ (i,o).
    % Получение списка элементов без пустых вложенных выражений -
    % удаление вложенных выражений из пустых подвыражений
    getElementsListWithoutEmptySubElements : ( elementsList, elementsList )
        determ (i,o).
    
    % Извлечение внутреннего списка элементов из вложенного выражения
    getElementsListExtractedFromSubElementsList : ( elementsList,
        elementsList ) procedure (i,o).
    % Получение списка элементов с элементами,
    % извлеченными из вложенных выражений
    getElementsListWithElementsExtractedFromSubElementsLists : ( elementsList,
        elementsList ) determ (i,o).
    /*======================================================================*/     
    

    /*-----------------------------------------------------------------------/
        Аргументы операций
    /-----------------------------------------------------------------------*/
    % Проверка принадлежности элемента к классу аргумента бинарной операции
    isBinaryOperationArgumentElement : ( element ) determ (i).
    % Получение внутреннего списка элементов аргумента бинарной операции
    getBinaryOperationArgumentInternalElementsList : ( element, elementsList )
        determ (i,o).
    % Переустановка внутреннего списка элементов аргумента бинарной операции
    resetBinaryOperationArgumentInternalElementsList : ( element, element,
        elementsList ) determ (i,o,i).
    
    % Проверка корректности чередования списка из аргументов
    % и знаков бинарных операций, которые чередуются в правильном порядке
    isCorrectBinaryOperationsArgumentsAndSignsElementsList : ( elementsList )
        determ (i).
    % Получение всех аргументов бинарных операций
    getAllBinaryOperationsArguments : ( elementsList, elementsList )
        determ (i,o).
    /*======================================================================*/     


    /*-----------------------------------------------------------------------/
        Двухместные операции
    /-----------------------------------------------------------------------*/
    % Проверка принадлежности списка к классу бинарной операции
    % с левым и правым списками подвыражений
    isTwoArgumentsOperation : ( elementsList, scanner::lexeme, elementsList,
        elementsList ) determ (i,i,o,o).
    
    % Получение эквивалентностей в ширину
    getEquivalencesInWidth : ( elementsList, elementsList ) determ (i,o).
    % Получение эквивалентностей в глубину
    getEquivalencesInDepth : ( elementsList, elementsList ) determ (i,o).
    
    % Получение импликаций в ширину
    getImplicationsInWidth : ( elementsList, elementsList ) determ (i,o).
    % Получение импликаций в глубину
    getImplicationsInDepth : ( elementsList, elementsList ) determ (i,o).
    
    % Получение всех аргументов бинарных операций и двухместных операций
    getAllBinaryOperationsArgumentsAndTwoArgumentsOperation : ( elementsList,
        elementsList ) determ (i,o).
    
    % Проверка принадлежности элемента к классу двухместной операции
    isTwoArgumentsOperationElement : ( element ) determ (i).
    % Получение внутренних списков элементов двухместной операции
    getTwoArgumentsOperationInternalElementsLists : ( element, elementsList,
        elementsList ) determ (i,o,o).
    % Переустановка внутренних списков элементов двухместной операции
    resetTwoArgumentsOperationInternalElementsLists : ( element, element,
        elementsList, elementsList ) determ (i,o,i,i).
    /*======================================================================*/         


    /*-----------------------------------------------------------------------/
        Многоместные операции
    /-----------------------------------------------------------------------*/
    % Преобразование списка элементов в результирующий элемент
    ConvertElementsListToElement : ( elementsList, element ) procedure (i,o).
    % Получение списка элементов-аргументов из исходного списка
    % путем расщепления по знаку операции
    getMultiArgumentsOperationElementsList : ( elementsList, scanner::lexeme,
        elementsList, elementsList ) determ (i,i,i,o).
    % Проверка принадлежности списка к классу многоместной операции
    % и получение списка элементов-аргументов
    isMultiArgumentsOperation : ( elementsList, scanner::lexeme,
        elementsList ) determ (i,i,o).
    
    % Получение списка элементов дизъюнкции без вложенных дизъюнкций   
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions : ( elementsList,
        elementsList ) procedure (i,o).
    % Получение дизъюнкций в ширину
    getDisjunctionsInWidth : ( elementsList, elementsList ) determ (i,o).
    % Получение аргументов с полученными дизъюнкциями в ширину
    getArgumentsWithGotDisjunctionsInWidth : ( elementsList, elementsList )
        determ (i,o).
    % Получение дизъюнкций в глубину
    getDisjunctionsInDepth : ( elementsList, elementsList ) determ (i,o).
    
    % Получение списка элементов конъюнкции без вложенных конъюнкций
    getConjunctionArgumentsWithoutEmbeddedConjunctions : ( elementsList,
        elementsList ) procedure (i,o).
    % Получение конъюнкций в ширину
    getConjunctionsInWidth : ( elementsList, elementsList ) determ (i,o).
    % Получение аргументов с полученными конъюнкциями в ширину
    getArgumentsWithGotConjunctionsInWidth : ( elementsList, elementsList )
        determ (i,o).
    % Получение конъюнкций в глубину
    getConjunctionsInDepth : ( elementsList, elementsList ) determ (i,o).
    
    % Получение всех аргументов и операций
    getAllArgumentsAndOperation : ( elementsList, elementsList ) determ (i,o).
    /*======================================================================*/   

    /*-----------------------------------------------------------------------/
        Конверторы
    /-----------------------------------------------------------------------*/    
    % Преобразование списка лексем в список элементов
    ConvertPositionedLexemesListToElementsList :
        ( scanner::positionedLexemesList, elementsList ) determ (i,o).
    % Преобразование элемента в выражение
    ConvertElementToExpression : ( element, expression ) determ (i,o).
    % Преобразование списка элементов в список выражений
    ConvertElementsListToExpressionsList : ( elementsList, expressionsList )
        determ (i,o).
    /*======================================================================*/   

clauses
    /*======================================================================/
    
        Ф А К Т Ы
    
    /=======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        theQuantifierString
        Строка квантора
    /------------------------------------------------------------------------/
        string ParQuantifierString - cтрока квантора
    /-----------------------------------------------------------------------*/
    % Квантор существования
    theQuantifierString( base::existenceString ).
    % Квантор общности
    theQuantifierString( base::generalityString ).
    /*======================================================================*/ 
    

    /*-----------------------------------------------------------------------/
        theNotQuantifierPunctuationSignLexeme
        Знаки пунктуации, не являющиеся кванторами
    /------------------------------------------------------------------------/
        scanner::lexeme ParNotQuantifierPunctuationSignLexeme - знак
            пунктуации, не являющийся квантором
    /-----------------------------------------------------------------------*/
    % Открывающая круглая скобка
    theNotQuantifierPunctuationSignLexeme( scanner::openningParentheses ).
    % Закрывающая круглая скобка
    theNotQuantifierPunctuationSignLexeme( scanner::closingParentheses ).
    % Отрицание
    theNotQuantifierPunctuationSignLexeme
        ( scanner::operationSign( base::negationString ) ).
    % Конъюнкция
    theNotQuantifierPunctuationSignLexeme
        ( scanner::operationSign( base::conjunctionString ) ).
    % Дизъюнкция
    theNotQuantifierPunctuationSignLexeme
        ( scanner::operationSign( base::disjunctionString ) ).
    % Импликация
    theNotQuantifierPunctuationSignLexeme
        ( scanner::operationSign( base::implicationString ) ).
    % Эквивалентность
    theNotQuantifierPunctuationSignLexeme
        ( scanner::operationSign( base::equivalenceString ) ).    
    /*======================================================================*/    
    
 
    /*-----------------------------------------------------------------------/
        theQuantifierKindAndString
        Вид и строка квантора
    /------------------------------------------------------------------------/
        quantifierKind ParQuantifierKind - вид квантора
        string ParQuantifierString - cтрока квантора
    /-----------------------------------------------------------------------*/
    % Квантор существования
    theQuantifierKindAndString( existence, base::existenceString ).
    % Квантор общности
    theQuantifierKindAndString( generality, base::generalityString ).
    /*======================================================================*/  
    
   
    /*======================================================================/
    
        Р А Б О Т А   С О   С К О Б К А М И
    
    /=======================================================================*/   
   

    /*-----------------------------------------------------------------------/
        getFirstOpenningParenthesesesNumber
        Получение количества идущих подряд открывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список оставшихся элементов
        core::integer32 ParStartFirstOpenningParenthesesesNumber - исходное
            количество идущих подряд открывающих скобок
        core::integer32 ParFirstOpenningParenthesesesNumber - итоговое
            количество идущих подряд открывающих скобок        
        determ (i,o,i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если в начале списка встречается очередная открывающая скобка,
        то увеличиваем счетчик идущих подряд открывающих скобок на единицу
            и продолжаем просмотр, пока не встретится нечто, не являющееся
            открывающей скобкой */
    getFirstOpenningParenthesesesNumber
    (
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        ParStartFirstOpenningParenthesesesNumber,
        ParFirstOpenningParenthesesesNumber
    ):-
        !,
        getFirstOpenningParenthesesesNumber
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParStartFirstOpenningParenthesesesNumber + 1,
            ParFirstOpenningParenthesesesNumber
        ).     
    /*
    Если в начале списка не открывающиеся, а иные элементы:
    оставшийся список и есть результат вместе с подсчитанным количеством
        идущих подряд открывающих скобок */
    getFirstOpenningParenthesesesNumber
    (
        ParRestElementsList,
        ParRestElementsList,
        ParFirstOpenningParenthesesesNumber,
        ParFirstOpenningParenthesesesNumber
    ).
    /*======================================================================*/
    
      
    /*-----------------------------------------------------------------------/
        getFirstOpenningParenthesesesNumber
        Получение количества идущих подряд открывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список оставшихся элементов
        core::integer32 ParFirstOpenningParenthesesesNumber - итоговое
            количество идущих подряд открывающих скобок        
        determ (i,o,o)
    /-----------------------------------------------------------------------*/    
    /*
    Получаем количество идущих подряд открывающих скобок,
    начиная счет с нуля */
    getFirstOpenningParenthesesesNumber
    (
        ParStartElementsList,
        ParRestElementsList,
        ParFirstOpenningParenthesesesNumber
    ):-    
        getFirstOpenningParenthesesesNumber
        (
            ParStartElementsList,
            ParRestElementsList,
            0,
            ParFirstOpenningParenthesesesNumber
        ).        
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getFirstClosingParenthesesesNumber
        Получение количества идущих подряд закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список оставшихся элементов
        core::integer32 ParStartFirstClosingParenthesesesNumber - исходное
            количество идущих подряд закрывающих скобок
        core::integer32 ParFirstClosingParenthesesesNumber - итоговое
            количество идущих подряд закрывающих скобок        
        determ (i,o,i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если в начале списка встречается очередная закрывающая скобка,
        то увеличиваем счетчик идущих подряд закрывающих скобок на единицу
            и продолжаем просмотр, пока не встретится нечто, не являющееся
            закрывающей скобкой */    
    getFirstClosingParenthesesesNumber
    (
        [
            positionedLexeme
            (
                scanner::closingParentheses,
                _
            )
            |                 
            ParStartElementsListTail
        ],
        ParRestElementsList,
        ParStartFirstClosingParenthesesesNumber,
        ParFirstClosingParenthesesesNumber
    ):-
        !,
        getFirstClosingParenthesesesNumber
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParStartFirstClosingParenthesesesNumber + 1,
            ParFirstClosingParenthesesesNumber
        ).
    /*
    Если в начале списка встречаются иные элементы,
    которые не являются закрывающими скобками,
        то увеличиваем счетчик идущих подряд закрывающих скобок на единицу
            и продолжаем просмотр */            
    getFirstClosingParenthesesesNumber
    (
        [
            ParElement
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        ParStartFirstClosingParenthesesesNumber,
        ParFirstClosingParenthesesesNumber
    ):-
        not
        ( 
            ParElement = 
                positionedLexeme
                (
                    scanner::openningParentheses,
                    _
                )
        ),
        !,
        getFirstClosingParenthesesesNumber
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParStartFirstClosingParenthesesesNumber,
            ParFirstClosingParenthesesesNumber
        ).        
    /*
    Если в начале списка встречается открывающая скобка
    или иной элемент, не являющийся закрывающим, то в результате:
    оставшийся список и есть результат вместе с подсчитанным количеством
        идущих подряд закрывающих скобок */    
    getFirstClosingParenthesesesNumber
    (
        ParRestElementsList,
        ParRestElementsList,
        ParFirstClosingParenthesesesNumber,
        ParFirstClosingParenthesesesNumber
    ).
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getFirstClosingParenthesesesNumber
        Получение количества идущих подряд закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список оставшихся элементов
        core::integer32 ParFirstClosingParenthesesesNumber - итоговое
            количество идущих подряд закрывающих скобок        
        determ (i,o,o)
    /-----------------------------------------------------------------------*/    
    /*
    Получаем количество идущих подряд закрывающих скобок,
    начиная счет с нуля */
    getFirstClosingParenthesesesNumber
    (
        ParStartElementsList,
        ParRestElementsList,
        ParFirstClosingParenthesesesNumber
    ):-    
        getFirstClosingParenthesesesNumber
        (
            ParStartElementsList,
            ParRestElementsList,
            0,
            ParFirstClosingParenthesesesNumber
        ).        
    /*======================================================================*/        
    
    
    /*-----------------------------------------------------------------------/
        outputErrorMessage
        Вывод сообщения об ошибке
    /------------------------------------------------------------------------/
        string ParErrorMessageString - строка сообщения об ошибке
        scanner::cursorPosition ParCursorPosition - позиция курсора
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
            scanner::cursorPositionTitle,
            ParCursorPosition + 1           
        ),
        file5x::nl.
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        outputErrorMessage
        Вывод сообщения об ошибке
    /------------------------------------------------------------------------/
        string ParErrorMessageString - строка сообщения об ошибке
        procedure (i)
    /-----------------------------------------------------------------------*/
    /*
    Вывод сообщения об ошибке
    в виде номера символа */
    outputErrorMessage( ParErrorMessageString ):-
        file5x::write
        (
            errorTitle,
            ParErrorMessageString
        ),
        file5x::nl.
    /*======================================================================*/         
    
    
    /*-----------------------------------------------------------------------/
        getParenthesesesBalance
        Получение баланса открывающих и закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список оставшихся элементов
        core::integer32 ParStartUnbalancedOpenningParenthesesesNumber -
            исходное количество несбалансированных открывающих скобок
        core::integer32 ParUnbalancedOpenningParenthesesesNumber - 
            итоговое количество несбалансированных открывающих скобок
        core::integer32 ParStartUnbalancedClosingParenthesesesNumber -
            исходное количество несбалансированных закрывающих скобок
        core::integer32 ParUnbalancedClosingParenthesesesNumber - 
            итоговое количество несбалансированных закрывающих скобок   
        determ (i,o,i,o,i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст,
        то рекурсия заканчивается,
        и количества несбалансированных открывающих и закрывающих скобок
            равны начальным */        
    getParenthesesesBalance
    (
        [],
        [],
        ParUnbalancedOpenningParenthesesesNumber,
        ParUnbalancedOpenningParenthesesesNumber,
        ParUnbalancedClosingParenthesesesNumber,
        ParUnbalancedClosingParenthesesesNumber
    ):- !.        
    /*
    Если в начале списка встречается очередная открывающая скобка,
        то увеличиваем счетчик элементов на единицу,
            как разность количеств несбалансированных
                открывающих скобок увеличивается,
            и уменьшаем количество несбалансированных
                закрывающих скобок уменьшается */     
    getParenthesesesBalance
    (
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        ParStartUnbalancedOpenningParenthesesesNumber,
        ParUnbalancedOpenningParenthesesesNumber,
        ParStartUnbalancedClosingParenthesesesNumber,
        ParUnbalancedClosingParenthesesesNumber
    ):-
        getParenthesesesBalance
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParStartUnbalancedOpenningParenthesesesNumber + 1,
            ParUnbalancedOpenningParenthesesesNumber,
            ParStartUnbalancedClosingParenthesesesNumber - 1,
            ParUnbalancedClosingParenthesesesNumber
        ),
        !.
    /*
    Если в начале списка встречается очередная закрывающая скобка,
    и если в настоящий момент текущее количество открывающих скобок больше
            закрывающих (то есть есть еще не закрытые открывающие скобки),
        то увеличиваем счетчик элементов на единицу,
            как разность количеств несбалансированных
                открывающих скобок уменьшается,
            и увеличиваем количество несбалансированных
                закрывающих скобок увеличивается */         
    getParenthesesesBalance
    (
        [
            positionedLexeme
            (
                scanner::closingParentheses,
                _
            )
            |                 
            ParStartElementsListTail
        ],
        ParRestElementsList,
        ParStartUnbalancedOpenningParenthesesesNumber,
        ParUnbalancedOpenningParenthesesesNumber,
        ParStartUnbalancedClosingParenthesesesNumber,
        ParUnbalancedClosingParenthesesesNumber
    ):-
        LocCurrentUnbalancedOpenningParenthesesesNumber =
            ParStartUnbalancedOpenningParenthesesesNumber - 1,
        LocCurrentUnbalancedClosingParenthesesesNumber =
            ParStartUnbalancedClosingParenthesesesNumber + 1,
        LocCurrentUnbalancedOpenningParenthesesesNumber >=
            LocCurrentUnbalancedClosingParenthesesesNumber,
        getParenthesesesBalance
        (
            ParStartElementsListTail,
            ParRestElementsList,
            LocCurrentUnbalancedOpenningParenthesesesNumber,
            ParUnbalancedOpenningParenthesesesNumber,
            LocCurrentUnbalancedClosingParenthesesesNumber,
            ParUnbalancedClosingParenthesesesNumber
        ),
        !.        
    /*
    Если в начале списка встречается очередная закрывающая скобка,
    и если в настоящий момент имеется больше закрывающих скобок, чем
            открывающих (то есть есть уже лишние закрывающие скобки),
        то ошибка - лишняя закрывающая скобка */         
    getParenthesesesBalance
    (
        [
            positionedLexeme
            (
                scanner::closingParentheses,
                ParCursorPosition
            )
            |                 
            _
        ],
        _,
        _,
        _,
        _,
        _
    ):-
        outputErrorMessage
        (
            unbalancedClosingParenthesesErrorMessage,
            ParCursorPosition
        ),
        !,
        fail.                
    /*
    Если в начале списка встречаются иные элементы,
    которые не являются открывающими или закрывающими скобками,
        то продолжаем рекурсивно обрабатывать хвост */                    
    getParenthesesesBalance
    (
        [
            _
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        ParStartUnbalancedOpenningParenthesesesNumber,
        ParUnbalancedOpenningParenthesesesNumber,
        ParStartUnbalancedClosingParenthesesesNumber,
        ParUnbalancedClosingParenthesesesNumber
    ):-
        getParenthesesesBalance
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParStartUnbalancedOpenningParenthesesesNumber,
            ParUnbalancedOpenningParenthesesesNumber,
            ParStartUnbalancedClosingParenthesesesNumber,
            ParUnbalancedClosingParenthesesesNumber
        ).
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getParenthesesesBalance
        Получение баланса открывающих и закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParElementsList - список элементов
        core::integer32 ParStartUnbalancedOpenningParenthesesesNumber -
            исходное количество несбалансированных открывающих скобок
        core::integer32 ParUnbalancedOpenningParenthesesesNumber - 
            итоговое количество несбалансированных открывающих скобок
        core::integer32 ParStartUnbalancedClosingParenthesesesNumber -
            исходное количество несбалансированных закрывающих скобок
        core::integer32 ParUnbalancedClosingParenthesesesNumber - 
            итоговое количество несбалансированных закрывающих скобок   
        determ (i,i,o,i,o)
    /-----------------------------------------------------------------------*/
    /*
    Получение числа несбалансированных открывающих и закрывающих скобок
    в исходном списке */
    getParenthesesesBalance
    (
        ParElementsList,
        ParStartUnbalancedOpenningParenthesesesNumber,
        ParUnbalancedOpenningParenthesesesNumber,
        ParStartUnbalancedClosingParenthesesesNumber,
        ParUnbalancedClosingParenthesesesNumber
    ):-
        getParenthesesesBalance
        (
            ParElementsList,
            _,
            ParStartUnbalancedOpenningParenthesesesNumber,
            ParUnbalancedOpenningParenthesesesNumber,
            ParStartUnbalancedClosingParenthesesesNumber,
            ParUnbalancedClosingParenthesesesNumber
        ).  
    /*======================================================================*/  
     
    
    /*-----------------------------------------------------------------------/
        getParenthesesesBalance
        Получение баланса открывающих и закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParElementsList - список элементов
        core::integer32 ParUnbalancedOpenningParenthesesesNumber - 
            итоговое количество несбалансированных открывающих скобок
        core::integer32 ParUnbalancedClosingParenthesesesNumber - 
            итоговое количество несбалансированных закрывающих скобок   
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Получение числа несбалансированных открывающих и закрывающих скобок
    в исходном списке при нулевых начальных значениях */
    getParenthesesesBalance
    (
        ParElementsList,
        ParUnbalancedOpenningParenthesesesNumber,
        ParUnbalancedClosingParenthesesesNumber
    ):-
        getParenthesesesBalance
        (
            ParElementsList,
            0,
            ParUnbalancedOpenningParenthesesesNumber,
            0,
            ParUnbalancedClosingParenthesesesNumber
        ).  
    /*======================================================================*/                
        

    /*-----------------------------------------------------------------------/
        parenthesesesAreBalanced
        Проверка сбалансированности открывающих и закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParElementsList - список элементов
        core::integer32 ParStartUnbalancedOpenningParenthesesesNumber -
            исходное количество несбалансированных открывающих скобок
        core::integer32 ParStartUnbalancedClosingParenthesesesNumber -
            исходное количество несбалансированных закрывающих скобок
        determ (i,i,i)
    /-----------------------------------------------------------------------*/
    /*
    Если количества несбалансированных открывающих и закрывающих скобок равны,
        то скобки сбалансированы */     
    parenthesesesAreBalanced
    (
        ParElementsList, 
        ParStartUnbalancedOpenningParenthesesesNumber,
        ParStartUnbalancedClosingParenthesesesNumber
    ):-
        getParenthesesesBalance
        (
            ParElementsList,
            ParStartUnbalancedOpenningParenthesesesNumber,
            LocUnbalancedOpenningParenthesesesNumber,
            ParStartUnbalancedClosingParenthesesesNumber,
            LocUnbalancedClosingParenthesesesNumber
        ),
        LocUnbalancedOpenningParenthesesesNumber = 0,
        LocUnbalancedClosingParenthesesesNumber = 0,
        !.        
    /*
    Если скобки не сбалансированы,
        то в качестве ошибки выдаем - есть открывающие скобки,
            на которые нет закрывающих */
    parenthesesesAreBalanced( _, _, _ ):-
        outputErrorMessage( unbalancedOpenningParenthesesesErrorMessage ),
        !,
        fail.        
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        parenthesesesAreBalanced
        Проверка сбалансированности открывающих и закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParElementsList - список элементов
        determ (i)
    /-----------------------------------------------------------------------*/
    /*
    Проверяем сбалансированность открывающих и закрывающих скобок,
    принимая начальные значения счетчиков равными нулю */     
    parenthesesesAreBalanced( ParElementsList ):-
        parenthesesesAreBalanced
        (
            ParElementsList,
            0,
            0
        ).     
    /*======================================================================*/    


    /*-----------------------------------------------------------------------/
        getElementsListAfterFirstClosingParentheseses
        Получение списка элементов после первой встречной закрывающей скобки
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsListAfterFirstClosingParentheseses -
            список элементов после первой встречной закрывающей скобки
        core::integer32 ParFirstOpenningParenthesesesNumber -
            количество идущих подряд открывающих скобок
        core::integer32 ParFirstClosingParenthesesesNumber -
            количество идущих подряд закрывающих скобок        
        determ (i,o,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список элементов сбалансирован,
        то подсчитываем количества идущих подряд открывающих и закрывающих скобок
        и возвращаем список элементов за ними */
    getElementsListAfterFirstClosingParentheseses
    (
        ParStartElementsList,
        ParElementsListAfterFirstClosingParentheseses,
        ParFirstOpenningParenthesesesNumber,
        ParFirstClosingParenthesesesNumber
    ):-
        parenthesesesAreBalanced( ParStartElementsList ),
        !,
        getFirstOpenningParenthesesesNumber
        (
            ParStartElementsList,
            LocElementsListAfterFirstOpenningParentheseses,
            ParFirstOpenningParenthesesesNumber
        ),
        getFirstClosingParenthesesesNumber
        (
            LocElementsListAfterFirstOpenningParentheseses,
            ParElementsListAfterFirstClosingParentheseses,
            ParFirstClosingParenthesesesNumber
        ).
    /*======================================================================*/     


    /*-----------------------------------------------------------------------/
        getElementsListWithoutExternalOpenningParentheseses
        Получение списка элементов без внешних открывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов без внешних
            открывающих скобок
        core::integer32 ParExternalOpenningParenthesesesPairsNumber -
            количество внешних открывающих скобок  
        determ (i,o,i)
    /-----------------------------------------------------------------------*/
    /*
    Если количество внешних открывающих скобок равно нулю,
        то возвращаем список без изменений */
    getElementsListWithoutExternalOpenningParentheseses
    (
        ParRestElementsList,
        ParRestElementsList,
        0
    ):- !.    
    /*
    Если количество внешних открывающих скобок положительно,
        то отбрасываем первый элемент,
        как разность искомого количества внешних открывающих скобок
            уменьшаем на единицу */    
    getElementsListWithoutExternalOpenningParentheseses
    (
        [
            _
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        ParExternalOpenningParenthesesesPairsNumber
    ):-
        !,
        getElementsListWithoutExternalOpenningParentheseses
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParExternalOpenningParenthesesesPairsNumber - 1
        ). 
    /*======================================================================*/
    

    /*-----------------------------------------------------------------------/
        concatenateElementsLists
        Конкатенация первого и второго списков в третий
    /------------------------------------------------------------------------/
        elementsList ParLeftElementsList - левый список элементов
        elementsList ParRightElementsList - правый список элементов
        elementsList ParConcatenatedElementsList - результирующий список
            элементов, получаемый конкатенацией левого и правого списков
        determ anyflow
    /-----------------------------------------------------------------------*/  
    /*
    Если левый список пуст,
        то конкатенированный список равен правому списку */
    concatenateElementsLists
    (
        [],
        ParConcatenatedElementsList,
        ParConcatenatedElementsList
    ):- !.
    /*
    Если левый список не пуст,
        то его первый элемент помещаем в начало результирующего списка
        и рекурсивно продолжаем с хвостом левого списка
        и неизменным правым */
    concatenateElementsLists
    (
        [
            ParElement
            |
            ParLeftElementsListTail
        ],
        ParRightElementsList,
        [
            ParElement
            |
            ParConcatenatedElementsListTail
        ]                
    ):-
        !,
        concatenateElementsLists
        (
            ParLeftElementsListTail,
            ParRightElementsList,
            ParConcatenatedElementsListTail
        ).
    /*======================================================================*/   

    
    /*-----------------------------------------------------------------------/
        getElementsListWithoutExternalClosingParentheseses
        Получение списка элементов без внешних закрывающих скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов без внешних
            закрывающих скобок
        core::integer32 ParExternalClosingParenthesesesPairsNumber -
            количество внешних закрывающих скобок  
        determ (i,o,i)
    /-----------------------------------------------------------------------*/
    /*
    Если количество внешних закрывающих скобок равно нулю,
        то возвращаем список без изменений */
    getElementsListWithoutExternalClosingParentheseses
    (
        ParRestElementsList,
        ParRestElementsList,
        0
    ):- !. 
    /*
    Если количество внешних закрывающих скобок положительно,
        то отбрасываем последний элемент, выделяя его путем отсечения хвоста,
        и рекурсивно вызываем, так как искомое количество внешних закрывающих скобок
            уменьшаем на единицу */        
    getElementsListWithoutExternalClosingParentheseses
    (
        ParStartElementsList,
        ParRestElementsList,
        ParExternalClosingParenthesesesPairsNumber
    ):-
        concatenateElementsLists
        (
            ParElementsListWithoutLastClosingParentheses,
            [ _ ],
            ParStartElementsList
        ),
        !,
        getElementsListWithoutExternalClosingParentheseses
        (
            ParElementsListWithoutLastClosingParentheses,
            ParRestElementsList,
            ParExternalClosingParenthesesesPairsNumber - 1
        ).
    /*======================================================================*/

    
    /*-----------------------------------------------------------------------/
        getElementsListWithoutExternalParentheseses
        Получение списка элементов без внешних скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов без внешних скобок
        core::integer32 ParExternalParenthesesesPairsNumber -
            количество внешних скобок
        determ (i,o,i)
    /-----------------------------------------------------------------------*/
    /*
    Из исходного списка удаляем внешние открывающие скобки,
    а затем закрывающие скобки */
    getElementsListWithoutExternalParentheseses
    (
        ParStartElementsList,
        ParRestElementsList,
        ParExternalParenthesesesPairsNumber
    ):-   
        getElementsListWithoutExternalOpenningParentheseses
        (
            ParStartElementsList,
            ParElementsListWithoutExternalOpenningParentheseses,
            ParExternalParenthesesesPairsNumber
        ),
        getElementsListWithoutExternalClosingParentheseses
        (
            ParElementsListWithoutExternalOpenningParentheseses,
            ParRestElementsList,
            ParExternalParenthesesesPairsNumber
        ).         
    /*======================================================================*/


    /*-----------------------------------------------------------------------/
        getElementsListWithoutExternalParentheseses
        Получение списка элементов без внешних скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsListAfterFirstClosingParentheseses -
            список элементов после первой встречной закрывающей скобки
        elementsList ParElementsListWithoutExternalParentheseses -
            результирующий список элементов без внешних скобок            
        core::integer32 ParFirstOpenningParenthesesesNumber -
            количество идущих подряд открывающих скобок
        core::integer32 ParFirstClosingParenthesesesNumber -
            количество идущих подряд закрывающих скобок               
        determ (i,i,o,i,i)
    /-----------------------------------------------------------------------*/
    /*
    Если список элементов после первой встречной закрывающей скобки пуст
            (то есть первая встречная закрывающая скобка является последней,
            закрывающей все внешние открывающие скобки -
                разность количеств идущих подряд открывающих и
                закрывающих скобок равна)
        то возвращаем список, получаемый удалением внешних скобок при
            указанных количествах открывающих (и закрывающих) скобок */        
    getElementsListWithoutExternalParentheseses
    (
        ParStartElementsList,
        [],
        ParElementsListWithoutExternalParentheseses,
        ParExternalParenthesesesPairsNumber,
        ParExternalParenthesesesPairsNumber
    ):-
        getElementsListWithoutExternalParentheseses
        (
            ParStartElementsList,
            ParElementsListWithoutExternalParentheseses,
            ParExternalParenthesesesPairsNumber
        ),
        !.
    /*
    Если список элементов после первой встречной закрывающей скобки не пуст,
        то вычисляем как разность количеств идущих подряд открывающих
            и закрывающих скобок
            (первая из них внешние открывающие скобки соответствуют
            внешней части выражения, удалив которую получим
            искомый результат)
        и получаем список элементов */               
    getElementsListWithoutExternalParentheseses
    (
        ParStartElementsList,
        _,
        ParElementsListWithoutExternalParentheseses,
        ParFirstOpenningParenthesesesNumber,
        ParFirstClosingParenthesesesNumber
    ):-
        LocExternalParenthesesesPairsNumber =
            ParFirstOpenningParenthesesesNumber -
            ParFirstClosingParenthesesesNumber,
        getElementsListWithoutExternalParentheseses
        (
            ParStartElementsList,
            ParElementsListWithoutExternalParentheseses,
            LocExternalParenthesesesPairsNumber
        ).  
    /*======================================================================*/        
        
  
    /*-----------------------------------------------------------------------/
        getElementsListWithoutExternalParentheseses
        Получение списка элементов без внешних скобок
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов без внешних скобок
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Подсчитываем количества идущих подряд открывающих и закрывающих скобок
    в списке элементов, начиная с его начала,
    затем из исходного списка элементов удаляем внешние скобки */ 
    getElementsListWithoutExternalParentheseses
    (
        ParStartElementsList,
        ParRestElementsList
    ):-        
        getElementsListAfterFirstClosingParentheseses
        (
            ParStartElementsList,
            LocElementsListAfterFirstClosingParentheseses,
            LocFirstOpenningParenthesesesNumber,
            LocFirstClosingParenthesesesNumber
        ),
        getElementsListWithoutExternalParentheseses
        (
            ParStartElementsList,
            LocElementsListAfterFirstClosingParentheseses,
            ParRestElementsList,
            LocFirstOpenningParenthesesesNumber,
            LocFirstClosingParenthesesesNumber
        ).
    /*======================================================================*/                
        
        
    /*-----------------------------------------------------------------------/
        getFirstParentheticallyElementsList
        Получение первого заключенного в скобки списка элементов
        и оставшегося списка элементов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список оставшихся элементов
        elementsList ParFirstParentheticallyElementsList -
            первый список элементов в скобках
        core::integer32 ParUnbalancedOpenningParenthesesesNumber -
            количество несбалансированных открывающих скобок
        determ (i,o,o,i)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст,
    и количество несбалансированных открывающих скобок равно нулю,
        то результирующий список пуст,
        и оставшийся список пуст */        
    getFirstParentheticallyElementsList
    (
        [],
        [],
        [],
        0
    ):- !.    
    /*
    Если исходный список элементов пуст,
    и количество несбалансированных открывающих скобок положительно,
        то ошибка - лишние открывающие скобки,
        и скобки не сбалансированы */        
    getFirstParentheticallyElementsList
    (
        [],
        _,
        _,
        _
    ):-
        outputErrorMessage( unbalancedOpenningParenthesesesErrorMessage ),
        !,        
        fail.    
    /*
    Если в начале списка встречается очередная открывающая скобка,
        то увеличиваем счетчик элементов на единицу,
            как разность количеств несбалансированных
                открывающих скобок увеличивается */     
    getFirstParentheticallyElementsList
    (
        [
            ParOpenningParentheses
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        [
            ParOpenningParentheses
            |
            ParFirstParentheticallyElementsListTail
        ],        
        ParUnbalancedOpenningParenthesesesNumber
    ):-
        ParOpenningParentheses = 
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            ),
        getFirstParentheticallyElementsList
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParFirstParentheticallyElementsListTail,
            ParUnbalancedOpenningParenthesesesNumber + 1
        ),
        !.
    /*
    Если в начале списка встречается очередная закрывающая скобка,
    и если в настоящий момент текущее количество открывающих скобок равно нулю
            (то есть есть еще не закрытые открывающие скобки,
            и они сбалансированы),
        то список элементов заканчивается */         
    getFirstParentheticallyElementsList
    (
        [
            ParClosingParentheses
            |                 
            ParRestElementsList
        ],
        ParRestElementsList,
        [ ParClosingParentheses ],        
        ParUnbalancedOpenningParenthesesesNumber
    ):-
        ParClosingParentheses = 
            positionedLexeme
            (
                scanner::closingParentheses,
                _
            ),    
        LocCurrentUnbalancedOpenningParenthesesesNumber =
            ParUnbalancedOpenningParenthesesesNumber - 1,
        LocCurrentUnbalancedOpenningParenthesesesNumber = 0,
        !.                
    /*
    Если в начале списка встречается очередная закрывающая скобка,
    и если в настоящий момент текущее количество открывающих скобок больше нуля
            (то есть есть еще не закрытые открывающие скобки),
        то увеличиваем счетчик элементов на единицу,
            как разность количеств несбалансированных
                открывающих скобок уменьшается */         
    getFirstParentheticallyElementsList
    (
        [
            ParClosingParentheses
            |                 
            ParStartElementsListTail
        ],
        ParRestElementsList,
        [
            ParClosingParentheses
            |                 
            ParFirstParentheticallyElementsListTail
        ],        
        ParUnbalancedOpenningParenthesesesNumber
    ):-
        ParClosingParentheses = 
            positionedLexeme
            (
                scanner::closingParentheses,
                _
            ),    
        LocCurrentUnbalancedOpenningParenthesesesNumber =
            ParUnbalancedOpenningParenthesesesNumber - 1,
        LocCurrentUnbalancedOpenningParenthesesesNumber > 0,
        getFirstParentheticallyElementsList
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParFirstParentheticallyElementsListTail,
            LocCurrentUnbalancedOpenningParenthesesesNumber
        ),
        !.        
    /*
    Если в начале списка встречается очередная закрывающая скобка,
    и если в настоящий момент текущее количество открывающих скобок меньше нуля
            (то есть уже есть лишние закрывающие скобки),
        то возвращаем пустой список в качестве первого вхождения
            и остаток списка */
    getFirstParentheticallyElementsList
    (
        [
            ParClosingParentheses
            |                 
            ParRestElementsListTail
        ],
        [
            ParClosingParentheses
            |                 
            ParRestElementsListTail
        ],
        [],
        _
    ):-
        ParClosingParentheses =
            positionedLexeme
            (
                scanner::closingParentheses,
                _
            ),    
        !.
    /*
    Если в начале списка встречаются иные элементы,
    которые не являются открывающими или закрывающими скобками,
        то продолжаем рекурсивно обрабатывать хвост,
        и очередной элемент добавляем в результирующий список */
    getFirstParentheticallyElementsList
    (
        [
            ParElement
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        [
            ParElement
            |                 
            ParFirstParentheticallyElementsListTail
        ],              
        ParUnbalancedOpenningParenthesesesNumber
    ):-
        getFirstParentheticallyElementsList
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParFirstParentheticallyElementsListTail,
            ParUnbalancedOpenningParenthesesesNumber
        ).
    /*======================================================================*/           
     
        
    /*-----------------------------------------------------------------------/
        getFirstParentheticallyElementsList
        Получение первого заключенного в скобки списка элементов
        и оставшегося списка элементов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список оставшихся элементов
        elementsList ParFirstParentheticallyElementsList -
            первый список элементов в скобках
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Получаем первый заключенный в скобки список элементов, принимая начальное
    количество несбалансированных открывающих скобок равным нулю */
    getFirstParentheticallyElementsList
    (
        ParStartElementsList,
        ParRestElementsList,
        ParFirstParentheticallyElementsList
    ):-
        getFirstParentheticallyElementsList
        (
            ParStartElementsList,
            ParRestElementsList,
            ParFirstParentheticallyElementsList,
            0
        ).    
    /*======================================================================*/


    /*======================================================================/
    
        П Е Р Е М Е Н Н Ы Е   И   С П И С К И   И З   Н И Х
    
    /=======================================================================*/


    /*-----------------------------------------------------------------------/
        isVariableElement        
        Проверка принадлежности к классу переменной
    /------------------------------------------------------------------------/        
        element ParVariableElement - элемент переменная
        variableDomain ParVariable - переменная
        determ (i,o)
    /-----------------------------------------------------------------------*/
    % Переменная
    isVariableElement
    (
        variable( ParVariableName ),        
        variable( ParVariableName )
    ):- !.
    % Из позиционированной лексемы
    isVariableElement
    (
        positionedLexeme
        (
            scanner::commonNoun( ParVariableName ),
            _
        ),        
        variable( ParVariableName )        
    ).
    /*======================================================================*/            
   
   
    /*-----------------------------------------------------------------------/
        getSingleVariable
        Получение единственной переменной, содержащейся в списке,
        как единого целого элемента
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        variableDomain ParVariable - единственная переменная,
            содержащаяся в исходном списке, взятая как единое целое
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    В исходном списке удаляем внешние скобки
    и если в оставшемся списке всего один элемент,
    который является подходящей переменной,
       то его и возвращаем в виде переменной */
    getSingleVariable
    (
        ParElementsList,
        ParVariable
    ):-
        getElementsListWithoutExternalParentheseses
        (
            ParElementsList,
            LocElementsListWithoutExternalParentheseses
        ),
        LocElementsListWithoutExternalParentheseses = [ LocElement ],
        isVariableElement
        (
            LocElement,        
            ParVariable
        ).
    /*======================================================================*/            


    /*-----------------------------------------------------------------------/
        getFirstVariable
        Получение первой переменной, встречающейся в списке
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов
            после первой переменной
        variableDomain ParFirstVariable - первая переменная списка
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если первый элемент - переменная-позиционированная лексема,
        то ее и возвращаем в качестве переменной,
        и оставшийся список - хвост после нее */
    getFirstVariable
    (
        [
            ParElement
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        ParFirstVariable
    ):-
        isVariableElement
        (
            ParElement,        
            ParFirstVariable
        ),
        !.
    /*
    Если первый элемент - открывающая скобка,
        то, возможно, в скобках находятся переменная, ее и ищем,
        и результирующий список получаем после данных скобок
        и следующего за ними списка элементов,
            затем из этих скобок получаем единственную переменную,
                по ее виду выбираем,
            затем возвращаем ее */        
    getFirstVariable
    (
        ParStartElementsList,
        ParRestElementsList,
        ParFirstVariable
    ):-
        ParStartElementsList =
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )    
            |
            _        
        ],
        getFirstParentheticallyElementsList
        (
            ParStartElementsList,
            ParRestElementsList,
            LocFirstParentheticallyElementsList
        ),
        getSingleVariable
        (
            LocFirstParentheticallyElementsList,
            ParFirstVariable
        ).    
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getVariablesAndCommasElementsList
        Получение списка переменных и запятых из исходного списка
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParVariablesAndCommasElementsList - список элементов
            из переменных и запятых
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если исходный список оканчивается пуст или пуст,
        то возвращаем пустой список */
    getVariablesAndCommasElementsList
    (
        [],
        []
    ):- !.
    /*
    Если в начале списка находится запятая
        то ее помещаем в результирующий список
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getVariablesAndCommasElementsList
    (
        [
            ParComma   
            |  
            ParElementsListTail
        ],
        [
            ParComma    
            |  
            ParVariablesAndCommasElementsListTail
        ]
    ):-
        ParComma =
            positionedLexeme
            (
                scanner::comma,
                _
            ),        
        getVariablesAndCommasElementsList
        (
            ParElementsListTail,
            ParVariablesAndCommasElementsListTail
        ),
        !.
    /*
    Применяем предикат получения первой переменной из исходного списка,
    и если получили переменную,
        то помещаем в результирующий список
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getVariablesAndCommasElementsList
    (
        ParStartElementsList,   
        [
            variable( ParFirstVariableName )
            |  
            ParVariablesAndCommasElementsListTail
        ]
    ):-
        getFirstVariable
        (
            ParStartElementsList,
            LocRestElementsList,
            LocFirstVariable
        ),
        LocFirstVariable = variable( ParFirstVariableName ),
        getVariablesAndCommasElementsList
        (
            LocRestElementsList,
            ParVariablesAndCommasElementsListTail
        ),
        !.
    /*
    Если в начале списка не переменная, не запятая, не открывающая скобка,
    и в начале списка находится лексема,
        то ошибка - недопустимая лексема */
    getVariablesAndCommasElementsList
    (
        [
            positionedLexeme
            (
                _,
                ParCursorPosition
            )    
            |  
            _
        ],
        _
    ):-
        outputErrorMessage
        (
            variablesListIllegalLexemeErrorMessage,
            ParCursorPosition
        ),
        !,
        fail. 
    /*
    Если в начале списка не переменная, не запятая, не открывающая скобка,
    и в начале списка выражение, а не лексема,
        то ошибка - недопустимое выражение */        
    getVariablesAndCommasElementsList( _, _ ):-
        outputErrorMessage( variablesListIllegalExpressionErrorMessage ),
        !,
        fail.
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        isCorrectVariablesAndCommasElementsList
        Проверка корректности списка, состоящего из переменных и запятых,
        которые чередуются в правильном порядке
    /------------------------------------------------------------------------/
        elementsList ParElementsList - список переменных и запятых
        determ (i)
    /-----------------------------------------------------------------------*/    
    /*
    Если список пуст,
        то считаем корректным */
    isCorrectVariablesAndCommasElementsList( [] ):- !.
    /*
    Если список содержит единственную переменную,
        то считаем корректным */    
    isCorrectVariablesAndCommasElementsList
    (
        [ variable( _ ) ]
    ):- !.
    /*
    Если список начинается с переменной и запятой,
        то за этой запятой следует хвост - остальной список,
            и рекурсивно проверяем корректность оставшейся части списка */
    isCorrectVariablesAndCommasElementsList
    (
        [
            variable( _ ),
            positionedLexeme
            (
                scanner::comma,
                _
            )
            |
            ParElementsListTail            
        ]
    ):-
        not
        (
            ParElementsListTail = []
        ),
        isCorrectVariablesAndCommasElementsList( ParElementsListTail ),
        !.
    /*
    Список не соответствует образцу, выводим сообщение об ошибке */
    isCorrectVariablesAndCommasElementsList( _ ):-
        outputErrorMessage( incorrectVariablesListErrorMessage ),
        !,
        fail.
    /*======================================================================*/ 
    
  
    /*-----------------------------------------------------------------------/
        getVariablesList
        Получение списка переменных из исходного списка элементов,
        состоящего из переменных и запятых
    /------------------------------------------------------------------------/
        elementsList ParVariablesAndCommasElementsList - исходный список
            из переменных и запятых
        variablesList ParVariablesList - список переменных
        determ (i,o)
    /-----------------------------------------------------------------------*/     
    /*
    Если исходный список оканчивается пуст или пуст,
        то возвращаем пустой список */      
    getVariablesList
    (
        [],
        []
    ):- !.
    /*
    Если в начале списка находится запятая
        то ее игнорируем и в результирующий список не помещаем
            и рекурсивно обрабатываем хвост исходного списка
                на оставшиеся элементы */           
    getVariablesList
    (
        [
            positionedLexeme
            (
                scanner::comma,
                _
            )    
            |  
            ParVariablesAndCommasElementsListTail
        ],
        ParVariablesList
    ):-
        getVariablesList
        (
            ParVariablesAndCommasElementsListTail,
            ParVariablesList
        ),
        !.
    /*
    Если в начале списка находится переменная
        то ее помещаем в результирующий список
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getVariablesList
    (
        [
            variable( ParVariableName )
            |  
            ParVariablesAndCommasElementsListTail
        ],
        [
            variable( ParVariableName )
            |  
            ParVariablesListTail
        ]   
    ):-
        getVariablesList
        (
            ParVariablesAndCommasElementsListTail,
            ParVariablesListTail
        ),
        !.
    /*
    Если в начале списка не переменная, не запятая, не открывающая скобка,
    и в начале списка находится лексема,
        то ошибка - недопустимая лексема */
    getVariablesList
    (
        [
            positionedLexeme
            (
                _,
                ParCursorPosition
            )    
            |  
            _
        ],
        _
    ):-
        outputErrorMessage
        (
            variablesListIllegalLexemeErrorMessage,
            ParCursorPosition
        ),
        !,
        fail. 
    /*
    Если в начале списка не переменная, не запятая, не открывающая скобка,
    и в начале списка выражение, а не лексема,
        то ошибка - недопустимое выражение */        
    getVariablesList( _, _ ):-
        outputErrorMessage( variablesListIllegalExpressionErrorMessage ),
        !,
        fail.        
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/
        variableIsInVariablesList
        Проверка вхождения переменной в список переменных
    /------------------------------------------------------------------------/
        variableDomain ParVariable - переменная
        variablesList ParVariablesList - список переменных
        determ (i,i)
    /-----------------------------------------------------------------------*/
    /*
    В случае пустого списка переменных,
        считаем что искомая переменная не содержится */
    variableIsInVariablesList( _, [] ):-
        !,
        fail.
    /*
    Если искомая переменная - в начале списка,
        то она содержится там */
    variableIsInVariablesList
    ( 
        ParVariable,
        [
            ParVariable
            |
            _
        ]
    ):- !.
    /*
    Если в начале списка переменная не лежит искомая,
        то ищем её в оставшейся части */
    variableIsInVariablesList
    ( 
        ParVariable,
        [
            _
            |
            ParVariablesListTail
        ]
    ):- 
        variableIsInVariablesList
        ( 
            ParVariable,
            ParVariablesListTail
        ).
    /*======================================================================*/             
    
  
    /*-----------------------------------------------------------------------/
        variableListIsInVariablesList
        Проверка вхождения списка переменных в другой список
    /------------------------------------------------------------------------/
        variablesList ParInternalVariablesList - внутренний список переменных
        variablesList ParExternalVariablesList - внешний список переменных
        determ (i,i)
    /-----------------------------------------------------------------------*/
    /*
    Пустой список входит всегда */
    variableListIsInVariablesList( [], _ ):- !.
    /*
    Проверяем переменную из внутреннего списка на вхождение,
    и если она там содержится,
        то рекурсивно проверяем оставшуюся часть списка */
    variableListIsInVariablesList
    ( 
        [
            ParVariable
            |
            ParInternalVariablesListTail
        ],
        ParExternalVariablesList
    ):- 
        variableIsInVariablesList
        ( 
            ParVariable,
            ParExternalVariablesList
        ),
        variableListIsInVariablesList
        ( 
           ParInternalVariablesListTail,
            ParExternalVariablesList
        ).
    /*======================================================================*/     
      
   
    /*-----------------------------------------------------------------------/
        getVariablesListWithoutReiterativeVariables
        Получение списка без повторяющихся переменных из исходного списка     
    /------------------------------------------------------------------------/
        variablesList ParStarVariablesList - исходный список переменных
        variablesList ParStarVariablesListWithoutReiterativeVariables -
            исходный список без повторяющихся переменных
        variablesList ParVariablesListWithoutReiterativeVariables -
            список без повторяющихся переменных
        determ (i,i,o)
    /-----------------------------------------------------------------------*/     
    /*
    Если исходный список оканчивается пуст или пуст,
        то возвращаем в качестве результата список без повторяющихся переменных
            накопленный */
    getVariablesListWithoutReiterativeVariables
    (
        [],
        ParVariablesListWithoutReiterativeVariables,
        ParVariablesListWithoutReiterativeVariables
    ):- !.
    /*
    Если очередная переменная не содержится в исходном списке
            накопленных переменных,
        то ее и добавляем
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getVariablesListWithoutReiterativeVariables
    (
        [
            ParVariable
            |  
            ParStarVariablesListTail
        ],
        ParStarVariablesListWithoutReiterativeVariables,
        ParVariablesListWithoutReiterativeVariables
    ):-
        not
        (
            variableIsInVariablesList
            (
                ParVariable,
                ParStarVariablesListWithoutReiterativeVariables
            )
        ),
        LocNextVariablesListWithoutReiterativeVariables =
        [
            ParVariable
            |  
            ParStarVariablesListWithoutReiterativeVariables            
        ],        
        getVariablesListWithoutReiterativeVariables
        (
            ParStarVariablesListTail,
            LocNextVariablesListWithoutReiterativeVariables,
            ParVariablesListWithoutReiterativeVariables
        ),
        !.   
    /*
    Если очередная переменная содержится в исходном списке
            накопленных переменных,
        то ее и не добавляем
        и продолжаем обрабатывать хвост исходного списка тем же образом */
    getVariablesListWithoutReiterativeVariables
    (
        [
            _
            |  
            ParStarVariablesListTail
        ],
        ParStarVariablesListWithoutReiterativeVariables,
        ParVariablesListWithoutReiterativeVariables
    ):-
        getVariablesListWithoutReiterativeVariables
        (
            ParStarVariablesListTail,
            ParStarVariablesListWithoutReiterativeVariables,
            ParVariablesListWithoutReiterativeVariables
        ).           
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        getVariablesListWithoutReiterativeVariables
        Получение списка без повторяющихся переменных из исходного списка        
    /------------------------------------------------------------------------/
        variablesList ParStarVariablesList - исходный список переменных
        variablesList ParVariablesListWithoutReiterativeVariables -
            список без повторяющихся переменных
        determ (i,o)
    /-----------------------------------------------------------------------*/     
    /*
    Получение списка без повторяющихся переменных из исходного списка,
    начиная с пустого списка */
    getVariablesListWithoutReiterativeVariables
    (
        ParStarVariablesList,
        ParVariablesListWithoutReiterativeVariables
    ):- 
        getVariablesListWithoutReiterativeVariables
        (
            ParStarVariablesList,
            [],
            ParVariablesListWithoutReiterativeVariables
        ).
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        addVariableToVariablesListWithoutRepetition
        Добавление переменной в список без повторения её
    /------------------------------------------------------------------------/
        variablesList ParStarVariablesList - исходный список переменных
        variablesList ParVariablesList - список с добавленной переменной
        variableDomain ParVariable - переменная
        procedure (i,o,i)
    /-----------------------------------------------------------------------*/     
    /*
    Если искомая переменная содержится в исходном списке,
        то возвращаем список без изменений,
            так как уже есть такая переменная */
    addVariableToVariablesListWithoutRepetition
    (
        ParStarVariablesList,
        ParStarVariablesList,
        ParVariable
    ):- 
        variableIsInVariablesList
        (
            ParVariable,
            ParStarVariablesList
        ),
        !.
    /*
    Искомая переменная не содержится в исходном списке,
        поэтому добавляем её в начало списка */
    addVariableToVariablesListWithoutRepetition
    (
        ParStarVariablesList,
        [
            ParVariable
            |
            ParStarVariablesList
        ],
        ParVariable
    ).        
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getFirstVariablesList
        Получение первого списка переменных из исходного списка элементов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список
        elementsList ParRestElementsList - оставшаяся часть исходного списка
        variablesList ParFirstVariablesList - первый список переменных
        determ (i,o,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если список не начинается с открывающей скобки,
        то, вероятно, за ним нет списка переменных,
        и, значит, список пуст,
        и возвращаем пустой список переменных */
    getFirstVariablesList
    (
        ParRestElementsList,
        ParRestElementsList,
        []
    ):-
        not
        (
            ParRestElementsList =
            [
                positionedLexeme
                (
                    scanner::openningParentheses,
                    _
                )    
                |
                _        
            ]
        ),
        !.  
    /*
    Если список начинается с открывающей скобки,
        то, возможно, в скобках имеется список переменных из аргументов,
        применяем предикат получения первого списка в скобках
        и удаляем внешние скобки из него,
            затем из полученного списка, состоящего из переменных и запятых,
                строим список переменных с повторяющимися именами,
            затем удаляем повторяющиеся вхождения переменных,
                и, наконец, возвращаем результирующий список переменных
                в результирующем списке */        
    getFirstVariablesList
    (
        ParStartElementsList,
        ParRestElementsList,
        ParFirstVariablesList
    ):-
        getFirstParentheticallyElementsList
        (
            ParStartElementsList,
            ParRestElementsList,
            LocFirstParentheticallyElementsList
        ),
        getElementsListWithoutExternalParentheseses
        (
            LocFirstParentheticallyElementsList,
            LocElementsListWithoutExternalParentheseses
        ),        
        getVariablesAndCommasElementsList        
        (
            LocElementsListWithoutExternalParentheseses,
            LocVariablesAndCommasElementsList
        ),                                       
        isCorrectVariablesAndCommasElementsList
            ( LocVariablesAndCommasElementsList ),
        getVariablesList
        (
            LocVariablesAndCommasElementsList,
            LocFirstVariablesListWithReiterativeVariables
        ),
        getVariablesListWithoutReiterativeVariables
        (
            LocFirstVariablesListWithReiterativeVariables,
            ParFirstVariablesList
        ).     
    /*======================================================================*/
    
    
    /*======================================================================/
    
        П Р Е Д И К А Т Ы
    
    /=======================================================================*/
        
    
    /*-----------------------------------------------------------------------/
        isPredicateElementsList        
        Проверка принадлежности списка к классу предиката
    /------------------------------------------------------------------------/        
        elementsList ParPredicateElementsList - список элементов предиката
        expression ParPredicate - предикат
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список состоит из результирующего элемента - предиката,
        то его и возвращаем */
    isPredicateElementsList
    (
        [ expressionElement( ParPredicate ) ],
        ParPredicate
    ):-
        ParPredicate = 
            predicate( _, _ ),
        !.
    /*
    Если это последовательность из имени собственного и следующих за ним,
        то применяем предикат получения первого списка переменных из списка,
            и если этот список переменных, в результате не пуст,
                то возвращаем предикат с заданным именем
                и полученным списком переменных */
    isPredicateElementsList
    (
        [
            positionedLexeme
            (
                scanner::properName( ParPredicateName ),
                _
            )
            |
            ParPredicateElementsListTail
        ],
        predicate
        (
            ParPredicateName,
            ParPredicateVariablesList
        )
    ):-
        getFirstVariablesList
        (
            ParPredicateElementsListTail,
            LocRestElementsList,
            ParPredicateVariablesList
        ),
        LocRestElementsList = [].
    /*======================================================================*/      
    

    /*-----------------------------------------------------------------------/
        getSinglePredicate
        Получение единственного предиката, содержащегося в списке,
        как единого целого элемента
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        expression ParPredicate - единственный предикат,
            содержащийся в исходном списке, взятый как единое целое
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    В исходном списке удаляем внешние скобки
    и если в оставшемся списке есть подходящий предикат,
       то возвращаем результат из его выделения */
    getSinglePredicate
    (
        ParElementsList,
        ParPredicate
    ):-
        getElementsListWithoutExternalParentheseses
        (
            ParElementsList,
            LocElementsListWithoutExternalParentheseses
        ),
        isPredicateElementsList
        (
            LocElementsListWithoutExternalParentheseses,        
            ParPredicate
        ).
    /*======================================================================*/           

   
    /*-----------------------------------------------------------------------/
        getFirstPredicate
        Получение первого предиката, встречающегося в списке
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов
            после первого предиката
        expression ParFirstPredicat - первый предикат списка
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если первый элемент - предикат-элемент,
        то его и возвращаем */ 
    getFirstPredicate
    (
        [ 
            expressionElement( ParPredicate )
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        ParPredicate
    ):-
        ParPredicate = predicate( _, _ ),    
        !.
    /*
    Если первый элемент - имя собственное,
        то, если за ним следует список переменных,
            возвращаем предикат с этим именем и этим списком */
    getFirstPredicate
    (
        [
            positionedLexeme
            (
                scanner::properName( ParPredicateName ),
                _
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        predicate
        (
            ParPredicateName,
            ParPredicateVariablesList
        )
    ):-     
        getFirstVariablesList
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParPredicateVariablesList
        ),
        !.
    /*
    Если первый элемент - открывающая скобка,
        то, возможно, в скобках находится предикат, его и ищем,
        и результирующий список получаем после данных скобок
        и следующего за ними списка элементов,
            затем из этих скобок получаем единственный предикат,
                по его виду выбираем,
            затем возвращаем его */        
    getFirstPredicate
    (
        ParStartElementsList,
        ParRestElementsList,
        ParFirstPredicat
    ):-
        ParStartElementsList =
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )    
            |
            _        
        ],
        getFirstParentheticallyElementsList
        (
            ParStartElementsList,
            ParRestElementsList,
            LocFirstParentheticallyElementsList
        ),
        getSinglePredicate
        (
            LocFirstParentheticallyElementsList,
            ParFirstPredicat
        ).        
    /*======================================================================*/
    
    
    /*======================================================================/
    
        К В А Н Т О Р Ы
    
    /=======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        isQuantifierAndVariableElementsList        
        Проверка принадлежности списка к классу квантора с переменной
    /------------------------------------------------------------------------/        
        elementsList ParQuantifierAndVariableElementsList - список элементов
            квантора с переменной
        element ParQuantifierAndVariable - элемент с переменной
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список состоит из результирующего элемента - квантора с переменной,
        то его и возвращаем */
    isQuantifierAndVariableElementsList
    (
        [ ParQuantifierAndVariable ],
        ParQuantifierAndVariable
    ):-
        ParQuantifierAndVariable = 
            quantifierAndVariable( _, _ ),
        !.
    /*
    Если список начинается со знака квантора существования,
        и за ним следует единственная переменная,
            то возвращаем квантор существования с полученной переменной */
    isQuantifierAndVariableElementsList
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::existenceString ),
                _
            )
            |
            ParQuantifierAndVariableElementsListTail
        ],
        quantifierAndVariable
        (
            existence,
            ParVariable
        )
    ):-
        getSingleVariable
        (
            ParQuantifierAndVariableElementsListTail,
            ParVariable
        ),
        !.
    /*
    Если список начинается со знака квантора общности,
        и за ним следует единственная переменная,
            то возвращаем квантор общности с полученной переменной */        
    isQuantifierAndVariableElementsList
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::generalityString ),
                _
            )
            |
            ParQuantifierAndVariableElementsListTail
        ],
        quantifierAndVariable
        (
            generality,
            ParVariable
        )
    ):-
        getSingleVariable
        (
            ParQuantifierAndVariableElementsListTail,
            ParVariable
        ),
        !.        
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        getSingleQuantifierAndVariable
        Получение единственного квантора с переменной, содержащегося в списке,
        как единого целого элемента
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        element ParQuantifierAndVariable - единственный квантор с переменной,
            содержащийся в исходном списке, взятый как целый элемент
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    В исходном списке удаляем внешние скобки
    и если в оставшемся списке есть подходящий квантор с переменной,
       то возвращаем результат из его выделения */
    getSingleQuantifierAndVariable
    (
        ParElementsList,
        ParQuantifierAndVariable
    ):-
        getElementsListWithoutExternalParentheseses
        (
            ParElementsList,
            LocElementsListWithoutExternalParentheseses
        ),
        isQuantifierAndVariableElementsList
        (
            LocElementsListWithoutExternalParentheseses,        
            ParQuantifierAndVariable
        ).
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/
        getFirstQuantifierAndVariable
        Получение первого квантора с переменной, встречающегося в списке
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов
            после первого квантора с переменной
        element ParFirstQuantifierAndVariable - первый квантор с переменной
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если первый элемент - квантор с переменной,
        то его и возвращаем */ 
    getFirstQuantifierAndVariable
    (
        [
            ParQuantifierAndVariable
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        ParQuantifierAndVariable
    ):-
        ParQuantifierAndVariable = quantifierAndVariable( _, _ ),
        !.
    /*
    Если первый элемент - знак квантора существования,
        то, если за ним следует переменная,
            возвращаем квантор существования и полученную переменную */
    getFirstQuantifierAndVariable
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::existenceString ),
                _
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        quantifierAndVariable
        (
            existence,
            ParVariable
        )
    ):-     
        getFirstVariable
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParVariable
        ),
        !.
    /*
    Если первый элемент - знак квантора общности,
        то, если за ним следует переменная,
            возвращаем квантор общности и полученную переменную */
    getFirstQuantifierAndVariable
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::generalityString ),
                _
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        quantifierAndVariable
        (
            generality,
            ParVariable
        )
    ):-     
        getFirstVariable
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParVariable
        ),
        !.
    /*
    Если первый элемент - открывающая скобка,
        то, возможно, в скобках находится квантор с переменной, его ищем,
        и результирующий список получаем после данных скобок
        и следующего за ними списка элементов,
            затем из этих скобок получаем единственный элемент - квантор с переменной,
                по его виду выбираем,
            затем возвращаем его */        
    getFirstQuantifierAndVariable
    (
        ParStartElementsList,
        ParRestElementsList,
        ParFirstQuantifierAndVariable
    ):-
        ParStartElementsList =
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )    
            |
            _        
        ],
        getFirstParentheticallyElementsList
        (
            ParStartElementsList,
            ParRestElementsList,
            LocFirstParentheticallyElementsList
        ),
        getSingleQuantifierAndVariable
        (
            LocFirstParentheticallyElementsList,
            ParFirstQuantifierAndVariable
        ).        
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getAllPredicatesAndQuantifiersAndVariables
        Получение всех предикатов, кванторов и переменных
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithPredicatesAndQuantifiersAndVariables -
            список элементов с выделенными предикатами,
            кванторами и переменными          
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getAllPredicatesAndQuantifiersAndVariables
    (
        [],
        []
    ):- !.    
    /*
    Если в начале списка лежит первый предикат,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllPredicatesAndQuantifiersAndVariables
    (
        ParElementsList,
        [
            expressionElement( ParPredicate )
            |
            ParElementsListWithPredicatesAndQuantifiersAndVariablesTail
        ]        
    ):-
        getFirstPredicate
        (
            ParElementsList,
            LocRestElementsList,
            ParPredicate
        ),
        getAllPredicatesAndQuantifiersAndVariables
        (
            LocRestElementsList,
            ParElementsListWithPredicatesAndQuantifiersAndVariablesTail
        ),
        !.     
    /*
    Если в начале списка лежит первый квантор с переменной,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllPredicatesAndQuantifiersAndVariables
    (
        ParElementsList,
        [
            ParFirstQuantifierAndVariable
            |
            ParElementsListWithPredicatesAndQuantifiersAndVariablesTail
        ]        
    ):-
        getFirstQuantifierAndVariable
        (
            ParElementsList,
            LocRestElementsList,
            ParFirstQuantifierAndVariable
        ),
        getAllPredicatesAndQuantifiersAndVariables
        (
            LocRestElementsList,
            ParElementsListWithPredicatesAndQuantifiersAndVariablesTail
        ),
        !.             
    /*
    Если в начале списка лежит запятая вне списка переменных,
        то ошибка - недопустимая запятая */
    getAllPredicatesAndQuantifiersAndVariables
    (
        [
            positionedLexeme
            (
                scanner::comma,
                ParCursorPosition
            )
            |
            _
        ],
        _
    ):-
        outputErrorMessage
        (
            illegalCommaOutOfVariablesListErrorMessage,
            ParCursorPosition
        ),
        !,
        fail.                      
    /*
    Если в начале списка лежит имя нарицательное - переменная
            вне списка переменных,
        то ошибка - недопустимая переменная */
    getAllPredicatesAndQuantifiersAndVariables
    (
        [
            positionedLexeme
            (
                scanner::commonNoun( ParVariableName ),
                ParCursorPosition
            )
            |
            _
        ],
        _
    ):-
        file5x::nl,
        file5x::write( ParVariableName ),           
        outputErrorMessage
        (
            illegalVariableOutOfVariablesListErrorMessage,
            ParCursorPosition
        ),
        !,
        fail.                      
    /*
    Если в начале списка лежит имя нарицательное - переменная
            вне списка переменных,
        то ошибка - недопустимая переменная */
    getAllPredicatesAndQuantifiersAndVariables
    (
        [
            variable( ParVariableName )
            |
            _
        ],
        _
    ):-
        file5x::nl,
        file5x::write( ParVariableName ),           
        outputErrorMessage( illegalVariableOutOfVariablesListErrorMessage ),
        !,
        fail.
    /*
    Если в начале списка лежит знак операции - квантор существования или общности,
    то его мы не выделяем как отдельный элемент,
    но если этот знак не сопровождается переменной
        то ошибка - недопустимый знак без переменной */
    getAllPredicatesAndQuantifiersAndVariables
    (
        [
            positionedLexeme
            (
                scanner::operationSign( ParSignString ),
                ParCursorPosition
            )
            |
            _
        ],
        _
    ):-
        theQuantifierString( ParSignString ),
        file5x::nl,
        file5x::write( ParSignString ),           
        outputErrorMessage
        (
            illegalQuantifierWithoutVariableErrorMessage,
            ParCursorPosition
        ),
        !,
        fail.
    /*
    Если в начале списка нет предиката, ни квантора с переменной,
    ни знака-лексемы, не являющегося знаком,
    и элемент (открывающая или закрывающая) или какой либо иной знак,
            знак операции,
        то помещаем его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllPredicatesAndQuantifiersAndVariables
    (
        [
            ParPositionedLexeme
            |
            ParElementsListTail
        ],        
        [
            ParPositionedLexeme
            |
            ParElementsListWithPredicatesAndQuantifiersAndVariablesTail
        ]        
    ):-
        ParPositionedLexeme =
            positionedLexeme
            (
                LocLexeme,
                _
            ),        
        theNotQuantifierPunctuationSignLexeme( LocLexeme ),
        getAllPredicatesAndQuantifiersAndVariables
        (
            ParElementsListTail,
            ParElementsListWithPredicatesAndQuantifiersAndVariablesTail
        ),
        !.                
    /*
    Если в исходном списке встретилась непредусмотренная лексема,
        то ошибка - недопустимая лексема */
    getAllPredicatesAndQuantifiersAndVariables
    (
        [
            positionedLexeme
            (
                _,
                ParCursorPosition
            )    
            |  
            _
        ],
        _
    ):-
        outputErrorMessage
        (
            elementsListIllegalLexemeErrorMessage,
            ParCursorPosition
        ),
        !,
        fail. 
    /*
    Если в исходном списке встретилось непредусмотренное выражение,
        то ошибка - недопустимое выражение */        
    getAllPredicatesAndQuantifiersAndVariables( _, _ ):-
        outputErrorMessage( elementsListIllegalExpressionErrorMessage ),
        !,
        fail.                        
    /*======================================================================*/

    
    /*-----------------------------------------------------------------------/
        isQuantifierElementsList        
        Проверка принадлежности списка к классу квантора
    /------------------------------------------------------------------------/        
        elementsList ParQuantifierElementsList - список элементов квантора
        element ParQuantifier - квантор
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список состоит из результирующего элемента - квантора,
        то его и возвращаем */
    isQuantifierElementsList
    (
        [ ParQuantifier ],
        ParQuantifier   
    ):-
        ParQuantifier = quantifier( _, _, _, _ ),
        !.
    /*
    Если список начинается с квантора с переменной,
        и за ним следует единственный предикат,
            то возвращаем квантор с этой переменной, списком переменных,
                состоящим из этой переменной и внутренним списком элементов,
                содержащим этот предикат */
    isQuantifierElementsList
    (
        [
            quantifierAndVariable
            (
                ParQuantifierKind,
                ParVariable
            )
            |
            ParQuantifierElementsListTail
        ],
        quantifier
        (
            ParQuantifierKind,
            ParVariable,
            [ ParVariable ],
            [ expressionElement( ParPredicate ) ]
        )
    ):-    
        getSinglePredicate
        (
            ParQuantifierElementsListTail,
            ParPredicate
        ),
        !.
    /*
    Если список начинается с квантора с переменной,
        и за ним следует еще один квантор,
            то возвращаем квантор с этой переменной, списком переменных,
                состоящим из этой переменной и внутренним списком элементов,
                содержащим этот квантор */
    isQuantifierElementsList
    (
        [
            quantifierAndVariable
            (
                ParExternalQuantifierKind,
                ParExternalVariable
            ),            
            ParInternalQuantifier
        ],
        quantifier
        (
            ParExternalQuantifierKind,
            ParExternalVariable,
            [ ParExternalVariable ],
            [ ParInternalQuantifier ]
        )
    ):- 
        ParInternalQuantifier = quantifier( _, _, _, _ ),        
        !.
    /*
    Если список начинается с квантора с переменной,
        и за ним следуют еще кванторы с переменными,
            то применяем рекурсивно выделение внутренних кванторов
                в квантор
            и возвращаем квантор с этой переменной, списком переменных,
                состоящим из этой переменной и внутренним списком элементов,
                содержащим полученный внутренний квантор */
    isQuantifierElementsList
    (
        [
            quantifierAndVariable
            (
                ParExternalQuantifierKind,
                ParExternalVariable
            )
            |
            ParQuantifierElementsListTail
        ],
        quantifier
        (
            ParExternalQuantifierKind,
            ParExternalVariable,
            [ ParExternalVariable ],
            [ ParInternalQuantifier ]
        )
    ):-    
        ParQuantifierElementsListTail =
        [
            quantifierAndVariable( _, _ )            
            |
            _
        ],
        isQuantifierElementsList
        (
            ParQuantifierElementsListTail,
            ParInternalQuantifier            
        ),
        !.
    /*
    Если список начинается с квантора с переменной,
        и за ним следует открывающая скобка,
            то в скобках содержится подформула из нескольких элементов,
            и возвращаемый список получаем путем выделения,
                то возвращаем квантор с этой переменной, списком переменных,
                    состоящим из этой переменной и полученным списком
                    элементов */
    isQuantifierElementsList
    (
        [
            quantifierAndVariable
            (
                ParQuantifierKind,
                ParVariable
            )
            |
            ParQuantifierElementsListTail
        ],
        quantifier
        (
            ParQuantifierKind,
            ParVariable,
            [ ParVariable ],
            ParElementsList
        )        
    ):-    
        ParQuantifierElementsListTail =
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )            
            |
            _
        ],
        getElementsListWithoutExternalParentheseses
        (
            ParQuantifierElementsListTail,
            ParElementsList
        ).
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/
        getSingleQuantifier
        Получение единственного квантора, содержащегося в списке,
        как единого целого элемента
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        element ParQuantifier - единственный квантор,
            содержащийся в исходном списке, взятый как единое целое
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    В исходном списке удаляем внешние скобки
    и если в оставшемся списке есть подходящий квантор,
       то возвращаем результат из его выделения */
    getSingleQuantifier
    (
        ParElementsList,
        ParQuantifier
    ):-
        getElementsListWithoutExternalParentheseses
        (
            ParElementsList,
            LocElementsListWithoutExternalParentheseses
        ),
        isQuantifierElementsList
        (
            LocElementsListWithoutExternalParentheseses,        
            ParQuantifier
        ).
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/
        getFirstQuantifier
        Получение первого квантора, встречающегося в списке
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов
            после первого квантора
        element ParFirstQuantifier - первый квантор списка
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если первый элемент - квантор,
        то его и возвращаем */ 
    getFirstQuantifier
    (
        [
            ParQuantifier          
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        ParQuantifier          
    ):-
        ParQuantifier = quantifier( _, _, _, _ ),
        !.
    /*
    Если первый элемент - квантор с переменной,
        и за ним следует предикат,
            то возвращаем квантор с этой переменной, списком переменных,
                состоящим из этой переменной и внутренним списком элементов,
                содержащим этот предикат */
    getFirstQuantifier
    (
        [
            quantifierAndVariable
            (
                ParQuantifierKind,
                ParVariable
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        quantifier
        (
            ParQuantifierKind,
            ParVariable,
            [ ParVariable ],
            [ expressionElement( ParPredicate ) ]
        )
    ):-    
        getFirstPredicate
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParPredicate
        ),
        !.    
    /*
    Если первый элемент - квантор с переменной,
        и за ним следует еще один квантор,
            то возвращаем квантор с этой переменной, списком переменных,
                состоящим из этой переменной и внутренним списком элементов,
                содержащим этот квантор */
    getFirstQuantifier
    (
        [
            quantifierAndVariable
            (
                ParExternalQuantifierKind,
                ParExternalVariable
            ),
            ParInternalQuantifier
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        quantifier
        (
            ParExternalQuantifierKind,
            ParExternalVariable,
            [ ParExternalVariable ],
            [ ParInternalQuantifier ]
        )
    ):- 
        ParInternalQuantifier = quantifier( _, _, _, _ ),
        !.
    /*
    Если первый элемент - квантор с переменной,
        и за ним следуют еще кванторы с переменными,
            то применяем рекурсивно выделение внутренних кванторов
                в квантор
            и возвращаем квантор с этой переменной, списком переменных,
                состоящим из этой переменной и внутренним списком элементов,
                содержащим полученный внутренний квантор */
    getFirstQuantifier
    (
        [
            quantifierAndVariable
            (
                ParExternalQuantifierKind,
                ParExternalVariable
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        quantifier
        (
            ParExternalQuantifierKind,
            ParExternalVariable,
            [ ParExternalVariable ],
            [ ParInternalQuantifier ]
        )
    ):-    
        ParStartElementsListTail =
        [
            quantifierAndVariable( _, _ )           
            |
            _
        ],
        getFirstQuantifier
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParInternalQuantifier            
        ),
        !.    
    /*
    Если первый элемент - квантор с переменной,
        и за ним следует открывающая скобка,
            то в скобках содержится подформула из нескольких элементов,
                после которой идет остаток списка элементов,
                и возвращаемый список получаем путем выделения,
                        то возвращаем квантор с этой переменной, списком
                            переменных, состоящим из этой переменной
                            и полученным списком элементов */
    getFirstQuantifier
    (
        [
            quantifierAndVariable
            (
                ParQuantifierKind,
                ParVariable
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        quantifier
        (
            ParQuantifierKind,
            ParVariable,
            [ ParVariable ],
            ParElementsList
        )        
    ):-    
        ParStartElementsListTail =
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )            
            |
            _
        ],
        getFirstParentheticallyElementsList
        (
            ParStartElementsListTail,
            ParRestElementsList,
            LocFirstParentheticallyElementsList
        ),        
        getElementsListWithoutExternalParentheseses
        (
            LocFirstParentheticallyElementsList,
            ParElementsList
        ).
    /*======================================================================*/              


    /*-----------------------------------------------------------------------/
        getAllQuantifiers
        Получение всех кванторов
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithQuantifiers -
            список элементов с выделенными кванторами
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getAllQuantifiers
    (
        [],
        []
    ):- !.        
    /*
    Если в начале списка лежит первый квантор,
        то его помещаем в результирующий список,
        и к его внутреннему списку применяем рекурсивно выделение
            внутренних кванторов,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllQuantifiers
    (
        ParElementsList,
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParQuantifierElementsList
            )
            |
            ParElementsListWithQuantifiersTail
        ]        
    ):-
        getFirstQuantifier
        (
            ParElementsList,
            LocRestElementsList,
            LocQuantifier
        ),
        LocQuantifier =
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                LocStartQuantifierElementsList
            ),
        getAllQuantifiers
        (
            LocStartQuantifierElementsList,
            ParQuantifierElementsList       
        ),
        getAllQuantifiers
        (
            LocRestElementsList,
            ParElementsListWithQuantifiersTail
        ),
        !.                            
    /*
    Если в начале списка лежит квантор с переменной, не входящий в квантор,
        то ошибка - недопустимое выражение под квантором,
        и результирующий список не меняется, оставляя его в том же виде
        и выводим его на экран */
    getAllQuantifiers
    (
        [
            quantifierAndVariable
            (
                ParQuantifierKind,
                variable( ParVariableName )
            )
            |
            _
        ],
        _
    ):- 
        string5x::concat
        (
            base::spaceString,
            ParVariableName,
            LocVariableString
        ),
        theQuantifierKindAndString
        (
            ParQuantifierKind,
            LocQuantifierString
        ),
        string5x::concat
        (
            LocQuantifierString,
            LocVariableString,
            LocQuantifierAndVariableString
        ),        
        file5x::nl,
        file5x::write( LocQuantifierAndVariableString ),           
        outputErrorMessage( illegalUngerQuantifierExpressionErrorMessage ),
        !,
        fail. 
    /*
    Если в начале списка лежит первый предикат,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllQuantifiers
    (
        ParElementsList,
        [
            expressionElement( ParPredicate )
            |
            ParElementsListWithQuantifiersTail
        ]        
    ):-
        getFirstPredicate
        (
            ParElementsList,
            LocRestElementsList,
            ParPredicate
        ),
        getAllQuantifiers
        (
            LocRestElementsList,
            ParElementsListWithQuantifiersTail
        ),
        !.                                      
    /*
    Если в начале списка нет кванторов,
    и элемент (открывающая или закрывающая) или какой либо иной знак,
            знак операции,
        то помещаем его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllQuantifiers
    (
        [
            ParPositionedLexeme
            |
            ParElementsListTail
        ],        
        [
            ParPositionedLexeme
            |
            ParElementsListWithQuantifiersTail
        ]        
    ):-
        ParPositionedLexeme = 
            positionedLexeme
            (
                LocLexeme,
                _
            ),           
        theNotQuantifierPunctuationSignLexeme( LocLexeme ),
        getAllQuantifiers
        (
            ParElementsListTail,
            ParElementsListWithQuantifiersTail
        ),
        !.                
    /*
    Если в исходном списке встретилась непредусмотренная лексема,
        то ошибка - недопустимая лексема */
    getAllQuantifiers
    (
        [
            positionedLexeme
            (
                _,
                ParCursorPosition
            )    
            |  
            _
        ],
        _
    ):-
        outputErrorMessage
        (
            elementsListIllegalLexemeErrorMessage,
            ParCursorPosition
        ),
        !,
        fail. 
    /*
    Если в исходном списке встретилось непредусмотренное выражение,
        то ошибка - недопустимое выражение */        
    getAllQuantifiers( _, _ ):-
        outputErrorMessage( elementsListIllegalExpressionErrorMessage ),
        !,
        fail.                        
    /*======================================================================*/

    
    /*-----------------------------------------------------------------------/
        getElementsListWithoutEmptyQuantifiers
        Получение списка элементов без пустых кванторов -
        удаление кванторов из пустых подвыражений
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithoutEmptyQuantifiers -
            список элементов без пустых кванторов
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getElementsListWithoutEmptyQuantifiers
    (
        [],
        []
    ):-!.
    /*
    Если в начале списка встречается квантор,
        и его внутренний список после удаления пустых кванторов
        и если его внутренние элементы пусты,
            то его не помещаем в результирующий список,
            и рекурсивно обрабатываем хвост исходного списка
                на оставшиеся элементы */
    getElementsListWithoutEmptyQuantifiers
    (
        [
            quantifier
            (
                _,
                _,
                _,
                ParQuantifierElementsList
            )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmptyQuantifiers
    ):-
        getElementsListWithoutEmptyQuantifiers
        (
            ParQuantifierElementsList,
            LocQuantifierElementsListWithoutEmptyQuantifiers
        ),
        LocQuantifierElementsListWithoutEmptyQuantifiers = [],
        getElementsListWithoutEmptyQuantifiers
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyQuantifiers
        ),
        !.        
    /*
    Если в начале списка встречается квантор,
        и его внутренний список после удаления пустых кванторов
                (после обработки внутренние элементы не пусты),
        и его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptyQuantifiers
    (
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParStartQuantifierElementsList
            )
            |
            ParElementsListTail
        ],
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParQuantifierElementsList
            )
            |
            ParElementsListWithoutEmptyQuantifiersTail
        ]        
    ):-
        getElementsListWithoutEmptyQuantifiers
        (
            ParStartQuantifierElementsList,
            ParQuantifierElementsList
        ),
        getElementsListWithoutEmptyQuantifiers
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyQuantifiersTail
        ),
        !.   
    /*
    Если в начале списка встречается элемент, не являющийся квантором,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptyQuantifiers
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithoutEmptyQuantifiersTail
        ]        
    ):-
        getElementsListWithoutEmptyQuantifiers
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyQuantifiersTail
        ).
    /*======================================================================*/           


    /*-----------------------------------------------------------------------/
        getQuantifiersVariablesLists
        Получение связанных переменных кванторов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        elementsList ParElementsListWithGotQuantifiersVariablesLists -
            список элементов с выделенными списками переменных кванторов
        variablesList ParDeclaredVariablesList - список переменных,
            объявленных во внешних кванторах
        determ (i,o,i)
    /-----------------------------------------------------------------------*/    
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getQuantifiersVariablesLists
    (
        [],
        [],
        _
    ):- !.
    /*
    Если в исходном списке встретился предикат,
        и если список его переменных входит
                в список объявленных переменных,
           то предикат помещаем в результирующий список
           и продолжаем рекурсивно обрабатывать хвост исходного списка */
    getQuantifiersVariablesLists
    (
        [
            ParPredicate
            |
            ParStartElementsListTail
        ],
        [
            ParPredicate
            |
            ParElementsListWithGotQuantifiersVariablesListsTail
        ],
        ParDeclaredVariablesList
    ):-
        ParPredicate =
            expressionElement
            (
                predicate
                (
                    _,
                    LocPredicateVariablesList
                )
            ),
        variableListIsInVariablesList
        (
            LocPredicateVariablesList,
            ParDeclaredVariablesList
        ),
        getQuantifiersVariablesLists
        (
            ParStartElementsListTail,
            ParElementsListWithGotQuantifiersVariablesListsTail,
            ParDeclaredVariablesList
        ),
        !.
    /*
    Если в исходном списке встретился предикат,
        и если список его переменных не входит
                в список объявленных переменных,
           то ошибка - необъявленная переменная */
    getQuantifiersVariablesLists
    (
        [
            expressionElement
            (
                predicate
                (
                    ParPredicateName,
                    _
                )
            )
            |
            _
        ],
        _,
        _
    ):-
        file5x::nl,
        file5x::write( ParPredicateName ),           
        outputErrorMessage( undeclaredPredicateVariablesErrorMessage ),
        !,
        fail.   
    /*
    Если в исходном списке встретился квантор,
        то его помещаем в результирующий список    
        и для его переменной добавляем в список объявленных переменных
            как в самом кванторе, так и во внешнем списке,
        и рекурсивно обрабатываем его внутренние элементы и хвост исходного
            списка, добавляя его переменную в список объявленных переменных,
            используя его как внутренний список переменных квантора,
            а потом для хвоста - внешний список */
    getQuantifiersVariablesLists
    (
        [
            quantifier
            (
                ParQuantifierKind,
                ParQuantifierVariableDomain,
                _,
                ParStartQuantifierElementsList
            )
            |
            ParStartElementsListTail
        ],
        [
            quantifier
            (
                ParQuantifierKind,
                ParQuantifierVariableDomain,
                ParQuantifierVariablesList,
                ParQuantifierElementsList
            )
            |
            ParElementsListWithGotQuantifiersVariablesListsTail
        ],
        ParDeclaredVariablesList
    ):-
        addVariableToVariablesListWithoutRepetition
        (
            ParDeclaredVariablesList,
            ParQuantifierVariablesList,
            ParQuantifierVariableDomain
        ),
        getQuantifiersVariablesLists
        (
            ParStartQuantifierElementsList,
            ParQuantifierElementsList,
            ParQuantifierVariablesList
        ),
        getQuantifiersVariablesLists
        (
            ParStartElementsListTail,
            ParElementsListWithGotQuantifiersVariablesListsTail,
            ParDeclaredVariablesList
        ),
        !.        
    /*
    Если в исходном списке встретился элемент не предикат,
        то его помещаем в результирующий список   
           и продолжаем рекурсивно обрабатывать хвост исходного списка */
    getQuantifiersVariablesLists
    (
        [
            ParElement
            |
            ParStartElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithGotQuantifiersVariablesListsTail
        ],
        ParDeclaredVariablesList
    ):-
        getQuantifiersVariablesLists
        (
            ParStartElementsListTail,
            ParElementsListWithGotQuantifiersVariablesListsTail,
            ParDeclaredVariablesList
        ).  
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getQuantifiersVariablesLists
        Получение связанных переменных кванторов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        elementsList ParElementsListWithGotQuantifiersVariablesLists -
            список элементов с выделенными списками переменных кванторов
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Получение связанных переменных кванторов
    при пустом внешнем списке объявленных переменных */
    getQuantifiersVariablesLists
    (
        ParStartElementsList,
        ParElementsListWithGotQuantifiersVariablesLists
    ):-
        getQuantifiersVariablesLists
        (
            ParStartElementsList,
            ParElementsListWithGotQuantifiersVariablesLists,
            []
        ).   
    /*======================================================================*/    
    
  
    /*-----------------------------------------------------------------------/
        getAllPredicatesAndQuantifiers
        Получение всех предикатов и кванторов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        elementsList ParElementsListWithPredicatesAndQuantifiers -
            список элементов с выделенными предикатами и кванторами
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Проверяем сбалансированность скобок в исходном списке,
    удаляем внешние скобки,
    получаем все предикаты, кванторы и переменные,
    получаем все кванторы,
    удаляем пустые кванторы,
    получаем связанные переменные кванторов */
    getAllPredicatesAndQuantifiers
    (
        ParStartElementsList,
        ParElementsListWithPredicatesAndQuantifiers
    ):-
        parenthesesesAreBalanced( ParStartElementsList ),
        getElementsListWithoutExternalParentheseses
        (
            ParStartElementsList,
            LocElementsListWithoutExternalParentheseses
        ),
        getAllPredicatesAndQuantifiersAndVariables
        (
            LocElementsListWithoutExternalParentheseses,
            LocElementsListWithPredicatesAndQuantifiersAndVariables
        ),
        getAllQuantifiers
        (
            LocElementsListWithPredicatesAndQuantifiersAndVariables,
            LocElementsListWithQuantifiers
        ),
        getElementsListWithoutEmptyQuantifiers
        (
            LocElementsListWithQuantifiers,
            LocElementsListWithoutEmptyQuantifiers
        ),
        getQuantifiersVariablesLists
        (
            LocElementsListWithoutEmptyQuantifiers,
            ParElementsListWithPredicatesAndQuantifiers
        ).
    /*======================================================================*/
    
    
    /*======================================================================/
    
        О Т Р И Ц А Н И Я
    
    /=======================================================================*/


    /*-----------------------------------------------------------------------/
        isNegationElementsList        
        Проверка принадлежности списка к классу отрицания
    /------------------------------------------------------------------------/        
        elementsList ParNegationElementsList - список элементов отрицания
        element ParNegation - отрицание
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список состоит из результирующего элемента - отрицания,
        то его и возвращаем */
    isNegationElementsList
    (
        [ ParNegation ],
        ParNegation   
    ):-
        ParNegation = negation( _ ),
        !.
    /*
    Если список начинается со знака отрицания,
        и за ним следует единственный предикат,
            то возвращаем отрицание с внутренним списком,
                содержащим этот предикат */
    isNegationElementsList
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParNegationElementsListTail
        ],
        negation
        (
            [ expressionElement( ParPredicate ) ]
        )
    ):-    
        getSinglePredicate
        (
            ParNegationElementsListTail,
            ParPredicate
        ),
        !.
    /*
    Если список начинается со знака отрицания,
        и за ним следует еще один квантор,
            то возвращаем отрицание c квантором в списке */
    isNegationElementsList
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParNegationElementsListTail
        ],
        negation( [ ParQuantifier ] )
    ):-    
        getSingleQuantifier
        (
            ParNegationElementsListTail,
            ParQuantifier
        ),
        !.            
    /*
    Если список начинается со знака отрицания,
        и за ним следует еще отрицание,
            то возвращаем отрицание c внутренним отрицанием в списке */
    isNegationElementsList
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            ),
            ParInternalNegation
        ],
        negation( [ ParInternalNegation ] )                
    ):- 
        ParInternalNegation = negation( _ ),        
        !.
    /*
    Если список начинается со знака отрицания,
        и за ним следуют еще несколько отрицаний,
            то применяем рекурсивно выделение внутренних отрицаний
                в отрицание
            и возвращаем отрицание с внутренним списком,
                содержащим полученное внутреннее отрицание */
    isNegationElementsList
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParNegationElementsListTail
        ], 
        negation( [ ParInternalNegation ] )                        
    ):-    
        ParNegationElementsListTail =
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )        
            |
            _
        ],
        isNegationElementsList
        (
            ParNegationElementsListTail,
            ParInternalNegation            
        ),
        !.
    /*
    Если список начинается со знака отрицания,
        и за ним следует открывающая скобка,
            то в скобках содержится подформула из нескольких элементов,
            и возвращаемый список получаем путем выделения,            
                то возвращаем отрицание с полученным списком элементов */
    isNegationElementsList
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParNegationElementsListTail
        ], 
        negation( ParElementsList )                  
    ):-    
        ParNegationElementsListTail =
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )            
            |
            _
        ],
        getElementsListWithoutExternalParentheseses
        (
            ParNegationElementsListTail,
            ParElementsList
        ).
    /*======================================================================*/                      


    /*-----------------------------------------------------------------------/
        getSingleNegation
        Получение единственного отрицания, содержащегося в списке,
        как единого целого элемента
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        element ParNegation - единственное отрицание,
            содержащееся в исходном списке, взятый как единое целое
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    В исходном списке удаляем внешние скобки
    и если в оставшемся списке есть подходящий отрицание,
       то возвращаем результат из его выделения */
    getSingleNegation
    (
        ParElementsList,
        ParNegation
    ):-
        getElementsListWithoutExternalParentheseses
        (
            ParElementsList,
            LocElementsListWithoutExternalParentheseses
        ),
        isNegationElementsList
        (
            LocElementsListWithoutExternalParentheseses,        
            ParNegation
        ).
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/
        getFirstNegation
        Получение первого отрицания, встречающегося в списке
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов
            после первого отрицания
        element ParFirstNegation - первое отрицание списка
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если первый элемент - отрицание,
        то его и возвращаем */ 
    getFirstNegation
    (
        [
            ParNegation          
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        ParNegation       
    ):-
        ParNegation = negation( _ ),
        !.
    /*
    Если первый элемент - знак отрицания,
        и за ним следует предикат,
            то возвращаем отрицание с внутренним списком,
                содержащим этот предикат */
    getFirstNegation
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParStartElementsListTail
        ],         
        ParRestElementsList,
        negation
        (
            [ expressionElement( ParPredicate ) ]
        )
    ):-    
        getFirstPredicate
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParPredicate
        ),
        !.    
    /*
    Если первый элемент - знак отрицания,
        и за ним следует еще квантор,
            то возвращаем отрицание с квантором в списке */
    getFirstNegation
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParStartElementsListTail
        ],         
        ParRestElementsList,
        negation( [ ParQuantifier ] )
    ):-    
        getFirstQuantifier
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParQuantifier
        ),
        !.    
    /*
    Если первый элемент - знак отрицания,
        и за ним следует еще отрицание,
            то возвращаем отрицание с внутренним отрицанием в списке */                        
    getFirstNegation
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            ),
            ParInternalNegation
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        negation( [ ParInternalNegation ] )
    ):- 
        ParInternalNegation = negation( _ ),
        !.
    /*
    Если первый элемент - знак отрицания,
        и за ним следуют еще несколько отрицаний,
            то применяем рекурсивно выделение внутренних отрицаний
                в отрицание
            и возвращаем отрицание с внутренним списком,
                содержащим полученное внутреннее отрицание */
    getFirstNegation
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        negation( [ ParInternalNegation ] )
    ):-    
        ParStartElementsListTail =
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )      
            |
            _
        ],
        getFirstNegation
        (
            ParStartElementsListTail,
            ParRestElementsList,
            ParInternalNegation            
        ),
        !.    
    /*
    Если первый элемент - знак отрицания,
        и за ним следует открывающая скобка,
            то в скобках содержится подформула из нескольких элементов,
                после которой идет остаток списка элементов,
                и возвращаемый список получаем путем выделения,
                        то возвращаем отрицание
                            с полученным списком элементов */
    getFirstNegation
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                _
            )
            |
            ParStartElementsListTail
        ],
        ParRestElementsList,
        negation( ParElementsList )
    ):-    
        ParStartElementsListTail =
        [
            positionedLexeme
            (
                scanner::openningParentheses,
                _
            )            
            |
            _
        ],
        getFirstParentheticallyElementsList
        (
            ParStartElementsListTail,
            ParRestElementsList,
            LocFirstParentheticallyElementsList
        ),        
        getElementsListWithoutExternalParentheseses
        (
            LocFirstParentheticallyElementsList,
            ParElementsList
        ).
    /*======================================================================*/              


    /*-----------------------------------------------------------------------/
        isBinaryOperationPunctuationSignLexeme
        Проверка принадлежности знака к знаку бинарной операции
    /------------------------------------------------------------------------/
        scanner::lexeme ParBinaryOperationPunctuationSignLexeme - знак
            знаку бинарной операции
        determ (i)
    /-----------------------------------------------------------------------*/
    /*
    Кроме знака отрицания, знаки эквивалентности, импликации, конъюнкции,
    дизъюнкции являются знаками бинарных операций */
    isBinaryOperationPunctuationSignLexeme
            ( ParBinaryOperationPunctuationSignLexeme ):-
        not
        (
            ParBinaryOperationPunctuationSignLexeme =
                 scanner::operationSign( base::negationString )
        ),
        theNotQuantifierPunctuationSignLexeme
            ( ParBinaryOperationPunctuationSignLexeme ),
        !.
    /*======================================================================*/    
    

    /*-----------------------------------------------------------------------/
        getAllNegations
        Получение всех отрицаний
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithNegations -
            список элементов с выделенными отрицаниями
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getAllNegations
    (
        [],
        []
    ):- !.   
    /*
    Если в начале списка лежит первое отрицание,
        то его помещаем в результирующий список,
        и к его внутреннему списку применяем рекурсивно выделение
            внутренних отрицаний,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllNegations
    (
        ParElementsList,
        [
            negation( ParNegationElementsList )
            |
            ParElementsListWithNegationsTail
        ]        
    ):-
        getFirstNegation
        (
            ParElementsList,
            LocRestElementsList,
            LocNegation
        ),
        LocNegation = negation( LocStartNegationElementsList ),
        getAllNegations
        (
            LocStartNegationElementsList,
            ParNegationElementsList       
        ),
        getAllNegations
        (
            LocRestElementsList,
            ParElementsListWithNegationsTail
        ),
        !.       
    /*
    Если в начале списка лежит знак отрицания, не входящий в отрицание,
        то ошибка - недопустимое выражение отрицания,
        и результирующий список не меняется */
    getAllNegations
    (
        [
            positionedLexeme
            (
                scanner::operationSign( base::negationString ),
                ParCursorPosition
            )
            |
            _
        ],
        _
    ):- 
        outputErrorMessage
        (
            illegalNegatedExpressionErrorMessage,
            ParCursorPosition
        ),
        !,
        fail.                
    /*
    Если в начале списка лежит первый квантор,
        то его помещаем в результирующий список,
        и к его внутреннему списку применяем рекурсивно выделение
            внутренних отрицаний,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllNegations
    (
        ParElementsList,
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParQuantifierElementsList
            )
            |
            ParElementsListWithNegationsTail
        ]        
    ):-
        getFirstQuantifier
        (
            ParElementsList,
            LocRestElementsList,
            LocQuantifier
        ),
        LocQuantifier =
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                LocStartQuantifierElementsList
            ),
        getAllNegations
        (
            LocStartQuantifierElementsList,
            ParQuantifierElementsList       
        ),
        getAllNegations
        (
            LocRestElementsList,
            ParElementsListWithNegationsTail
        ),
        !.     
    /*
    Если в начале списка лежит первый предикат,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllNegations
    (
        ParElementsList,
        [
            expressionElement( ParPredicate )
            |
            ParElementsListWithNegationsTail
        ]        
    ):-
        getFirstPredicate
        (
            ParElementsList,
            LocRestElementsList,
            ParPredicate
        ),
        getAllNegations
        (
            LocRestElementsList,
            ParElementsListWithNegationsTail
        ),
        !.                                                          
    /*
    Если в начале списка нет отрицаний, предикатов или кванторов,
    и элемент (открывающая или закрывающая) или какой либо иной знак операции,
        то помещаем его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllNegations
    (
        [
            ParPositionedLexeme
            |
            ParElementsListTail
        ],        
        [
            ParPositionedLexeme
            |
            ParElementsListWithNegationsTail
        ]        
    ):-
        ParPositionedLexeme = 
            positionedLexeme
            (
                LocLexeme,
                _
            ),           
        isBinaryOperationPunctuationSignLexeme( LocLexeme ),
        getAllNegations
        (
            ParElementsListTail,
            ParElementsListWithNegationsTail
        ),
        !.                
    /*
    Если в исходном списке встретилась непредусмотренная лексема,
        то ошибка - недопустимая лексема */
    getAllNegations
    (
        [
            positionedLexeme
            (
                _,
                ParCursorPosition
            )    
            |  
            _
        ],
        _
    ):-
        outputErrorMessage
        (
            elementsListIllegalLexemeErrorMessage,
            ParCursorPosition
        ),
        !,
        fail. 
    /*
    Если в исходном списке встретилось непредусмотренное выражение,
        то ошибка - недопустимое выражение */        
    getAllNegations( _, _ ):-
        outputErrorMessage( elementsListIllegalExpressionErrorMessage ),
        !,
        fail.                        
    /*======================================================================*/


    /*-----------------------------------------------------------------------/
        getElementsListWithoutEmptyNegations
        Получение списка элементов без пустых отрицаний -
        удаление отрицаний из пустых подвыражений
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithoutEmptyNegations -
            список элементов без пустых отрицаний
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getElementsListWithoutEmptyNegations
    (
        [],
        []
    ):-!.
    /*
    Если в начале списка встречается отрицание,
        и его внутренний список после удаления пустых отрицаний
        и если его внутренние элементы пусты,
            то его не помещаем в результирующий список,
            и рекурсивно обрабатываем хвост исходного списка
                на оставшиеся элементы */
    getElementsListWithoutEmptyNegations
    (
        [
            negation( ParNegationElementsList )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmptyNegations
    ):-
        getElementsListWithoutEmptyNegations
        (
            ParNegationElementsList,
            LocNegationElementsListWithoutEmptyNegations
        ),
        LocNegationElementsListWithoutEmptyNegations = [],
        getElementsListWithoutEmptyNegations
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyNegations
        ),
        !.
    /*
    Если в начале списка встречается отрицание,
        и его внутренний список после удаления пустых отрицаний
                (после обработки внутренние элементы не пусты),
        и его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptyNegations
    (
        [
            negation( ParStartNegationElementsList )
            |
            ParElementsListTail
        ],
        [
            negation( ParNegationElementsList )
            |
            ParElementsListWithoutEmptyNegationsTail
        ]        
    ):-
        getElementsListWithoutEmptyNegations
        (
            ParStartNegationElementsList,
            ParNegationElementsList
        ),
        getElementsListWithoutEmptyNegations
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyNegationsTail
        ),
        !.                    
    /*
    Если в начале списка встречается квантор,
        и его внутренний список после удаления пустых отрицаний
        и если его внутренние элементы пусты,
            то его не помещаем в результирующий список,
            и рекурсивно обрабатываем хвост исходного списка
                на оставшиеся элементы */
    getElementsListWithoutEmptyNegations
    (
        [
            quantifier
            (
                _,
                _,
                _,
                ParQuantifierElementsList
            )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmptyNegations
    ):-
        getElementsListWithoutEmptyNegations
        (
            ParQuantifierElementsList,
            LocQuantifierElementsListWithoutEmptyNegations
        ),
        LocQuantifierElementsListWithoutEmptyNegations = [],
        getElementsListWithoutEmptyQuantifiers
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyNegations
        ),
        !.        
    /*
    Если в начале списка встречается квантор,
        и его внутренний список после удаления пустых отрицаний
                (после обработки внутренние элементы не пусты),
        и его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptyNegations
    (
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParStartQuantifierElementsList
            )
            |
            ParElementsListTail
        ],
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParQuantifierElementsList
            )
            |
            ParElementsListWithoutEmptyNegationsTail
        ]        
    ):-
        getElementsListWithoutEmptyNegations
        (
            ParStartQuantifierElementsList,
            ParQuantifierElementsList
        ),
        getElementsListWithoutEmptyNegations
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyNegationsTail
        ),
        !.   
    /*
    Если в начале списка встречается элемент,
            не являющийся отрицанием или квантором,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptyNegations
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithoutEmptyNegationsTail
        ]        
    ):-
        getElementsListWithoutEmptyNegations
        (
            ParElementsListTail,
            ParElementsListWithoutEmptyNegationsTail
        ).
    /*======================================================================*/           


    /*======================================================================/
    
        В Л О Ж Е Н Н Ы Е   В Ы Р А Ж Е Н И Я
    
    /=======================================================================*/
    

    /*-----------------------------------------------------------------------/
        isSubElementsList        
        Проверка принадлежности списка к классу вложенного выражения
    /------------------------------------------------------------------------/        
        elementsList ParSubElementsList - список элементов
            вложенного выражения
        element ParSubElements - вложенное выражение
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список состоит из результирующего элемента - вложенного выражения,
        то его и возвращаем */
    isSubElementsList
    (
        [ ParSubElements ],
        ParSubElements   
    ):-
        ParSubElements = subElements( _ ),
        !.
    /*
    Если список начинается с открывающей скобки,
        то применяем предикат получения первого списка в скобках,
        и если этот список является всем остатком
                (оставшийся список после скобок пуст),
            то возвращаем полученный список
            и возвращаем соответствующее вложенное выражение */
    isSubElementsList
    (
        ParSubElementsList,
        subElements( ParSubElements )
    ):- 
        ParSubElementsList =
            [
                positionedLexeme
                (
                    scanner::openningParentheses,
                    _
                )
                |
                _
            ],    
        getFirstParentheticallyElementsList
        (
            ParSubElementsList,
            LocRestElementsList,
            LocFirstParentheticallyElementsList
        ),
        LocRestElementsList = [],
        getElementsListWithoutExternalParentheseses
        (
            LocFirstParentheticallyElementsList,
            ParSubElements
        ).        
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        getSingleSubElements
        Получение единственного вложенного выражения, содержащегося в списке,
        как единого целого элемента
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        element ParSubElements - единственное вложенное выражение,
            содержащееся в исходном списке, взятое как целый элемент
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    В исходном списке удаляем внешние скобки
    и если в оставшемся списке есть подходящее вложенное выражение
            (которое само по себе без внешних скобок),
       то возвращаем результат из его выделения */
    getSingleSubElements
    (
        ParElementsList,
        ParSubElements
    ):-
        getElementsListWithoutExternalParentheseses
        (
            ParElementsList,
            LocElementsListWithoutExternalParentheseses
        ),
        isSubElementsList
        (
            LocElementsListWithoutExternalParentheseses,        
            ParSubElements
        ),
        !.
    /*
    В исходном списке не удаляем внешние скобки
            (потому что именно в них и заключается вложенное выражение)
    и если в исходном списке есть подходящее вложенное выражение,
       то возвращаем результат из его выделения */
    getSingleSubElements
    (
        ParElementsList,
        ParSubElements
    ):-
        isSubElementsList
        (
            ParElementsList,        
            ParSubElements
        ).        
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/
        getFirstSubElements
        Получение первого вложенного выражения, встречающегося в списке
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParRestElementsList - список элементов
            после первого вложенного выражения
        element ParFirstSubElements - первое вложенное выражение
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    /*
    Если первый элемент - вложенное выражение,
        то его и возвращаем */ 
    getFirstSubElements
    (
        [
            ParSubElements         
            |
            ParRestElementsList
        ],
        ParRestElementsList,
        ParSubElements       
    ):-
        ParSubElements = subElements( _ ),
        !.
    /*
    Если первый элемент - открывающая скобка,
        то, если за ней следует вложенное выражение,
            то получаем его и оставшийся список */
    getFirstSubElements
    (
        ParStartElementsList,         
        ParRestElementsList,
        ParSubElements
    ):-    
        ParStartElementsList =
            [
                positionedLexeme
                (
                    scanner::openningParentheses,
                    _
                )
                |
                _
            ],       
        getFirstParentheticallyElementsList
        (
            ParStartElementsList,
            ParRestElementsList,
            LocFirstParentheticallyElementsList
        ),    
        getSingleSubElements
        (
            LocFirstParentheticallyElementsList,
            ParSubElements
        ).
    /*======================================================================*/              
    
    
    /*-----------------------------------------------------------------------/
        isBinaryOperationSignLexeme
        Проверка принадлежности знака к знаку бинарной операции
    /------------------------------------------------------------------------/
        scanner::lexeme ParBinaryOperationSignLexeme - знак
            знаку бинарной операции
        determ (i)
    /-----------------------------------------------------------------------*/
    /*
    Все знаки бинарных операций, кроме скобок, запятых
    являются знаками бинарных операций */
    isBinaryOperationSignLexeme( ParBinaryOperationSignLexeme ):-
        not
        (
            ParBinaryOperationSignLexeme = scanner::openningParentheses
        ),
        not
        (
            ParBinaryOperationSignLexeme = scanner::closingParentheses
        ),        
        isBinaryOperationPunctuationSignLexeme
            ( ParBinaryOperationSignLexeme ).
    /*======================================================================*/     
    
    
    /*-----------------------------------------------------------------------/
        getAllSubElements
        Получение всех вложенных выражений
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithSubElements -
            список элементов с выделенными вложенными выражениями
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getAllSubElements
    (
        [],
        []
    ):- !.
    /*
    Если в начале списка лежит первое отрицание,
        то его помещаем в результирующий список,
        и к его внутреннему списку применяем рекурсивно выделение
            внутренних вложенных выражений,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllSubElements
    (
        ParElementsList,
        [
            negation( ParNegationElementsList )
            |
            ParElementsListWithSubElementsTail
        ]        
    ):-
        getFirstNegation
        (
            ParElementsList,
            LocRestElementsList,
            LocNegation
        ),
        LocNegation = negation( LocStartNegationElementsList ),
        getAllSubElements
        (
            LocStartNegationElementsList,
            ParNegationElementsList       
        ),
        getAllSubElements
        (
            LocRestElementsList,
            ParElementsListWithSubElementsTail
        ),
        !.
    /*
    Если в начале списка лежит первый квантор,
        то его помещаем в результирующий список,
        и к его внутреннему списку применяем рекурсивно выделение
            внутренних вложенных выражений,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllSubElements
    (
        ParElementsList,
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParQuantifierElementsList
            )
            |
            ParElementsListWithSubElementsTail
        ]        
    ):-
        getFirstQuantifier
        (
            ParElementsList,
            LocRestElementsList,
            LocQuantifier
        ),
        LocQuantifier =
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                LocStartQuantifierElementsList
            ),
        getAllSubElements
        (
            LocStartQuantifierElementsList,
            ParQuantifierElementsList       
        ),
        getAllSubElements
        (
            LocRestElementsList,
            ParElementsListWithSubElementsTail
        ),
        !.  
    /*
    Если в начале списка лежит первый предикат,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllSubElements
    (
        ParElementsList,
        [
            expressionElement( ParPredicate )
            |
            ParElementsListWithSubElementsTail
        ]        
    ):-
        getFirstPredicate
        (
            ParElementsList,
            LocRestElementsList,
            ParPredicate
        ),
        getAllSubElements
        (
            LocRestElementsList,
            ParElementsListWithSubElementsTail
        ),
        !.                              
    /*
    Если в начале списка лежит первое вложенное выражение,
        то его помещаем в результирующий список,
        и к его внутреннему списку применяем рекурсивно выделение
            внутренних вложенных выражений,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllSubElements
    (
        ParElementsList,
        [
            subElements( ParSubElementsList )
            |
            ParElementsListWithSubElementsTail
        ]        
    ):-
        getFirstSubElements
        (
            ParElementsList,
            LocRestElementsList,
            LocSubElements
        ),
        LocSubElements = subElements( LocStartSubElementsList ),
        getAllSubElements
        (
            LocStartSubElementsList,
            ParSubElementsList       
        ),
        getAllSubElements
        (
            LocRestElementsList,
            ParElementsListWithSubElementsTail
        ),
        !.
    /*
    Если в начале списка нет отрицаний, кванторов, предикатов или выражений,
    и это знаки операций,
        то помещаем его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getAllSubElements
    (
        [
            ParPositionedLexeme
            |
            ParElementsListTail
        ],        
        [
            ParPositionedLexeme
            |
            ParElementsListWithSubElementsTail
        ]        
    ):-
        ParPositionedLexeme = 
            positionedLexeme
            (
                LocLexeme,
                _
            ),           
        isBinaryOperationSignLexeme( LocLexeme ),
        getAllSubElements
        (
            ParElementsListTail,
            ParElementsListWithSubElementsTail
        ),
        !.                
    /*
    Если в исходном списке встретилась непредусмотренная лексема,
        то ошибка - недопустимая лексема */
    getAllSubElements
    (
        [
            positionedLexeme
            (
                _,
                ParCursorPosition
            )    
            |  
            _
        ],
        _
    ):-
        outputErrorMessage
        (
            elementsListIllegalLexemeErrorMessage,
            ParCursorPosition
        ),
        !,
        fail. 
    /*
    Если в исходном списке встретилось непредусмотренное выражение,
        то ошибка - недопустимое выражение */        
    getAllSubElements( _, _ ):-
        outputErrorMessage( elementsListIllegalExpressionErrorMessage ),
        !,
        fail.                        
    /*======================================================================*/    


    /*-----------------------------------------------------------------------/
        getElementsListWithoutEmptySubElements
        Получение списка элементов без пустых вложенных выражений -
        удаление вложенных выражений из пустых подвыражений
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithoutEmptySubElements -
            список элементов без пустых вложенных выражений
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */
    getElementsListWithoutEmptySubElements
    (
        [],
        []
    ):-!.
    /*
    Если в начале списка встречается вложенное выражение,
        и его внутренний список после удаления пустых вложенных выражений
        и если его внутренние элементы пусты,
            то его не помещаем в результирующий список,
            и рекурсивно обрабатываем хвост исходного списка
                на оставшиеся элементы */
    getElementsListWithoutEmptySubElements
    (
        [
            subElements( ParSubElementsList )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmptySubElements
    ):-
        getElementsListWithoutEmptySubElements
        (
            ParSubElementsList,
            LocSubElementsListWithoutEmptySubElements
        ),
        LocSubElementsListWithoutEmptySubElements = [],
        getElementsListWithoutEmptySubElements
        (
            ParElementsListTail,
            ParElementsListWithoutEmptySubElements
        ),
        !.    
    /*
    Если в начале списка встречается вложенное выражение,
        и его внутренний список после удаления пустых вложенных выражений,
                (после обработки внутренние элементы не пусты),
        и его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptySubElements
    (
        [
            subElements( ParStartSubElementsList )
            |
            ParElementsListTail
        ],
        [
            subElements( ParSubElementsList )
            |
            ParElementsListWithoutEmptySubElementsTail
        ]        
    ):-
        getElementsListWithoutEmptySubElements
        (
            ParStartSubElementsList,
            ParSubElementsList
        ),
        getElementsListWithoutEmptySubElements
        (
            ParElementsListTail,
            ParElementsListWithoutEmptySubElementsTail
        ),
        !.                          
    /*
    Если в начале списка встречается отрицание,
        и его внутренний список после удаления пустых вложенных выражений
        и если его внутренние элементы пусты,
            то его не помещаем в результирующий список,
            и рекурсивно обрабатываем хвост исходного списка
                на оставшиеся элементы */
    getElementsListWithoutEmptySubElements
    (
        [
            negation( ParNegationElementsList )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmptySubElements
    ):-
        getElementsListWithoutEmptySubElements
        (
            ParNegationElementsList,
            LocNegationElementsListWithoutEmptySubElements
        ),
        LocNegationElementsListWithoutEmptySubElements = [],
        getElementsListWithoutEmptySubElements
        (
            ParElementsListTail,
            ParElementsListWithoutEmptySubElements
        ),
        !.
    /*
    Если в начале списка встречается отрицание,
        и его внутренний список после удаления пустых вложенных выражений
                (после обработки внутренние элементы не пусты),
        и его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptySubElements
    (
        [
            negation( ParStartNegationElementsList )
            |
            ParElementsListTail
        ],
        [
            negation( ParNegationElementsList )
            |
            ParElementsListWithoutEmptySubElementsTail
        ]        
    ):-
        getElementsListWithoutEmptySubElements
        (
            ParStartNegationElementsList,
            ParNegationElementsList
        ),
        getElementsListWithoutEmptySubElements
        (
            ParElementsListTail,
            ParElementsListWithoutEmptySubElementsTail
        ),
        !.                    
    /*
    Если в начале списка встречается квантор,
        и его внутренний список после удаления пустых вложенных выражений
        и если его внутренние элементы пусты,
            то его не помещаем в результирующий список,
            и рекурсивно обрабатываем хвост исходного списка
                на оставшиеся элементы */
    getElementsListWithoutEmptySubElements
    (
        [
            quantifier
            (
                _,
                _,
                _,
                ParQuantifierElementsList
            )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmptySubElements
    ):-
        getElementsListWithoutEmptySubElements
        (
            ParQuantifierElementsList,
            LocQuantifierElementsListWithoutEmptySubElements
        ),
        LocQuantifierElementsListWithoutEmptySubElements = [],
        getElementsListWithoutEmptyQuantifiers
        (
            ParElementsListTail,
            ParElementsListWithoutEmptySubElements
        ),
        !.        
    /*
    Если в начале списка встречается квантор,
        и его внутренний список после удаления пустых вложенных выражений
                (после обработки внутренние элементы не пусты),
        и его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptySubElements
    (
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParStartQuantifierElementsList
            )
            |
            ParElementsListTail
        ],
        [
            quantifier
            (
                ParQuantifierKind,
                ParVariableDomain,
                ParVariablesList,
                ParQuantifierElementsList
            )
            |
            ParElementsListWithoutEmptySubElementsTail
        ]        
    ):-
        getElementsListWithoutEmptySubElements
        (
            ParStartQuantifierElementsList,
            ParQuantifierElementsList
        ),
        getElementsListWithoutEmptySubElements
        (
            ParElementsListTail,
            ParElementsListWithoutEmptySubElementsTail
        ),
        !.   
    /*
    Если в начале списка встречается элемент,
            не являющийся отрицанием или квантором,
        то его помещаем в результирующий список,
        и рекурсивно обрабатываем хвост исходного списка
           с результатом в хвосте на оставшиеся элементы */
    getElementsListWithoutEmptySubElements
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithoutEmptySubElementsTail
        ]        
    ):-
        getElementsListWithoutEmptySubElements
        (
            ParElementsListTail,
            ParElementsListWithoutEmptySubElementsTail
        ).
    /*======================================================================*/           
    
    
    /*-----------------------------------------------------------------------/
        getElementsListExtractedFromSubElementsList        
        Извлечение внутреннего списка элементов из вложенного выражения
    /------------------------------------------------------------------------/        
        elementsList ParSubElementsList - список элементов
            вложенного выражения
        elementsList ParInternalElementsList - внутренний список элементов
        procedure (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список состоит из результирующего элемента - вложенного выражения,
        то возвращаем его внутренние элементы */
    getElementsListExtractedFromSubElementsList
    (
        [ subElements( ParInternalElementsList ) ],
        ParInternalElementsList   
    ):- !.
    /*
    Если список не состоит из результирующего элемента - вложенного выражения,
        то возвращаем список неизменным, считая что вложений в нем нет,
            и результирующий список получаем тот же */
    getElementsListExtractedFromSubElementsList
    (
        ParInternalElementsList,
        ParInternalElementsList
    ). 
    /*======================================================================*/    

    
    /*-----------------------------------------------------------------------/
        getElementsListWithElementsExtractedFromSubElementsLists    
        Получение списка элементов с элементами,
        извлеченными из вложенных выражений
    /------------------------------------------------------------------------/        
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsListWithoutSubElements - список элементов
            без вложенных выражений
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getElementsListWithElementsExtractedFromSubElementsLists
    (
        [],
        []
    ):- !.
    /*
    Перебираем,
        то возвращаем пустой список */
    getElementsListWithElementsExtractedFromSubElementsLists
    (
        [
            ParStartElement
            |
            ParStartElementsListTail
        ],
        [
            ParSingleElementExtractedFromSubElementsList
            |
            ParElementsListWithoutSubElementsTail
        ]
    ):-
        getElementsListExtractedFromSubElementsList
        (
            [ ParStartElement ],
            LocSingleElementListExtractedFromSubElementsList
        ),
        LocSingleElementListExtractedFromSubElementsList =
            [ ParSingleElementExtractedFromSubElementsList ],
        getElementsListWithElementsExtractedFromSubElementsLists
        (
            ParStartElementsListTail,
            ParElementsListWithoutSubElementsTail
        ).
    /*======================================================================*/   
    
    
    /*======================================================================/
    
        А Р Г У М Е Н Т Ы   О П Е Р А Ц И Й
    
    /=======================================================================*/
    

    /*-----------------------------------------------------------------------/
        isBinaryOperationArgumentElement
        Проверка принадлежности элемента к классу аргумента бинарной операции
    /------------------------------------------------------------------------/
        element ParBinaryOperationArgumentElement - элемент аргумента
            бинарной операции
        determ (i)
    /-----------------------------------------------------------------------*/
    % Предикат
    isBinaryOperationArgumentElement
    (
        expressionElement( predicate( _, _ ) )
    ):- !.
    % Отрицание
    isBinaryOperationArgumentElement( negation( _ ) ):- !.
    % Квантор
    isBinaryOperationArgumentElement( quantifier( _, _, _, _ ) ):- !.    
    % Вложенное выражение
    isBinaryOperationArgumentElement( subElements( _ ) ).        
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/
        getBinaryOperationArgumentInternalElementsList
        Получение внутреннего списка элементов аргумента бинарной операции
    /------------------------------------------------------------------------/
        element ParElement - элемент аргумента бинарной операции
        elementsList ParInternalElementsList -
            внутренний список элементов аргумента аргумента бинарной операции
        determ (i,o)
    /-----------------------------------------------------------------------*/
    % Предикат - не имеет внутренних элементов
    getBinaryOperationArgumentInternalElementsList
    (
        expressionElement( predicate( _, _ ) ),
        []
    ):- !.
    % Отрицание
    getBinaryOperationArgumentInternalElementsList
    (
        negation( ParInternalElementsList ),
        ParInternalElementsList        
    ):- !.
    % Квантор
    getBinaryOperationArgumentInternalElementsList
    (
        quantifier
        (
            _,
            _,
            _,
            ParInternalElementsList
        ),
        ParInternalElementsList
    ):- !.
    % Вложенное выражение
    getBinaryOperationArgumentInternalElementsList
    (
        subElements( ParInternalElementsList ),
        ParInternalElementsList
    ).
    /*======================================================================*/             
    
    
    /*-----------------------------------------------------------------------/
        resetBinaryOperationArgumentInternalElementsList
        Переустановка внутреннего списка элементов аргумента бинарной операции
    /------------------------------------------------------------------------/
        element ParStartElement - исходный аргумент бинарной операции
        element ParElement - аргумент бинарной операции        
        elementsList ParInternalElementsList -
            внутренний список элементов аргумента аргумента бинарной операции
        determ (i,o,i)
    /-----------------------------------------------------------------------*/
    % Предикат - не имеет внутренних элементов
    resetBinaryOperationArgumentInternalElementsList
    (
        ParElement,
        ParElement,
        _
    ):-
        ParElement =
            expressionElement( predicate( _, _ ) ),
        !.
    % Отрицание
    resetBinaryOperationArgumentInternalElementsList
    (
        negation( _ ),
        negation( ParInternalElementsList ),
        ParInternalElementsList        
    ):- !.
    % Квантор
    resetBinaryOperationArgumentInternalElementsList
    (
        quantifier
        (
            ParKind,
            ParVariableDomain,
            ParVariablesList,
            _
        ),       
        quantifier
        (
            ParKind,
            ParVariableDomain,
            ParVariablesList,
            ParInternalElementsList
        ),        
        ParInternalElementsList
    ):- !.
    % Вложенное выражение
    resetBinaryOperationArgumentInternalElementsList
    (
        subElements( _ ),
        subElements( ParInternalElementsList ),
        ParInternalElementsList
    ).
    /*======================================================================*/      
    
    
    /*-----------------------------------------------------------------------/
        isCorrectBinaryOperationsArgumentsAndSignsElementsList
        Проверка корректности чередования списка из аргументов
        и знаков бинарных операций, которые чередуются в правильном порядке
    /------------------------------------------------------------------------/
        elementsList ParElementsList - список аргументов и знаков
        determ (i)
    /-----------------------------------------------------------------------*/    
    /*
    Если список пуст,
        то считаем корректным */
    isCorrectBinaryOperationsArgumentsAndSignsElementsList( [] ):- !.
    /*
    Если список содержит единственный аргумент,
        то считаем его корректным аргументом,
             и если у него есть внутренние элементы,
                то рекурсивно проверяем его внутренние элементы */
    isCorrectBinaryOperationsArgumentsAndSignsElementsList
    (
        [ ParElement ]
    ):-
        isBinaryOperationArgumentElement( ParElement ),
        getBinaryOperationArgumentInternalElementsList
        (
            ParElement,
            LocInternalElementsList
        ),
        isCorrectBinaryOperationsArgumentsAndSignsElementsList
            ( LocInternalElementsList ),
        !.
    /*
    Если список начинается с аргумента и знака,
        то за этим знаком следует хвост - остальной список,
            и рекурсивно проверяем внутренние элементы аргумента,
                и если у него есть внутренние элементы,
                    то рекурсивно проверяем корректность
                        оставшейся части списка */
    isCorrectBinaryOperationsArgumentsAndSignsElementsList
    (
        [
            ParElement,
            positionedLexeme
            (
                ParLexeme,
                _
            )
            |
            ParElementsListTail            
        ]
    ):-
        isBinaryOperationArgumentElement( ParElement ),
        isBinaryOperationSignLexeme( ParLexeme ),
        not
        (
            ParElementsListTail = []
        ), 
        getBinaryOperationArgumentInternalElementsList
        (
            ParElement,
            LocInternalElementsList
        ),
        isCorrectBinaryOperationsArgumentsAndSignsElementsList
            ( LocInternalElementsList ),                   
        isCorrectBinaryOperationsArgumentsAndSignsElementsList
            ( ParElementsListTail ),
        !.
    /*
    Список не соответствует образцу, выводим сообщение об ошибке */
    isCorrectBinaryOperationsArgumentsAndSignsElementsList( _ ):-
        outputErrorMessage
            ( incorrectArgumentsAndOperationsSignsListErrorMessage ),
        !,
        fail.
    /*======================================================================*/     
    

    /*-----------------------------------------------------------------------/
        getAllBinaryOperationsArguments
        Получение всех аргументов бинарных операций
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithBinaryOperationsArguments -
            список элементов с выделенными аргументами бинарных операций
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Получаем все предикаты и кванторы,
    получаем все отрицания,
    удаляем пустые отрицания,
    получаем все вложенные выражения,
    удаляем пустые вложенные выражения,    
    проверяем корректность чередования аргументов и знаков операций */
    getAllBinaryOperationsArguments
    (
        ParElementsList,
        ParElementsListWithBinaryOperationsArguments
    ):-
        getAllPredicatesAndQuantifiers
        (
            ParElementsList,
            LocElementsListWithPredicatesAndQuantifiers
        ),
        getAllNegations
        (
            LocElementsListWithPredicatesAndQuantifiers,
            LocElementsListWithNegations
        ),
        getElementsListWithoutEmptyNegations
        (
            LocElementsListWithNegations,
            LocElementsListWithoutEmptyNegations
        ),
        getAllSubElements
        (
            LocElementsListWithoutEmptyNegations,
            LocElementsListWithSubElements
        ),
        getElementsListWithoutEmptySubElements
        (
            LocElementsListWithSubElements,
            ParElementsListWithBinaryOperationsArguments
        ),
        isCorrectBinaryOperationsArgumentsAndSignsElementsList
            ( ParElementsListWithBinaryOperationsArguments ).
    /*======================================================================*/   


    /*======================================================================/
    
        Д В У Х М Е С Т Н Ы Е   О П Е Р А Ц И И 
    
    /=======================================================================*/


    /*-----------------------------------------------------------------------/
        isTwoArgumentsOperation
        Проверка принадлежности списка к классу бинарной операции
        с левым и правым списками подвыражений
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        scanner::lexeme ParOperationSignLexeme - знак бинарной операции
        elementsList ParLeftArgumentElementsList - список элементов
            левого аргумента
        elementsList ParRightArgumentElementsList - список элементов
            правого аргумента
        determ (i,i,o,o)
    /-----------------------------------------------------------------------*/
    /* 
    Если исходный список пуст или пуст
    и это знак операции не важен
        то возвращаем пустые списки и выходим
            ничего не выделяя */
    isTwoArgumentsOperation
    (
        [],
        _,
        _,
        _
    ):-
        fail,
        !.
    /* 
    Если это последовательность из знака операции,
            который стоит в начале списка,
        то возвращаем пустой левый аргумент и в качестве правого аргумента
            оставшийся список */
    isTwoArgumentsOperation
    (
        [
            positionedLexeme
            (
                ParOperationSignLexeme,
                _
            )
            |
            ParRightArgumentElementsList
        ],
        ParOperationSignLexeme,
        [],
        ParRightArgumentElementsList
    ):- !.
    /* 
    Если это последовательность не начинается со знака операции,
        то помещаем первый элемент в левый
            список аргументов результирующего списка,
        и рекурсивно обрабатываем оставшийся список
            с тем же знаком операции */
    isTwoArgumentsOperation
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        ParOperationSignLexeme,
        [
            ParElement
            |
            ParLeftArgumentElementsListTail
        ],
        ParRightArgumentElementsList
    ):- 
        isTwoArgumentsOperation
        (
            ParElementsListTail,
            ParOperationSignLexeme,
            ParLeftArgumentElementsListTail,
            ParRightArgumentElementsList
        ).
    /*======================================================================*/  

    
    /*-----------------------------------------------------------------------/
        getEquivalencesInWidth
        Получение эквивалентностей в ширину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithEquivalences - список элементов
            содержащий эквивалентность
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если в исходном списке лежит знак операции эквивалентности, 
        то в результате получаем элемент типа эквивалентность,
        и в нем левые и правые аргументы рекурсивно преобразованные
            так, чтобы, возможно, содержать эквивалентность в глубину,
                которые представляют собой списки аргументов левый и правый */
    getEquivalencesInWidth
    (
        ParElementsList,
        [
            equivalence
            (
                ParLeftArgumentElementsList,
                ParRightArgumentElementsList
            )
        ]
    ):-
        isTwoArgumentsOperation
        (
            ParElementsList,            
            scanner::operationSign( base::equivalenceString ),
            LocStartLeftArgumentElementsList,
            LocStartRightArgumentElementsList
        ),
        getElementsListExtractedFromSubElementsList
        (
            LocStartLeftArgumentElementsList,
            LocLeftArgumentElementsListExtractedFromSubElementsList
        ),
        getEquivalencesInWidth
        (
            LocLeftArgumentElementsListExtractedFromSubElementsList,
            ParLeftArgumentElementsList
        ),
        getElementsListExtractedFromSubElementsList
        (
            LocStartRightArgumentElementsList,
            LocRightArgumentElementsListExtractedFromSubElementsList
        ),        
        getEquivalencesInWidth
        (
            LocRightArgumentElementsListExtractedFromSubElementsList,
            ParRightArgumentElementsList
        ),
        !.
    /*
    Если в исходном списке нет знака операции эквивалентности, 
        то применяем эквивалентность в глубину к аргументам */
    getEquivalencesInWidth
    (
        ParElementsList,
        ParElementsListWithEquivalences
    ):-
        getEquivalencesInDepth
        (
            ParElementsList,
            ParElementsListWithEquivalences
        ).
    /*======================================================================*/          
    

    /*-----------------------------------------------------------------------/
        getEquivalencesInDepth
        Получение эквивалентностей в глубину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithEquivalences - список элементов
            содержащий эквивалентность
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */    
    getEquivalencesInDepth
    (
        [],
        []
    ):- !.      
    /*
    Если в начале списка элемент, являющийся аргументом бинарной операции,
        то применяем к его внутреннему списку элементов,
        и полученный результат преобразований эквивалентности вставляем внутрь,
        затем помещаем в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getEquivalencesInDepth
    (
        [
            ParStartArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithEquivalencesTail
        ]
    ):-
        isBinaryOperationArgumentElement( ParStartArgumentElement ),
        getBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            LocStartArgumentInternalElementsList
        ),
        getEquivalencesInWidth
        (
            LocStartArgumentInternalElementsList,
            LocArgumentInternalElementsListWithEquivalences
        ),    
        resetBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            ParArgumentElement,
            LocArgumentInternalElementsListWithEquivalences
        ),
        getEquivalencesInDepth
        (
            ParElementsListTail,
            ParElementsListWithEquivalencesTail
        ),
        !.
    /*
    Если в начале списка элемент не являющийся аргументом бинарной операции,
        то просто переносим его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getEquivalencesInDepth
    (
        [
            ParArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithEquivalencesTail
        ]
    ):-
        getEquivalencesInDepth
        (
            ParElementsListTail,
            ParElementsListWithEquivalencesTail
        ).        
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        getImplicationsInWidth
        Получение импликаций в ширину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithImplications - список элементов
            содержащий импликацию
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если в исходном списке лежит знак операции импликации, 
        то в результате получаем элемент типа импликация,
        и в нем левые и правые аргументы рекурсивно преобразованные
            так, чтобы, возможно, содержать импликацию в глубину,
                которые представляют собой списки аргументов левый и правый */
    getImplicationsInWidth
    (
        ParElementsList,
        [
            implication
            (
                ParLeftArgumentElementsList,
                ParRightArgumentElementsList
            )
        ]
    ):-
        isTwoArgumentsOperation
        (
            ParElementsList,            
            scanner::operationSign( base::implicationString ),
            LocStartLeftArgumentElementsList,
            LocStartRightArgumentElementsList
        ),
        getElementsListExtractedFromSubElementsList
        (
            LocStartLeftArgumentElementsList,
            LocLeftArgumentElementsListExtractedFromSubElementsList
        ),
        getImplicationsInWidth
        (
            LocLeftArgumentElementsListExtractedFromSubElementsList,
            ParLeftArgumentElementsList
        ),
        getElementsListExtractedFromSubElementsList
        (
            LocStartRightArgumentElementsList,
            LocRightArgumentElementsListExtractedFromSubElementsList
        ),        
        getImplicationsInWidth
        (
            LocRightArgumentElementsListExtractedFromSubElementsList,
            ParRightArgumentElementsList
        ),
        !.
    /*
    Если в исходном списке нет знака операции импликации, 
        то применяем импликацию в глубину к аргументам */
    getImplicationsInWidth
    (
        ParElementsList,
        ParElementsListWithEquivalences
    ):-
        getImplicationsInDepth
        (
            ParElementsList,
            ParElementsListWithEquivalences
        ).
    /*======================================================================*/       


    /*-----------------------------------------------------------------------/
        getImplicationsInDepth
        Получение импликаций в глубину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithImplications - список элементов
            содержащий импликацию
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */    
    getImplicationsInDepth
    (
        [],
        []
    ):- !.      
    /*
    Если в начале списка элемент, являющийся аргументом бинарной операции,
        то применяем к его внутреннему списку элементов,
        и полученный результат преобразований импликации вставляем внутрь,
        затем помещаем в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getImplicationsInDepth
    (
        [
            ParStartArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithImplicationsTail
        ]
    ):-
        isBinaryOperationArgumentElement( ParStartArgumentElement ),
        getBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            LocStartArgumentInternalElementsList
        ),
        getImplicationsInWidth
        (
            LocStartArgumentInternalElementsList,
            LocArgumentInternalElementsListWithImplications
        ),       
        resetBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            ParArgumentElement,
            LocArgumentInternalElementsListWithImplications
        ),
        getImplicationsInDepth
        (
            ParElementsListTail,
            ParElementsListWithImplicationsTail
        ),
        !.
    /*
    Если в начале списка элемент, являющийся эквивалентностью,
        то применяем импликацию в ширину к его левому и правому аргументам,
        затем рекурсивно обрабатываем внутренние эквивалентности в глубину
            данного элемента списка
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getImplicationsInDepth
    (
        [
            equivalence
            (
                ParStartLeftArgumentElementsList,
                ParStartRightArgumentElementsList
            )    
            |
            ParElementsListTail
        ],
        [
            equivalence
            (
                ParLeftArgumentElementsList,
                ParRightArgumentElementsList
            )    
            |
            ParElementsListWithImplicationsTail
        ]
    ):-
        getImplicationsInWidth
        (
            ParStartLeftArgumentElementsList,
            ParLeftArgumentElementsList
        ),  
        getImplicationsInWidth
        (
            ParStartRightArgumentElementsList,
            ParRightArgumentElementsList
        ),          
        getImplicationsInDepth
        (
            ParElementsListTail,
            ParElementsListWithImplicationsTail
        ),
        !.
    /*
    Если в начале списка элемент не являющийся аргументом бинарной операции,
        то просто переносим его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getImplicationsInDepth
    (
        [
            ParArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithEquivalencesTail
        ]
    ):-
        getImplicationsInDepth
        (
            ParElementsListTail,
            ParElementsListWithEquivalencesTail
        ).       
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        getAllBinaryOperationsArgumentsAndTwoArgumentsOperation
        Получение всех аргументов бинарных операций
        и двухместных операций
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        elementsList ParElements - список элементов с выделенными
            аргументами бинарных операций и двухместными операциями
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Получаем все аргументы бинарных операций,
    получаем все эквивалентности,
    получаем все импликации */
    getAllBinaryOperationsArgumentsAndTwoArgumentsOperation
    (
        ParStartElementsList,
        ParElements
    ):-
        getAllBinaryOperationsArguments
        (
            ParStartElementsList,
            LocElementsListWithBinaryOperationsArguments
        ),
        getEquivalencesInWidth
        (
            LocElementsListWithBinaryOperationsArguments,
            LocElementsListWithEquivalences
        ),
        getImplicationsInWidth
        (
            LocElementsListWithEquivalences,
            ParElements
        ).        
    /*======================================================================*/   
    

    /*-----------------------------------------------------------------------/
        isTwoArgumentsOperationElement
        Проверка принадлежности элемента к классу двухместной операции
    /------------------------------------------------------------------------/
        element ParTwoArgumentsOperationElement - элемент
            двухместной операции
        determ (i)
    /-----------------------------------------------------------------------*/
    % Эквивалентность
    isTwoArgumentsOperationElement( equivalence( _, _ ) ):- !.
    % Импликация
    isTwoArgumentsOperationElement( implication( _, _ ) ).
    /*======================================================================*/   
    
   
    /*-----------------------------------------------------------------------/
        getTwoArgumentsOperationInternalElementsLists
        Получение внутренних списков элементов двухместной операции
    /------------------------------------------------------------------------/
        element ParElement - элемент двухместной операции
        elementsList ParInternalLeftElementsList - внутренний список
            элементов левого аргумента двухместной операции
        elementsList ParInternalRightElementsList - внутренний список
            элементов правого аргумента двухместной операции
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    % Эквивалентность
    getTwoArgumentsOperationInternalElementsLists
    (
        equivalence
        (
            ParInternalLeftElementsList,
            ParInternalRightElementsList
        ),
        ParInternalLeftElementsList,
        ParInternalRightElementsList        
    ):- !.
    % Импликация
    getTwoArgumentsOperationInternalElementsLists
    (
        implication
        (
            ParInternalLeftElementsList,
            ParInternalRightElementsList
        ),
        ParInternalLeftElementsList,
        ParInternalRightElementsList        
    ).
    /*======================================================================*/             
    
   
    /*-----------------------------------------------------------------------/
        resetTwoArgumentsOperationInternalElementsLists
        Переустановка внутренних списков элементов двухместной операции
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент двухместной операции
        element ParElement - элемент двухместной операции   
        elementsList ParInternalLeftElementsList - внутренний список
            элементов левого аргумента двухместной операции
        elementsList ParInternalRightElementsList - внутренний список
            элементов правого аргумента двухместной операции
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/
    % Эквивалентность
    resetTwoArgumentsOperationInternalElementsLists
    (
        equivalence( _, _ ),
        equivalence
        (
            ParInternalLeftElementsList,
            ParInternalRightElementsList
        ),
        ParInternalLeftElementsList,
        ParInternalRightElementsList      
    ):- !.
    % Импликация
    resetTwoArgumentsOperationInternalElementsLists
    (
        implication( _, _ ),
        implication
        (
            ParInternalLeftElementsList,
            ParInternalRightElementsList
        ),
        ParInternalLeftElementsList,
        ParInternalRightElementsList
    ).
    /*======================================================================*/   
   
   
    /*======================================================================/
    
        М Н О Г О М Е С Т Н Ы Е   О П Е Р А Ц И И
    
    /=======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        ConvertElementsListToElement
        Преобразование списка элементов в результирующий элемент
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        element ParElement - результирующий элемент
        procedure (i,o)
    /-----------------------------------------------------------------------*/
    /* 
    Если исходный список состоит из результирующего элемента,
        то его и возвращаем */
    ConvertElementsListToElement
    (
        [ ParElement ],
        ParElement
    ):- !.
    /* 
    Если исходный список состоит из нескольких элементов,
        то его преобразуем в элемент вложенного выражения */
    ConvertElementsListToElement
    (
        ParElementsList,
        subElements( ParElementsList )
    ).    
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        getMultiArgumentsOperationElementsList
        Получение списка элементов-аргументов из исходного списка
        путем расщепления по знаку операции
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        scanner::lexeme ParOperationSignLexeme - знак бинарной операции
        elementsList ParCurrentArgumentElementsList - список элементов
            текущего обрабатываемого аргумента        
        elementsList ParArgumentsElementsList - список элементов-аргументов
        determ (i,i,i,o)
    /-----------------------------------------------------------------------*/
    /* 
    Если исходный список пуст или пуст
            (очередной аргумент закончился),
        то из текущего списка аргументов делаем элемент,
            который помещается как единственный в список аргументов */
    getMultiArgumentsOperationElementsList
    (
        [],
        _,
        ParCurrentArgumentElementsList,
        [ ParArgumentElement ]
    ):-
        ConvertElementsListToElement
        (
            ParCurrentArgumentElementsList,
            ParArgumentElement
        ),
        !.
    /* 
    Если это последовательность из знака операции,
            который стоит в начале списка,
        то из текущего списка аргументов делаем элемент,
        и рекурсивно обрабатываем хвост исходного списка,
        и результирующий список аргументов получаем как этот элемент
            и результат обработки хвоста */
    getMultiArgumentsOperationElementsList
    (
        [
            positionedLexeme
            (
                ParOperationSignLexeme,
                _
            )
            |
            ParStartElementsListTail
        ],
        ParOperationSignLexeme,
        ParCurrentArgumentElementsList,
        [
            ParArgumentElement
            |
            ParArgumentsElementsListTail
        ]
    ):- 
        ConvertElementsListToElement
        (
            ParCurrentArgumentElementsList,
            ParArgumentElement
        ),
        getMultiArgumentsOperationElementsList
        (
            ParStartElementsListTail,
            ParOperationSignLexeme,
            [],
            ParArgumentsElementsListTail
        ),
        !.         
    /* 
    Если это последовательность не начинается со знака операции,
        то помещаем первый элемент в список
            текущего обрабатываемого аргумента,
        и рекурсивно обрабатываем оставшийся список
           с тем же знаком операции */
    getMultiArgumentsOperationElementsList
    (
        [
            ParElement
            |
            ParStartElementsListTail
        ],
        ParOperationSignLexeme,
        ParCurrentArgumentElementsList,
        ParArgumentsElementsList
    ):- 
        getMultiArgumentsOperationElementsList
        (
            ParStartElementsListTail,
            ParOperationSignLexeme,
            [
                ParElement
                |
                ParCurrentArgumentElementsList
            ],
            ParArgumentsElementsList
        ).
    /*======================================================================*/      
        
    
    /*-----------------------------------------------------------------------/
        isMultiArgumentsOperation
        Проверка принадлежности списка к классу многоместной операции
        и получение списка элементов-аргументов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        scanner::lexeme ParOperationSignLexeme - знак бинарной операции
        elementsList ParArgumentsElementsList - список элементов-аргументов
        determ (i,i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Получаем список аргументов-элементов путем расщепления списка по знаку,
        если полученный список содержит более одного элемента,
       то возвращаем положительный результат -
            данный список представляет собой многоместную операцию */
    isMultiArgumentsOperation
    (
        ParStartElementsList,
        ParOperationSignLexeme,
        ParArgumentsElementsList
    ):-
        getMultiArgumentsOperationElementsList
        (
            ParStartElementsList,
            ParOperationSignLexeme,
            [],
            ParArgumentsElementsList
        ),
        not
        (
            ParArgumentsElementsList = [ _ ]
        ),
        !.
    /*
    При отрицательном результате или если аргументов меньше двух,
            соответствующий список элементов не является,
        поэтому возвращаем отрицание на проверку принадлежности */
    isMultiArgumentsOperation( _, _, _ ):-
        !,
        fail.
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions     
        Получение списка элементов дизъюнкции без вложенных дизъюнкций   
    /------------------------------------------------------------------------/        
        elementsList ParElementsList - исходный список элементов дизъюнкции 
        elementsList ParElementsListWithoutEmbeddedDisjunctions -
            список элементов-аргументов дизъюнкции без вложенных дизъюнкций
        procedure (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст,
       то возвращаем пустой список */
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions
    (
        [],
        []
    ):- !.
    /*
    Если в списке встречается вложенное выражение
            с единственным вхождением дизъюнкции,
        то обрабатываем внутренние элементы дизъюнкции на наличие дизъюнкций,
           и в результате получаем результат */
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions
    (
        [
            subElements
            (
                [ disjunction( ParInternalDisjunctionElementsList ) ]
            )            
        ],
        ParElementsListWithoutEmbeddedDisjunctions
    ):-
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            ParInternalDisjunctionElementsList,
            ParElementsListWithoutEmbeddedDisjunctions
        ),
        !.    
    /*
    Если в списке встречается внутренняя дизъюнкция,
        то обрабатываем внутренние элементы дизъюнкции на наличие дизъюнкций,
           и в результате получаем результат */
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions
    (
        [ disjunction( ParInternalDisjunctionElementsList ) ],
        ParElementsListWithoutEmbeddedDisjunctions
    ):-
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            ParInternalDisjunctionElementsList,
            ParElementsListWithoutEmbeddedDisjunctions
        ),
        !.
    /*
    Если в начале списка встречается единственный элемент,
            не являющийся дизъюнкцией,
        то его помещаем в начало списка */
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions
    (
        [ ParElement ],
        [ ParElement ]
    ):- !.
    /*
    Если в начале списка встречается вложенное выражение
            с единственным вхождением дизъюнкции,
        то обрабатываем внутренние элементы дизъюнкции на наличие дизъюнкций
        и их рекурсивно помещаем в начало
        и далее хвост обрабатывается так же, как и исходный список элементов,
            с соответствующим рекурсивным вызовом */
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions
    (
        [
            subElements
            (
                [ disjunction( ParInternalDisjunctionElementsList ) ]
            )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmbeddedDisjunctions
    ):-
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            ParInternalDisjunctionElementsList,
            LocInternalDisjunctionElementsListWithoutEmbeddedDisjunctions
        ),    
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            ParElementsListTail,
            LocElementsListWithoutEmbeddedDisjunctionsTail
        ),
        concatenateElementsLists
        (
            LocInternalDisjunctionElementsListWithoutEmbeddedDisjunctions,
            LocElementsListWithoutEmbeddedDisjunctionsTail,
            ParElementsListWithoutEmbeddedDisjunctions
        ),
        !.
    /*
    Если в начале списка встречается внутренняя дизъюнкция,
        то обрабатываем внутренние элементы дизъюнкции на наличие дизъюнкций
        и их рекурсивно помещаем в начало
        и далее хвост обрабатывается так же, как и исходный список элементов,
            с соответствующим рекурсивным вызовом */
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions
    (
        [
            disjunction( ParInternalDisjunctionElementsList )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmbeddedDisjunctions
    ):-
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            ParInternalDisjunctionElementsList,
            LocInternalDisjunctionElementsListWithoutEmbeddedDisjunctions
        ),    
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            ParElementsListTail,
            LocElementsListWithoutEmbeddedDisjunctionsTail
        ),
        concatenateElementsLists
        (
            LocInternalDisjunctionElementsListWithoutEmbeddedDisjunctions,
            LocElementsListWithoutEmbeddedDisjunctionsTail,
            ParElementsListWithoutEmbeddedDisjunctions
        ),
        !.    
    /*
    Если в начале списка встречается элемент, не являющийся дизъюнкцией,
        то его помещаем в начало результирующего списка
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getDisjunctionArgumentsWithoutEmbeddedDisjunctions
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithoutEmbeddedDisjunctionsTail
        ]        
    ):-
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            ParElementsListTail,
            ParElementsListWithoutEmbeddedDisjunctionsTail
        ).      
    /*======================================================================*/    
       
    
    /*-----------------------------------------------------------------------/
        getDisjunctionsInWidth
        Получение дизъюнкций в ширину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithDisjunctions - список элементов
            c выделенными дизъюнкциями
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если в исходном списке лежит знак операции дизъюнкции, 
        то в первом шаге и в результате получаем элемент дизъюнкции,
            затем из аргументов выделяем дизъюнкции в ширину
            и удаляем вложенные дизъюнкции */
    getDisjunctionsInWidth
    (
        ParElementsList,
        [ disjunction( ParArgumentsElementsList ) ]
    ):-
        isMultiArgumentsOperation
        (
            ParElementsList,            
            scanner::operationSign( base::disjunctionString ),
            LocStartArgumentsElementsList
        ),
        getArgumentsWithGotDisjunctionsInWidth
        (
            LocStartArgumentsElementsList,
            LocArgumentsElementsListWithDisjunctions
        ),
        getDisjunctionArgumentsWithoutEmbeddedDisjunctions
        (
            LocArgumentsElementsListWithDisjunctions,
            ParArgumentsElementsList
        ),
        !.
    /*
    Если в исходном списке нет знака операции дизъюнкции, 
        то применяем дизъюнкцию в глубину к аргументам */
    getDisjunctionsInWidth
    (
        ParElementsList,
        ParElementsListWithDisjunctions
    ):-
        getDisjunctionsInDepth
        (
            ParElementsList,
            ParElementsListWithDisjunctions
        ).
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getArgumentsWithGotDisjunctionsInWidth
        Получение аргументов с полученными дизъюнкциями в ширину
    /------------------------------------------------------------------------/
        elementsList ParArgumentsElementsList - исходный список аргументов        
        elementsList ParArgumentsElementsListWithDisjunctions - список
            элементов-аргументов c выделенными дизъюнкциями
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getArgumentsWithGotDisjunctionsInWidth
    (
        [],
        []
    ):- !.
    
    /*
    Применяем к первому элементу списка дизъюнкции
    и к его внутренним аргументам,
    и его помещаем в начало результирующего списка,
        затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getArgumentsWithGotDisjunctionsInWidth
    (
        [
            ParArgumentElement
            |
            ParArgumentsElementsListTail
        ],
        [
            ParArgumentElementWithDisjunction
            |
            ParArgumentsElementsListWithDisjunctionsTail        
        ]
    ):-   
        getDisjunctionsInWidth
        (
            [ ParArgumentElement ],
            LocSingleArgumentElementsListWithDisjunction
        ),
        LocSingleArgumentElementsListWithDisjunction =
            [ ParArgumentElementWithDisjunction ],
        getArgumentsWithGotDisjunctionsInWidth
        (
            ParArgumentsElementsListTail,
            ParArgumentsElementsListWithDisjunctionsTail
        ).
    /*======================================================================*/     
    
    
    /*-----------------------------------------------------------------------/
        getDisjunctionsInDepth
        Получение дизъюнкций в глубину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithDisjunctions - список элементов
            с выделенными дизъюнкциями
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */    
    getDisjunctionsInDepth
    (
        [],
        []
    ):- !.      
    /*
    Если в начале списка элемент, являющийся аргументом бинарной операции,
        то применяем к его внутреннему списку элементов,
        и полученный результат преобразований дизъюнкции вставляем внутрь,
        затем помещаем в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getDisjunctionsInDepth
    (
        [
            ParStartArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithDisjunctionsTail
        ]
    ):-
        isBinaryOperationArgumentElement( ParStartArgumentElement ),        
        getBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            LocStartArgumentInternalElementsList
        ),
        getDisjunctionsInWidth
        (
            LocStartArgumentInternalElementsList,
            LocArgumentInternalElementsListWithDisjunctions
        ),       
        resetBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            ParArgumentElement,
            LocArgumentInternalElementsListWithDisjunctions
        ),
        getDisjunctionsInDepth
        (
            ParElementsListTail,
            ParElementsListWithDisjunctionsTail
        ),
        !.
    /*
    Если в начале списка элемент, являющийся
            элементом двухместной операции,
        то применяем дизъюнкцию в ширину к его левому и правому аргументам,
        затем рекурсивно обрабатываем внутренние двухместные операции в глубину
            данного элемента списка
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getDisjunctionsInDepth
    (
        [
            ParStartArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithDisjunctionsTail
        ]
    ):-
        isTwoArgumentsOperationElement( ParStartArgumentElement ),
        getTwoArgumentsOperationInternalElementsLists
        (
            ParStartArgumentElement,
            LocStartArgumentLeftInternalElementsList,
            LocStartArgumentRightInternalElementsList
        ),
        getDisjunctionsInWidth
        (
            LocStartArgumentLeftInternalElementsList,
            LocArgumentLeftInternalElementsListWithDisjunctions
        ),    
        getDisjunctionsInWidth
        (
            LocStartArgumentRightInternalElementsList,
            LocArgumentRightInternalElementsListWithDisjunctions
        ),               
        resetTwoArgumentsOperationInternalElementsLists
        (
            ParStartArgumentElement,
            ParArgumentElement,
            LocArgumentLeftInternalElementsListWithDisjunctions,
            LocArgumentRightInternalElementsListWithDisjunctions
        ),
        getDisjunctionsInDepth
        (
            ParElementsListTail,
            ParElementsListWithDisjunctionsTail
        ),
        !.        
    /*
    Если в начале списка элемент не являющийся аргументом бинарной операции
            или двухместной операции,
        то просто переносим его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getDisjunctionsInDepth
    (
        [
            ParArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithDisjunctionsTail
        ]
    ):-
        getDisjunctionsInDepth
        (
            ParElementsListTail,
            ParElementsListWithDisjunctionsTail
        ).       
    /*======================================================================*/      
    
    
    /*-----------------------------------------------------------------------/
        getConjunctionArgumentsWithoutEmbeddedConjunctions     
        Получение списка элементов конъюнкции без вложенных конъюнкций   
    /------------------------------------------------------------------------/        
        elementsList ParElementsList - исходный список элементов конъюнкции 
        elementsList ParElementsListWithoutEmbeddedConjunctions -
            список элементов-аргументов конъюнкции без вложенных конъюнкций
        procedure (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст,
       то возвращаем пустой список */
    getConjunctionArgumentsWithoutEmbeddedConjunctions
    (
        [],
        []
    ):- !.

    /*
    Если в списке встречается вложенное выражение
            с единственным вхождением конъюнкции,
        то обрабатываем внутренние элементы конъюнкции на наличие конъюнкций,
           и в результате получаем результат */
    getConjunctionArgumentsWithoutEmbeddedConjunctions
    (
        [
            subElements
            (
                [ conjunction( ParInternalConjunctionElementsList ) ]
            )            
        ],
        ParElementsListWithoutEmbeddedConjunctions
    ):-
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            ParInternalConjunctionElementsList,
            ParElementsListWithoutEmbeddedConjunctions
        ),
        !.    
    /*
    Если в списке встречается внутренняя конъюнкция,
        то обрабатываем внутренние элементы конъюнкции на наличие конъюнкций,
           и в результате получаем результат */
    getConjunctionArgumentsWithoutEmbeddedConjunctions
    (
        [ conjunction( ParInternalConjunctionElementsList ) ],
        ParElementsListWithoutEmbeddedConjunctions
    ):-
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            ParInternalConjunctionElementsList,
            ParElementsListWithoutEmbeddedConjunctions
        ),
        !.
    /*
    Если в начале списка встречается единственный элемент,
            не являющийся конъюнкцией,
        то его помещаем в начало списка */
    getConjunctionArgumentsWithoutEmbeddedConjunctions
    (
        [ ParElement ],
        [ ParElement ]
    ):- !.    
    /*
    Если в начале списка встречается вложенное выражение
            с единственным вхождением конъюнкции,
        то обрабатываем внутренние элементы конъюнкции на наличие конъюнкций
        и их рекурсивно помещаем в начало            
        и далее хвост обрабатывается так же, как и исходный список элементов,
            с соответствующим рекурсивным вызовом */
    getConjunctionArgumentsWithoutEmbeddedConjunctions
    (
        [
            subElements
            (
                [ conjunction( ParInternalConjunctionElementsList ) ]
            )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmbeddedConjunctions
    ):-
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            ParInternalConjunctionElementsList,
            LocInternalConjunctionElementsListWithoutEmbeddedConjunctions
        ),    
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            ParElementsListTail,
            LocElementsListWithoutEmbeddedConjunctionsTail
        ),
        concatenateElementsLists
        (
            LocInternalConjunctionElementsListWithoutEmbeddedConjunctions,
            LocElementsListWithoutEmbeddedConjunctionsTail,
            ParElementsListWithoutEmbeddedConjunctions
        ),
        !.
    /*
    Если в начале списка встречается внутренняя конъюнкция,
        то обрабатываем внутренние элементы конъюнкции на наличие конъюнкций
        и их рекурсивно помещаем в начало            
        и далее хвост обрабатывается так же, как и исходный список элементов,
            с соответствующим рекурсивным вызовом */
    getConjunctionArgumentsWithoutEmbeddedConjunctions
    (
        [
            conjunction( ParInternalConjunctionElementsList )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmbeddedConjunctions
    ):-
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            ParInternalConjunctionElementsList,
            LocInternalConjunctionElementsListWithoutEmbeddedConjunctionsTail
        ),
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            ParElementsListTail,
            LocElementsListWithoutEmbeddedConjunctionsTail
        ),        
        concatenateElementsLists
        (
            LocInternalConjunctionElementsListWithoutEmbeddedConjunctionsTail,
            LocElementsListWithoutEmbeddedConjunctionsTail,
            ParElementsListWithoutEmbeddedConjunctions
        ),
        !.    
    /*
    Если в начале списка встречается элемент, не являющийся конъюнкцией,
        то его помещаем в начало результирующего списка
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getConjunctionArgumentsWithoutEmbeddedConjunctions
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithoutEmbeddedConjunctionsTail
        ]        
    ):-
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            ParElementsListTail,
            ParElementsListWithoutEmbeddedConjunctionsTail
        ).      
    /*======================================================================*/        
    
    
    /*-----------------------------------------------------------------------/
        getConjunctionsInWidth
        Получение конъюнкций в ширину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithConjunctions - список элементов
            c выделенными конъюнкциями
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если в исходном списке лежит знак операции конъюнкции, 
        то в первом шаге и в результате получаем элемент конъюнкции,
            затем из аргументов выделяем конъюнкции в ширину
            и удаляем вложенные конъюнкции,
            и извлекаем элементы из вложенных выражений */
    getConjunctionsInWidth
    (
        ParElementsList,
        [ conjunction( ParArgumentsElementsList ) ]
    ):-
        isMultiArgumentsOperation
        (
            ParElementsList,            
            scanner::operationSign( base::conjunctionString ),
            LocStartArgumentsElementsList
        ),
        getArgumentsWithGotConjunctionsInWidth
        (
            LocStartArgumentsElementsList,
            LocArgumentsElementsListWithConjunctions
        ),
        getConjunctionArgumentsWithoutEmbeddedConjunctions
        (
            LocArgumentsElementsListWithConjunctions,
            LocArgumentsElementsListWithoutEmbeddedConjunctions
        ),
        getElementsListWithElementsExtractedFromSubElementsLists
        (
            LocArgumentsElementsListWithoutEmbeddedConjunctions,
            ParArgumentsElementsList
        ),
        !.
    /*
    Если в исходном списке нет знака операции конъюнкции, 
        то применяем конъюнкцию в глубину к аргументам */
    getConjunctionsInWidth
    (
        ParElementsList,
        ParElementsListWithConjunctions
    ):-
        getConjunctionsInDepth
        (
            ParElementsList,
            ParElementsListWithConjunctions
        ).
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getArgumentsWithGotConjunctionsInWidth
        Получение аргументов с полученными конъюнкциями в ширину
    /------------------------------------------------------------------------/
        elementsList ParArgumentsElementsList - исходный список аргументов        
        elementsList ParArgumentsElementsListWithConjunctions - список
            элементов-аргументов c выделенными конъюнкциями
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getArgumentsWithGotConjunctionsInWidth
    (
        [],
        []
    ):- !.
    
    /*
    Применяем к первому элементу списка конъюнкции
    и к его внутренним аргументам,
    и его помещаем в начало результирующего списка,
        затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getArgumentsWithGotConjunctionsInWidth
    (
        [
            ParArgumentElement
            |
            ParArgumentsElementsListTail
        ],
        [
            ParArgumentElementWithConjunction
            |
            ParArgumentsElementsListWithConjunctionsTail        
        ]
    ):-   
        getConjunctionsInWidth
        (
            [ ParArgumentElement ],
            LocSingleArgumentElementsListWithConjunction
        ),
        LocSingleArgumentElementsListWithConjunction =
            [ ParArgumentElementWithConjunction ],
        getArgumentsWithGotConjunctionsInWidth
        (
            ParArgumentsElementsListTail,
            ParArgumentsElementsListWithConjunctionsTail
        ).
    /*======================================================================*/  
    
 
    /*-----------------------------------------------------------------------/
        getConjunctionsInDepth
        Получение конъюнкций в глубину
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов        
        elementsList ParElementsListWithConjunctions - список элементов
            с выделенными конъюнкциями
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный список элементов пуст или пуст, 
        то возвращаем пустой список */    
    getConjunctionsInDepth
    (
        [],
        []
    ):- !.      
    /*
    Если в начале списка элемент, являющийся аргументом бинарной операции,
        то применяем к его внутреннему списку элементов,
        и полученный результат преобразований конъюнкции вставляем внутрь,
        затем помещаем в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getConjunctionsInDepth
    (
        [
            ParStartArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithConjunctionsTail
        ]
    ):-
        isBinaryOperationArgumentElement( ParStartArgumentElement ),
        getBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            LocStartArgumentInternalElementsList
        ),
        getConjunctionsInWidth
        (
            LocStartArgumentInternalElementsList,
            LocArgumentInternalElementsListWithConjunctions
        ),       
        resetBinaryOperationArgumentInternalElementsList
        (
            ParStartArgumentElement,
            ParArgumentElement,
            LocArgumentInternalElementsListWithConjunctions
        ),
        getConjunctionsInDepth
        (
            ParElementsListTail,
            ParElementsListWithConjunctionsTail
        ),
        !.
    /*
    Если в начале списка элемент, являющийся
            элементом двухместной операции,
        то применяем конъюнкцию в ширину к его левому и правому аргументам,
        затем рекурсивно обрабатываем внутренние двухместные операции в глубину
            данного элемента списка
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getConjunctionsInDepth
    (
        [
            ParStartArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithConjunctionsTail
        ]
    ):-
        isTwoArgumentsOperationElement( ParStartArgumentElement ),
        getTwoArgumentsOperationInternalElementsLists
        (
            ParStartArgumentElement,
            LocStartArgumentLeftInternalElementsList,
            LocStartArgumentRightInternalElementsList
        ),
        getConjunctionsInWidth
        (
            LocStartArgumentLeftInternalElementsList,
            LocArgumentLeftInternalElementsListWithConjunctions
        ),    
        getConjunctionsInWidth
        (
            LocStartArgumentRightInternalElementsList,
            LocArgumentRightInternalElementsListWithConjunctions
        ),               
        resetTwoArgumentsOperationInternalElementsLists
        (
            ParStartArgumentElement,
            ParArgumentElement,
            LocArgumentLeftInternalElementsListWithConjunctions,
            LocArgumentRightInternalElementsListWithConjunctions
        ),
        getConjunctionsInDepth
        (
            ParElementsListTail,
            ParElementsListWithConjunctionsTail
        ),
        !. 
    /*
    Если в начале списка элемент, являющийся дизъюнкцией,
        то применяем конъюнкцию в ширину к его аргументам,
        затем рекурсивно обрабатываем внутренние дизъюнкции в глубину
            данного элемента списка
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getConjunctionsInDepth
    (
        [
            disjunction( ParStartArgumentsElementsList )
            |
            ParElementsListTail
        ],
        [
            disjunction( ParArgumentsElementsList )
            |
            ParElementsListWithConjunctionsTail
        ]
    ):-
        getArgumentsWithGotConjunctionsInWidth
        (
            ParStartArgumentsElementsList,
            ParArgumentsElementsList
        ),
        getConjunctionsInDepth
        (
            ParElementsListTail,
            ParElementsListWithConjunctionsTail
        ),
        !.               
    /*
    Если в начале списка элемент не являющийся аргументом бинарной операции
            или двухместной операции,
        то просто переносим его в начало результирующего списка,
        и рекурсивно обрабатываем хвост исходного списка
            на оставшиеся элементы */
    getConjunctionsInDepth
    (
        [
            ParArgumentElement
            |
            ParElementsListTail
        ],
        [
            ParArgumentElement
            |
            ParElementsListWithConjunctionsTail
        ]
    ):-
        getConjunctionsInDepth
        (
            ParElementsListTail,
            ParElementsListWithConjunctionsTail
        ).       
    /*======================================================================*/    


    /*-----------------------------------------------------------------------/
        getAllBinaryOperationsArgumentsAndTwoArgumentsOperation
        Получение всех аргументов бинарных операций
        и двухместных операций
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        elementsList ParElements - список элементов с выделенными
            аргументами бинарных операций и двухместными операциями
        determ (i,o)
    /-----------------------------------------------------------------------*/  
            
        
    /*-----------------------------------------------------------------------/
        getAllArgumentsAndOperation
        Получение всех аргументов и операций
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов        
        elementsList ParElementsList - список элементов с выделенными
            аргументами и операциями
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Получаем все аргументы бинарных операций и двухместных операций,
    получаем все дизъюнкции,
    получаем все конъюнкции */
    getAllArgumentsAndOperation
    (
        ParStartElementsList,
        ParElementsList
    ):-
        getAllBinaryOperationsArgumentsAndTwoArgumentsOperation
        (
            ParStartElementsList,
            LocElementsListWithArgumentsAndTwoArgumentsOperation
        ),
        getDisjunctionsInWidth
        (
            LocElementsListWithArgumentsAndTwoArgumentsOperation,
            LocElementsListWithDisjunctions
        ),
        getConjunctionsInWidth
        (
            LocElementsListWithDisjunctions,
            ParElementsList
        ).        
    /*======================================================================*/           


    /*======================================================================/
    
        К О Н В Е Р Т О Р Ы
    
    /=======================================================================*/
             
        
    /*-----------------------------------------------------------------------/
        ConvertPositionedLexemesListToElementsList
        Преобразование списка лексем в список элементов
    /------------------------------------------------------------------------/
        scanner::positionedLexemesList ParPositionedLexemesList -
            список лексем
        elementsList ParElementsList - список элементов
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список оканчивается пуст или пуст,
        то возвращаем пустой список */
    ConvertPositionedLexemesListToElementsList
    (
        [],
        []
    ):- !.
    /*
    Позиционированные лексемы последовательно помещаются
        в начало результирующего списка,
    и рекурсивно обрабатываем хвост исходного списка
        на оставшиеся элементы */
    ConvertPositionedLexemesListToElementsList
    (
        [
            scanner::positionedLexeme
            (
                ParLexeme,
                ParCursorPosition
            )
            |
            ParPositionedLexemesListTail
        ],
        [
            positionedLexeme
            (
                ParLexeme,
                ParCursorPosition
            )
            |
            ParElementsListTail
        ]
    ):- 
        ConvertPositionedLexemesListToElementsList
        (
            ParPositionedLexemesListTail,
            ParElementsListTail
        ).
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        ConvertElementToExpression
        Преобразование элемента в выражение
    /------------------------------------------------------------------------/
        element ParElement - элемент
        expression ParExpression - выражение
        determ (i,o)
    /-----------------------------------------------------------------------*/   
    % Имеем уже готовое выражение - предикат
    ConvertElementToExpression
    (
        expressionElement( ParExpression ),
        ParExpression
    ):- !.
    /*
    Если элемент - квантор вида существования с единственным элементом
            в списке элементов,
        то преобразуем его в квантор существования
        в соответствии с правилом преобразования */
    ConvertElementToExpression
    (
        quantifier
        (
            existence,
            ParVariableDomain,
            _,
            [ ParElement ]
        ),
        existence
        (
            ParVariableDomain,
            ParExpression
        )
    ):-
        ConvertElementToExpression
        (
            ParElement,
            ParExpression
        ),
        !.
    /*
    Если элемент - квантор вида общности с единственным элементом
            в списке элементов,
        то преобразуем его в квантор общности
        в соответствии с правилом преобразования */ 
    ConvertElementToExpression
    (
        quantifier
        (
            generality,
            ParVariableDomain,
            _,
            [ ParElement ]
        ),
        generality
        (
            ParVariableDomain,
            ParExpression
        )        
    ):-
        ConvertElementToExpression
        (
            ParElement,
            ParExpression
        ),
        !.
    /*
    Если элемент - отрицание с единственным элементом в списке,
        то преобразуем его в отрицание
        в соответствии с правилом отрицания */ 
    ConvertElementToExpression
    (
        negation( [ ParElement ] ),
        negation( ParExpression )
    ):-
        ConvertElementToExpression
        (
            ParElement,
            ParExpression
        ),
        !.        
    /*
    Если элемент - эквивалентность с единственными элементами
            в списках,
        то преобразуем левую и правую части в выражения
        в соответствии с правилом эквивалентности */ 
    ConvertElementToExpression
    (
        equivalence
        (
            [ ParLeftElement ],
            [ ParRightElement ]
        ),
        equivalence
        (
            ParLeftExpression,
            ParRightExpression
        )     
    ):-
        ConvertElementToExpression
        (
            ParLeftElement,
            ParLeftExpression
        ),
        ConvertElementToExpression
        (
            ParRightElement,
            ParRightExpression
        ),        
        !.    
    /*
    Если элемент - импликация с единственными элементами
            в списках,
        то преобразуем левую и правую части в выражения
        в соответствии с правилом импликации */ 
    ConvertElementToExpression
    (
        implication
        (
            [ ParLeftElement ],
            [ ParRightElement ]
        ),
        implication
        (
            ParLeftExpression,
            ParRightExpression
        )     
    ):-
        ConvertElementToExpression
        (
            ParLeftElement,
            ParLeftExpression
        ),
        ConvertElementToExpression
        (
            ParRightElement,
            ParRightExpression
        ),        
        !.   
    /*
    Если элемент - дизъюнкция,
        то преобразуем список элементов в список выражений
        в соответствии с правилом дизъюнкции */ 
    ConvertElementToExpression
    (
        disjunction( ParElementsList ),
        disjunction( ParExpressionsList )
    ):-
        ConvertElementsListToExpressionsList
        (
            ParElementsList,
            ParExpressionsList
        ),        
        !.           
    /*
    Если элемент - вложенное выражение
        с единственным вхождением дизъюнкции,
        то преобразуем список элементов в список выражений
        в соответствии с правилом дизъюнкции */ 
    ConvertElementToExpression
    (
        subElements
        (
            [ disjunction( ParElementsList ) ]
        ),
        disjunction( ParExpressionsList )
    ):-
        ConvertElementsListToExpressionsList
        (
            ParElementsList,
            ParExpressionsList
        ),        
        !.                     
    /*
    Если элемент - конъюнкция,
        то преобразуем список элементов в список выражений
        в соответствии с правилом конъюнкции */ 
    ConvertElementToExpression
    (
        conjunction( ParElementsList ),
        conjunction( ParExpressionsList )
    ):-
        ConvertElementsListToExpressionsList
        (
            ParElementsList,
            ParExpressionsList
        ),        
        !.   
    /*
    Если элемент - вложенное выражение
        с единственным вхождением конъюнкции,
        то преобразуем список элементов в список выражений
        в соответствии с правилом конъюнкции */ 
    ConvertElementToExpression
    (
        subElements
        (
            [ conjunction( ParElementsList ) ]
        ),        
        conjunction( ParExpressionsList )
    ):-
        ConvertElementsListToExpressionsList
        (
            ParElementsList,
            ParExpressionsList
        ).           
    /*======================================================================*/       
                             
        
    /*-----------------------------------------------------------------------/
        ConvertElementsListToExpressionsList
        Преобразование списка элементов в список выражений
    /------------------------------------------------------------------------/
        elementsList ParElementsList - элементы
        expressionsList ParExpressionsList - выражения
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    ConvertElementsListToExpressionsList
    (
        [],
        []
    ):- !.
    /*
    Применяем к первому элементу списка преобразование в выражение,
    и рекурсивно к хвосту, помещаем в результирующий список на оставшиеся элементы */
    ConvertElementsListToExpressionsList
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParExpression
            |
            ParExpressionsListTail        
        ]
    ):-
        ConvertElementToExpression
        (
            ParElement,
            ParExpression
        ),
        ConvertElementsListToExpressionsList
        (
            ParElementsListTail,
            ParExpressionsListTail
        ).
    /*======================================================================*/        
    
        
    /*-----------------------------------------------------------------------/
        getExpression
        Получение выражения
    /------------------------------------------------------------------------/
        scanner::positionedLexemesList ParPositionedLexemesList -
            список лексем
        expression ParExpression - выражение
        procedure (i,o)
    /-----------------------------------------------------------------------*/        
    getExpression
    (
        ParPositionedLexemesList,
        ParExpression
    ):-
        ConvertPositionedLexemesListToElementsList
        (
            ParPositionedLexemesList,
            LocElementsList
        ),
        getAllArgumentsAndOperation
        (
            LocElementsList,
            LocElementsListWithArgumentsAndOperation
        ),
        LocElementsListWithArgumentsAndOperation = 
            [ LocElement ],
        ConvertElementToExpression
        (
            LocElement,
            ParExpression
        ),
        !.
    /*
    Возвращаем пустой */
    getExpression
    (
        _,
        predicate
        (
            base::emptyString,
            []
        )
    ).
    /*======================================================================*/                
        
end implement parser