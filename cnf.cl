/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

class cnf
open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
predicates
    run : core::runnable.
end class cnf