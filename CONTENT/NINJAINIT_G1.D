// Version des Patches
const string NINJA_SPRINT_VERSION = "Sprint 2.0.1-G1";

/*
 * Menu initialization function called by Ninja every time a menu is opened
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void Ninja_Sprint_Menu(var int menuPtr) {
	
    MEM_InitAll();
	
	// Version check
    if (NINJA_VERSION < 2202) {
        MEM_SendToSpy(zERR_TYPE_FATAL, "Infinite Sprint requires at least Ninja 2.2.02 or higher. Dauerhaft Rennen benoetigt Ninja 2.2.02 oder hoeher. Download: https://bit.ly/2XFFFEn");
    };
	
	// IF THERE ARE NO ENTRIES FOR THE KEYS IN THE GOTHIC-INI YET, CREATE THEM HERE:
    const int Ninja_Sprint_setKeysOnce = 0;
    if (!Ninja_Sprint_setKeysOnce) 
	{
		if (!MEM_GothOptExists("KEYS", "Ninja_Sprint_UseKey"))
		{ MEM_SetKeys("Ninja_Sprint_UseKey", KEY_RSHIFT, KEY_COMMA); };
		
		if (!MEM_GothOptExists("NINJA_SPRINT", "Strength"))
		{ MEM_SetGothOpt("NINJA_SPRINT", "Strength", "40"); };
		
		if (!MEM_GothOptExists("NINJA_SPRINT", "PermaSprint"))
		{ MEM_SetGothOpt("NINJA_SPRINT", "PermaSprint", "0"); };
		
		if (!MEM_GothOptExists("NINJA_SPRINT", "Anim"))
		{ MEM_SetGothOpt("NINJA_SPRINT", "Anim", "0"); };
		
		if (!MEM_GothOptExists("NINJA_SPRINT", "Weapon"))
		{ MEM_SetGothOpt("NINJA_SPRINT", "Weapon", "1"); };


        Ninja_Sprint_setKeysOnce = 1;
    };	

   var int Ninja_Sprint_Lang; Ninja_Sprint_Lang = Ninja_Sprint_GuessLocalization();

    // Get menu and menu item list, corresponds to C_MENU_DEF.items[]
    var zCMenu menu; menu = _^(menuPtr);
    var int items; items = _@(menu.m_listItems_array);
	
	if (Hlp_StrCmp(menu.name, "MENU_OPTIONS")) {
		// New menu instances
		var string itm1Str2;
		itm1Str2 = "MENUITEM_EN_NINJA_SPRINT_OPT_G1";

        if (Ninja_Sprint_Lang == 1) {
            itm1Str2 = "MENUITEM_DE_NINJA_SPRINT_OPT_G1";
		} else if (Ninja_Sprint_Lang == 2) {
            itm1Str2 = "MENUITEM_PO_NINJA_SPRINT_OPT_G1";
        } else if (Ninja_Sprint_Lang == 3){
            itm1Str2 = "MENUITEM_RU_NINJA_SPRINT_OPT_G1";
        };

        // Get bottom most menu item and new menu items
        var int itmL; itmL = MEM_ArrayPop(items); // Typically "BACK"
        var int itm1; itm1 = MEM_GetMenuItemByString(itm1Str2);


        // If the new ones do not exist yet, create them the first time
        if (!itm1) {
            itm1 = Ninja_Sprint_CreateMenuItem(itm1Str2);

            // Also adjust vertical positions of the menu items
            var zCMenuItem itm;
            itm = _^(itmL);
            var int y; y = itm.m_parPosY;
            itm.m_parPosY = y+300; // Move bottom item down

            itm = _^(itm1);
            itm.m_parPosY = y-260; // Move new item 1 up
        };

        // (Re-)insert the menu items in the correct order
        MEM_ArrayInsert(items, itm1);
        MEM_ArrayInsert(items, itmL);
    };

    // Modify each menu by its name
    if (Hlp_StrCmp(menu.name, "MENU_OPT_CONTROLS")) {

		// Language
        var string itm1Str; var string itm2Str;
		itm1Str = "MENUITEM_EN_NINJA_SPRINT_KEY";
        itm2Str = "MENUITEM_EN_NINJA_SPRINT_INP";
		
        if (Ninja_Sprint_Lang == 1) {
            itm1Str = "MENUITEM_DE_NINJA_SPRINT_KEY";
            itm2Str = "MENUITEM_DE_NINJA_SPRINT_INP";
		} else if (Ninja_Sprint_Lang == 2) {
            itm1Str = "MENUITEM_PO_NINJA_SPRINT_KEY";
            itm2Str = "MENUITEM_PO_NINJA_SPRINT_INP";
        } else if (Ninja_Sprint_Lang == 3) {
            itm1Str = "MENUITEM_RU_NINJA_SPRINT_KEY";
            itm2Str = "MENUITEM_RU_NINJA_SPRINT_INP";
        };

        // Get new items
        var int itm1; itm1 = MEM_GetMenuItemByString(itm1Str);
        var int itm2; itm2 = MEM_GetMenuItemByString(itm2Str);

        // If the new ones do not exist yet, create them the first time
        if (!itm1) {
            var zCMenuItem itm;
            itm1 = Ninja_Sprint_CreateMenuItem(itm1Str);
            itm2 = Ninja_Sprint_CreateMenuItem(itm2Str);

            // Copy properties of first key binding entry (left column)
            var int itmF_left; itmF_left = MEM_ArrayRead(items, 1);
            Ninja_Sprint_CopyMenuItemProperties(itm1, itmF_left);
            itm = _^(itmF_left);
            var int ypos_l; ypos_l = itm.m_parPosY;

            // Retrieve right column entry and copy its properties too
            var string rightname; rightname = itm.m_parOnSelAction_S;
            rightname = STR_SubStr(rightname, 4, STR_Len(rightname)-4);
            var int itmF_right; itmF_right = MEM_GetMenuItemByString(rightname);
            if (itmF_right) {
                Ninja_Sprint_CopyMenuItemProperties(itm2, itmF_right);
            } else { // If not found, copy from left column
                Ninja_Sprint_CopyMenuItemProperties(itm2, itmF_left);
                itm = _^(itm2);
                itm.m_parPosX += 2700; // Default x position
            };
            itm = _^(itmF_right);
            var int ypos_r; ypos_r = itm.m_parPosY;

            // Find "BACK" menu item by its action (to add the new ones above)
            const int index = 0;
            repeat(index, MEM_ArraySize(items));
                itm = _^(MEM_ArrayRead(items, index));
                if (itm.m_parOnSelAction == /*SEL_ACTION_BACK*/ 1)
                && (itm.m_parItemFlags & /*IT_SELECTABLE*/ 4) {
                    break;
                };
            end;
            var int y; y = itm.m_parPosY; // Obtain vertical position

            // Adjust height of new entries (just above the "BACK" option)
            itm = _^(itm1);
            itm.m_parPosY = y;
            itm = _^(itm2);
            itm.m_parPosY = y + (ypos_r - ypos_l); // Maintain possible difference

            // Get maximum height of new entries
            var int ystep; ystep = Ninja_Sprint_MenuItemGetHeight(itm1);
            var int ystep_r; ystep_r = Ninja_Sprint_MenuItemGetHeight(itm2);
            if (ystep_r > ystep) {
                ystep = ystep_r;
            };

            // Shift vertical positions of all following menu items below
            repeat(i, MEM_ArraySize(items) - index); var int i;
                itm = _^(MEM_ArrayRead(items, i + index));
                itm.m_parPosY += ystep;
            end;
        };

        // Add new entries at the correct position
        Ninja_Sprint_ArrayInsertAtPos(items, index, itm1);
        Ninja_Sprint_ArrayInsertAtPos(items, index+1, itm2);
    };
};

/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_Sprint_Init() {
    // IKARUS
	MEM_InitAll();

    // Wrapper for "LeGo_Init" to ensure correct LeGo initialization without breaking the mod
    LeGo_MergeFlags(LeGo_FrameFunctions);

    // WRITE YOUR INITIALIZATIONS HERE
    MEM_Info(ConcatStrings(ConcatStrings("Initialize ", NINJA_SPRINT_VERSION), "."));	
	FF_ApplyOnce(Ninja_Sprint_Main);
	MEM_Info(ConcatStrings(NINJA_SPRINT_VERSION, " was initialized successfully."));
};
