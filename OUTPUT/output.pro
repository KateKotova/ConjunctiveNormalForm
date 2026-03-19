/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

% Реализация
implement output
    open core
      
constants
    % Имя класса
    className = "com/visual-prolog/Engine/engine".
    % Версия класса
    classVersion = "$JustDate: 2008-05-01 $$Revision: 5 $".
    
clauses
    % Информация о классе
    classInfo( className, classVersion ). 
    
class predicates
    /*-----------------------------------------------------------------------/
        Вывод выражения
    /-----------------------------------------------------------------------*/
    % Вывод списка переменных предиката
    showPredicateVariablesList : ( parser::variablesList ) determ (i). 
    % Вывод выражения
    % showExpression : ( parser::expression ) determ (i). 
    % Вывод списка дизъюнктивных подвыражений выражения
    showDisjunctionExpressionsList : ( parser::expressionsList ) determ (i).
    % Вывод списка конъюнктивных подвыражений выражения
    showConjunctionExpressionsList : ( parser::expressionsList ) determ (i).   
    /*======================================================================*/ 
    

    /*-----------------------------------------------------------------------/
        Вывод множества предложений
    /-----------------------------------------------------------------------*/
    % Вывод списка переменных функции
    showFunctionVariablesList : ( engine::variablesList ) determ (i).     
    % Вывод параметра
    showParameter : ( engine::parameterDomain ) determ (i). 
    % Вывод списка параметров
    showParametersList : ( engine::parametersList ) determ (i).
            
    % Вывод направленного предиката
    showDirectedPredicate : ( engine::directedPredicateDomain ) determ (i).    
    % Вывод списка направленных предикатов дизъюнкции
    showDisjunctionDirectedPredicatesList : ( engine::directedPredicatesList )
        determ (i).
    
    % Вывод конъюнкта
    showConjunct : ( engine::conjunct ) determ (i).
    % Вывод списка конъюнктов 
    showConjunctsList : ( engine::conjunctsList ) determ (i).         
    /*======================================================================*/ 
     
clauses
    /*=======================================================================/
    
        В Ы В О Д   В Ы Р А Ж Е Н И Я
    
    /=======================================================================*/
    
    
    /*-----------------------------------------------------------------------/
        showPredicateVariablesList
        Вывод списка переменных предиката
    /------------------------------------------------------------------------/
        parser::variablesList ParVariablesList - список переменных
        determ (i)
    /-----------------------------------------------------------------------*/       
    /*
    Если список переменных пуст,
        то ничего не выводим */
    showPredicateVariablesList( [] ):- !.
    /*
    Если список переменных содержит единственную переменную,
        то выводим её */    
    showPredicateVariablesList
    (
        [ parser::variable( ParVariableName ) ]
    ):-
        file5x::write( ParVariableName ),
        !.
    /*
    Выводим первую переменную, затем запятую и пробел,
    и затем выводим хвост списка переменных тем же образом */    
    showPredicateVariablesList
    (
        [
            parser::variable( ParVariableName )
            |
            ParVariablesListTail
        ]
    ):-
        file5x::write
        (
            ParVariableName,
            base::commaString,
            base::spaceString
        ),
        showPredicateVariablesList( ParVariablesListTail ),
        !.
    /*======================================================================*/
    
     
    /*-----------------------------------------------------------------------/
        showExpression
        Вывод выражения
    /------------------------------------------------------------------------/
        parser::expression ParExpression - выражение
        procedure (i)
    /-----------------------------------------------------------------------*/ 
    /*
    Если выражение - предикат,
        то выводим его имя, открывающую скобку, пробел,
        затем выводим список переменных предиката,
        и в конце - пробел и закрывающую скобку */
    showExpression
    (
        parser::predicate
        (
            ParPredicateName,
            ParVariablesList
        )
    ):-
        file5x::write
        (
            ParPredicateName,
            base::openningParenthesesString,
            base::spaceString
        ),
        showPredicateVariablesList( ParVariablesList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),
        !.   
    /*
    Если выражение - квантор существования,
        то выводим знак квантора - квантор существования,
        его связанную переменную, пробел, открывающую скобку, пробел,
        затем выводим внутреннее выражение,
        и в конце - пробел и закрывающую скобку */
    showExpression
    (
        parser::existence
        (
            parser::variable( ParVariableName ),
            ParInternalExpression
        )
    ):-        
        file5x::write
        (
            base::existenceString,
            ParVariableName,
            base::spaceString,
            base::openningParenthesesString,
            base::spaceString
        ),        
        showExpression( ParInternalExpression ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),   
        !.
    /*
    Если выражение - квантор общности,
        то выводим знак квантора - квантор общности,
        его связанную переменную, пробел, открывающую скобку, пробел,
        затем выводим внутреннее выражение,
        и в конце - пробел и закрывающую скобку */
    showExpression
    (
        parser::generality
        (
            parser::variable( ParVariableName ),
            ParInternalExpression
        )
    ):-        
        file5x::write
        (
            base::generalityString,
            ParVariableName,
            base::spaceString,
            base::openningParenthesesString,
            base::spaceString
        ),        
        showExpression( ParInternalExpression ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),   
        !.                  
    /*
    Если выражение - отрицание,
        то выводим знак отрицания, открывающую скобку, пробел,
        затем выводим внутреннее выражение,
        и в конце - пробел и закрывающую скобку */
    showExpression
    (
        parser::negation( ParInternalExpression )
    ):-        
        file5x::write
        (
            base::negationString,
            base::openningParenthesesString,
            base::spaceString
        ),        
        showExpression( ParInternalExpression ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),   
        !.                      
    /*
    Если выражение - эквивалентность,
        то выводим открывающую скобку, пробел,
        затем выводим левое подвыражение,
        затем пробел, закрывающую скобку, пробел, знак эквивалентности,
        пробел, открывающую скобку, пробел,
        затем выводим правое подвыражение,
        и в конце - пробел и закрывающую скобку */
    showExpression
    (
        parser::equivalence
        (
            ParLeftExpression,
            ParRightExpression
        )
    ):-        
        file5x::write
        (
            base::openningParenthesesString,
            base::spaceString
        ),        
        showExpression( ParLeftExpression ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString,
            base::spaceString,
            base::equivalenceString,
            base::spaceString,
            base::openningParenthesesString,
            base::spaceString
        ),   
        showExpression( ParRightExpression ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),           
        !.      
    /*
    Если выражение - импликация,
        то выводим открывающую скобку, пробел,
        затем выводим левое подвыражение,
        затем пробел, закрывающую скобку, пробел, знак импликации,
        пробел, открывающую скобку, пробел,
        затем выводим правое подвыражение,
        и в конце - пробел и закрывающую скобку */
    showExpression
    (
        parser::implication
        (
            ParLeftExpression,
            ParRightExpression
        )
    ):-        
        file5x::write
        (
            base::openningParenthesesString,
            base::spaceString
        ),        
        showExpression( ParLeftExpression ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString,
            base::spaceString,
            base::implicationString,
            base::spaceString,
            base::openningParenthesesString,
            base::spaceString
        ),   
        showExpression( ParRightExpression ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),           
        !.              
    /*
    Если выражение - дизъюнкция,
        то выводим список в виде дизъюнктивного выражения */
    showExpression
    (
        parser::disjunction( ParExpressionsList )
    ):-        
        showDisjunctionExpressionsList( ParExpressionsList ),
        !.      
    /*
    Если выражение - конъюнкция,
        то выводим список в виде конъюнктивного выражения */
    showExpression
    (
        parser::conjunction( ParExpressionsList )
    ):-        
        showConjunctionExpressionsList( ParExpressionsList ),
        !.        
    /*
    Возвращаем пустой */
    showExpression( _ ).
    /*======================================================================*/
    
 
    /*-----------------------------------------------------------------------/
        showDisjunctionExpressionsList
        Вывод списка дизъюнктивных подвыражений выражения
    /------------------------------------------------------------------------/
        parser::expressionsList ParDisjunctionExpressionsList - список
            дизъюнктивных подвыражений выражения
        determ (i)
    /-----------------------------------------------------------------------*/ 
    /*
    Если список содержит единственное выражение - конъюнкцию,
        то выводим открывающую скобку, пробел,
        затем выводим список конъюнктивных подвыражений выражения,
        и в конце - пробел и закрывающую скобку */
    showDisjunctionExpressionsList
    (
        [ parser::conjunction( ParExpressionsList ) ]
    ):-
        file5x::write
        (
            base::openningParenthesesString,
            base::spaceString
        ),        
        showConjunctionExpressionsList( ParExpressionsList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),           
        !.                     
    /*
    Если список содержит единственное выражение, не конъюнкцию,
        то его выводим просто */
    showDisjunctionExpressionsList
    (
        [ ParExpression ]
    ):-
        showExpression( ParExpression ),      
        !.       
    /*
    Если список начинается с выражения - конъюнкции,
        то выводим открывающую скобку, пробел,
        затем выводим список конъюнктивных подвыражений выражения,
        затем - пробел, закрывающую скобку, пробел, знак дизъюнкции, пробел,
        затем выводим остальные выражения хвоста */
    showDisjunctionExpressionsList
    (
        [
            parser::conjunction( ParExpressionsList )
            |
            ParDisjunctionExpressionsListTail
        ]
    ):-
        file5x::write
        (
            base::openningParenthesesString,
            base::spaceString
        ),        
        showConjunctionExpressionsList( ParExpressionsList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString,
            base::spaceString,
            base::disjunctionString,
            base::spaceString
        ), 
        showDisjunctionExpressionsList( ParDisjunctionExpressionsListTail ),
        !.                    
    /*
    Если список начинается с выражения, не конъюнкции,
        то его выводим просто,
        затем знак дизъюнкции, пробел,
        затем выводим остальные выражения хвоста */
    showDisjunctionExpressionsList
    (
        [
            ParExpression
            |
            ParDisjunctionExpressionsListTail
        ]
    ):-
        showExpression( ParExpression ),
        file5x::write
        (
            base::spaceString,
            base::disjunctionString,
            base::spaceString
        ), 
        showDisjunctionExpressionsList( ParDisjunctionExpressionsListTail ).
    /*======================================================================*/        

        
    /*-----------------------------------------------------------------------/
        showConjunctionExpressionsList
        Вывод списка конъюнктивных подвыражений выражения
    /------------------------------------------------------------------------/
        parser::expressionsList ParConjunctionExpressionsList - список
            конъюнктивных подвыражений выражения
        determ (i)
    /-----------------------------------------------------------------------*/ 
    /*
    Если список содержит единственное выражение - дизъюнкцию,
        то выводим открывающую скобку, пробел,
        затем выводим список дизъюнктивных подвыражений выражения,
        и в конце - пробел и закрывающую скобку */
    showConjunctionExpressionsList
    (
        [ parser::disjunction( ParExpressionsList ) ]
    ):-
        file5x::write
        (
            base::openningParenthesesString,
            base::spaceString
        ),        
        showDisjunctionExpressionsList( ParExpressionsList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),           
        !.                     
    /*
    Если список содержит единственное выражение, не дизъюнкцию,
        то его выводим просто */
    showConjunctionExpressionsList
    (
        [ ParExpression ]
    ):-
        showExpression( ParExpression ),      
        !.       
    /*
    Если список начинается с выражения - дизъюнкции,
        то выводим открывающую скобку, пробел,
        затем выводим список дизъюнктивных подвыражений выражения,
        затем - пробел, закрывающую скобку, пробел, знак дизъюнкции, пробел,
        затем выводим остальные выражения хвоста */
    showConjunctionExpressionsList
    (
        [
            parser::disjunction( ParExpressionsList )
            |
            ParConjunctionExpressionsListTail
        ]
    ):-
        file5x::write
        (
            base::openningParenthesesString,
            base::spaceString
        ),        
        showDisjunctionExpressionsList( ParExpressionsList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString,
            base::spaceString,
            base::disjunctionString,
            base::spaceString
        ), 
        showConjunctionExpressionsList( ParConjunctionExpressionsListTail ),
        !.                    
    /*
    Если список начинается с выражения, не дизъюнкции,
        то его выводим просто,
        затем знак дизъюнкции, пробел,
        затем выводим остальные выражения хвоста */
    showConjunctionExpressionsList
    (
        [
            ParExpression
            |
            ParConjunctionExpressionsListTail
        ]
    ):-
        showExpression( ParExpression ),
        file5x::write
        (
            base::spaceString,
            base::disjunctionString,
            base::spaceString
        ), 
        showConjunctionExpressionsList( ParConjunctionExpressionsListTail ).
    /*======================================================================*/                
    
    
    /*=======================================================================/
    
        В Ы В О Д   М Н О Ж Е С Т В А   П Р Е Д Л О Ж Е Н И Й
    
    /=======================================================================*/    

    
    /*-----------------------------------------------------------------------/
        showFunctionVariablesList
        Вывод списка переменных функции
    /------------------------------------------------------------------------/
        engine::variablesList ParVariablesList - список переменных
        determ (i)
    /-----------------------------------------------------------------------*/       
    /*
    Если список переменных пуст,
        то ничего не выводим */
    showFunctionVariablesList( [] ):- !.
    /*
    Если список переменных содержит единственную переменную,
        то выводим её */    
    showFunctionVariablesList
    (
        [ engine::variable( ParVariableName ) ]
    ):-
        file5x::write( ParVariableName ),
        !.
    /*
    Выводим первую переменную, затем запятую и пробел,
    и затем выводим хвост списка переменных тем же образом */    
    showFunctionVariablesList
    (
        [
            engine::variable( ParVariableName )
            |
            ParVariablesListTail
        ]
    ):-
        file5x::write
        (
            ParVariableName,
            base::commaString,
            base::spaceString
        ),
        showFunctionVariablesList( ParVariablesListTail ),
        !.
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        showParameter
        Вывод параметра
    /------------------------------------------------------------------------/
        engine::parameterDomain ParParameter - параметр
        determ (i)
    /-----------------------------------------------------------------------*/
    /*
    Если параметр - переменная,
        то выводим её */
    showParameter
    (
        engine::variableParameter( ParVariableName )
    ):-
        file5x::write( ParVariableName ),
        !.
    /*
    Если параметр - константа,
        то выводим её */
    showParameter
    (
        engine::constantParameter( ParConstantName )
    ):-
        file5x::write( ParConstantName ),
        !.    
    /*
    Если параметр - функция,
        то выводим её имя, открывающую скобку, пробел
        затем выводим список её переменных,
        и в конце - пробел и закрывающую скобку */
    showParameter
    (
        engine::functionParameter
        (
            ParFunctionName,
            ParVariablesList
        )
    ):-
        file5x::write
        (
            ParFunctionName,
            base::openningParenthesesString,
            base::spaceString
        ),
        showFunctionVariablesList( ParVariablesList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ).                         
    /*======================================================================*/  
    
    
    /*-----------------------------------------------------------------------/
        showParametersList
        Вывод списка параметров
    /------------------------------------------------------------------------/
        engine::parametersList ParParametersList - список параметров
        determ (i)
    /-----------------------------------------------------------------------*/    
    /*
    Если список параметров пуст,
        то ничего не выводим */
    showParametersList( [] ):- !.
    /*
    Если список параметров содержит единственный параметр,
        то его выводим */    
    showParametersList
    (
        [ ParParameter ]
    ):-
        showParameter( ParParameter ),
        !.
    /*
    Выводим первый параметр, затем запятую, пробел,
    и затем выводим хвост списка параметров тем же образом */    
    showParametersList
    (
        [
            ParParameter
            |
            ParParametersListTail
        ]
    ):-
        showParameter( ParParameter ),
        file5x::write
        (
            base::commaString,
            base::spaceString
        ),
        showParametersList( ParParametersListTail ).
    /*======================================================================*/

    
    /*-----------------------------------------------------------------------/
        showDirectedPredicate
        Вывод направленного предиката
    /------------------------------------------------------------------------/
        engine::directedPredicateDomain ParDirectedPredicate -
            направленный предикат
        determ (i)
    /-----------------------------------------------------------------------*/
    /*
    Если направленный предикат положительный,
        то выводим его имя, открывающую скобку, пробел,
        затем выводим список его параметров,
        и в конце - пробел и закрывающую скобку */
    showDirectedPredicate
    (
        engine::directedPredicate
        (
            engine::positive,
            ParDirectedPredicateName,
            ParParametersList
        )
    ):-
        file5x::write
        (
            ParDirectedPredicateName,
            base::openningParenthesesString,
            base::spaceString
        ),
        showParametersList( ParParametersList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),       
        !.
    /*
    Если направленный предикат отрицательный,
        то выводим знак отрицания, пробел, его имя,
        открывающую скобку, пробел,
        затем выводим список его параметров,
        и в конце - пробел и закрывающую скобку */
    showDirectedPredicate
    (
        engine::directedPredicate
        (
            engine::negative,
            ParDirectedPredicateName,
            ParParametersList
        )
    ):-
        file5x::write
        (
            base::negationString,
            base::spaceString,
            ParDirectedPredicateName,
            base::openningParenthesesString,
            base::spaceString
        ),
        showParametersList( ParParametersList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ),       
        !.
    /*======================================================================*/    

    
    /*-----------------------------------------------------------------------/
        showDisjunctionDirectedPredicatesList
        Вывод списка направленных предикатов дизъюнкции
    /------------------------------------------------------------------------/
        engine::directedPredicatesList ParDirectedPredicatesList -
            список направленных предикатов дизъюнкции
        determ (i)
    /-----------------------------------------------------------------------*/    
    /*
    Если список предикатов пуст,
        то ничего не выводим */
    showDisjunctionDirectedPredicatesList( [] ):- !.
    /*
    Если список предикатов содержит единственный направленный предикат,
        то его выводим */    
    showDisjunctionDirectedPredicatesList
    (
        [ ParDirectedPredicate ]
    ):-
        showDirectedPredicate( ParDirectedPredicate ),
        !.
    /*
    Выводим первый направленный предикат,
    и затем пробел, знак дизъюнкции, пробел,
    и затем выводим хвост списка направленных предикатов тем же образом */    
    showDisjunctionDirectedPredicatesList
    (
        [
            ParDirectedPredicate
            |
            ParDirectedPredicatesListTail
        ]
    ):-
        showDirectedPredicate( ParDirectedPredicate ),
        file5x::write
        (
            base::spaceString,
            base::disjunctionString,
            base::spaceString                        
        ),
        showDisjunctionDirectedPredicatesList
            ( ParDirectedPredicatesListTail ).
    /*======================================================================*/ 
    
    
    /*-----------------------------------------------------------------------/
        showConjunct
        Вывод конъюнкта
    /------------------------------------------------------------------------/
        engine::conjunct ParConjunct - конъюнкт
        determ (i)
    /-----------------------------------------------------------------------*/
    /*
    Если конъюнкт - направленный,
        то его выводим */
    showConjunct
    (
        engine::directedPredicateConjunct( ParDirectedPredicate )
    ):-
        showDirectedPredicate( ParDirectedPredicate ),
        !.
    /*
    Если конъюнкт - дизъюнкция,
        то выводим открывающую скобку, пробел,
        затем выводим список в виде направленных предикатов,
        и в конце - пробел и закрывающую скобку */
    showConjunct
    (
        engine::disjunction( ParDirectedPredicatesList )
    ):-
        file5x::write
        (
            base::openningParenthesesString,
            base::spaceString
        ),
        showDisjunctionDirectedPredicatesList( ParDirectedPredicatesList ),
        file5x::write
        (
            base::spaceString,
            base::closingParenthesesString
        ).
    /*======================================================================*/            

        
    /*-----------------------------------------------------------------------/
        showConjunctsList
        Вывод списка конъюнктов
    /------------------------------------------------------------------------/
        engine::conjunctsList ParConjunctsList - список конъюнктов
        determ (i)
    /-----------------------------------------------------------------------*/    
    /*
    Если список конъюнктов пуст,
        то ничего не выводим */
    showConjunctsList( [] ):- !.
    /*
    Если список конъюнктов содержит единственный конъюнкт,
        то его выводим */    
    showConjunctsList
    (
        [ ParConjunct ]
    ):-
        showConjunct( ParConjunct ),
        !.
    /*
    Выводим первый конъюнкт,
    и затем запятую, пробел, 
    и затем выводим хвост списка конъюнктов тем же образом */    
    showConjunctsList
    (
        [
            ParConjunct
            |
            ParConjunctsListTail
        ]
    ):-
        showConjunct( ParConjunct ),
        file5x::write
        (
            base::commaString,
            base::spaceString                        
        ),
        showConjunctsList( ParConjunctsListTail ).
    /*======================================================================*/       
    
    
    /*-----------------------------------------------------------------------/
        showSentencesSet
        Вывод множества предложений
    /------------------------------------------------------------------------/
        engine::conjunctsList ParConjunctsList - список конъюнктов
        procedure (i)
    /-----------------------------------------------------------------------*/
    /*
    Выводим открывающую фигурную скобку, пробел,
    затем выводим список конъюнктов,
    и в конце - пробел и закрывающую фигурную скобку */
    showSentencesSet( ParConjunctsList ):-
        file5x::write
        (
            base::openningFiguredParenthesesString,
            base::spaceString                        
        ),
        showConjunctsList( ParConjunctsList ),
        file5x::write
        (
            base::spaceString,
            base::closingFiguredParenthesesString                        
        ),
        !.
    /*
    Выводим пустой */
    showSentencesSet( _ ).                
    /*======================================================================*/                             

end implement output