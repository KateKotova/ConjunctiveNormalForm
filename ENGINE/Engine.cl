/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

% Домен
class engine
    open core

predicates
    % Информация о классе
    classInfo : core::classInfo.
    % @short Class information predicate.
    % @detail This predicate represents information predicate of this class.
    % @end

domains  
    % Переменная
    variableDomain = variable( string ).
    % Список переменных
    variablesList = variableDomain*.    
    
    % Параметр
    parameterDomain =
        % Переменная
        variableParameter( string );
        % Константа
        constantParameter( string );
        % Функция
        functionParameter( string, variablesList ).
        
    % Список параметров
    parametersList = parameterDomain*. 
    /*----------------------------------------------------------------------*/

    % Направленность предиката
    predicateDirection = 
        % Положительный
        positive;
        % Отрицательный
        negative.
    
    % Направленный предикат
    directedPredicateDomain = directedPredicate( predicateDirection, string,
        parametersList ).
    % Список направленных предикатов
    directedPredicatesList = directedPredicateDomain*.
    /*----------------------------------------------------------------------*/      

    % Конъюнкт
    conjunct  = 
        % Направленный предикат
        directedPredicateConjunct( directedPredicateDomain );
        % Дизъюнкция
        disjunction( directedPredicatesList ).
        
    % Список конъюнктов
    conjunctsList = conjunct*.
    /*----------------------------------------------------------------------*/    
    
predicates
    % Получение списка конъюнктов
    getConjunctsList : ( parser::expression, conjunctsList ) procedure (i,o).
    % Перевод строки в множество предложений
    translateStringToSentencesSet : ( string ) procedure (i).

end class engine