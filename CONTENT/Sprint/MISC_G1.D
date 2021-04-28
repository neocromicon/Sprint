/*
 * Create menu item from script instance name
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func int Ninja_Sprint_CreateMenuItem(var string scriptName) { // Adjust name
    const int zCMenuItem__Create_G1 = 5052784; //0x4D1970
    const int zCMenuItem__Create_G2 = 5105600; //0x4DE7C0

    var int strPtr; strPtr = _@s(scriptName);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(strPtr));
        CALL_PutRetValTo(_@(ret));
        CALL__cdecl(MEMINT_SwitchG1G2(zCMenuItem__Create_G1,
                                      zCMenuItem__Create_G2));
        call = CALL_End();
    };

    var int ret;
    return +ret;
};

/*
 * Copy essential properties from one to another menu entry
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void Ninja_Sprint_CopyMenuItemProperties(var int dstPtr, var int srcPtr) {
    if (!dstPtr) || (!srcPtr) {
        return;
    };

    var zCMenuItem src; src = _^(srcPtr);
    var zCMenuItem dst; dst = _^(dstPtr);

    dst.m_parPosX = src.m_parPosX;
    dst.m_parPosY = src.m_parPosY;
    dst.m_parDimX = src.m_parDimX;
    dst.m_parDimY = src.m_parDimY;
    dst.m_pFont = src.m_pFont;
    dst.m_pFontSel = src.m_pFontSel;
    dst.m_parBackPic = src.m_parBackPic;
};

/*
 * Get maximum menu item height
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func int Ninja_Sprint_MenuItemGetHeight(var int itmPtr) { // Adjust name
    if (!itmPtr) {
        return 0;
    };

    var zCMenuItem itm; itm = _^(itmPtr);
    var int fontPtr; fontPtr = itm.m_pFont;

    const int zCFont__GetFontY_G1 = 7209472; //0x6E0200
    const int zCFont__GetFontY_G2 = 7902432; //0x7894E0

    var int fontHeight;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(_@(fontPtr), MEMINT_SwitchG1G2(zCFont__GetFontY_G1,
                                                      zCFont__GetFontY_G2));
        CALL_PutRetValTo(_@(fontHeight));
        call = CALL_End();
    };

    // Transform to virtual pixels
    MEM_InitGlobalInst();
    var zCView screen; screen = _^(MEM_Game._zCSession_viewport);
    fontHeight *= 8192 / screen.psizey;

    if (fontHeight > itm.m_parDimY) {
        return fontHeight;
    } else {
        return itm.m_parDimY;
    };
};

/*
 * Insert value into array at specific position
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void Ninja_Sprint_ArrayInsertAtPos(var int zCArray_ptr,
                                             var int pos,
                                             var int value) { // Adjust name
    const int zCArray__InsertAtPos_G1 = 6267728; //0x5FA350
    const int zCArray__InsertAtPos_G2 = 6458144; //0x628B20

    var int valuePtr; valuePtr = _@(value);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(pos));
        CALL_PtrParam(_@(valuePtr));
        CALL__thiscall(_@(zCArray_ptr), MEMINT_SwitchG1G2(zCArray__InsertAtPos_G1,
                                                          zCArray__InsertAtPos_G2));
        call = CALL_End();
    };
};

/*
 * Guess localization (0 = EN, 1 = DE, 2 = PL, 3 = RU)
 *
 *	--> Function by mud-freak!
 *  https://github.com/szapp/Ninja/wiki/Inject-Changes#localization
 */
func int Ninja_Sprint_GuessLocalization()
{
    var int Ninja_Sprint_CheckLanguage; Ninja_Sprint_CheckLanguage = MEM_GetSymbol("MOBNAME_PAN");
	
    if (Ninja_Sprint_CheckLanguage) 
	{
        var zCPar_Symbol Ninja_Sprint_CheckLanguageSymb; Ninja_Sprint_CheckLanguageSymb = _^(Ninja_Sprint_CheckLanguage);
        var string Ninja_Sprint_CheckLanguageName; Ninja_Sprint_CheckLanguageName = MEM_ReadString(Ninja_Sprint_CheckLanguageSymb.content);
		
        if (Hlp_StrCmp(Ninja_Sprint_CheckLanguageName, "Pfanne")) {			// DE
            return 1;
		} else if (Hlp_StrCmp(Ninja_Sprint_CheckLanguageName, "Patelnia")) { // PL
            return 2;
		} else if (Hlp_StrCmp(Ninja_Sprint_CheckLanguageName, "Сковорода")) { // RU
            return 3;
        };
    };
	
    return 0;
};

/*
 * Check if an MDS overlay of given name is active. Credits: Mud-Freak Stamina Patch
 */
func int Ninja_Sprint_Mdl_OverlayMdsIsActive(var C_Npc slf, var string mdsName) {
    var oCNpc npc; npc = Hlp_GetNpc(slf);
    mdsName = STR_Upper(mdsName);

    repeat(i, npc.activeOverlays_numInArray); var int i;
        if (Hlp_StrCmp(mdsName, MEM_ReadStringArray(npc.activeOverlays_array, i))) {
            return TRUE;
        };
    end;
    return FALSE;
};

/*
 * Copy of C_BodyStateContains to ensure it exists as expected. Credits: Mud-Freak
 */
func int Ninja_Sprint_BodyStateContains(var C_Npc slf, var int bodystate) {
    const int mod = 31 | 32768 | 65536; // BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS
    return ((Npc_GetBodyState(slf) & mod) == (bodystate & mod));
};

/*
 * Check if an NPC is running. Credits: Mud-Freak Stamina Patch
 */
func int Ninja_Sprint_Npc_IsRunning(var C_Npc slf) {
    var oCNpc npc; npc = Hlp_GetNpc(slf);
    var int aiPtr; aiPtr = npc.human_ai;

    if (GOTHIC_BASE_VERSION == 2) {
        const int oCAniCtrl_Human__IsRunning = 7004672; //0x6AE200

        const int call = 0;
        if (CALL_Begin(call)) {
            CALL_PutRetValTo(_@(ret));
            CALL__thiscall(_@(aiPtr), oCAniCtrl_Human__IsRunning);
            call = CALL_End();
        };

        var int ret;
        return +ret;

    } else {
        // Gothic 1 does not have the function oCAniCtrl_Human::IsRunning. Re-implement it here
        // These lines require at lease Ikarus 1.2.2

        var oCAniCtrl_Human ai; ai = _^(aiPtr);
        var int modelPtr; modelPtr = ai._zCAIPlayer_model;

        if (!modelPtr) {
            return FALSE;
        };

        // Modified from auxillary.d in GothicFreeAim
        // https://github.com/szapp/GothicFreeAim/blob/v1.2.0/_work/data/Scripts/Content/GFA/_intern/auxiliary.d#L169
        const int zCModel_numActAnis_offset = 52; //0x34
        const int zCModel_actAniList_offset = 56; //0x37
        const int zCModelAni_aniID_offset   = 76; //0x4C
        var int actAniOffset; actAniOffset = modelPtr+zCModel_actAniList_offset;
        repeat(i, MEM_ReadInt(modelPtr+zCModel_numActAnis_offset)); var int i;
            var int aniID; aniID = MEM_ReadInt(MEM_ReadInt(MEM_ReadInt(actAniOffset))+zCModelAni_aniID_offset);
            if (aniID == MEM_ReadStatArr(ai.s_runl,        npc.fmode))
            || (aniID == MEM_ReadStatArr(ai.s_runr,        npc.fmode))
            || (aniID == MEM_ReadStatArr(ai.t_run_2_runl,  npc.fmode))
            || (aniID == MEM_ReadStatArr(ai.t_runl_2_run,  npc.fmode))
            || (aniID == MEM_ReadStatArr(ai.t_runl_2_runr, npc.fmode))
            || (aniID == MEM_ReadStatArr(ai.t_runr_2_runl, npc.fmode))
            || (aniID == MEM_ReadStatArr(ai.t_runr_2_run,  npc.fmode)) {
                return TRUE;
            };
            actAniOffset += 4;
        end;
    };
    return FALSE;
};