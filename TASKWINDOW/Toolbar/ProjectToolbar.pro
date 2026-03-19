/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

implement projectToolbar
open core, vpiDomains, vpiToolbar, resourceIdentifiers

constants
    className = "com/visual-prolog/TaskWindow/Toolbar/projectToolbar".
    version = "$JustDate: 2004-10-15 $$Revision: 2 $".

clauses
    classInfo(className, version).
clauses
    create(Parent):-
        _ = vpiToolbar::create(style, Parent, controlList).

% This code is maintained by the VDE do not update it manually, 09:09:13-20.5.2008
constants
    style : vpiToolbar::style = tb_top().
    controlList : vpiToolbar::control_list =
        [
        tb_ctrl(id_file_new,pushb(),resId(idb_NewFileBitmap),"New;New file",1,1),
        tb_ctrl(id_file_open,pushb(),resId(id_OpenFileBitmap),"Open;Open file",1,1),
        tb_ctrl(id_file_consult,pushb(),resId(idb_consult),"Consult;Consult File",1,1),
        tb_ctrl(id_file_save,pushb(),resId(id_SaveFileBitmap),"Save;File save",1,1),
        vpiToolbar::separator,
        tb_ctrl(id_edit_undo,pushb(),resId(id_UndoBitmap),"Undo;Undo",1,1),
        tb_ctrl(id_edit_redo,pushb(),resId(id_RedoBitmap),"Redo;Redo",1,1),
        vpiToolbar::separator,
        tb_ctrl(id_edit_cut,pushb(),resId(id_CutBitmap),"Cut;Cut to clipboard",1,1),
        tb_ctrl(id_edit_copy,pushb(),resId(id_CopyBitmap),"Copy;Copy to clipboard",1,1),
        tb_ctrl(id_edit_paste,pushb(),resId(id_PasteBitmap),"Paste;Paste from clipboard",1,1),
        vpiToolbar::separator,
        tb_ctrl(id_Engine_reconsult,pushb(),resId(idb_reconsult),"Reconsult;Reconsult this text",1,1),
        vpiToolbar::separator,
        tb_ctrl(id_help_contents,pushb(),resId(id_HelpBitmap),"Help;Help",1,1)
        ].
% end of automatic code
end implement projectToolbar
