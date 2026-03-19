/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

implement cnf
open core

constants
    className = "com/visual-prolog/cnf".
    version = "$JustDate: 2004-10-02 $$Revision: 1 $".

clauses
    classInfo(className, version).

clauses
    run():-
        TaskWindow = taskWindow::new(),
        TaskWindow:show().
end implement cnf

goal
    mainExe::run(cnf::run).
