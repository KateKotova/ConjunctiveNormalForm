/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

% Домен
implement engine
    open core, file5x, fileSelector
      
constants
    % Имя класса
    className = "com/visual-prolog/Engine/engine".
    % Версия класса
    classVersion = "$JustDate: 2008-05-01 $$Revision: 5 $".
    
clauses
    % Информация о классе
    classInfo( className, classVersion ). 
    
domains    
    % Список строк
    stringsList = string*.
    
    % Тип символа    
    symbolKind = 
        % Прописная буква
        title;
        % Строчная буква
        lower.
    
constants
    % Список всех прописных букв английского алфавита
    titleAlphabetSymbolsList : stringsList =
        [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
          "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ].   
    % Список всех строчных букв английского алфавита
    lowerAlphabetSymbolsList : stringsList =
        [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
          "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" ].              
          
    % Первая прописная буква английского алфавита
    firstTitleAlphabetSymbolString = "A".    
    % Первая строчная буква английского алфавита
    firstLowerAlphabetSymbolString = "a".     
    
domains      
    % Элемент
    element =
        % Предикат
        predicate( string, parametersList );    
        % Отрицание
        negation( element ); 
        % Направленный предикат
        directedPredicateElement( predicateDirection, string,
            parametersList );
        % Квантор существования
        existence( variableDomain, element );
        % Квантор общности 
        generality( variableDomain, element );
        % Эквивалентность
        equivalence( element, element );
        % Импликация
        implication( element, element );
        % Дизъюнкция
        disjunction( elementsList );
        % Конъюнкция
        conjunction( elementsList ).        

    % Список элементов
    elementsList = element*. 
    
class facts
    % Вид и алфавитный список символов
    theSymbolsKindAndAlphabetList : ( symbolKind, stringsList ).
    % Вид и первая строка соответствующего алфавита
    theSymbolKindAndFirstAlphabetString : ( symbolKind, string ).   
    % Вид символа, алфавитный список и первая его строка
    theSymbolKindAndAlphabetListAndFirstString : ( symbolKind, stringsList,
        string ).

class predicates
    /*-----------------------------------------------------------------------/
        Операции проверки
    /-----------------------------------------------------------------------*/    
    % Проверка принадлежности к классу унарных операций
    isSingleArgumentOperationElement : ( element ) determ (i).
    % Получение внутреннего элемента унарной операции
    getSingleArgumentOperationInternalElement : ( element, element )
        determ (i,o).
    % Переустановка внутреннего элемента унарной операции
    resetSingleArgumentOperationInternalElement : ( element, element,
        element ) determ (i,o,i).
    % Получение составляющих унарной операции
    getSingleArgumentOperationComponents : ( element, variableDomain,
        element ) determ (i,o,o).
    % Переустановка составляющих унарной операции
    resetSingleArgumentOperationComponents : ( element, element,
        variableDomain, element ) determ (i,o,i,i).
   
    % Проверка принадлежности к классу многоместных операций
    isMultiArgumentsOperationElement : ( element ) determ (i).
    % Получение списка внутренних элементов многоместной операции
    getMultiArgumentsOperationInternalElementsList : ( element, elementsList )
        determ (i,o).
    % Переустановка списка внутренних элементов многоместной операции
    resetMultiArgumentsOperationInternalElementsList : ( element, element,
        elementsList ) determ (i,o,i).
    /*======================================================================*/   
        

    /*-----------------------------------------------------------------------/
        Устранение эквивалентности и импликации
    /-----------------------------------------------------------------------*/    
    % Получение элемента без эквивалентности и импликации
    getElementWithoutEquivalencesAndImplications : ( element, element )
        determ (i,o).
    % Получение списка элементов без эквивалентности и импликации
    getElementsListWithoutEquivalencesAndImplications : ( elementsList,
        elementsList ) determ (i,o).
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/
        Продвижение отрицания к листу    
    /-----------------------------------------------------------------------*/ 
    % Получение списка отрицательных элементов
    getNegatedElementsList : ( elementsList, elementsList ) determ (i,o).
    % Получение элемента с отрицаниями, продвинутыми к предикатам
    getElementWithPromotedToPredicatesNegations : ( element, element )
        determ (i,o).
    % Получение списка элементов с отрицаниями, продвинутыми к предикатам
    getElementsListWithPromotedToPredicatesNegations : ( elementsList,
        elementsList ) determ (i,o).
   
    % Получение элемента с направленными предикатами
    getElementWithDirectedPredicates : ( element, element ) determ (i,o).
    % Получение списка элементов с направленными предикатами
    getElementsListWithDirectedPredicates : ( elementsList, elementsList )
        determ (i,o).
    /*======================================================================*/     
                 
    
    /*-----------------------------------------------------------------------/
        Работа со списком
    /-----------------------------------------------------------------------*/     
    % Проверка вхождения строки в список строк
    stringIsInStringsList : ( string, stringsList ) determ (i,i).
    % Получение строки, следующей за строкой в списке
    getNextStringInStringsList : ( string, string, stringsList, string )
        determ (i,o,i,i).
    % Получение строки, следующей за строкой в алфавите
    getNextStringOnAlphabet : ( string, string, symbolKind ) determ (i,o,i).
    
    % Получение уникальной строки, не содержащейся в заданном списке
    getAlphabetSymbolsStringOutOfStringsList : ( string, string, stringsList,
        symbolKind, stringsList ) determ (i,o,i,i,i).
    getAlphabetSymbolsStringOutOfStringsList : ( stringsList, string,
        symbolKind ) determ (i,o,i).
    % Получение уникальной строки, отличной от содержащихся
    % в списке
    getReplacedAlphabetSymbolsStringOutOfStringsList : ( string, string,
        stringsList, symbolKind ) procedure (i,o,i,i).
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        Замена параметра
    /-----------------------------------------------------------------------*/         
    % Получение списка параметров с заменой параметра
    getParametersListWithReplacedParameter : ( parametersList, parametersList,
        parameterDomain, parameterDomain ) determ (i,o,i,i).
    % Получение элемента с заменой параметра
    getElementWithReplacedParameter : ( element, element, parameterDomain,
        parameterDomain ) determ (i,o,i,i).
    % Получение списка элементов с заменой параметра
    getElementsListWithReplacedParameter : ( elementsList, elementsList,
        parameterDomain, parameterDomain ) determ (i,o,i,i).          
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/    
        Расщепление кванторов и переменных   
    /-----------------------------------------------------------------------*/        
    % Получение элемента с расщепленными кванторными переменными,
    % при этом имена входящих в него связанных переменных уникальны
    getElementWithSplitedQuantifiersVariables : ( element, element,
        stringsList, stringsList ) determ (i,o,i,o).
    % Получение списка элементов с расщепленными кванторными переменными,
    % при этом имена входящих в него связанных переменных уникальны
    getElementsListWithSplitedQuantifiersVariables : ( elementsList,
        elementsList, stringsList, stringsList ) determ (i,o,i,o).
    % Получение элемента с расщепленными кванторами,
    % при этом имена входящих в него связанных переменных уникальны
    getElementWithSplitedQuantifiersVariables : ( element, element )
        determ (i,o).
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/    
        Сколемизация - исключение кванторов существования 
    /-----------------------------------------------------------------------*/      
    % Получение списка имен для предикатных констант
    getElementPredicatesNamesStringsList : ( stringsList, stringsList,
        element ) determ (i,o,i).
    % Получение списка имен для предикатных констант списка элементов
    getElementsListPredicatesNamesStringsList : ( stringsList, stringsList,
        elementsList ) determ (i,o,i).
    % Получение списка имен для предикатных констант элемента
    getElementPredicatesNamesStringsList : ( stringsList, element )
        determ (o,i).
                              
    % Получение списка имен для переменных элемента
    getElementVariablesNamesStringsList : ( stringsList, stringsList,
        element ) determ (i,o,i).
    % Получение списка имен для переменных списка элементов
    getElementsListVariablesNamesStringsList : ( stringsList, stringsList,
        elementsList ) determ (i,o,i).
    % Получение списка имен для переменных элемента
    getElementVariablesNamesStringsList : ( stringsList, element )
        determ (o,i).
        
    % Получение элемента без кванторов существования
    getElementWithoutExistenceQuantifiers : ( element, element, stringsList,
        stringsList, stringsList, stringsList, variablesList)
        determ (i,o,i,o,i,o,i).          
    % Получение списка элементов без кванторов существования
    getElementsListWithoutExistenceQuantifiers : ( elementsList, elementsList,
       stringsList, stringsList, stringsList, stringsList, variablesList)
       determ (i,o,i,o,i,o,i).
    % Получение элемента без кванторов существования
    getElementWithoutExistenceQuantifiers : ( element, element ) determ (i,o).
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/    
        Преобразования с элиминацией кванторов общности
    /-----------------------------------------------------------------------*/ 
    % Получение элемента без кванторов общности 
    getElementWithoutGeneralityQuantifiers : ( element, element )
        determ (i,o).
    % Получение списка элементов без кванторов общности        
    getElementsListWithoutGeneralityQuantifiers : ( elementsList,
        elementsList ) determ (i,o).
        
    % Конкатенация первого и второго списков элементов в третий
    concatenateElementsLists : ( elementsList, elementsList, elementsList )
        determ anyflow.
    
    % Получение элемента без вложенных многоместных операций
    getElementWithoutEmbeddedMultiArgumentsOperations : ( element, element )
        determ (i,o).
    % Получение списка элементов без вложенных дизъюнкций
    getElementsListWithoutEmbeddedDisjunctions : ( elementsList,
        elementsList ) determ (i,o).
    % Получение списка элементов без вложенных конъюнкций
    getElementsListWithoutEmbeddedConjunctions : ( elementsList,
        elementsList ) determ (i,o).
    /*======================================================================*/
    

    /*-----------------------------------------------------------------------/    
        Преобразования с конъюнктивной нормальной формой
    /-----------------------------------------------------------------------*/     
    % Получение списка из внутреннего списка первой встречной конъюнкции
    % и оставшегося списка элементов
    splitElementsListUpToFirstConjunctionAndRestElementsLists :
        ( elementsList, elementsList, elementsList ) determ (i,o,o).
    % Получение конъюнктивного списка элементов из дизъюнктов и конъюнктов,
    % между которыми стоит знак конъюнкции
    % (в соответствии дистрибутивностью) и результирующих конъюнктов
    getConjunctionElementsListFromDisjunctsAndConjunctsElementsLists :
        ( elementsList, elementsList, elementsList ) determ (i,i,o).
    % Получение конъюнктивного списка элементов из элемента
    getConjunctionElementsListFromElement : ( element, elementsList )
        determ (i,o).
    % Получение конъюнктивного списка элементов из списка элементов
    getConjunctionElementsListFromElementsList : ( elementsList,
        elementsList ) determ (i,o).    
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/    
        Вспомогательные предикаты
    /-----------------------------------------------------------------------*/         
    % Получение строки с индексом на конце, не содержащейся
    % в заданном списке
    getIndexedStringOutOfStringsList : ( string, string, stringsList,
        core::integer32 ) determ (i,o,i,i).
    getIndexedStringOutOfStringsList : ( string, string, stringsList ) determ (i,o,i).

    % Получение списка вспомогательных имен для переменных
    % из списка переменных
    getVariablesListVariablesNamesStringsList : ( variablesList, stringsList,
        stringsList ) determ (i,i,o).        
    % Получение списка вспомогательных имен для переменных из списка параметров
    getParametersListVariablesNamesStringsList : ( parametersList,
        stringsList, stringsList ) determ (i,i,o).

    % Получение списка вспомогательных имен для переменных из элемента
    getConjunctionElementVariablesNamesStringsList : ( element, stringsList,
        stringsList ) determ (i,i,o).    
    % Получение списка вспомогательных имен для переменных
    % из cписка элементов
    getConjunctionElementsListVariablesNamesStringsList : ( elementsList,
        stringsList, stringsList ) determ (i,i,o).
    % Получение списка вспомогательных имен для переменных из элемента
    getConjunctionElementVariablesNamesStringsList : ( element, stringsList )
        determ (i,o).     
    /*======================================================================*/     
    
    
    /*-----------------------------------------------------------------------/    
        Замена переменной
    /-----------------------------------------------------------------------*/             
    % Получение списка переменных с заменой переменной
    getVariablesListWithReplacedVariable : ( variablesList, variablesList,
        variableDomain, variableDomain ) determ (i,o,i,i).
    % Получение списка параметров с заменой переменной
    getParametersListWithReplacedVariable : ( parametersList, parametersList,
        variableDomain, variableDomain ) determ (i,o,i,i).
    % Получение элемента с заменой переменной
    getElementWithReplacedVariable : ( element, element, variableDomain,
        variableDomain ) determ (i,o,i,i).
    % Получение списка элементов с заменой переменной
    getElementsListWithReplacedVariable : ( elementsList, elementsList,
        variableDomain, variableDomain ) determ (i,o,i,i).    
    /*======================================================================*/  
    

    /*-----------------------------------------------------------------------/    
        Расщепление переменных в конъюнкте
    /-----------------------------------------------------------------------*/                 
    % Получение элемента конъюнкта с расщепленными переменными
    getConjunctionElementWithSplitedVariables : ( element, element,
        stringsList, stringsList, stringsList ) determ (i,o,i,i,o).
    % Получение списка элементов конъюнкта с расщепленными переменными,
    % при этом имена входящих в них попарно различны
    getConjunctionElementsListWithSplitedVariables : ( elementsList,
        elementsList, stringsList, stringsList ) determ (i,o,i,o).
    getConjunctionElementsListWithSplitedVariables : ( elementsList,
        elementsList ) determ (i,o).
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/    
        Конверторы
    /-----------------------------------------------------------------------*/        
    % Перевод элемента в список элементов в конъюнктивной нормальной форме
    translateElementToConjunctionElementsList : ( element, elementsList )
        determ (i,o).
        
    % Преобразование списка переменных в список параметров
    ConvertVariablesListToParametersList : ( parser::variablesList,
        parametersList ) determ (i,o).
    % Преобразование выражения в элемент
    ConvertExpressionToElement : ( parser::expression, element ) determ (i,o).
    % Преобразование списка выражений в список элементов
    ConvertExpressionsListToElementsList : ( parser::expressionsList,
        elementsList ) determ (i,o).
    
    % Преобразование списка элементов в список направленных предикатов
    ConvertElementsListToDirectedPredicatesList : ( elementsList,
        directedPredicatesList ) determ (i,o).
    % Преобразование списка элементов конъюнкции в список конъюнктов
    ConvertConjunctionElementsListToConjunctsList : ( elementsList,
        conjunctsList ) determ (i,o).
    /*======================================================================*/        
    
clauses   
    /*=======================================================================/
    
        Ф А К Т Ы
    
    /=======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        theSymbolsKindAndAlphabetList
        Вид и алфавитный список символов
    /------------------------------------------------------------------------/
        symbolKind ParSymbolKind - вид символа
        stringsList ParStringsList - алфавитный список символов
    /-----------------------------------------------------------------------*/
    % Прописные буквы 
    theSymbolsKindAndAlphabetList( title, titleAlphabetSymbolsList ).
    % Строчные буквы     
    theSymbolsKindAndAlphabetList( lower, lowerAlphabetSymbolsList ).
    /*======================================================================*/
           
    
    /*-----------------------------------------------------------------------/
        theSymbolKindAndFirstAlphabetString
        Вид и первая строка соответствующего алфавита
    /------------------------------------------------------------------------/
        symbolKind ParSymbolKind - вид символа
        string ParString - первая буква алфавита
    /-----------------------------------------------------------------------*/        
    % Прописные буквы
    theSymbolKindAndFirstAlphabetString( title,
        firstTitleAlphabetSymbolString ).
    % Строчные буквы     
    theSymbolKindAndFirstAlphabetString( lower,
        firstLowerAlphabetSymbolString ).
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        theSymbolKindAndAlphabetListAndFirstString
        Вид символа, алфавитный список и первая его строка
    /------------------------------------------------------------------------/
        symbolKind ParSymbolKind - вид символа
        stringsList ParStringsList - алфавитный список символов        
        string ParString - первая буква алфавита
    /-----------------------------------------------------------------------*/        
    % Прописные буквы 
    theSymbolKindAndAlphabetListAndFirstString( title,
        titleAlphabetSymbolsList, firstTitleAlphabetSymbolString ).
    % Строчные буквы     
    theSymbolKindAndAlphabetListAndFirstString( lower,
        lowerAlphabetSymbolsList, firstLowerAlphabetSymbolString ).
    /*======================================================================*/    
    

    /*======================================================================/
    
        П Р Е Д И К А Т Ы   П Р О В Е Р К И
    
    /=======================================================================*/
    

    /*-----------------------------------------------------------------------/
        isSingleArgumentOperationElement
        Проверка принадлежности к классу унарных операций
    /------------------------------------------------------------------------/
        element ParElement - элемент унарной операции
        determ (i)
    /-----------------------------------------------------------------------*/
    % Квантор существования
    isSingleArgumentOperationElement( existence( _, _ ) ):- !.
    % Квантор общности 
    isSingleArgumentOperationElement( generality( _, _ ) ).
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/
        getSingleArgumentOperationInternalElement
        Получение внутреннего элемента унарной операции
    /------------------------------------------------------------------------/
        element ParElement - элемент унарной операции
        element ParInternalElement - внутренний элемент операции
        determ (i,o)
    /-----------------------------------------------------------------------*/
    % Квантор существования
    getSingleArgumentOperationInternalElement
    (
        existence
        (
            _,
            ParInternalElement
        ),
        ParInternalElement      
    ):- !.
    % Квантор общности 
    getSingleArgumentOperationInternalElement
    (
        generality
        (
            _,
            ParInternalElement
        ),
        ParInternalElement        
    ).
    /*======================================================================*/           
    
    
    /*-----------------------------------------------------------------------/
        resetSingleArgumentOperationInternalElement
        Переустановка внутреннего элемента унарной операции
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент унарной операции
        element ParElement - элемент унарной операции   
        element ParInternalElement - внутренний элемент операции
        determ (i,o,i)
    /-----------------------------------------------------------------------*/
    % Квантор существования
    resetSingleArgumentOperationInternalElement
    (
        existence
        (
            ParVariableDomain,
            _
        ),
        existence
        (
            ParVariableDomain,
            ParInternalElement
        ),
        ParInternalElement    
    ):- !.
    % Квантор общности 
    resetSingleArgumentOperationInternalElement
    (
        generality
        (
            ParVariableDomain,
            _
        ),
        generality
        (
            ParVariableDomain,
            ParInternalElement
        ),
        ParInternalElement    
    ).
    /*======================================================================*/       
    

    /*-----------------------------------------------------------------------/
        getSingleArgumentOperationComponents
        Получение составляющих унарной операции
    /------------------------------------------------------------------------/
        element ParElement - элемент унарной операции
        variableDomain ParVariable - переменная
        element ParInternalElement - внутренний элемент операции
        determ (i,o,o)
    /-----------------------------------------------------------------------*/
    % Квантор существования
    getSingleArgumentOperationComponents
    (
        existence
        (
            ParVariable,
            ParInternalElement
        ),
        ParVariable,
        ParInternalElement
    ):- !.
    % Квантор общности 
    getSingleArgumentOperationComponents
    (
        generality
        (
            ParVariable,
            ParInternalElement
        ),
        ParVariable,
        ParInternalElement 
    ).
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        resetSingleArgumentOperationComponents
        Переустановка составляющих унарной операции
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент унарной операции
        element ParElement - элемент унарной операции   
        variableDomain ParVariable - переменная
        element ParInternalElement - внутренний элемент операции        
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/
    % Квантор существования
    resetSingleArgumentOperationComponents
    (
        existence( _, _ ),
        existence
        (
            ParVariable,
            ParInternalElement
        ),
        ParVariable,
        ParInternalElement
    ):- !.
    % Квантор общности 
    resetSingleArgumentOperationComponents
    (
        generality( _, _ ),
        generality
        (
            ParVariable,
            ParInternalElement
        ),
        ParVariable,
        ParInternalElement
    ).
    /*======================================================================*/               
    
    
    /*-----------------------------------------------------------------------/
        isMultiArgumentsOperationElement
        Проверка принадлежности к классу многоместных операций
    /------------------------------------------------------------------------/
        element ParElement - элемент многоместной операции
        determ (i)
    /-----------------------------------------------------------------------*/
    % Дизъюнкция
    isMultiArgumentsOperationElement( disjunction( _ ) ):- !.
    % Конъюнкция
    isMultiArgumentsOperationElement( conjunction( _ ) ).
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        getMultiArgumentsOperationInternalElementsList
        Получение списка внутренних элементов многоместной операции
    /------------------------------------------------------------------------/
        element ParElement - элемент унарной операции
        elementsList ParInternalElementsList - список
            внутренних элементов операции
        determ (i,o)
    /-----------------------------------------------------------------------*/
    % Дизъюнкция
    getMultiArgumentsOperationInternalElementsList
    (
        disjunction( ParInternalElementsList ),
        ParInternalElementsList        
    ):- !.
    % Конъюнкция
    getMultiArgumentsOperationInternalElementsList
    (
        conjunction( ParInternalElementsList ),
        ParInternalElementsList        
    ).
    /*======================================================================*/     
    
    
    /*-----------------------------------------------------------------------/
        resetMultiArgumentsOperationInternalElementsList
        Переустановка списка внутренних элементов многоместной операции
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент многоместной операции
        element ParElement - элемент многоместной операции   
        elementsList ParInternalElementsList - список
            внутренних элементов операции
        determ (i,o,i)
    /-----------------------------------------------------------------------*/
    % Дизъюнкция
    resetMultiArgumentsOperationInternalElementsList
    (
        disjunction( _ ),
        disjunction( ParInternalElementsList ),
        ParInternalElementsList   
    ):- !.
    % Конъюнкция
    resetMultiArgumentsOperationInternalElementsList
    (
        conjunction( _ ),
        conjunction( ParInternalElementsList ),
        ParInternalElementsList   
    ).
    /*======================================================================*/          
    
    
    /*=======================================================================/
    
      У С Т Р А Н Е Н И Е   Э К В И В А Л Е Н Т Н О С Т И   И   И М П Л И К А Ц И И 
    
    /=======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getElementWithoutEquivalencesAndImplications
        Получение элемента без эквивалентности и импликации
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElementWithoutEquivalencesAndImplications - элемент
            без эквивалентности и импликации
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если на входе предикат,
    то он не содержит эквивалентности и импликации */
    getElementWithoutEquivalencesAndImplications
    (
        ParPredicate,
        ParPredicate
    ):-
        ParPredicate = predicate( _, _ ),
        !.
    /*
    Если элемент - отрицание,
       то применяем устранение эквивалентности и импликации
            к его внутреннему элементу
       и восстанавливаем отрицание на полученном результате */
    getElementWithoutEquivalencesAndImplications
    (
        negation( ParStartElement ),
        negation( ParElement )    
    ):-
        !,
        getElementWithoutEquivalencesAndImplications
        (
            ParStartElement,
            ParElement
        ).  
    /*
    Если элемент - унарная операция - квантор,
       то применяем её к внутреннему элементу,
       а к нему применяем устранение эквивалентности и импликации
       затем в качестве результирующего унарного элемента - квантора */
    getElementWithoutEquivalencesAndImplications
    (
        ParStartElement,
        ParElementWithoutEquivalencesAndImplications
    ):-
        isSingleArgumentOperationElement( ParStartElement ),
        !,
        getSingleArgumentOperationInternalElement
        (
            ParStartElement,
            LocStartInternalElement
        ),
        getElementWithoutEquivalencesAndImplications
        (
            LocStartInternalElement,
            LocInternalElementWithoutEquivalencesAndImplications
        ),
        resetSingleArgumentOperationInternalElement
        (
            ParStartElement,
            ParElementWithoutEquivalencesAndImplications,
            LocInternalElementWithoutEquivalencesAndImplications            
        ).  
    /*
    Если элемент - многоместная операция - дизъюнкция или конъюнкция,
       то применяем ко всем её внутренним элементам,
       а к ним применяем устранение эквивалентности и импликации
       затем в качестве результирующего списка внутренних элементов */   
    getElementWithoutEquivalencesAndImplications
    (
        ParStartElement,
        ParElementWithoutEquivalencesAndImplications
    ):-
        isMultiArgumentsOperationElement( ParStartElement ), 
        !,
        getMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            LocStartInternalElementsList
        ),        
        getElementsListWithoutEquivalencesAndImplications
        (
            LocStartInternalElementsList,
            LocInternalElementsListWithoutEquivalencesAndImplications
        ),
        resetMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            ParElementWithoutEquivalencesAndImplications,
            LocInternalElementsListWithoutEquivalencesAndImplications            
        ).          
    /*
    Если элемент - импликация,
        то применяем устранение эквивалентности и импликации
            к её внутренним элементам
        и восстанавливаем импликацию в виде дизъюнкции
            с отрицанием левого и правого аргумента */
    getElementWithoutEquivalencesAndImplications
    (
        implication( ParStartLeftElement, ParStartRightElement ),
        disjunction
        (
            [
                negation( ParLeftElement ),
                ParRightElement
            ]
        )
    ):-
        !,
        getElementWithoutEquivalencesAndImplications
        (
            ParStartLeftElement,
            ParLeftElement
        ),
        getElementWithoutEquivalencesAndImplications
        (
            ParStartRightElement,
            ParRightElement
        ).              
    /*
    Если элемент - эквивалентность,
        то применяем устранение эквивалентности и импликации
            к её внутренним элементам
        и восстанавливаем эквивалентность
            в виде конъюнкции двух дизъюнкций
                с отрицанием левого и правого аргумента
            и дизъюнкции левого и правого аргумента
                с отрицанием правого аргумента */
    getElementWithoutEquivalencesAndImplications
    (
        equivalence( ParStartLeftElement, ParStartRightElement ),
        conjunction
        (
            [
                disjunction
                (
                    [
                        negation( ParLeftElement ),
                        ParRightElement
                    ]
                ),
                disjunction
                (
                    [
                        ParLeftElement,
                        negation( ParRightElement )
                    ]
                )
            ]
        )
    ):-
        !,
        getElementWithoutEquivalencesAndImplications
        (
            ParStartLeftElement,
            ParLeftElement
        ),
        getElementWithoutEquivalencesAndImplications
        (
            ParStartRightElement,
            ParRightElement
        ).                                    
    /*======================================================================*/        
            
            
    /*-----------------------------------------------------------------------/
        getElementsListWithoutEquivalencesAndImplications
        Получение списка элементов без эквивалентности и импликации
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsListWithoutEquivalencesAndImplications -
            список элементов без эквивалентности и импликации
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст или пуст,
       то возвращаем пустой результат */
    getElementsListWithoutEquivalencesAndImplications
    (
        [],
        []
    ):- !.
    /*
    В противном случае обрабатываем первый элемент устранением
        эквивалентности и импликации,
        и обрабатываем хвост с рекурсивным вызовом
            на оставшиеся элементы */
    getElementsListWithoutEquivalencesAndImplications
    (
        [
            ParStartElement
            |
            ParStartElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithoutEquivalencesAndImplicationsTail        
        ]
    ):-
        getElementWithoutEquivalencesAndImplications
        (
            ParStartElement,
            ParElement
        ),
        getElementsListWithoutEquivalencesAndImplications
        (
            ParStartElementsListTail,
            ParElementsListWithoutEquivalencesAndImplicationsTail
        ).
    /*======================================================================*/   
    

    /*=======================================================================/
    
        П Р О Д В И Ж Е Н И Е   О Т Р И Ц А Н И Я   К   Л И С Т У
    
    /=======================================================================*/


    /*-----------------------------------------------------------------------/
        getNegatedElementsList
        Получение списка отрицательных элементов
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParNegatedElementsList - список отрицательных элементов
        determ (i,o)
    /-----------------------------------------------------------------------*/   
    /*
    Если исходный список элементов пуст или пуст,
       то возвращаем пустой результат */
    getNegatedElementsList
    (
        [],
        []
    ):- !.
    /*
    Применяем операцию отрицания к каждому элементу
    в соответствии с правилом Де Моргана
    и затем рекурсивно обрабатываем хвост полученного списка
        на оставшиеся элементы */
    getNegatedElementsList
    (
        [
            ParElement
            |
            ParStartElementsListTail
        ],
        [
            negation( ParElement )
            |
            ParNegatedElementsListTail
        ]
    ):-
        getNegatedElementsList
        (
            ParStartElementsListTail,
            ParNegatedElementsListTail
        ).
    /*======================================================================*/       

    
    /*-----------------------------------------------------------------------/
        getElementWithPromotedToPredicatesNegations
        Получение элемента с отрицаниями, продвинутыми к предикатам
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElementWithPromotedToPredicatesNegations - элемент
            с отрицаниями, продвинутыми к предикатам
        determ (i,o)
    /-----------------------------------------------------------------------*/   
    /*
    Если на входе предикат,
    то он уже содержит отрицание внутри себя */     
    getElementWithPromotedToPredicatesNegations
    (
        ParPredicate,
        ParPredicate
    ):-
        ParPredicate = predicate( _, _ ),
        !.
    /*
    Двойное отрицание эквивалентно исходному выражению,
        поэтому убираем его путем удаления
        и затем его восстанавливаем */
    getElementWithPromotedToPredicatesNegations
    (
        negation( negation( ParStartElement ) ),
        ParElement
    ):-
        !,
        getElementWithPromotedToPredicatesNegations
        (
            ParStartElement,
            ParElement
        ).
    /*
    Если отрицание находится перед квантором существования,
        то преобразуем отрицание в квантор общности,
        затем применяем отрицание к подформуле
            и рекурсивно обрабатываем дальше */
    getElementWithPromotedToPredicatesNegations
    (
        negation
        (
            existence
            (
                ParVariableDomain,
                ParStartElement
            )
        ),
        generality
        (
            ParVariableDomain,
            ParElement
        )
    ):-
        !,
        getElementWithPromotedToPredicatesNegations
        (
            negation( ParStartElement ),
            ParElement
        ).  
    /*
    Если отрицание находится перед квантором общности,
        то преобразуем отрицание в квантор существования,
        затем применяем отрицание к подформуле
            и рекурсивно обрабатываем дальше */
    getElementWithPromotedToPredicatesNegations
    (
        negation
        (
            generality
            (
                ParVariableDomain,
                ParStartElement
            )
        ),
        existence
        (
            ParVariableDomain,
            ParElement
        )
    ):-
        !,
        getElementWithPromotedToPredicatesNegations
        (
            negation( ParStartElement ),
            ParElement
        ).
    /*
    Если элемент - унарная операция - квантор,
        то применяем её к внутреннему элементу,
        а к нему применяем продвижение отрицаний,
        и на выходе получаем элемент восстанавливающийся */
    getElementWithPromotedToPredicatesNegations
    (
        ParStartElement,
        ParElement
    ):-
        isSingleArgumentOperationElement( ParStartElement ),
        !,
        getSingleArgumentOperationInternalElement
        (
            ParStartElement,
            LocStartInternalElement
        ),
        getElementWithPromotedToPredicatesNegations
        (
            LocStartInternalElement,
            LocInternalElement
        ),
        resetSingleArgumentOperationInternalElement
        (
            ParStartElement,
            ParElement,
            LocInternalElement
        ).
    /*
    Если отрицание перед дизъюнкцией,
        то в результате получаем конъюнкцию,
        а к ней применяем продвижение отрицаний,
        и затем применяем к полученной дизъюнкции */
    getElementWithPromotedToPredicatesNegations
    (
        negation( disjunction( ParStartElementsList ) ),
        conjunction( ParElementsList )
    ):-
        !,
        getNegatedElementsList
        (
            ParStartElementsList,
            LocNegatedElementsList
        ),
        getElementsListWithPromotedToPredicatesNegations
        (
            LocNegatedElementsList,
            ParElementsList
        ).   
    /*
    Если отрицание перед конъюнкцией,
        то в результате получаем дизъюнкцию,
        а к ней применяем продвижение отрицаний,
        и затем применяем к полученной конъюнкции */
    getElementWithPromotedToPredicatesNegations
    (
        negation( conjunction( ParStartElementsList ) ),
        disjunction( ParElementsList )
    ):-
        !,
        getNegatedElementsList
        (
            ParStartElementsList,
            LocNegatedElementsList
        ),
        getElementsListWithPromotedToPredicatesNegations
        (
            LocNegatedElementsList,
            ParElementsList
        ).   
    /*
    Если элемент - многоместная операция - дизъюнкция или конъюнкция,
        то применяем ко всем его внутренним элементам,
        а к ним применяем продвижение отрицаний,
        и затем внутренние элементы получаем восстанавливающимися */        
    getElementWithPromotedToPredicatesNegations
    (
        ParStartElement,
        ParElement
    ):-
        isMultiArgumentsOperationElement( ParStartElement ),        
        !,
        getMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            LocStartInternalElementsList
        ),
        getElementsListWithPromotedToPredicatesNegations
        (
            LocStartInternalElementsList,
            LocInternalElementsList
        ),
        resetMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            ParElement,
            LocInternalElementsList
        ).                 
    /*
    Если отрицание над формулой,
        то к нему применяем продвижение отрицаний,
        и его восстанавливаем в виде отрицания */
    getElementWithPromotedToPredicatesNegations
    (
        negation( ParStartElement ),
        negation( ParElement )
    ):-
        getElementWithPromotedToPredicatesNegations
        (
            ParStartElement,
            ParElement
        ). 
    /*======================================================================*/                                                         
            
            
    /*-----------------------------------------------------------------------/
        getElementsListWithPromotedToPredicatesNegations
        Получение списка элементов с отрицаниями, продвинутыми к предикатам
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsListWithPromotedToPredicatesNegations -
            список элементов с отрицаниями, продвинутыми к предикатам
        determ (i,o)
    /-----------------------------------------------------------------------*/   
    /*
    Если исходный список элементов пуст или пуст,
       то возвращаем пустой результат */
    getElementsListWithPromotedToPredicatesNegations
    (
        [],
        []
    ):- !.
    /*
    В противном случае обрабатываем первый элемент продвижением отрицаний,
    и его помещаем в начало результирующего списка,
    затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getElementsListWithPromotedToPredicatesNegations
    (
        [
            ParStartElement
            |
            ParStartElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithPromotedToPredicatesNegationsTail
        ]
    ):-
        getElementWithPromotedToPredicatesNegations
        (
            ParStartElement,
            ParElement
        ),
        getElementsListWithPromotedToPredicatesNegations
        (
            ParStartElementsListTail,
            ParElementsListWithPromotedToPredicatesNegationsTail
        ).
    /*======================================================================*/
    

    /*-----------------------------------------------------------------------/
        getElementWithDirectedPredicates
        Получение элемента с направленными предикатами
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElementWithDirectedPredicates - элемент
            с направленными предикатами
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если элемент - отрицание предиката,
        то преобразуем в направленный отрицательный предикат */
    getElementWithDirectedPredicates
    (
        negation
        (
            predicate
            (
                ParName,
                ParParametersList
            )
        ),
        directedPredicateElement
        (
            negative,
            ParName,
            ParParametersList
        )
    ):- !.  
    /*
    Если элемент - предикат,
        то преобразуем в направленный положительный предикат */    
    getElementWithDirectedPredicates
    (
        predicate
        (
            ParName,
            ParParametersList
        ),
        directedPredicateElement
        (
            positive,
            ParName,
            ParParametersList
        )
    ):- !.  
    /*
    Если элемент - унарная операция - квантор,
        то применяем к его внутреннему элементу,
        где будет осуществляться продвижение отрицаний
        и затем в качестве результирующего унарного элемента */
    getElementWithDirectedPredicates
    (
        ParStartElement,
        ParElement
    ):- 
        isSingleArgumentOperationElement( ParStartElement ),        
        !,
        getSingleArgumentOperationInternalElement
        (
            ParStartElement,
            LocStartInternalElement
        ),        
        getElementWithDirectedPredicates
        (
            LocStartInternalElement,
            LocInternalElement
        ),
        resetSingleArgumentOperationInternalElement
        (
            ParStartElement,
            ParElement,
            LocInternalElement
        ).
    /*
    Если элемент - многоместная операция - дизъюнкция или конъюнкция,
        то применяем к списку его внутренних элементов,
        где будет осуществляться продвижение отрицаний
        и затем в качестве результирующего списка внутренних элементов */            
    getElementWithDirectedPredicates
    (
        ParStartElement,
        PaElement
    ):- 
        isMultiArgumentsOperationElement( ParStartElement ),
        !,
        getMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            LocStartInternalElementsList
        ),
        getElementsListWithDirectedPredicates
        (
            LocStartInternalElementsList,
            LocInternalElementsList
        ),
        resetMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            PaElement,
            LocInternalElementsList
        ).
    /*======================================================================*/     
    
    
    /*-----------------------------------------------------------------------/
        getElementsListWithDirectedPredicates
        Получение списка элементов с направленными предикатами
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsListWithDirectedPredicates - список элементов
            с направленными предикатами
        determ (i,o)
    /-----------------------------------------------------------------------*/   
    /*
    Если исходный список элементов пуст или пуст,
       то возвращаем пустой результат */
    getElementsListWithDirectedPredicates
    (
        [],
        []
    ):- !.
    /*
    В противном случае обрабатываем первый элемент продвижением направленных
        предикатов,
    и его помещаем в начало результирующего списка,
    затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getElementsListWithDirectedPredicates
    (
        [
            ParStartElement
            |
            ParStartElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListWithDirectedPredicatesTail
        ]
    ):-
        getElementWithDirectedPredicates
        (
            ParStartElement,
            ParElement
        ),
        getElementsListWithDirectedPredicates
        (
            ParStartElementsListTail,
            ParElementsListWithDirectedPredicatesTail
        ).
    /*======================================================================*/  
    
    
    /*=======================================================================/
    
        Р А Б О Т А   С О   С П И С К О М
    
    /=======================================================================*/

    
    /*-----------------------------------------------------------------------/
        stringIsInStringsList
        Проверка вхождения строки в список строк
    /------------------------------------------------------------------------/
        string ParString - строка
        stringsList ParStringsList - список строк        
        determ (i,i)
    /-----------------------------------------------------------------------*/
    /*
    В случае пустого списка строк,
        считаем что искомая строка не содержится */
    stringIsInStringsList( _, [] ):-
        !,
        fail.
    /*
    Если искомая строка - в начале списка,
        то она содержится там */
    stringIsInStringsList
    ( 
        ParString,
        [
            ParString
            |
            _
        ]
    ):- !.
    /*
    Если в начале списка строка не лежит искомая,
        то ищем её в оставшейся части */
    stringIsInStringsList
    ( 
        ParString,
        [
            _
            |
            ParStringsListTail
        ]
    ):- 
        stringIsInStringsList
        ( 
            ParString,
            ParStringsListTail
        ).
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        getNextStringInStringsList
        Получение строки, следующей за строкой в списке
    /------------------------------------------------------------------------/
        string ParString - строка
        string ParNextString - следующая строка
        stringsList ParStringsList - список строк
        string ParEmptyStringsListDeputyString - строка,
            используемая при пустом списке
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/    
    /*
    Если список пуст,
        то возвращаем строку-заместителя */
    getNextStringInStringsList
    (
        _,
        ParEmptyStringsListDeputyString,
        [],
        ParEmptyStringsListDeputyString
    ):- !.
    /*
    Если исходный список состоит из одного элемента
            (не важно, совпадает он с искомым или нет -
            просто нет за ним следующего элемента),
        то возвращаем строку-заместителя */
    getNextStringInStringsList
    (
        _,
        ParEmptyStringsListDeputyString,
        [ _ ],
        ParEmptyStringsListDeputyString
    ):- !.        
    /*
    Если в списке сразу после искомой стоит следующая строка,
        то возвращаем следующую за ней */
    getNextStringInStringsList
    (
        ParString,
        ParNextString,
        [
            ParString,
            ParNextString
            |
            _
        ],
        _
    ):- !.    
    /*
    Если в списке искомая строка, за которой следует
        не сразу искомая за ней строка,
        то переходим к следующему элементу */
    getNextStringInStringsList
    (
        ParString,
        ParNextString,
        [
            _
            |
            ParStringsListTail
        ],
        ParEmptyStringsListDeputyString
    ):- 
        getNextStringInStringsList
        (
            ParString,
            ParNextString,
            ParStringsListTail,
            ParEmptyStringsListDeputyString
        ).
    /*======================================================================*/               


    /*-----------------------------------------------------------------------/
        getNextStringOnAlphabet
        Получение строки, следующей за строкой в алфавите
    /------------------------------------------------------------------------/
        string ParString - строка
        string ParNextString - следующая строка
        symbolKind ParSymbolKind - вид символа  
        determ (i,o,i)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходная строка пуста,
        то возвращаем первую букву алфавита */
    getNextStringOnAlphabet
    (
        base::emptyString,
        ParFirstAlphabetSymbolString,
        ParSymbolKind
    ):-
        theSymbolKindAndFirstAlphabetString
        (
            ParSymbolKind,
            ParFirstAlphabetSymbolString
        ),
        !.      
    /*
    Определяем длину исходной строки,
    и если она равна единице,
        то ищем следующую за ней в заданном списке,
        а если следующего элемента в списке нет,
            то делаем строку из двух первых букв алфавита */
    getNextStringOnAlphabet
    (
        ParString,
        ParNextString,
        ParSymbolKind
    ):- 
        string5x::str_len
        (
            ParString,
            LocStringLength
        ),
        LocStringLength = 1,
        theSymbolKindAndAlphabetListAndFirstString
        (
            ParSymbolKind,
            LocAlphabetSymbolsList,
            LocFirstAlphabetSymbolString
        ),
        getNextStringInStringsList
        (
            ParString,
            ParNextString,
            LocAlphabetSymbolsList,
            LocFirstAlphabetSymbolString
        ),
        not( ParNextString = LocFirstAlphabetSymbolString ),
        !.
    /*
    Определяем длину исходной строки,
    и если она равна единице,
    и если следующей, за ней в алфавите,
        не оказалось на месте,
        (следующего элемента в списке нет)
    возвращаем строку из двух первых букв алфавита */
    getNextStringOnAlphabet
    (
        ParString,
        ParNextString,
        ParSymbolKind
    ):- 
        string5x::str_len
        (
            ParString,
            LocStringLength
        ),
        LocStringLength = 1,
        theSymbolKindAndFirstAlphabetString
        (
            ParSymbolKind,
            LocFirstAlphabetSymbolString
        ),        
        string5x::concat
        (
            LocFirstAlphabetSymbolString,
            LocFirstAlphabetSymbolString,
            ParNextString
        ),
        !.                
    /*
    Определяем длину исходной строки,
    и выделяем последний символ в отдельную строку,
    затем ищем следующий, за ним в алфавите элемент,
    и если следующего элемента в списке нет,
        то делаем строку путем приписывания
            первой буквы алфавита к начальной строке без последнего символа */
    getNextStringOnAlphabet
    (
        ParString,
        ParNextString,
        ParSymbolKind
    ):- 
        string5x::str_len
        (
            ParString,
            LocStringLength
        ),
        string5x::frontStr
        (
            LocStringLength - 1,
            ParString,
            LocStringWithoutLastSymbol,
            LocLastSymbolString
        ),
        theSymbolKindAndAlphabetListAndFirstString
        (
            ParSymbolKind,
            LocAlphabetSymbolsList,
            LocFirstAlphabetSymbolString
        ),        
        getNextStringInStringsList
        (
            LocLastSymbolString,
            LocNextLastSymbolString,
            LocAlphabetSymbolsList,
            LocFirstAlphabetSymbolString
        ),
        not( LocNextLastSymbolString = LocFirstAlphabetSymbolString ),
        string5x::concat
        (
            LocStringWithoutLastSymbol,
            LocNextLastSymbolString,
            ParNextString
        ),
        !.
    /*
    Определяем длину исходной строки,
    и последний символ исходной строки заменяем алфавитным,
    затем ищем следующий, за ним в алфавите
        последний символ исходной строки,
    и делаем строку путем приписывания начальной строки
        к первой букве алфавита
        (после чего убеждаемся, что строка, следующая за исходной
        в алфавите не совпадает с исходной - первый случай сработал) */
    getNextStringOnAlphabet
    (
        ParString,
        ParNextString,
        ParSymbolKind
    ):- 
        string5x::str_len
        (
            ParString,
            LocStringLength
        ),
        string5x::subString
        (
            ParString,
            1,
            LocStringLength - 1,
            LocStringWithoutLastSymbol
        ),
        getNextStringOnAlphabet
        (
            LocStringWithoutLastSymbol,
            LocNextStringWithoutLastSymbol,
            ParSymbolKind
        ),
        theSymbolKindAndFirstAlphabetString
        (
            ParSymbolKind,
            LocFirstAlphabetSymbolString
        ),     
        !,       
        string5x::concat
        (
            LocNextStringWithoutLastSymbol,
            LocFirstAlphabetSymbolString,
            ParNextString
        ).        
    /*======================================================================*/               

            
    /*-----------------------------------------------------------------------/
        getAlphabetSymbolsStringOutOfStringsList
        Получение уникальной строки, не содержащейся в заданном списке
    /------------------------------------------------------------------------/
        string ParStartString - исходная строка
        string ParString - строка для поиска вне списка       
        stringsList ParStringsList - список строк
        symbolKind ParSymbolKind - вид символа  
        stringsList ParCurrentPartAlphabetSymbolsList - текущая часть списка
            алфавитных символов
        determ (i,o,i,i,i)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходная строка не пуста,
        и если она не содержится в списке,
            то её и возвращаем */
    getAlphabetSymbolsStringOutOfStringsList
    (
        ParString,
        ParString,
        ParStringsList,
        _,
        _
    ):-
        not( ParString = base::emptyString ),
        not
        (
            stringIsInStringsList
            (
                ParString,
                ParStringsList
            )
        ),
        !.
    /*
    Если текущая часть алфавитного списка пуста
            (при данном начале построения строки конструировать,
            добавляя к ней символы алфавита,
            уже все перебрали
            и попали в заданный список строк),
        то продолжаем путь от следующей на алфавите начальной строки
        и в качестве начальной части текущего
            списка алфавитных символов - весь алфавит */
    getAlphabetSymbolsStringOutOfStringsList
    (
        ParStartString,
        ParString,
        ParStringsList,
        ParSymbolKind,
        []
    ):-
        getNextStringOnAlphabet
        (
            ParStartString,
            LocNextOnAlphabetStartString,
            ParSymbolKind
        ),
        theSymbolsKindAndAlphabetList
        (
            ParSymbolKind,
            LocAlphabetSymbolsList
        ),
        getAlphabetSymbolsStringOutOfStringsList
        (
            LocNextOnAlphabetStartString,
            ParString,
            ParStringsList,
            ParSymbolKind,
            LocAlphabetSymbolsList
        ),
        !.        
    /*
    Пробуем соединить начальную строку с текущим символом алфавита
        и смотрим полученную строку,
    и если полученная строка не содержится в заданном списке,
        то её возвращаем */
    getAlphabetSymbolsStringOutOfStringsList
    (
        ParStartString,
        ParString,
        ParStringsList,
        _,
        [
            ParCurrentAlphabetSymbolString
            |
            _
        ]
    ):-
        string5x::concat
        (
            ParStartString,
            ParCurrentAlphabetSymbolString,
            ParString
        ),
        not
        (
            stringIsInStringsList
            (
                ParString,
                ParStringsList
            )
        ),
        !.    
    /*
    Продолжаем перебор символов в пределах текущего алфавита
        или переходим к следующей начальной строке
    Увеличиваем соответствующий индекс -
        текущая часть списка алфавитных символов сокращается
        на один рассмотренный элемент */
    getAlphabetSymbolsStringOutOfStringsList
    (
        ParStartString,
        ParString,
        ParStringsList,
        ParSymbolKind,
        [
            _
            |
            ParCurrentPartAlphabetSymbolsListTail
        ]
    ):-
        getAlphabetSymbolsStringOutOfStringsList
        (
            ParStartString,
            ParString,
            ParStringsList,
            ParSymbolKind,
            ParCurrentPartAlphabetSymbolsListTail
        ),
        !.            
    /*======================================================================*/               
            
            
    /*-----------------------------------------------------------------------/
        getAlphabetSymbolsStringOutOfStringsList
        Получение уникальной строки, не содержащейся в заданном списке
    /------------------------------------------------------------------------/
        stringsList ParStringsList - список строк    
        string ParString - строка для поиска вне списка 
        symbolKind ParSymbolKind - вид символа        
        determ (i,o,i)
    /-----------------------------------------------------------------------*/ 
    /*
    Получаем строку, не содержащуюся в заданном списке
    для пустой начальной строки
    и в качестве начальной части всего алфавитного списка */
    getAlphabetSymbolsStringOutOfStringsList
    (
        ParStringsList,
        ParString,
        ParSymbolKind
    ):-
        theSymbolsKindAndAlphabetList
        (
            ParSymbolKind,
            LocAlphabetSymbolsList
        ),
        !,
        getAlphabetSymbolsStringOutOfStringsList
        (
            base::emptyString,
            ParString,
            ParStringsList,
            ParSymbolKind,
            LocAlphabetSymbolsList
        ).
    /*======================================================================*/         
                
                
    /*-----------------------------------------------------------------------/
        getReplacedAlphabetSymbolsStringOutOfStringsList
        Получение уникальной строки, отличной от содержащихся
        в списке
    /------------------------------------------------------------------------/
        string ParStartString - исходная строка 
        string ParReplacedString - строка, отличная от содержащихся
            в списке
        stringsList ParStringsList - список строк  
        symbolKind ParSymbolKind - вид символа         
        procedure (i,o,i,i)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходная строка содержится в списке,
        то подбираем новую строку в качестве замены для нее */
    getReplacedAlphabetSymbolsStringOutOfStringsList
    (
        ParStartString,
        ParReplacedString,
        ParStringsList,
        ParSymbolKind
    ):-
        stringIsInStringsList
        (
            ParStartString,
            ParStringsList
        ),
        getAlphabetSymbolsStringOutOfStringsList
        (
            ParStringsList,
            ParReplacedString,
            ParSymbolKind
        ),
        !.       
    /*
    Исходная строка не содержится в списке,
    поэтому её и возвращаем */
    getReplacedAlphabetSymbolsStringOutOfStringsList
    (
        ParReplacedString,
        ParReplacedString,
        _,
        _
    ).
    /*======================================================================*/                     
    
    
    /*=======================================================================/
    
        З А М Е Н А   П А Р А М Е Т Р А
    
    /=======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getParametersListWithReplacedParameter
        Получение списка параметров с заменой параметра
    /------------------------------------------------------------------------/
        parametersList ParOldParametersList - старый список параметров
        parametersList ParParametersList - новый список параметров    
        parameterDomain ParOldParameter - старый параметр
        parameterDomain ParParameter - параметр
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/      
    /*
    Если старый список параметров пуст или пуст, 
        то возвращаем пустой результат параметров */
    getParametersListWithReplacedParameter
    (
        [],
        [],    
        _,
        _
    ):- !.
    /*
    Если заменяемый параметр совпадает с заменяющим,
        то возвращаем список без изменений */
    getParametersListWithReplacedParameter
    (
        ParParametersList,
        ParParametersList,    
        ParParameter,
        ParParameter
    ):- !.               
    /*
    Если в начале списка искомый параметр,
        то его заменяем сразу,
        и дальше список остается без изменений,
            так как в списке не может быть повторяющихся элементов */
    getParametersListWithReplacedParameter
    (
        [
            ParOldParameter
            |
            ParParametersListTail
        ],
        [
            ParParameter
            |
            ParParametersListTail
        ],
        ParOldParameter,
        ParParameter        
    ):- !.      
    /*
    В начале списка параметр, отличный от искомого,
    поэтому рекурсивно применяем замену к хвосту */
    getParametersListWithReplacedParameter
    (
        [
            ParSomeParameter
            |
            ParOldParametersListTail
        ],
        [
            ParSomeParameter
            |
            ParParametersListTail
        ],
        ParOldParameter,
        ParParameter        
    ):- 
        getParametersListWithReplacedParameter
        (
            ParOldParametersListTail,
            ParParametersListTail,
            ParOldParameter,
            ParParameter            
        ).         
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getElementWithReplacedParameter
        Получение элемента с заменой параметра
    /------------------------------------------------------------------------/
        element ParOldElement - старый элемент
        element ParElement - элемент    
        parameterDomain ParOldParameter - старый параметр
        parameterDomain ParParameter - параметр
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/      
    /*
    Если заменяемый параметр совпадает с заменяющим,
        то возвращаем элемент без изменений */
    getElementWithReplacedParameter
    (
        ParElement,
        ParElement,
        ParParameter,
        ParParameter
    ):- !.   
    /*
    Если элемент - направленный предикат,
       то заменяем параметр в его внутреннем списке параметров */
    getElementWithReplacedParameter
    (
        directedPredicateElement
        (
            ParPredicateDirection,
            ParName,
            ParStartParametersList
        ),
        directedPredicateElement
        (
            ParPredicateDirection,
            ParName,
            ParParametersList
        ),
        ParOldParameter,
        ParParameter        
    ):-      
        getParametersListWithReplacedParameter
        (
            ParStartParametersList,
            ParParametersList,        
            ParOldParameter,
            ParParameter
        ),
        !.
    /*
    Если элемент - унарная операция - квантор,
        то применяем к его внутреннему элементу,
            если только затрагиваемое выражение не содержит параметр,
        применяем замену в связанной переменной и в его внутреннем элементе
        и восстанавливаем элемент с его внутренними компонентами */
    getElementWithReplacedParameter
    (
        ParOldElement,
        ParElement,    
        ParOldParameter,
        ParParameter
    ):-      
        isSingleArgumentOperationElement( ParOldElement ),
        getSingleArgumentOperationComponents
        (
            ParOldElement,
            LocOldVariable,
            LocOldInternalElement
        ),
        LocOldVariable = variable( LocOldVariableName ),
        getParametersListWithReplacedParameter
        (
            [ variableParameter( LocOldVariableName ) ],
            LocVariableParametersList,        
            ParOldParameter,
            ParParameter
        ),
        LocVariableParametersList =
            [ variableParameter( LocVariableName ) ],
        getElementWithReplacedParameter
        (
            LocOldInternalElement,
            LocInternalElement,        
            ParOldParameter,
            ParParameter
        ),
        resetSingleArgumentOperationComponents
        (
            ParOldElement,
            ParElement,
            variable( LocVariableName ),
            LocInternalElement
        ),
        !.
    /*
    Если элемент - многоместная операция -
            дизъюнкция или конъюнкция,
        то применяем замену к его внутренним элементам */
    getElementWithReplacedParameter
    (
        ParOldElement,
        ParElement,    
        ParOldParameter,
        ParParameter
    ):-      
        isMultiArgumentsOperationElement( ParOldElement ),
        getMultiArgumentsOperationInternalElementsList
        (
            ParOldElement,
            LocOldInternalElementsList
        ),
        getElementsListWithReplacedParameter
        (
            LocOldInternalElementsList,
            LocInternalElementsList,
            ParOldParameter,
            ParParameter            
        ),
        resetMultiArgumentsOperationInternalElementsList
        (
            ParOldElement,
            ParElement,
            LocInternalElementsList
        ).        
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getElementsListWithReplacedParameter
        Получение списка элементов с заменой параметра
    /------------------------------------------------------------------------/
        elementsList ParOldElementsList - старый список элементов
        elementsList ParElementsList - новый список элементов
        parameterDomain ParOldParameter - старый параметр
        parameterDomain ParParameter - параметр
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/  
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getElementsListWithReplacedParameter
    (
        [],
        [],
        _,
        _
    ):- !.   
    /*
    Если заменяемый параметр совпадает с заменяющим,
        то возвращаем список без изменений */
    getElementsListWithReplacedParameter
    (
        ParElementsList,
        ParElementsList,
        ParParameter,
        ParParameter
    ):- !.       
    /*
    Применяем замену к первому элементу списка
    и рекурсивно к хвосту,
    затем рекурсивно вызываем процедуру на оставшиеся элементы */
    getElementsListWithReplacedParameter
    (
        [
            ParOldElement
            |
            ParOldElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListTail
        ],
        ParOldParameter,
        ParParameter
    ):- 
        getElementWithReplacedParameter
        (
            ParOldElement,
            ParElement,
            ParOldParameter,
            ParParameter            
        ),
        getElementsListWithReplacedParameter
        (
            ParOldElementsListTail,
            ParElementsListTail,
            ParOldParameter,
            ParParameter            
        ).
    /*======================================================================*/                    
    
    
    /*=======================================================================/
    
        Р А С Щ Е П Л Е Н И Е   К В А Н Т О Р О В   И   П Е Р Е М Е Н Н Ы Х
    
    /=======================================================================*/    

 
    /*-----------------------------------------------------------------------/
        getElementWithSplitedQuantifiersVariables
        Получение элемента с расщепленными кванторными переменными,
        при этом имена входящих в него связанных переменных уникальны
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElement - элемент с расщепленными переменными
        stringsList ParStartUsedVariablesNamesList - исходный список уже
            использованных имен переменных
        stringsList ParUsedVariablesNamesList - список уже
            использованных имен переменных            
        determ (i,o,i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный - направленный предикат,
        то возвращаем его без изменений */
    getElementWithSplitedQuantifiersVariables
    (
        ParDirectedPredicate,
        ParDirectedPredicate,        
        ParUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):- 
        ParDirectedPredicate = directedPredicateElement( _, _, _ ),
        !.
    /*
    Если квантор - унарная операция - квантор,
        то применяем к его внутреннему элементу,
        и в качестве новой переменной квантора берем имя,
            которое, не содержится в списке использованных ранее,
        и если это имя совпадает с именем
                (то есть оно уже в списке),
            то его вносим в список использованных имен переменных,
            и восстанавливаем квантор на полученном результате,
            затем рекурсивно вызываем процедуру
                с оставшимися необработанными элементами */
    getElementWithSplitedQuantifiersVariables
    (
        ParStartElement,
        ParElement,
        ParStartUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):-
        isSingleArgumentOperationElement( ParStartElement ),
        getSingleArgumentOperationComponents
        (
            ParStartElement,
            LocStartVariable,
            LocStartInternalElement
        ),
        LocStartVariable = variable( LocStartVariableName ),
        getReplacedAlphabetSymbolsStringOutOfStringsList
        (
            LocStartVariableName,
            LocVariableName,
            ParStartUsedVariablesNamesList,
            lower
        ),
        LocStartVariableName = LocVariableName,
        getElementWithSplitedQuantifiersVariables
        (
            LocStartInternalElement,
            LocInternalElement,
            [
                LocStartVariableName
                |
                ParStartUsedVariablesNamesList
            ],
            ParUsedVariablesNamesList
        ),
        resetSingleArgumentOperationInternalElement
        (
            ParStartElement,
            ParElement,
            LocInternalElement
        ),
        !.
    /*
    Если квантор - унарная операция - квантор,
        то применяем к его внутреннему элементу,
        и в качестве новой связанной переменной квантора берем имя,
            не содержащееся в списке использованных ранее,
        затем применяем замену квантора на новую переменную
            и затем во внутреннем элементе,
        затем применяем замену переменной в подформуле,
        после чего в ней рекурсивно расщепляем переменные,
            при этом новое имя переменной заносится в список
            использованных имен переменных
        и затем рекурсивно вызываем процедуру с остальными элементами */
    getElementWithSplitedQuantifiersVariables
    (
        ParStartElement,
        ParElement,
        ParStartUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):-
        isSingleArgumentOperationElement( ParStartElement ),
        getSingleArgumentOperationComponents
        (
            ParStartElement,
            LocStartVariable,
            LocStartInternalElement
        ),
        LocStartVariable = variable( LocStartVariableName ),
        getReplacedAlphabetSymbolsStringOutOfStringsList
        (
            LocStartVariableName,
            LocVariableName,
            ParStartUsedVariablesNamesList,
            lower
        ),
        LocStartVariableParameter = variableParameter( LocStartVariableName ),
        LocVariableParameter = variableParameter( LocVariableName ),
        getElementWithReplacedParameter
        (
            LocStartInternalElement,
            LocInternalElementWithReplacedParameter,
            LocStartVariableParameter,
            LocVariableParameter
        ),        
        getElementWithSplitedQuantifiersVariables
        (
            LocInternalElementWithReplacedParameter,
            LocInternalElementWithSplitedVariables,
            [
                LocVariableName
                |
                ParStartUsedVariablesNamesList
            ],
            ParUsedVariablesNamesList
        ),
        resetSingleArgumentOperationComponents
        (
            ParStartElement,
            ParElement,
            variable( LocVariableName ),
            LocInternalElementWithSplitedVariables
        ),
        !.
    /*
    Если исходный - многоместная операция - дизъюнкция или конъюнкция,
        то применяем к его внутренним элементам,
        работая с каждым внутренним элементом по очереди,
        и затем внутренние элементы получаем восстанавливающимися */
    getElementWithSplitedQuantifiersVariables
    (
        ParStartElement,
        ParElement,
        ParStartUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):-
        isMultiArgumentsOperationElement( ParStartElement ),
        getMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            ParStartInternalElementsList
        ),
        getElementsListWithSplitedQuantifiersVariables
        (
            ParStartInternalElementsList,
            ParInternalElementsList,
            ParStartUsedVariablesNamesList,
            ParUsedVariablesNamesList
        ),
        resetMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            ParElement,
            ParInternalElementsList
        ).
    /*======================================================================*/                   
    
    
    /*-----------------------------------------------------------------------/
        getElementsListWithSplitedQuantifiersVariables
        Получение списка элементов с расщепленными кванторными переменными,
        при этом имена входящих в него связанных переменных уникальны
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsList - новый список элементов
            с расщепленными переменными
        stringsList ParStartUsedVariablesNamesList - исходный список уже
            использованных имен переменных
        stringsList ParUsedVariablesNamesList - новый список уже
            использованных имен переменных                        
        determ (i,o,i,o)
    /-----------------------------------------------------------------------*/     
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getElementsListWithSplitedQuantifiersVariables
    (
        [],
        [],
        ParUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):- !.
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getElementsListWithSplitedQuantifiersVariables
    (
        [
            ParStartElement
            |
            ParStartElementsList
        ],
        [
            ParElement
            |
            ParElementsList
        ],
        ParStartVariablesNamesList,
        ParUsedVariablesNamesList
    ):-
        getElementWithSplitedQuantifiersVariables
        (
            ParStartElement,
            ParElement,
            ParStartVariablesNamesList,
            LocElementWithSplitedVariablesUsedVariablesNamesList
        ),
        getElementsListWithSplitedQuantifiersVariables
        (
            ParStartElementsList,
            ParElementsList,
            LocElementWithSplitedVariablesUsedVariablesNamesList,
            ParUsedVariablesNamesList 
        ).
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getElementWithSplitedQuantifiersVariables
        Получение элемента с расщепленными кванторными переменными,
        при этом имена входящих в него связанных переменных уникальны
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElement - элемент с расщепленными переменными
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Получаем элемент с расщепленными кванторами,
    при этом исходный список использованных имен переменных пуст */
    getElementWithSplitedQuantifiersVariables
    (
        ParStartElement,
        ParElement
    ):-
        getElementWithSplitedQuantifiersVariables
        (
            ParStartElement,
            ParElement,
            [],
            _
        ).
    /*======================================================================*/ 
    
    
    /*=======================================================================/
    
        С К О Л Е М И З А Ц И Я  -  исключение кванторов существования
    
    /=======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getElementPredicatesNamesStringsList
        Получение списка имен для предикатных констант
    /------------------------------------------------------------------------/
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для предикатов            
        element ParElement - элемент        
        determ (i,o,i)
    /-----------------------------------------------------------------------*/            
    /*
    Если элемент - направленный предикат,
        то если его имя еще не в списке для накопления, 
            то его и добавляем */
    getElementPredicatesNamesStringsList
    (
        ParStartStringsList,
        [
            ParPredicateName
            |
            ParStartStringsList
        ],
        directedPredicateElement
        (
            _,
            ParPredicateName,
            _
        )        
    ):-
        not
        (
            stringIsInStringsList
            (
                ParPredicateName,
                ParStartStringsList
            )
        ),
        !.
    /*
    Если элемент - направленный предикат,
    и его имя уже есть в списке для накопления, 
        то его и не добавляем */
    getElementPredicatesNamesStringsList
    (
        ParStringsList,
        ParStringsList,
        directedPredicateElement( _, _, _ )        
    ):- !.    
    /*
    Если элемент - унарная операция - квантор,
        то к его внутреннему элементу применяем предикат,
        и затем получаем результат в нем
        и результирующий список имен от его обработки */
    getElementPredicatesNamesStringsList
    (
        ParStartStringsList,
        ParStringsList,
        ParElement        
    ):-
        isSingleArgumentOperationElement( ParElement ),
        getSingleArgumentOperationInternalElement
        (
            ParElement,
            LocInternalElement
        ),
        getElementPredicatesNamesStringsList
        (
            ParStartStringsList,
            ParStringsList,
            LocInternalElement
        ),
        !.     
    /*
    Если элемент - многоместная операция - дизъюнкция или конъюнкция,
        то к его внутренним элементам применяем предикат,
        и затем получаем результат в них
        и результирующий список имен от их обработки */
    getElementPredicatesNamesStringsList
    (
        ParStartStringsList,
        ParStringsList,
        ParElement
    ):-
        isMultiArgumentsOperationElement( ParElement ),
        getMultiArgumentsOperationInternalElementsList
        (
            ParElement,
            LocInternalElementsList
        ),
        getElementsListPredicatesNamesStringsList
        (
            ParStartStringsList,
            ParStringsList,
            LocInternalElementsList
        ),
        !.             
    /*======================================================================*/        
       
 
    /*-----------------------------------------------------------------------/
        getElementsListPredicatesNamesStringsList
        Получение списка имен для предикатных констант списка элементов
    /------------------------------------------------------------------------/
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для предикатов            
        elementsList ParElementsList - список элементов        
        determ (i,o,i)
    /-----------------------------------------------------------------------*/            
    /*
    Если исходный список элементов для обработки пуст,
        возвращаем список для накопления неизменным */
    getElementsListPredicatesNamesStringsList
    (
        ParStringsList,
        ParStringsList,
        []        
    ):- !.
    /*
    В противном случае обрабатываем первый элемент списка элементов,
        затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getElementsListPredicatesNamesStringsList
    (
        ParStartStringsList,
        ParStringsList,
        [
            ParElement
            |
            ParElementsListTail
        ]        
    ):-
        getElementPredicatesNamesStringsList
        (
            ParStartStringsList,
            LocStringsListWithGotElementPredicatesNames,
            ParElement
        ),
        getElementsListPredicatesNamesStringsList
        (
            LocStringsListWithGotElementPredicatesNames,
            ParStringsList,
            ParElementsListTail        
        ).    
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getElementPredicatesNamesStringsList
        Получение списка имен для предикатных констант элемента
    /------------------------------------------------------------------------/
        stringsList ParStringsList - новый список имен для предикатов            
        element ParElement - элемент        
        determ (o,i)
    /-----------------------------------------------------------------------*/
    /*
    Получение списка имен для предикатных констант элемента 
        при пустом исходном списке для накопления */
    getElementPredicatesNamesStringsList
    (
        ParStringsList,
        ParElement
    ):-
        getElementPredicatesNamesStringsList
        (
            [],
            ParStringsList,
            ParElement
        ).
    /*======================================================================*/    


    /*-----------------------------------------------------------------------/
        getElementVariablesNamesStringsList
        Получение списка имен для переменных элемента
    /------------------------------------------------------------------------/
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для переменных            
        element ParElement - элемент        
        determ (i,o,i)
    /-----------------------------------------------------------------------*/            
    /*
    Если элемент - направленный предикат,
        то имена переменных, содержащиеся в его списке параметров,
        и рекурсивно собираем */
    getElementVariablesNamesStringsList
    (
        ParStringsList,
        ParStringsList,
        directedPredicateElement( _, _, _ )
    ):- !.
    /*
    Если элемент - унарная операция - квантор,
        то к его внутреннему элементу применяем,
        и если его связанная переменная не содержится
                в списке для накопления,
            то ее тоже заносим в список для накопления
            и рекурсивно собираем список имен для переменных
                от внутреннего элемента */
    getElementVariablesNamesStringsList
    (
        ParStartStringsList,
        ParStringsList,
        ParElement        
    ):-
        isSingleArgumentOperationElement( ParElement ),
        getSingleArgumentOperationComponents
        (
            ParElement,
            LocVariable,
            LocInternalElement
        ),
        LocVariable = variable( LocVariableName ),        
        not
        (
            stringIsInStringsList
            (
                LocVariableName,
                ParStartStringsList
            )
        ),        
        getElementVariablesNamesStringsList
        (
            [
                LocVariableName
                |
                ParStartStringsList
            ],
            ParStringsList,
            LocInternalElement
        ),
        !.         
    /*
    Если элемент - унарная операция - квантор,
        то к его внутреннему элементу применяем,
            (его связанная переменная уже содержится
            в списке для накопления),
        и рекурсивно собираем список имен для переменных
                от внутреннего элемента */
    getElementVariablesNamesStringsList
    (
        ParStartStringsList,
        ParStringsList,
        ParElement        
    ):-
        isSingleArgumentOperationElement( ParElement ),
        getSingleArgumentOperationInternalElement
        (
            ParElement,
            LocInternalElement
        ),
        getElementVariablesNamesStringsList
        (
            ParStartStringsList,
            ParStringsList,
            LocInternalElement
        ),
        !.     
    /*
    Если элемент - многоместная операция - дизъюнкция или конъюнкция,
        то к его внутренним элементам применяем предикат,
        и затем получаем результат в них
        и результирующий список имен от их обработки */
    getElementVariablesNamesStringsList
    (
        ParStartStringsList,
        ParStringsList,
        ParElement
    ):-
        isMultiArgumentsOperationElement( ParElement ),
        getMultiArgumentsOperationInternalElementsList
        (
            ParElement,
            LocInternalElementsList
        ),
        getElementsListVariablesNamesStringsList
        (
            ParStartStringsList,
            ParStringsList,
            LocInternalElementsList
        ),
        !.             
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        getElementsListVariablesNamesStringsList
        Получение списка имен для переменных списка элементов
    /------------------------------------------------------------------------/
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для переменных            
        elementsList ParElementsList - список элементов        
        determ (i,o,i)
    /-----------------------------------------------------------------------*/            
    /*
    Если исходный список элементов для обработки пуст,
        возвращаем список для накопления неизменным */
    getElementsListVariablesNamesStringsList
    (
        ParStringsList,
        ParStringsList,
        []        
    ):- !.
    /*
    В противном случае обрабатываем первый элемент списка элементов,
        затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getElementsListVariablesNamesStringsList
    (
        ParStartStringsList,
        ParStringsList,
        [
            ParElement
            |
            ParElementsListTail
        ]        
    ):-
        getElementVariablesNamesStringsList
        (
            ParStartStringsList,
            LocStringsListWithGotElementVariablesNames,
            ParElement
        ),
        getElementsListVariablesNamesStringsList
        (
            LocStringsListWithGotElementVariablesNames,
            ParStringsList,
            ParElementsListTail        
        ).    
    /*======================================================================*/      
    
    
    /*-----------------------------------------------------------------------/
        getElementVariablesNamesStringsList
        Получение списка имен для переменных элемента
    /------------------------------------------------------------------------/
        stringsList ParStringsList - новый список имен для переменных            
        element ParElement - элемент        
        determ (o,i)
    /-----------------------------------------------------------------------*/
    /*
    Получение списка имен для переменных элемента 
        при пустом исходном списке для накопления */
    getElementVariablesNamesStringsList
    (
        ParStringsList,
        ParElement
    ):-
        getElementVariablesNamesStringsList
        (
            [],
            ParStringsList,
            ParElement
        ).
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        getElementWithoutExistenceQuantifiers
        Получение элемента без кванторов существования
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElement - элемент без кванторов существования
        stringsList ParStartTitleStrinsList - исходный список строк,
            используемых в качестве констант
        stringsList ParTitleStrinsList - новый список строк, используемых
            в качестве констант
        stringsList ParStartLowerStrinsList - исходный список строк,
            используемых на сколемовские функции
        stringsList ParLowerStrinsList - новый список строк, используемых
            на сколемовские функции 
        variablesList ParExternalGeneralityQuantifiersVariablesList - список
            переменных внешних кванторов общности
        determ (i,o,i,o,i,o,i)
    /-----------------------------------------------------------------------*/
    /*
    Если элемент - направленный предикат,
        то он не содержит кванторов существования,
        поэтому его и возвращаем,
        а списки констант и сколемовских функций не изменяются */
    getElementWithoutExistenceQuantifiers
    (
        ParElement,
        ParElement,        
        ParTitleStrinsList,
        ParTitleStrinsList,
        ParLowerStrinsList,
        ParLowerStrinsList,
        _
    ):-
        ParElement = directedPredicateElement( _, _, _ ),
        !.
    /*
    Если элемент - квантор общности,
        то применяем преобразование квантора к внутренней формуле
            данного квантора,
        и добавляем переменную квантора во внешний список,
        который будет использоваться в сколемовских функциях */    
    getElementWithoutExistenceQuantifiers
    (
        generality
        (
            ParVariable,
            ParStartInternalElement
        ),
        generality
        (
            ParVariable,
            ParInternalElement
        ),        
        ParStartTitleStrinsList,
        ParTitleStrinsList,
        ParStartLowerStrinsList,
        ParLowerStrinsList,
        ParExternalGeneralityQuantifiersVariablesList
    ):-
        getElementWithoutExistenceQuantifiers
        (
            ParStartInternalElement,
            ParInternalElement,
            ParStartTitleStrinsList,
            ParTitleStrinsList,
            ParStartLowerStrinsList,
            ParLowerStrinsList,
            [
                ParVariable
                |
                ParExternalGeneralityQuantifiersVariablesList
            ]
        ),
        !.    
    /*
    Если элемент - квантор существования,
        то если список внешних кванторов общности пуст,
            то применяем преобразование квантора в константу
                    для сколемовской константы (функции без аргументов),
                        которую нужно получить
                        и добавить в список констант,
                которая больше не используется нигде,
            затем применяем к внутреннему элементу замену переменной
                квантора на полученную константу,
            и затем обрабатываем результат квантора существования,
                при этом новое имя константы заносится в список констант,
                а сколемовские функции остаются без изменений,
            и в итоге возвращаем результат квантора существования,
                уже не содержащий квантор вообще,
            рекурсивно обрабатываемый тем же самым способом существования */
    getElementWithoutExistenceQuantifiers
    (
        existence
        (
            variable( ParVariableName ),
            ParStartInternalElement
        ),
        ParInternalElement,
        ParStartTitleStrinsList,
        ParTitleStrinsList,
        ParStartLowerStrinsList,
        ParLowerStrinsList,
        []
    ):-
        getAlphabetSymbolsStringOutOfStringsList
        (
            ParStartTitleStrinsList,
            LocConstantName,
            title
        ),
        getElementWithReplacedParameter
        (
            ParStartInternalElement,
            LocInternalElementWithReplacedParameter,
            variableParameter( ParVariableName ),
            constantParameter( LocConstantName )
        ),
        getElementWithoutExistenceQuantifiers
        (
            LocInternalElementWithReplacedParameter,
            ParInternalElement,
            [
                LocConstantName
                |
                ParStartTitleStrinsList
            ],
            ParTitleStrinsList,
            ParStartLowerStrinsList,
            ParLowerStrinsList,
            []
        ),
        !.
    /*
    Если элемент - квантор существования
            (список внешних кванторов общности не пуст),
        то применяем преобразование квантора в функцию
                для сколемовской функции, ее имя должно быть получено
                и добавлено в список функций,
                а ее аргументы - список внешних кванторов,
            которая больше не используется в других местах,
        затем применяем к внутреннему элементу замену переменной
            квантора на полученную функцию,
        затем применяем к внутреннему элементу замену переменной
            квантора на сколемовскую функцию, построенную по внешним
                кванторам общности,
        и затем обрабатываем результат квантора существования,
            при этом новое имя функции заносится в список функций,
            а константы остаются без изменений,
        и в итоге возвращаем результат квантора существования,
            уже не содержащий квантор вообще,
        рекурсивно обрабатываемый тем же самым способом существования */
    getElementWithoutExistenceQuantifiers
    (
        existence
        (
            variable( ParVariableName ),
            ParStartInternalElement
        ),
        ParInternalElement,
        ParStartTitleStrinsList,
        ParTitleStrinsList,
        ParStartLowerStrinsList,
        ParLowerStrinsList,
        ParExternalGeneralityQuantifiersVariablesList
    ):-
        getAlphabetSymbolsStringOutOfStringsList
        (
            ParStartLowerStrinsList,
            LocFunctionName,
            lower
        ),
        getElementWithReplacedParameter
        (
            ParStartInternalElement,
            LocInternalElementWithReplacedParameter,
            variableParameter( ParVariableName ),
            functionParameter
            (
                LocFunctionName,
                ParExternalGeneralityQuantifiersVariablesList
            )
        ),
        getElementWithoutExistenceQuantifiers
        (
            LocInternalElementWithReplacedParameter,
            ParInternalElement,
            ParStartTitleStrinsList,
            ParTitleStrinsList,
            [
                LocFunctionName
                |
                ParStartLowerStrinsList
            ],
            ParLowerStrinsList,
            ParExternalGeneralityQuantifiersVariablesList
        ),
        !.      
    /*
    Если элемент - многоместная операция - дизъюнкция или конъюнкция,
        то применяем к его внутренним элементам,
        и преобразуем кванторы существования в них,
        а затем их восстанавливаем в виде многоместной операции */    
    getElementWithoutExistenceQuantifiers
    (
        ParStartElement,
        ParElement,        
        ParStartTitleStrinsList,
        ParTitleStrinsList,
        ParStartLowerStrinsList,
        ParLowerStrinsList,
        ParExternalGeneralityQuantifiersVariablesList
    ):-
        isMultiArgumentsOperationElement( ParStartElement ),
        getMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            LocStartInternalElementsList
        ),        
        getElementsListWithoutExistenceQuantifiers
        (
            LocStartInternalElementsList,
            LocInternalElementsList,
            ParStartTitleStrinsList,
            ParTitleStrinsList,
            ParStartLowerStrinsList,
            ParLowerStrinsList,
            ParExternalGeneralityQuantifiersVariablesList
        ),
        resetMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            ParElement,
            LocInternalElementsList
        ).    
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        getElementsListWithoutExistenceQuantifiers
        Получение списка элементов без кванторов существования
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список формул
        elementsList ParElementsList - новый список элементов
            без кванторов существования
        stringsList ParStartTitleStrinsList - исходный список строк,
            используемых в качестве констант
        stringsList ParTitleStrinsList - новый список строк, используемых
            в качестве констант
        stringsList ParStartLowerStrinsList - исходный список строк,
            используемых на сколемовские функции
        stringsList ParLowerStrinsList - новый список строк, используемых
            на сколемовские функции 
        variablesList ParExternalGeneralityQuantifiersVariablesList - список
            переменных внешних кванторов общности
        determ (i,o,i,o,i,o,i)
    /-----------------------------------------------------------------------*/   
    /*
    Если исходный список элементов пуст или пуст,
       то возвращаем пустой результат,
       и списки возвращаем неизменными в исходном состоянии */
    getElementsListWithoutExistenceQuantifiers
    (
        [],
        [],        
        ParTitleStrinsList,
        ParTitleStrinsList,
        ParLowerStrinsList,
        ParLowerStrinsList,
        _
    ):- !.    
    /*
    В противном случае обрабатываем первый элемент списка преобразованием
        кванторов существования,
    а затем рекурсивно обрабатываем оставшиеся элементы списка,
        причем результаты обработки первого элемента
        передаются как исходные данные для обработки хвоста,
        при этом обновляются оба списка констант */
    getElementsListWithoutExistenceQuantifiers
    (
        [
            ParStartElement
            |
            ParStartElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListTail
        ],
        ParStartTitleStrinsList,
        ParTitleStrinsList,
        ParStartLowerStrinsList,
        ParLowerStrinsList,
        ParExternalGeneralityQuantifiersVariablesList
    ):- 
        getElementWithoutExistenceQuantifiers
        (
            ParStartElement,
            ParElement,        
            ParStartTitleStrinsList,
            LocElementWithoutExistenceQuantifiersTitleStrinsList,
            ParStartLowerStrinsList,
            LocElementWithoutExistenceQuantifiersLowerStrinsList,
            ParExternalGeneralityQuantifiersVariablesList
        ),
        getElementsListWithoutExistenceQuantifiers
        (
            ParStartElementsListTail,
            ParElementsListTail,        
            LocElementWithoutExistenceQuantifiersTitleStrinsList,
            ParTitleStrinsList,
            LocElementWithoutExistenceQuantifiersLowerStrinsList,
            ParLowerStrinsList,
            ParExternalGeneralityQuantifiersVariablesList
        ).           
    /*======================================================================*/     
    
    
    /*-----------------------------------------------------------------------/
        getElementWithoutExistenceQuantifiers
        Получение элемента без кванторов существования
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElement - элемент без кванторов существования
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Получаем имя для констант и функций из предикатных символов,
    получаем имя для переменных из списка переменных,
    обрабатываем элемент без кванторов существования
        при пустых списках констант и функций
        и пустом списке внешних кванторов общности */
    getElementWithoutExistenceQuantifiers
    (
        ParStartElement,
        ParElement
    ):-
        getElementPredicatesNamesStringsList
        (
            LocStartTitleStrinsList,
            ParStartElement
        ),
        getElementVariablesNamesStringsList
        (
            LocStartLowerStrinsList,
            ParStartElement
        ),
        getElementWithoutExistenceQuantifiers
        (
            ParStartElement,
            ParElement,
            LocStartTitleStrinsList,
            _,
            LocStartLowerStrinsList,
            _,
            []
        ).
    /*======================================================================*/     
    
    
    /*=======================================================================/
    
        ПРЕОБРАЗОВАНИЯ  С   Э Л И М И Н А Ц И Е Й   КВАНТОРОВ ОБЩНОСТИ
    
    /=======================================================================*/   
     
     
    /*-----------------------------------------------------------------------/
        getElementWithoutGeneralityQuantifiers
        Получение элемента без кванторов общности 
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElement - элемент без кванторов общности
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если элемент - направленный предикат,
        то он не содержит кванторов общности,
        поэтому его и возвращаем */
    getElementWithoutGeneralityQuantifiers
    (
        ParElement,
        ParElement
    ):-
        ParElement = directedPredicateElement( _, _, _ ),
        !.
    /*
    Если элемент - квантор общности,
        то применяем преобразование квантора к его внутреннему элементу,
        который будет восстанавливаться */    
    getElementWithoutGeneralityQuantifiers
    (
        generality
        (
            _,
            ParStartInternalElement
        ),
        ParInternalElement
    ):-
        getElementWithoutGeneralityQuantifiers
        (
            ParStartInternalElement,
            ParInternalElement
        ),
        !.    
    /*
    Если элемент - многоместная операция - дизъюнкция или конъюнкция,
        то применяем к его внутренним элементам,
        и преобразуем кванторы общности в них,
        а затем их восстанавливаем в виде многоместной операции */    
    getElementWithoutGeneralityQuantifiers
    (
        ParStartElement,
        ParElement
    ):-
        isMultiArgumentsOperationElement( ParStartElement ),
        getMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            LocStartInternalElementsList
        ),        
        getElementsListWithoutGeneralityQuantifiers
        (
            LocStartInternalElementsList,
            LocInternalElementsList
        ),
        resetMultiArgumentsOperationInternalElementsList
        (
            ParStartElement,
            ParElement,
            LocInternalElementsList
        ).           
    /*======================================================================*/      
    
    
    /*-----------------------------------------------------------------------/
        getElementsListWithoutGeneralityQuantifiers
        Получение списка элементов без кванторов общности
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список формул
        elementsList ParElementsList - новый список элементов без кванторов общности
        determ (i,o)
    /-----------------------------------------------------------------------*/   
    /*
    Если исходный список элементов пуст или пуст,
       то возвращаем пустой результат */
    getElementsListWithoutGeneralityQuantifiers
    (
        [],
        []
    ):- !.    
    /*
    В противном случае обрабатываем первый элемент списка преобразованием
        кванторов общности,
        затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getElementsListWithoutGeneralityQuantifiers
    (
        [
            ParStartElement
            |
            ParStartElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListTail
        ]
    ):- 
        getElementWithoutGeneralityQuantifiers
        (
            ParStartElement,
            ParElement
        ),
        getElementsListWithoutGeneralityQuantifiers
        (
            ParStartElementsListTail,
            ParElementsListTail
        ).           
    /*======================================================================*/                      
            
            
    /*-----------------------------------------------------------------------/
        concatenateElementsLists
        Конкатенация первого и второго списков элементов в третий
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
        getElementWithoutEmbeddedMultiArgumentsOperations
        Получение элемента без вложенных многоместных операций   
    /------------------------------------------------------------------------/        
        element ParElement - исходный элемент
        element ParElementWithoutEmbeddedMultiArgumentsOperations - элемент
            без вложенных многоместных операций   
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если элемент - направленный предикат,
        то он не содержит вложенных многоместных операций,
        поэтому возвращаем его */
    getElementWithoutEmbeddedMultiArgumentsOperations
    (
        ParDirectedPredicate,
        ParDirectedPredicate
    ):-
        ParDirectedPredicate = directedPredicateElement( _, _, _ ),
        !.
    /*
    Если элемент - дизъюнкция,
        то к его внутреннему списку элементов применяем
            преобразование дизъюнкции */
    getElementWithoutEmbeddedMultiArgumentsOperations
    (
        disjunction( ParStartInternalElementsList ),
        disjunction( ParInternalElementsList )
    ):-
        getElementsListWithoutEmbeddedDisjunctions
        (
            ParStartInternalElementsList,
            ParInternalElementsList
        ),
        !.        
    /*
    Если элемент - конъюнкция,
        то к его внутреннему списку элементов применяем
            преобразование конъюнкции */
    getElementWithoutEmbeddedMultiArgumentsOperations
    (
        conjunction( ParStartInternalElementsList ),
        conjunction( ParInternalElementsList )
    ):-
        getElementsListWithoutEmbeddedConjunctions
        (
            ParStartInternalElementsList,
            ParInternalElementsList
        ),
        !.                
    /*======================================================================*/     
    
    
    /*-----------------------------------------------------------------------/
        getElementsListWithoutEmbeddedDisjunctions
        Получение списка элементов без вложенных дизъюнкций
    /------------------------------------------------------------------------/        
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithoutEmbeddedDisjunctions - список
            элементов без вложенных дизъюнкций   
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст,
       то возвращаем пустой результат */
    getElementsListWithoutEmbeddedDisjunctions
    (
        [],
        []
    ):- !.
    /*
    Если в начале списка встречается дизъюнкция,
        то обрабатываем внутренние элементы дизъюнкции на наличие дизъюнкций
        и их рекурсивно помещаем в начало
        и далее хвост обрабатывается так же, как и исходный список элементов,
            с соответствующим рекурсивным вызовом */
    getElementsListWithoutEmbeddedDisjunctions
    (
        [
            disjunction( ParInternalElementsList )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmbeddedDisjunctions
    ):-
        getElementsListWithoutEmbeddedDisjunctions
        (
            ParInternalElementsList,
            LocInternalElementsListWithoutEmbeddedDisjunctions
        ),
        getElementsListWithoutEmbeddedDisjunctions
        (
            ParElementsListTail,
            LocElementsListWithoutEmbeddedDisjunctionsTail
        ),
        concatenateElementsLists
        (
            LocInternalElementsListWithoutEmbeddedDisjunctions,
            LocElementsListWithoutEmbeddedDisjunctionsTail,
            ParElementsListWithoutEmbeddedDisjunctions
        ),
        !.    
    /*
    Если в начале списка встречается элемент, не являющийся дизъюнкцией,
        то к нему применяем преобразование вложенных многоместных операций
        и его помещаем в начало результирующего списка
        и рекурсивно обрабатываем хвост на оставшиеся элементы */
    getElementsListWithoutEmbeddedDisjunctions
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParElementWithoutEmbeddedMultiArgumentsOperations
            |
            ParElementsListWithoutEmbeddedDisjunctionsTail
        ]        
    ):-
        getElementWithoutEmbeddedMultiArgumentsOperations
        (
            ParElement,
            ParElementWithoutEmbeddedMultiArgumentsOperations
        ),
        getElementsListWithoutEmbeddedDisjunctions
        (
            ParElementsListTail,
            ParElementsListWithoutEmbeddedDisjunctionsTail
        ).              
    /*======================================================================*/            
    
    
    /*-----------------------------------------------------------------------/
        getElementsListWithoutEmbeddedConjunctions
        Получение списка элементов без вложенных конъюнкций
    /------------------------------------------------------------------------/        
        elementsList ParElementsList - исходный список элементов
        elementsList ParElementsListWithoutEmbeddedConjunctions - список
            элементов без вложенных конъюнкций   
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список элементов пуст,
       то возвращаем пустой результат */
    getElementsListWithoutEmbeddedConjunctions
    (
        [],
        []
    ):- !.
    /*
    Если в начале списка встречается конъюнкция,
        то обрабатываем внутренние элементы конъюнкции на наличие конъюнкций
        и их рекурсивно помещаем в начало
        и далее хвост обрабатывается так же, как и исходный список элементов,
            с соответствующим рекурсивным вызовом */
    getElementsListWithoutEmbeddedConjunctions
    (
        [
            conjunction( ParInternalElementsList )
            |
            ParElementsListTail
        ],
        ParElementsListWithoutEmbeddedConjunctions
    ):-
        getElementsListWithoutEmbeddedConjunctions
        (
            ParInternalElementsList,
            LocInternalElementsListWithoutEmbeddedConjunctions
        ),
        getElementsListWithoutEmbeddedConjunctions
        (
            ParElementsListTail,
            LocElementsListWithoutEmbeddedConjunctionsTail
        ),
        concatenateElementsLists
        (
            LocInternalElementsListWithoutEmbeddedConjunctions,
            LocElementsListWithoutEmbeddedConjunctionsTail,
            ParElementsListWithoutEmbeddedConjunctions
        ),
        !.    
    /*
    Если в начале списка встречается элемент, не являющийся конъюнкцией,
        то к нему применяем преобразование вложенных многоместных операций
        и его помещаем в начало результирующего списка
        и рекурсивно обрабатываем хвост на оставшиеся элементы */
    getElementsListWithoutEmbeddedConjunctions
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        [
            ParElementWithoutEmbeddedMultiArgumentsOperations
            |
            ParElementsListWithoutEmbeddedConjunctionsTail
        ]        
    ):-
        getElementWithoutEmbeddedMultiArgumentsOperations
        (
            ParElement,
            ParElementWithoutEmbeddedMultiArgumentsOperations
        ),
        getElementsListWithoutEmbeddedConjunctions
        (
            ParElementsListTail,
            ParElementsListWithoutEmbeddedConjunctionsTail
        ).              
    /*======================================================================*/                
    

    /*=======================================================================/
    
        ПРЕОБРАЗОВАНИЯ  В   К О Н Ь Ю Н К Т И В Н У Ю   НОРМАЛЬНУЮ ФОРМУ
    
    /=======================================================================*/  

    
    /*-----------------------------------------------------------------------/
        splitElementsListUpToFirstConjunctionAndRestElementsLists
        Получение списка из внутреннего списка первой встречной конъюнкции
        и оставшегося списка элементов
    /------------------------------------------------------------------------/        
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParFirstConjunctionInternalElementsList - список
            внутренних элементов первой конъюнкции
        elementsList ParRestElementsList - список оставшихся элементов
            после первой конъюнкции
        determ (i,o,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если исходный список элементов пуст,
       то возвращаем пустые оба списка */
    splitElementsListUpToFirstConjunctionAndRestElementsLists
    (
        [],
        [],
        []
    ):- !.
    /*
    Если в списке встречается первая встречная конъюнкция,
        то расщепляем в соответствии с внутренним списком конъюнкции,
        а остаток списка возвращаем как хвост */
    splitElementsListUpToFirstConjunctionAndRestElementsLists
    (
        [
            conjunction( ParFirstConjunctionInternalElementsList )
            |
            ParRestElementsList
        ],
        ParFirstConjunctionInternalElementsList,
        ParRestElementsList
    ):- !.    
    /*
    Если в списке встречается первый элемент - предикат,
        то его помещаем в начало списка оставшихся элементов,
        и рекурсивно обрабатываем хвост на оставшиеся элементы */
    splitElementsListUpToFirstConjunctionAndRestElementsLists
    (
        [
            ParDirectedPredicate
            |
            ParStartElementsListTail
        ],
        ParFirstConjunctionInternalElementsList,
        [
            ParDirectedPredicate
            |
            ParRestElementsListTail
        ]
    ):-
        ParDirectedPredicate = directedPredicateElement( _, _, _ ),
        splitElementsListUpToFirstConjunctionAndRestElementsLists
        (
            ParStartElementsListTail,
            ParFirstConjunctionInternalElementsList,
            ParRestElementsListTail
        ).
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getConjunctionElementsListFromDisjunctsAndConjunctsElementsLists
        Получение конъюнктивного списка элементов
        из дизъюнктов и конъюнктов, между которыми стоит знак конъюнкции
        (в соответствии дистрибутивностью) и результирующих конъюнктов
    /------------------------------------------------------------------------/        
        elementsList ParFirstInternalConjunctionElementsList - список
            внутренних элементов первой конъюнкции
        elementsList ParRestDisjunctionElementsList - список
            оставшихся элементов после первой конъюнкции
        elementsList ParConjunctionElementsList - новый список элементов
        determ (i,i,o)
    /-----------------------------------------------------------------------*/        
    /*
    Если исходный список внутренних элементов конъюнкции пуст или пуст,
       то возвращаем пустой список */    
    getConjunctionElementsListFromDisjunctsAndConjunctsElementsLists
    (
        [],
        _,
        []
    ):- !.
    /*
    Из первого элемента списка внутренних конъюнкции строим дизъюнкт
    в соответствии с правилом дистрибутивности дизъюнкции,
    а затем строим дизъюнкцию из этого дизъюнкта и остатка
        списка дизъюнктивных элементов,
    и рекурсивно вызываем процедуру для хвоста
           первого списка внутренних конъюнкции */
    getConjunctionElementsListFromDisjunctsAndConjunctsElementsLists
    (
        [
            ParInternalConjunctionElement
            |
            ParFirstInternalConjunctionElementsListTail
        ],
        ParRestDisjunctionElementsList,
        [
            disjunction
            (
                [
                    ParInternalConjunctionElement
                    |
                    ParRestDisjunctionElementsList
                ]
            )
            |
            ParConjunctionElementsListTail
        ]
    ):- 
        getConjunctionElementsListFromDisjunctsAndConjunctsElementsLists
        (
            ParFirstInternalConjunctionElementsListTail,
            ParRestDisjunctionElementsList,
            ParConjunctionElementsListTail
        ).
    /*======================================================================*/    
    
 
    /*-----------------------------------------------------------------------/
        getConjunctionElementsListFromElement
        Получение конъюнктивного списка элементов из элемента
    /------------------------------------------------------------------------/        
        element ParElement - элемент
        elementsList ParConjunctionElementsList - новый список элементов
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если элемент - предикат,
        то он помещается в список как отдельный элемент - предикат,
            ибо он уже не содержит вложенных многоместных операций */       
    getConjunctionElementsListFromElement
    (
        ParDirectedPredicate,
        [ ParDirectedPredicate ]
    ):-
        ParDirectedPredicate = directedPredicateElement( _, _, _ ),
        !.    
    /*
    Если элемент - дизъюнкция,
        то применяем преобразование к дизъюнктивному элементу
            из списка дизъюнктов и конъюнктов,
        и если первый элемент списка дизъюнктов пуст,
        то его помещаем в начало списка - дизъюнкцию,
            которая возвращается конъюнкцией как дизъюнкция */
    getConjunctionElementsListFromElement
    (
        ParDisjunction,
        [ ParDisjunction ]
    ):-
        ParDisjunction = disjunction( LocElementsList ),    
        splitElementsListUpToFirstConjunctionAndRestElementsLists
        (
            LocElementsList,
            LocFirstConjunctionInternalElementsList,
            _
        ),
        LocFirstConjunctionInternalElementsList = [],
        !.
    /*
    Если элемент - дизъюнкция,
        то применяем преобразование к дизъюнктивному элементу
            из списка дизъюнктов и конъюнктов,
        затем применяем дистрибутивность с конъюнктивной нормальной формой:
            из ее первого элемента строим дизъюнкцию,
            затем остальные - список остальных дизъюнктивных элементов,
        затем строим список конъюнктов из полученного на предыдущем шаге,
            каждый из которых будет иметь вид дизъюнкции или предиката,
        и затем рекурсивно собираем список конъюнктов
            в конъюнктивную нормальную форму
        и на выходе список возвращаем */
    getConjunctionElementsListFromElement
    (
        disjunction( ParElementsList ),
        ParConjunctionElementsList     
    ):-
        splitElementsListUpToFirstConjunctionAndRestElementsLists
        (
            ParElementsList,
            LocFirstConjunctionInternalElementsList,
            LocRestDisjunctionElementsList
        ),
        getConjunctionElementsListFromDisjunctsAndConjunctsElementsLists
        (
            LocFirstConjunctionInternalElementsList,
            LocRestDisjunctionElementsList,
            LocConjunctionElementsListFromDisjunctsAndConjunctsElementsLists
        ),
        getElementsListWithoutEmbeddedConjunctions
        (
            LocConjunctionElementsListFromDisjunctsAndConjunctsElementsLists,
            LocConjunctionElementsListWithoutEmbeddedConjunctions
        ),
        getConjunctionElementsListFromElementsList
        (
            LocConjunctionElementsListWithoutEmbeddedConjunctions,
            ParConjunctionElementsList
        ),        
        !.
    /*
    Если элемент - конъюнкция,
        то работаем с каждым элементом в конъюнктивной нормальной форме
        и на выходе список возвращаем */
    getConjunctionElementsListFromElement
    (
        conjunction( ParElementsList ),
        ParConjunctionElementsList     
    ):-
        getConjunctionElementsListFromElementsList
        (
            ParElementsList,
            ParConjunctionElementsList
        ).
    /*======================================================================*/   
    
    
    /*-----------------------------------------------------------------------/
        getConjunctionElementsListFromElementsList
        Получение конъюнктивного списка элементов из списка элементов
    /------------------------------------------------------------------------/        
        elementsList ParElementsList - список элементов
        elementsList ParConjunctionElementsList - новый список элементов
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходный список элементов пуст,
       то возвращаем пустой список */
    getConjunctionElementsListFromElementsList
    (
        [],
        []
    ):- !.         
    /*
    Если в списке встречается конъюнкция,
        то обрабатываем внутренние элементы конъюнкции на наличие конъюнкций
        и их рекурсивно помещаем в начало
        и далее хвост обрабатывается так же, как и исходный список элементов,
            с соответствующим рекурсивным вызовом */
    getConjunctionElementsListFromElementsList
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        ParConjunctionElementsList
    ):-
        getConjunctionElementsListFromElement
        (
            ParElement,
            LocConjunctionElementsListFromElement
        ),
        getConjunctionElementsListFromElementsList
        (
            ParElementsListTail,
            LocConjunctionElementsListTail
        ),
        concatenateElementsLists
        (
            LocConjunctionElementsListFromElement,
            LocConjunctionElementsListTail,
            ParConjunctionElementsList
        ).        
    /*======================================================================*/  
    
    
    /*=======================================================================/
    
        В С П О М О Г А Т Е Л Ь Н Ы Е   П Р Е Д И К А Т Ы
    
    /=======================================================================*/

        
    /*-----------------------------------------------------------------------/
        getIndexedStringOutOfStringsList
        Получение строки с индексом на конце,
        не содержащейся в заданном списке
    /------------------------------------------------------------------------/
        string ParStartString - исходная строка с начальным индексом
        string ParString - результирующая строка для поиска вне списка       
        stringsList ParStringsList - список строк
        core::integer32 ParIndex - текущий индекс в начальной строке
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/ 
    /*
    Если исходная строка не содержится в списке,
            то её и возвращаем */
    getIndexedStringOutOfStringsList
    (
        ParString,
        ParString,
        ParStringsList,
        _
    ):-
        not
        (
            stringIsInStringsList
            (
                ParString,
                ParStringsList
            )
        ),
        !.
    /*
    Пробуем соединить начальную строку с текущим индексом
        и смотрим полученную строку,
    и если полученная строка не содержится в заданном списке,
        то её возвращаем */
    getIndexedStringOutOfStringsList
    (
        ParStartString,
        ParString,
        ParStringsList,
        ParIndex
    ):-        
        string5x::concat
        (
            ParStartString,
            toString( ParIndex ),
            ParString
        ),
        not
        (
            stringIsInStringsList
            (
                ParString,
                ParStringsList
            )
        ),
        !.    
    /*
    Продолжаем перебор символов с увеличением индекса
        или переходим к следующей начальной строке
    Увеличиваем соответствующий индекс -
        пробуем следующий по порядку индекс */
    getIndexedStringOutOfStringsList
    (
        ParStartString,
        ParString,
        ParStringsList,
        ParIndex
    ):-
        getIndexedStringOutOfStringsList
        (
            ParStartString,
            ParString,
            ParStringsList,
            ParIndex + 1
        ),
        !.            
    /*======================================================================*/               
            
            
    /*-----------------------------------------------------------------------/
        getIndexedStringOutOfStringsList
        Получение строки с индексом на конце,
        не содержащейся в заданном списке
    /------------------------------------------------------------------------/
        string ParStartString - исходная строка с начальным индексом
        string ParString - результирующая строка для поиска вне списка       
        stringsList ParStringsList - список строк
        determ (i,o,i)
    /-----------------------------------------------------------------------*/ 
    /*
    Получение строки с индексом на конце, не содержащейся в заданном списке    
    в качестве начального, равным единице */
    getIndexedStringOutOfStringsList
    (
        ParStartString,
        ParString,
        ParStringsList
    ):-
        getIndexedStringOutOfStringsList
        (
            ParStartString,
            ParString,
            ParStringsList,
            1
        ).
    /*======================================================================*/             
         
         
    /*-----------------------------------------------------------------------/
        getVariablesListVariablesNamesStringsList
        Получение списка вспомогательных имен для переменных
        из списка переменных
    /------------------------------------------------------------------------/
        variablesList ParVariablesList - список переменных
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для переменных
        determ (i,i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список переменных пуст или пуст,
        то возвращаем в качестве результата список накопленных имен,
            которые не вошли в результирующий список для накопления */
    getVariablesListVariablesNamesStringsList
    (
        [],
        ParStringsList,
        ParStringsList
    ):- !.
    /*
    В противном случае обрабатываем очередную переменную,
    содержащуюся в нем,
    и если ее имя не содержится в исходном списке имен для переменных,
        то его и добавляем в список,
        и затем рекурсивно обрабатываем хвост исходного списка,
            добавляя его имя в список для накопления, увеличивая его размер */
    getVariablesListVariablesNamesStringsList
    (
        [
            variable( ParVariableName )
            |
            ParVariablesListTail
        ],
        ParStartStringsList,
        ParStringsList
    ):-
        not
        (
            stringIsInStringsList
            (
                ParVariableName,
                ParStartStringsList
            )
        ),
        getVariablesListVariablesNamesStringsList
        (
            ParVariablesListTail,
            [
                ParVariableName
                |
                ParStartStringsList
            ],
            ParStringsList
        ),
        !.
    /*
    Для переменной из списка если уже есть в списке накопления,
        просто ее и не добавляем,
    и рекурсивно обрабатываем хвост исходного списка переменных */
    getVariablesListVariablesNamesStringsList
    (
        [
            _
            |
            ParVariablesListTail
        ],
        ParStartStringsList,
        ParStringsList
    ):-
        getVariablesListVariablesNamesStringsList
        (
            ParVariablesListTail,
            ParStartStringsList,
            ParStringsList
        ),
        !.    
    /*======================================================================*/           
    
    
    /*-----------------------------------------------------------------------/
        getParametersListVariablesNamesStringsList
        Получение списка вспомогательных имен для переменных
        из списка параметров
    /------------------------------------------------------------------------/
        parametersList ParParametersList - список параметров
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для переменных
        determ (i,i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если список параметров пуст или пуст,
        то возвращаем в качестве результата список накопленных имен,
            которые не вошли в результирующий список для накопления */
    getParametersListVariablesNamesStringsList
    (
        [],
        ParStringsList,
        ParStringsList
    ):- !.    
    /*
    Если в списке встречается переменная,
        то применяем к ней,
        и если ее имя не содержится в исходном списке имен для переменных,
            то его и добавляем в список,
            и затем рекурсивно обрабатываем хвост исходного списка
                    параметров,
                добавляя его имя в список для накопления,
                    увеличивая его размер */
    getParametersListVariablesNamesStringsList
    (
        [
            variableParameter( ParVariableName )
            |
            ParParametersListTail
        ],
        ParStartStringsList,
        ParStringsList
    ):-
        not
        (
            stringIsInStringsList
            (
                ParVariableName,
                ParStartStringsList
            )
        ),
        getParametersListVariablesNamesStringsList
        (
            ParParametersListTail,
            [
                ParVariableName
                |
                ParStartStringsList
            ],
            ParStringsList
        ),
        !.    
    /*
    Если в списке встречается функция,
        то применяем к ее параметрам,
        и к тем переменным, которые еще не содержатся в исходном списке,
            применяем к ним,
        затем рекурсивно обрабатываем хвост исходного списка параметров,
            добавляя их имена в список для накопления, увеличивая его размер */
    getParametersListVariablesNamesStringsList
    (
        [
            functionParameter( _, ParFunctionVariablesList )
            |
            ParParametersListTail
        ],
        ParStartStringsList,
        ParStringsList
    ):-
        getVariablesListVariablesNamesStringsList
        (
            ParFunctionVariablesList,
            ParStartStringsList,
            LocStringsListWithFunctionVariablesNames
        ),
        getParametersListVariablesNamesStringsList
        (
            ParParametersListTail,
            LocStringsListWithFunctionVariablesNames,
            ParStringsList
        ),
        !.            
    /*
    Если в списке встречается константа, не являющаяся переменной,
            или параметр, который уже есть в списке накопления,
        то рекурсивно обрабатываем хвост исходного списка параметров */
    getParametersListVariablesNamesStringsList
    (
        [
            _
            |
            ParParametersListTail
        ],
        ParStartStringsList,
        ParStringsList
    ):-
        getParametersListVariablesNamesStringsList
        (
            ParParametersListTail,
            ParStartStringsList,
            ParStringsList
        ).   
    /*======================================================================*/             
             
             
    /*-----------------------------------------------------------------------/
        getConjunctionElementVariablesNamesStringsList
        Получение списка вспомогательных имен для переменных из элемента
    /------------------------------------------------------------------------/
        element ParElement - элемент
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для переменных
        determ (i,i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Если в начале списка встречается направленный предикат,
        то ищем переменные в его параметрах и добавляем в список */
    getConjunctionElementVariablesNamesStringsList
    (
        directedPredicateElement( _, _, ParParametersList ),
        ParStartStringsList,
        ParStringsList
    ):-
        getParametersListVariablesNamesStringsList
        (
            ParParametersList,
            ParStartStringsList,
            ParStringsList
        ),
        !.
    /*
    Если в начале списка встречается направленная дизъюнкция,
        то ищем переменные в ее элементах и списке */
    getConjunctionElementVariablesNamesStringsList
    (
        disjunction( ParElementsList ),
        ParStartStringsList,
        ParStringsList
    ):-
        getConjunctionElementsListVariablesNamesStringsList
        (
            ParElementsList,
            ParStartStringsList,
            ParStringsList
        ),
        !.    
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/
        getConjunctionElementsListVariablesNamesStringsList
        Получение списка вспомогательных имен для переменных
        из списка элементов
    /------------------------------------------------------------------------/
        elementsList ParElementsList - список элементов
        stringsList ParStartStringsList - исходный список строк
            для накопления
        stringsList ParStringsList - новый список имен для переменных
        determ (i,i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список элементов пуст или пуст,
        то возвращаем в качестве результата список накопленных имен,
            которые не вошли в результирующий список для накопления */
    getConjunctionElementsListVariablesNamesStringsList
    (
        [],
        ParStringsList,
        ParStringsList
    ):- !.    
    /*
    Если список элементов пуст или пуст,
        то возвращаем в качестве результата список накопленных имен,
            которые не вошли в результирующий список для накопления */
    getConjunctionElementsListVariablesNamesStringsList
    (
        [
            ParElement
            |
            ParElementsListTail
        ],
        ParStartStringsList,
        ParStringsList
    ):-
        getConjunctionElementVariablesNamesStringsList
        (
            ParElement,
            ParStartStringsList,
            LocStringsListWithElementVariablesNames
        ),
        getConjunctionElementsListVariablesNamesStringsList
        (
            ParElementsListTail,
            LocStringsListWithElementVariablesNames,
            ParStringsList
        ).
    /*======================================================================*/         
                    
                    
    /*-----------------------------------------------------------------------/
        getConjunctionElementVariablesNamesStringsList
        Получение списка вспомогательных имен для переменных из элемента
    /------------------------------------------------------------------------/
        element ParElement - элемент
        stringsList ParStringsList - новый список имен для переменных
        determ (i,o)
    /-----------------------------------------------------------------------*/ 
    /*
    Получение списка вспомогательных имен для переменных из элемента
    в исходном списке для накопления пустого списка */
    getConjunctionElementVariablesNamesStringsList
    (
        ParElement,
        ParStringsList
    ):-
        getConjunctionElementVariablesNamesStringsList
        (
            ParElement,
            [],
            ParStringsList
        ).
    /*======================================================================*/
    

    /*=======================================================================/
    
        З А М Е Н А   П Е Р Е М Е Н Н О Й
    
    /=======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getVariablesListWithReplacedVariable
        Получение списка переменных с заменой переменной
    /------------------------------------------------------------------------/
        variablesList ParOldVariablesList - старый список переменных
        variablesList ParVariablesList - новый список переменных    
        variableDomain ParOldVariable - старая переменная
        variableDomain ParVariable - переменная
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/      
    /*
    Если старый список переменных пуст или пуст, 
        то возвращаем пустой результат переменных */
    getVariablesListWithReplacedVariable
    (
        [],
        [],    
        _,
        _
    ):- !.
    /*
    Если заменяемая переменная совпадает с заменяющей,
        то возвращаем список без изменений */
    getVariablesListWithReplacedVariable
    (
        ParVariablesList,
        ParVariablesList,    
        ParVariable,
        ParVariable
    ):- !.               
    /*
    Если в начале списка искомая переменная,
        то её заменяем сразу,
        и дальше список остается без изменений,
            так как в списке не может быть повторяющихся элементов */
    getVariablesListWithReplacedVariable
    (
        [
            ParOldVariable
            |
            ParVariablesListTail
        ],
        [
            ParVariable
            |
            ParVariablesListTail
        ],
        ParOldVariable,
        ParVariable        
    ):- !.      
    /*
    В начале списка переменная, отличная от искомой,
    поэтому рекурсивно применяем замену к хвосту */
    getVariablesListWithReplacedVariable
    (
        [
            ParSomeVariable
            |
            ParOldVariablesListTail
        ],
        [
            ParSomeVariable
            |
            ParVariablesListTail
        ],
        ParOldVariable,
        ParVariable        
    ):- 
        getVariablesListWithReplacedVariable
        (
            ParOldVariablesListTail,
            ParVariablesListTail,
            ParOldVariable,
            ParVariable            
        ).         
    /*======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        getParametersListWithReplacedVariable
        Получение списка параметров с заменой переменной
    /------------------------------------------------------------------------/
        parametersList ParOldParametersList - старый список параметров
        parametersList ParParametersList - новый список параметров    
        variableDomain ParOldVariable - старая переменная
        variableDomain ParVariable - переменная
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/      
    /*
    Если старый список параметров пуст или пуст, 
        то возвращаем пустой результат параметров */
    getParametersListWithReplacedVariable
    (
        [],
        [],    
        _,
        _
    ):- !.
    /*
    Если заменяемая переменная совпадает с заменяющей,
        то возвращаем список без изменений */
    getParametersListWithReplacedVariable
    (
        ParParametersList,
        ParParametersList,    
        ParVariable,
        ParVariable
    ):- !.               
    /*
    Если в начале списка искомая переменная,
        то ее заменяем сразу,
        и затем весь список параметров обрабатываем рекурсивно дальше */
    getParametersListWithReplacedVariable
    (
        [
            variableParameter( ParOldVariableName )
            |
            ParOldParametersListTail
        ],
        [
            variableParameter( ParVariableName )
            |
            ParParametersListTail
        ],
        ParOldVariable,
        ParVariable       
    ):-
        ParOldVariable = variable( ParOldVariableName ),
        ParVariable = variable( ParVariableName ),
        getParametersListWithReplacedVariable
        (
            ParOldParametersListTail,
            ParParametersListTail,
            ParOldVariable,
            ParVariable
        ),
        !.
    /*
    Если в списке функция,
        то работаем с ее внутренним списком переменных по очереди,
        и ее помещаем в начало результирующего списка,
        и затем весь список параметров обрабатываем рекурсивно дальше */
    getParametersListWithReplacedVariable
    (
        [
            functionParameter( ParFunctionName, ParOldVariablesList )
            |
            ParOldParametersListTail
        ],
        [
            functionParameter( ParFunctionName, ParVariablesList )
            |
            ParParametersListTail
        ],
        ParOldVariable,
        ParVariable       
    ):-
        getVariablesListWithReplacedVariable
        (
            ParOldVariablesList,
            ParVariablesList,
            ParOldVariable,
            ParVariable
        ),
        getParametersListWithReplacedVariable
        (
            ParOldParametersListTail,
            ParParametersListTail,
            ParOldVariable,
            ParVariable
        ),
        !.
    /*
    В начале списка параметр, отличный от искомого, или константа,
        но не содержащийся в начале результирующего списка,
        и затем весь список параметров обрабатываем рекурсивно дальше */
    getParametersListWithReplacedVariable
    (
        [
            ParSomeVariableParameter
            |
            ParOldParametersListTail
        ],
        [
            ParSomeVariableParameter
            |
            ParParametersListTail
        ],
        ParOldVariable,
        ParVariable        
    ):- 
        getParametersListWithReplacedVariable
        (
            ParOldParametersListTail,
            ParParametersListTail,
            ParOldVariable,
            ParVariable            
        ).         
    /*======================================================================*/
        
    
    /*-----------------------------------------------------------------------/
        getElementWithReplacedVariable
        Получение элемента с заменой переменной
    /------------------------------------------------------------------------/
        element ParOldElement - старый элемент
        element ParElement - элемент    
        variableDomain ParOldVariable - старая переменная
        variableDomain ParVariable - переменная
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/      
    /*
    Если заменяемая переменная совпадает с заменяющей,
        то возвращаем элемент без изменений */
    getElementWithReplacedVariable
    (
        ParElement,
        ParElement,
        ParVariable,
        ParVariable
    ):- !.   
    /*
    Если элемент - направленный предикат,
       то заменяем переменную в его внутреннем списке параметров */
    getElementWithReplacedVariable
    (
        directedPredicateElement
        (
            ParPredicateDirection,
            ParName,
            ParStartParametersList
        ),
        directedPredicateElement
        (
            ParPredicateDirection,
            ParName,
            ParParametersList
        ),
        ParOldVariable,
        ParVariable        
    ):-      
        getParametersListWithReplacedVariable
        (
            ParStartParametersList,
            ParParametersList,        
            ParOldVariable,
            ParVariable
        ),
        !.
    /*
    Если элемент - дизъюнкция,
        то заменяем переменную в его внутренних элементах */
    getElementWithReplacedVariable
    (
        disjunction( ParOldElementsList ),
        disjunction( ParElementsList ),
        ParOldVariable,
        ParVariable
    ):-      
        getElementsListWithReplacedVariable
        (
            ParOldElementsList,
            ParElementsList,
            ParOldVariable,
            ParVariable            
        ).        
    /*======================================================================*/
    

    /*-----------------------------------------------------------------------/
        getElementsListWithReplacedVariable
        Получение списка элементов с заменой переменной
    /------------------------------------------------------------------------/
        elementsList ParOldElementsList - старый список элементов
        elementsList ParElementsList - новый список элементов
        variableDomain ParOldVariable - старая переменная
        variableDomain ParVariable - переменная
        determ (i,o,i,i)
    /-----------------------------------------------------------------------*/  
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getElementsListWithReplacedVariable
    (
        [],
        [],
        _,
        _
    ):- !.   
    /*
    Если заменяемая переменная совпадает с заменяющей,
        то возвращаем список без изменений */
    getElementsListWithReplacedVariable
    (
        ParElementsList,
        ParElementsList,
        ParVariable,
        ParVariable
    ):- !.       
    /*
    Применяем замену к первому элементу списка
    и рекурсивно к хвосту,
    затем рекурсивно вызываем процедуру на оставшиеся элементы */
    getElementsListWithReplacedVariable
    (
        [
            ParOldElement
            |
            ParOldElementsListTail
        ],
        [
            ParElement
            |
            ParElementsListTail
        ],
        ParOldVariable,
        ParVariable
    ):- 
        getElementWithReplacedVariable
        (
            ParOldElement,
            ParElement,
            ParOldVariable,
            ParVariable            
        ),
        getElementsListWithReplacedVariable
        (
            ParOldElementsListTail,
            ParElementsListTail,
            ParOldVariable,
            ParVariable            
        ).
    /*======================================================================*/  


    /*=======================================================================/
    
        Р А С Щ Е П Л Е Н И Е   П Е Р Е М Е Н Н Ы Х   В   К О Н Ь Ю Н К Т Е
    
    /=======================================================================*/    

 
    /*-----------------------------------------------------------------------/
        getConjunctionElementWithSplitedVariables
        Получение элемента конъюнкта с расщепленными переменными
    /------------------------------------------------------------------------/
        element ParStartElement - исходный элемент
        element ParElement - элемент с расщепленными переменными
        stringsList ParElementVariablesNamesList - список имен переменных
            данного конъюнкта
        stringsList ParStartUsedVariablesNamesList - исходный список уже
            использованных имен переменных
        stringsList ParUsedVariablesNamesList - новый список уже
            использованных имен переменных            
        determ (i,o,i,i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список имен переменных данного конъюнкта пуст или пуст,
        то возвращаем элемент без изменений и список использованных имен тем же */
    getConjunctionElementWithSplitedVariables
    (
        ParElement,
        ParElement,
        [],
        ParUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):- !.
    /*
    Если имя переменной из очередного списка имен переменных конъюнкта
            не содержится в текущем списке использованных переменных,
        то его и добавляем в список,
        и рекурсивно обрабатываем оставшиеся имена
            данного конъюнкта на оставшиеся элементы */
    getConjunctionElementWithSplitedVariables
    (
        ParStartElement,
        ParElement,
        [
            ParElementVariableName
            |
            ParElementVariablesNamesListTail
        ],
        ParStartUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):-
        not
        (
            stringIsInStringsList
            (
                ParElementVariableName,
                ParStartUsedVariablesNamesList
            )
        ),
        getConjunctionElementWithSplitedVariables
        (
            ParStartElement,
            ParElement,
            ParElementVariablesNamesListTail,
            [
                ParElementVariableName
                |
                ParStartUsedVariablesNamesList
            ],
            ParUsedVariablesNamesList
        ),
        !.
    /*
    Это имя переменной из очередного списка имен переменных конъюнкта
            содержится в текущем списке использованных переменных,
        и следовательно нужно подобрать для нее новое имя,
        затем применить к элементу замену данной переменной на новую,
        и новое имя добавить в список использованных переменных,
        и рекурсивно обрабатываем оставшиеся имена
            данного конъюнкта на оставшиеся элементы */
    getConjunctionElementWithSplitedVariables
    (
        ParStartElement,
        ParElement,
        [
            ParElementVariableName
            |
            ParElementVariablesNamesListTail
        ],
        ParStartUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):-
        getIndexedStringOutOfStringsList
        (
            ParElementVariableName,
            LocVariableNameOutOfUsedVariablesNamesStringsList,
            ParStartUsedVariablesNamesList
        ),
        getElementWithReplacedVariable
        (
            ParStartElement,
            LocElementWithReplacedVariable,
            variable( ParElementVariableName ),
            variable( LocVariableNameOutOfUsedVariablesNamesStringsList )
        ),
        getConjunctionElementWithSplitedVariables
        (
            LocElementWithReplacedVariable,
            ParElement,
            ParElementVariablesNamesListTail,
            [
                LocVariableNameOutOfUsedVariablesNamesStringsList
                |
                ParStartUsedVariablesNamesList
            ],
            ParUsedVariablesNamesList
        ).    
    /*======================================================================*/                   
    
    
    /*-----------------------------------------------------------------------/
        getConjunctionElementsListWithSplitedVariables
        Получение списка элементов конъюнкта с расщепленными переменными,
        при этом имена входящих в них попарно различны
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsList - новый список элементов
            с расщепленными переменными
        stringsList ParStartUsedVariablesNamesList - исходный список уже
            использованных имен переменных
        stringsList ParUsedVariablesNamesList - новый список уже
            использованных имен переменных            
        determ (i,o,i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если исходный список элементов пуст или пуст,
        то возвращаем пустой список */
    getConjunctionElementsListWithSplitedVariables
    (
        [],
        [],
        ParUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):- !.
    /*
    Из первого элемента списка строим конъюнкт,
    и получаем список имен его переменных в виде списка,
    затем к нему применяем расщепление переменных, 
    и затем рекурсивно обрабатываем хвост на оставшиеся элементы */
    getConjunctionElementsListWithSplitedVariables
    (
        [
            ParStartElement
            |
            ParStartElementsList
        ],
        [
            ParElement
            |
            ParElementsList
        ],
        ParStartUsedVariablesNamesList,
        ParUsedVariablesNamesList
    ):-
        getConjunctionElementVariablesNamesStringsList
        (
            ParStartElement,
            LocElementVariablesNamesList
        ),
        getConjunctionElementWithSplitedVariables
        (
            ParStartElement,
            ParElement,
            LocElementVariablesNamesList,
            ParStartUsedVariablesNamesList,
            LocUsedVariablesNamesListWithElementVariablesNames
        ),
        getConjunctionElementsListWithSplitedVariables
        (
            ParStartElementsList,
            ParElementsList,
            LocUsedVariablesNamesListWithElementVariablesNames,
            ParUsedVariablesNamesList
        ).
    /*======================================================================*/    
    
    
    /*-----------------------------------------------------------------------/
        getConjunctionElementsListWithSplitedVariables
        Получение списка элементов конъюнкта с расщепленными переменными,
        при этом имена входящих в них попарно различны
    /------------------------------------------------------------------------/
        elementsList ParStartElementsList - исходный список элементов
        elementsList ParElementsList - новый список элементов
            с расщепленными переменными
        determ (i,o)
    /-----------------------------------------------------------------------*/  
    /*
    Получение списка элементов конъюнкта с расщепленными переменными,
        при этом имена входящих в них попарно различны,
        при пустом исходном списке использованных имен переменных */
    getConjunctionElementsListWithSplitedVariables
    (
        ParStartElementsList,
        ParElementsList
    ):-
        getConjunctionElementsListWithSplitedVariables
        (
            ParStartElementsList,
            ParElementsList,
            [],
            _
        ).
    /*======================================================================*/        
    
    
    /*=======================================================================/
    
        К О Н В Е Р Т О Р Ы
    
    /=======================================================================*/        
    
    
    /*-----------------------------------------------------------------------/
        translateElementToConjunctionElementsList
        Перевод элемента в список элементов в конъюнктивной нормальной форме
    /------------------------------------------------------------------------/
        element ParElement - исходный элемент
        elementsList ParElementsList - список элементов
            в конъюнктивной нормальной форме
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    В начале устраняем эквивалентность и импликацию,
    продвигаем отрицания к листу,
    получаем направленные предикаты,
    расщепляем кванторы и переменные,
    скoлемизируем - исключаем кванторы существования,
    устраняем кванторы общности,
    устраняем вложенные многоместные операции,
    преобразуем в конъюнктивную нормальную форму,
    расщепляем переменные в конъюнкте */
    translateElementToConjunctionElementsList
    (
        ParElement,
        ParElementsList
    ):-    
        getElementWithoutEquivalencesAndImplications
        (
            ParElement,
            LocElementWithoutEquivalencesAndImplications
        ),
        getElementWithPromotedToPredicatesNegations
        (
            LocElementWithoutEquivalencesAndImplications,
            LocElementWithPromotedToPredicatesNegations
        ),
        getElementWithDirectedPredicates
        (
            LocElementWithPromotedToPredicatesNegations,
            LocElementWithDirectedPredicates
        ),
        getElementWithSplitedQuantifiersVariables
        (
            LocElementWithDirectedPredicates,
            LocElementWithSplitedQuantifiersVariables
        ),
        getElementWithoutExistenceQuantifiers
        (
            LocElementWithSplitedQuantifiersVariables,
            LocElementWithoutExistenceQuantifiers
        ),
        getElementWithoutGeneralityQuantifiers
        (
            LocElementWithoutExistenceQuantifiers,
            LocElementWithoutGeneralityQuantifiers
        ),
        getElementWithoutEmbeddedMultiArgumentsOperations
        (
            LocElementWithoutGeneralityQuantifiers,
            LocElementWithoutEmbeddedMultiArgumentsOperations
        ),
        getConjunctionElementsListFromElement
        (
            LocElementWithoutEmbeddedMultiArgumentsOperations,
            LocConjunctionElementsListFromElement
        ),
        getConjunctionElementsListWithSplitedVariables
        (
            LocConjunctionElementsListFromElement,
            ParElementsList
        ).
    /*======================================================================*/            
    
    
    /*-----------------------------------------------------------------------/
        ConvertVariablesListToParametersList
        Преобразование списка переменных в список параметров
    /------------------------------------------------------------------------/
        parser::variablesList ParVariablesList - исходный список переменных
        parametersList ParParametersList - новый список параметров
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если список переменных пуст или пуст,
        то возвращаем пустой список параметров */
    ConvertVariablesListToParametersList
    (
        [],
        []
    ):- !.    
    /*
    Применяем к каждому элементу исходного списка преобразование
            в соответствующий параметр-переменную и помещаем в начало списка,
        и рекурсивно обрабатываем хвост исходного списка тем же образом */
    ConvertVariablesListToParametersList
    (
        [
            parser::variable( ParVariableName )
            |
            ParVariablesListTail
        ],
        [
            variableParameter( ParVariableName )
            |
            ParParametersListTail
        ]        
    ):-        
        ConvertVariablesListToParametersList
        (
            ParVariablesListTail,
            ParParametersListTail
        ).
    /*======================================================================*/            
    

    /*-----------------------------------------------------------------------/
        ConvertExpressionToElement
        Преобразование выражения в элемент
    /------------------------------------------------------------------------/
        parser::expression ParExpression - исходное выражение
        element ParElement - элемент
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если выражение - предикат,
        то преобразуем соответствующий элемент с тем же именем
        и списком параметров, полученным из списка переменных */
    ConvertExpressionToElement
    (
        parser::predicate
        (
            ParPredicateName,
            ParVariablesList
        ),
        predicate
        (
            ParPredicateName,
            ParParametersList
        )
    ):-
        ConvertVariablesListToParametersList
        (
            ParVariablesList,
            ParParametersList
        ),
        !.
    /*
    Если выражение - отрицание,
        то преобразуем соответствующий элемент 
        в виде отрицания, полученного из преобразованного выражения */
    ConvertExpressionToElement
    (
        parser::negation( ParExpression ),
        negation( ParElement )
    ):-
        ConvertExpressionToElement
        (
            ParExpression,
            ParElement
        ),
        !.        
    /*
    Если выражение - квантор существования,
        то преобразуем соответствующий элемент
        в виде унарной операции 
        и внутреннего элемента, полученного из преобразованного выражения */
    ConvertExpressionToElement
    (
        parser::existence
        (
            parser::variable( ParVariableName ),
            ParExpression
        ),
        existence
        (
            variable( ParVariableName ),
            ParElement
        )
    ):-
        ConvertExpressionToElement
        (
            ParExpression,
            ParElement
        ),
        !.                
    /*
    Если выражение - квантор общности,
        то преобразуем соответствующий элемент
        в виде унарной операции 
        и внутреннего элемента, полученного из преобразованного выражения */
    ConvertExpressionToElement
    (
        parser::generality
        (
            parser::variable( ParVariableName ),
            ParExpression
        ),
        generality
        (
            variable( ParVariableName ),
            ParElement
        )
    ):-
        ConvertExpressionToElement
        (
            ParExpression,
            ParElement
        ),
        !.          
    /*
    Если выражение - эквивалентность,
        то преобразуем соответствующий элемент
        в виде бинарной операции, полученной из преобразованных выражений */
    ConvertExpressionToElement
    (
        parser::equivalence
        (
            ParLeftExpression,
            ParRightExpression
        ),
        equivalence
        (
            ParLeftElement,
            ParRightElement
        )
    ):-
        ConvertExpressionToElement
        (
            ParLeftExpression,
            ParLeftElement
        ),
        ConvertExpressionToElement
        (
            ParRightExpression,
            ParRightElement
        ),        
        !.                  
    /*
    Если выражение - импликация,
        то преобразуем соответствующий элемент
        в виде бинарной операции, полученной из преобразованных выражений */
    ConvertExpressionToElement
    (
        parser::implication
        (
            ParLeftExpression,
            ParRightExpression
        ),
        implication
        (
            ParLeftElement,
            ParRightElement
        )
    ):-
        ConvertExpressionToElement
        (
            ParLeftExpression,
            ParLeftElement
        ),
        ConvertExpressionToElement
        (
            ParRightExpression,
            ParRightElement
        ),        
        !.                  
    /*
    Если выражение - дизъюнкция,
        то преобразуем соответствующий элемент
        из списка дизъюнктивных выражений,
            полученных из списка исходных выражений */
    ConvertExpressionToElement
    (
        parser::disjunction( ParExpressionsList ),
        disjunction( ParElementsList )
    ):-
        ConvertExpressionsListToElementsList
        (
            ParExpressionsList,
            ParElementsList
        ),        
        !.          
    /*
    Если выражение - конъюнкция,
        то преобразуем соответствующий элемент
        из списка конъюнктивных выражений,
            полученных из списка исходных выражений */
    ConvertExpressionToElement
    (
        parser::conjunction( ParExpressionsList ),
        conjunction( ParElementsList )
    ):-
        ConvertExpressionsListToElementsList
        (
            ParExpressionsList,
            ParElementsList
        ),        
        !.                          
    /*======================================================================*/           
  

    /*-----------------------------------------------------------------------/
        ConvertExpressionsListToElementsList
        Преобразование списка выражений в список элементов
    /------------------------------------------------------------------------/
        parser::expressionsList ParExpressionsList - исходный список выражений
        elementsList ParElementsList - новый список элементов
        determ (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Если исходный список выражений пуст или пуст,
        то возвращаем пустой список */
    ConvertExpressionsListToElementsList
    (
        [],
        []
    ):- !.
    /*
    Применяем к первому элементу списка преобразование в элемент
    в соответствии с правилом преобразования выражений,
        и рекурсивно вызываем процедуру на оставшиеся элементы  */
    ConvertExpressionsListToElementsList
    (
        [
            ParExpression
            |
            ParExpressionsListTail
        ],
        [
            ParElement
            |
            ParElementsListTail
        ]
    ):-
        ConvertExpressionToElement
        (
            ParExpression,
            ParElement
        ),
        ConvertExpressionsListToElementsList
        (
            ParExpressionsListTail,
            ParElementsListTail
        ).
    /*======================================================================*/        

    
    /*-----------------------------------------------------------------------/
        ConvertElementsListToDirectedPredicatesList
        Преобразование списка элементов в список направленных предикатов
    /------------------------------------------------------------------------/
        elementsList ParElementsList - исходный список элементов
        directedPredicatesList ParDirectedPredicatesList - новый список
            направленных предикатов
        determ (i,o)
    /-----------------------------------------------------------------------*/  
    /*
    Если список исходных направленных предикатов пуст или пуст,
        то возвращаем пустой список */
    ConvertElementsListToDirectedPredicatesList     
    (
        [],
        []
    ):- !.          
    /*
    Преобразуем первый элемент списка элементов в направленный
        предикат с помощью направленного предиката
    и рекурсивно обрабатываем хвост на оставшиеся элементы */
    ConvertElementsListToDirectedPredicatesList     
    (
        [
            directedPredicateElement
            (
                ParPredicateDirection,
                ParPredicateName,
                ParParametersList
            )
            |
            ParElementsListTail
        ],
        [
            directedPredicate
            (
                ParPredicateDirection,
                ParPredicateName,
                ParParametersList
            )
            |
            ParDirectedPredicatesListTail
        ]
    ):-
        ConvertElementsListToDirectedPredicatesList
        (
            ParElementsListTail,
            ParDirectedPredicatesListTail
        ).
    /*======================================================================*/  
        
    
    /*-----------------------------------------------------------------------/
        ConvertConjunctionElementsListToConjunctsList
        Преобразование списка элементов конъюнкции в список конъюнктов
    /------------------------------------------------------------------------/
        elementsList ParConjunctionElementsList - исходный список конъюнкции
        conjunctsList ParConjunctsList - новый список конъюнктов
        determ (i,o)
    /-----------------------------------------------------------------------*/    
    /*
    Если список исходных конъюнктивных элементов пуст или пуст,
        то возвращаем пустой список */
    ConvertConjunctionElementsListToConjunctsList     
    (
        [],
        []
    ):- !.
    /*
    Если в начале списка встречается элемент направленный предикат,
        то его помещаем в начало списка конъюнктов,
        и рекурсивно обрабатываем хвост на оставшиеся элементы */
    ConvertConjunctionElementsListToConjunctsList     
    (
        [
            directedPredicateElement
            (
                ParPredicateDirection,
                ParPredicateName,
                ParParametersList
            )
            |
            ParConjunctionElementsListTail
        ],
        [
            directedPredicateConjunct
            (
                directedPredicate
                (
                    ParPredicateDirection,
                    ParPredicateName,
                    ParParametersList
                )
            )            
            |
            ParConjunctsListTail
        ]
    ):- 
        ConvertConjunctionElementsListToConjunctsList
        (
            ParConjunctionElementsListTail,
            ParConjunctsListTail
        ),
        !.
    /*
    Если в начале списка встречается элемент дизъюнкция,
        то работаем с его внутренним списком дизъюнктов
            в виде направленных предикатов,
        его помещаем в начало списка конъюнктов,
        и рекурсивно обрабатываем хвост на оставшиеся элементы */
    ConvertConjunctionElementsListToConjunctsList     
    (
        [
            disjunction( ParElementsList )            
            |
            ParConjunctionElementsListTail
        ],
        [
            disjunction( ParDirectedPredicatesList )         
            |
            ParConjunctsListTail
        ]
    ):- 
        ConvertElementsListToDirectedPredicatesList
        (
            ParElementsList,
            ParDirectedPredicatesList
        ),        
        ConvertConjunctionElementsListToConjunctsList
        (
            ParConjunctionElementsListTail,
            ParConjunctsListTail
        ).        
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/
        getConjunctsList
        Получение списка конъюнктов
    /------------------------------------------------------------------------/
        parser::expression ParExpression - выражение
        conjunctsList ParConjunctsList - список конъюнктов
        procedure (i,o)
    /-----------------------------------------------------------------------*/
    /*
    Преобразовываем выражение в элемент,
    применяем преобразование в список конъюнктивных элементов
        в конъюнктивной нормальной форме,
    преобразовываем результирующий список элементов в список конъюнктов */
    getConjunctsList
    (
        ParExpression,
        ParConjunctsList
    ):-
        ConvertExpressionToElement
        (
            ParExpression,
            LocElement
        ),
        translateElementToConjunctionElementsList
        (
            LocElement,
            LocConjunctionElementsList
        ),
        ConvertConjunctionElementsListToConjunctsList
        (
            LocConjunctionElementsList,
            ParConjunctsList
        ),
        !.
    /*
    Возвращаем пустой */
    getConjunctsList( _, [] ).
    /*======================================================================*/             


    /*-----------------------------------------------------------------------/
        translateStringToSentencesSet
        Перевод строки в множество предложений
    /------------------------------------------------------------------------/
        string ParString - строка
        procedure (i)
    /-----------------------------------------------------------------------*/
    /*
    Получаем список позиционированных лексем из строки,
    получаем выражение из этого списка,
    затем выводим выражение,
    получаем список конъюнктов из выражения,
    затем выводим множество предложений из списка конъюнктов */
    translateStringToSentencesSet( ParString ):-        
        scanner::getPositionedLexemesList
        (
            ParString,
            LocPositionedLexemesList
        ),
        parser::getExpression
        (
            LocPositionedLexemesList,
            LocExpression
        ),
        file5x::nl,
        output::showExpression( LocExpression ),
        getConjunctsList
        (
            LocExpression,
            LocConjunctsList
        ),
        file5x::nl,        
        output::showSentencesSet( LocConjunctsList ),
        file5x::nl.
    /*======================================================================*/             

end implement engine