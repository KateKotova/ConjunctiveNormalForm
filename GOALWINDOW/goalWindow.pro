/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

    Message window but catches Return Key
******************************************************************************/

implement goalWindow
open core

constants
    className = "com/visual-prolog/goalWindow/goalWindow".
    version = "$JustDate: 2004-10-02 $$Revision: 1 $".

clauses
    classInfo(className, version).

class facts - my_msg_win
 oldhandler : (vpiDomains::ehandler)determ.

clauses
create(MsgWin):-
    MsgWin = vpiMessage::create(1000, " Dialog"), 
    OldEhandler=vpi::winGetHandler(MsgWin), 
    assert(oldhandler(OldEhandler)), 
    vpi::winSetHandler(MsgWin, eventHandler).

class predicates 
eventHandler : vpiDomains::ehandler.
clauses
eventHandler(_Win, vpidomains::e_Char(Char, _)) = 0 :-
    retract(readChar_fact()),
    !,
    readChar_result := uncheckedConvert(char, convert(integer16, Char)),
    stdio::write(readChar_result, "\n").
eventHandler(Win, vpidomains::e_Char(13, _)) = 0 :-
    vpiEditor::doLineHome( Win ), 
    StartPos=vpiEditor::getPos(Win), 
    vpiEditor::doLineEnd( Win ), 
    EndPos=vpiEditor::getPos(Win), 
    EndPos>StartPos, !, 
    Text=vpiEditor::getText(Win), 
    NBytes=EndPos-StartPos, 
    string5x::substring(Text, StartPos, NBytes, MyGoal), 
    EndPos1=EndPos-1, 
    string5x::frontstr(EndPos1, Text, NewText, _RestString), 
    vpiEditor::pasteStr(Win, NewText), file5x::nl, 
    try_run_goal(MyGoal).
eventHandler(Win, vpidomains::e_Size(_, _)) = 0 :- 
    configuration::set_msg_pos(Win), 
    fail.
eventHandler(Win, vpidomains::e_Move(_, _)) = 0 :- 
    configuration::set_msg_pos(Win), 
    fail.
eventHandler(_Win, vpidomains::e_CloseRequest()) = 0 :-!.

eventHandler(_, vpidomains::e_GetFocus) = 0 :-!, 
    Task=vpi::getTaskWindow(), 
    vpiToolbar::mesRedirect(Task, Task).
eventHandler(Win, Event) = 0 :-
    oldhandler(OldEhandler), 
    _ = OldEHandler(Win, Event).

class predicates 
try_run_goal : (string) procedure.
clauses
try_run_goal(String) :-
    retract(readln_fact()),
    !,
    readln_result := String.
try_run_goal(TheGoal) :-
    string5x::format(Status, "Run goal: %s", TheGoal), 
    taskWindow::system_status(Status), 
    engine::translateStringToSentencesSet( TheGoal ),    
    taskWindow::system_status("Ready").

clauses
aboutToClose() :-
    MesWin = vpiMessage::getWin(), 
    !,
    FONT = vpi::winGetFont(MesWin), 
    configuration::set_msg_font(FONT).
aboutToClose().

clauses
destroy() :-
    MesWin = vpiMessage::getWin(), 
    !,
    vpi::winDestroy(MesWin).
destroy().

clauses
    readLn() = _ :-
        assert(readLn_fact()),
        readLn_loop(),
        fail.
    readLn() = readln_result.

class facts
    readLn_fact : () determ.
    readln_result : string := "".
class predicates
    readLn_loop : () nondeterm.
clauses
    readLn_loop() :-
        not(readLn_fact()),
        !,
        fail.
    readLn_loop().
    readLn_loop() :-
        vpi::processEvents() = _,
        readLn_loop().

clauses
    readChar() = _ :-
        assert(readChar_fact()),
        readChar_loop(),
        fail.
    readChar() = readChar_result.
        
class facts
    readChar_fact : () determ.
    readchar_result : char := ' '.
class predicates
    readChar_loop : () nondeterm.
clauses
    readChar_loop() :-
        not(readChar_fact()),
        !,
        fail.
    readChar_loop().
    readChar_loop() :-
        vpi::processEvents() = _,
        readChar_loop().


end implement goalWindow
