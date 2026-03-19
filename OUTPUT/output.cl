/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

% Заголовок
class output
    open core

predicates
    % Информация о классе
    classInfo : core::classInfo.
    % @short Class information predicate.
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    % Вывод выражения
    showExpression : ( parser::expression ) procedure (i).
    % Вывод множества предложений
    showSentencesSet : ( engine::conjunctsList ) procedure (i).
   
end class output