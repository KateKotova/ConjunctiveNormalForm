/*****************************************************************************

                        Copyright (c) 2004 Kate Kotova

******************************************************************************/

implement aboutDialog
open core, vpiDomains, resourceIdentifiers

constants
    className = "com/visual-prolog/TaskWindow/aboutDialog".
    version = "$JustDate: 2004-10-15 $$Revision: 2 $".

clauses
    classInfo(className, version).

facts
    thisWin : vpiDomains::windowHandle := uncheckedConvert(vpiDomains::windowHandle, 0).
        
clauses
    show(Parent):-
        _ = vpi::winCreateDynDialog(Parent, controlList, eventHandler, 0).

predicates
    eventHandler : vpiDomains::ehandler.
clauses
    eventHandler(Win, Event) = Result :-
        Result = generatedEventHandler(Win, Event).

predicates
    onCreate : vpiDomains::createHandler.
clauses
    onCreate(_CreationData) = defaultHandling() :-
        TWH = vpi::wingetctlhandle(thisWin,idc_dlg_about_st_prj),
        Font = vpi::winGetFont(TWH),
        Font1 = vpi::fontsetattrs(Font,[fs_Bold],dialogFontSize+4),
        vpi::winSetFont(TWH, Font1).
        
        
        
                    
predicates
    onControlOK : vpiDomains::controlHandler.
clauses
    onControlOK(_Ctrl, _CtrlType, _CtrlWin, _CtrlInfo) = handled(0) :-
        vpi::winDestroy(thisWin).
                    
predicates
    onControlCancel : vpiDomains::controlHandler.
clauses
    onControlCancel(_Ctrl, _CtrlType, _CtrlWin, _CtrlInfo) = handled(0) :-
        vpi::winDestroy(thisWin).

% This code is maintained by the VDE do not update it manually, 10:07:09-20.5.2008
constants
    dialogType : vpiDomains::wintype = wd_modal.
    title : string = " About".
    rectangle : vpiDomains::rct = rct(122,26,342,190).
    dialogFlags : vpiDomains::wsflags = [wsf_Close,wsf_TitleBar].
    dialogFont = "MS Sans Serif".
    dialogFontSize = 8.

constants
    controlList : vpiDomains::windef_list =
        [
        dlgFont(wdef(dialogType, rectangle, title, u_DlgBase),
                dialogFont, dialogFontSize, dialogFlags),
        ctl(wdef(wc_PushButton,rct(10,115,46,130),"OK",u_DlgBase),idc_ok,[wsf_Default,wsf_Group,wsf_TabStop]),
        ctl(wdef(wc_Text,rct(65,15,200,30),"Conjunctive Normal Form",u_DlgBase),idc_dlg_about_st_prj,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,35,200,55),"Copyright (c) 1984 - 2000 Prolog Development Center A/S",u_DlgBase),idc_dlg_about_st_copy,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,100,200,110),"Copyright (c) 2004 Kate Kotova",u_DlgBase),idc_dlg_about_nijanus,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,110,200,120),"���. �������� �.�.",u_DlgBase),idc_dlg_about_bogdanov,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,120,200,130),"���. �������� �.�.",u_DlgBase),idc_dlg_about_cukanova,[wsf_AlignCenter]),
        icon(wdef(wc_Icon,rct(20,20,36,36),"",u_DlgBase),project_icon,application_icon,[]),
        ctl(wdef(wc_Text,rct(65,60,200,70),"Copenhagen, Denmark",u_DlgBase),idct_hjholstvej,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,70,200,80),"sales@visual-prolog.com",u_DlgBase),idct_internet_email,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,80,200,90),"http://www.visual-prolog.com",u_DlgBase),idct_web_httpwwwpdcdk,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,130,200,140),"�. ������, ��. 443",u_DlgBase),idct_dlg_about_kotova,[wsf_AlignCenter]),
        ctl(wdef(wc_Text,rct(65,140,200,150),"�����, 2008 �.",u_DlgBase),idct_dlg_about_rgrtu,[wsf_AlignCenter]),
        ctl(wdef(wc_GroupBox,rct(55,5,210,155),"",u_DlgBase),idc_about_dialog_1,[])
        ].

predicates
    generatedEventHandler : vpiDomains::ehandler.
clauses
    generatedEventHandler(Win, e_create(_)) = _ :-
        thisWin := Win,
        fail.
    generatedEventHandler(_Win, e_Create(CreationData)) = Result :-
        handled(Result) = onCreate(CreationData).
    generatedEventHandler(_Win, e_Control(idc_ok, CtrlType, CtrlWin, CtlInfo)) = Result :-
            handled(Result) = onControlOk(idc_ok, CtrlType, CtrlWin, CtlInfo).
% end of automatic code
end implement aboutDialog
