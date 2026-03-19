/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

% Синтаксический анализатор
class parser
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

    % Выражение
    expression  = 
        % Предикат
        predicate( string, variablesList );
        % Квантор существования
        existence( variableDomain, expression );
        % Квантор общности 
        generality( variableDomain, expression );
        % Отрицание
        negation( expression );
        % Эквивалентность
        equivalence( expression, expression );
        % Импликация
        implication( expression, expression );
        % Дизъюнкция
        disjunction( expressionsList );
        % Конъюнкция
        conjunction( expressionsList ).
        
    % Список выражений
    expressionsList = expression*.
    
predicates
    % Получение выражения
    getExpression : ( scanner::positionedLexemesList, expression )
        procedure (i,o).

end class parser