/* posx = <-->
 * posy = /\
		  |
		  \/
 *--------------MENÜ IN EINSTELLUNGEN--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_OPT(C_MENU_ITEM_DEF)
{
	text[0]		= "Dauerhaftes Rennen";
	text[1]		= "Dauerhaftes Rennen Einstellungen.";  // Kommentar
	// Position und Dimension
	posx		= 0;		posy		= 0;
	dimx		= 8192;		dimy		= 750;
	// Aktionen
	onSelAction[0]	= SPRINT_SEL_ACTION_STARTMENU;
	onSelAction_S[0]= "MENU_DE_NINJA_SPRINT_OPT";
	// Weitere Eigenschaften
	flags = flags | SPRINT_IT_TXT_CENTER;
};
/*
 *--------------G1--------------
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_OPT_G1(C_MENU_ITEM_DEF)
{
	text[0]		= "Dauerhaftes Rennen";
	text[1]		= "Dauerhaftes Rennen Einstellungen.";  // Kommentar
	// Position und Dimension
	posx		= 0;		posy		= 0;
	dimx		= 8192;		dimy		= 750;
	// Aktionen
	onSelAction[0]	= SPRINT_SEL_ACTION_STARTMENU;
	onSelAction_S[0]= "MENU_DE_NINJA_SPRINT_OPT_G1";
	// Weitere Eigenschaften
	flags = flags | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------SPRINT HAUPTMENÜ--------------
 *
 *------Deutsch------1
 */
INSTANCE MENU_DE_NINJA_SPRINT_OPT(C_MENU_DEF)
{
	backpic		= MENU_BACK_PIC;
	
	items[0]	= "MENUITEM_DE_NINJA_SPRINT_OPT_HEADING";
	
	items[1] 	= "MENUITEM_DE_NINJA_SPRINT_PERMA_INST";
	items[2] 	= "MENUITEM_DE_NINJA_SPRINT_PERMA_CHOICE";
			
	items[3] 	= "MENUITEM_DE_NINJA_SPRINT_ANIM_INST";
	items[4] 	= "MENUITEM_DE_NINJA_SPRINT_ANIM_CHOICE";
			
    items[5] 	= "MENUITEM_DE_NINJA_SPRINT_STRENGTH_INST";
    items[6] 	= "MENUITEM_DE_NINJA_SPRINT_STRENGTH_CHOICE";
			
	items[7] 	= "MENUITEM_DE_NINJA_SPRINT_WEAPON_INST";
    items[8] 	= "MENUITEM_DE_NINJA_SPRINT_WEAPON_CHOICE";
			
	items[9] 	= "MENUITEM_DE_NINJA_SPRINT_PARTY_INST";
	items[10] 	= "MENUITEM_DE_NINJA_SPRINT_PARTY_CHOICE";
			
	items[11] 	= "MENUITEM_DE_NINJA_SPRINT_OPT_BACK";
	
	defaultOutGame	= 0;	// PERFORMANCE-SETTINGS
	defaultInGame	= 0;	// PERFORMANCE-SETTINGS

	flags = flags | SPRINT_MENU_SHOW_INFO;
};
/*
 *--------------G1--------------
 */
INSTANCE MENU_DE_NINJA_SPRINT_OPT_G1(C_MENU_DEF)
{
	backpic		= MENU_BACK_PIC;
	
	items[0]	= "MENUITEM_DE_NINJA_SPRINT_OPT_HEADING";
	
	items[1] 	= "MENUITEM_DE_NINJA_SPRINT_PERMA_INST";
	items[2] 	= "MENUITEM_DE_NINJA_SPRINT_PERMA_CHOICE";
			
	items[3] 	= "MENUITEM_DE_NINJA_SPRINT_ANIM_INST";
	items[4] 	= "MENUITEM_DE_NINJA_SPRINT_ANIM_CHOICE";
			
    items[5] 	= "MENUITEM_DE_NINJA_SPRINT_STRENGTH_INST";
    items[6] 	= "MENUITEM_DE_NINJA_SPRINT_STRENGTH_CHOICE";
			
	items[7] 	= "MENUITEM_DE_NINJA_SPRINT_WEAPON_INST";
    items[8] 	= "MENUITEM_DE_NINJA_SPRINT_WEAPON_CHOICE";
						
	items[9] 	= "MENUITEM_DE_NINJA_SPRINT_OPT_BACK";
	
	defaultOutGame	= 0;	// PERFORMANCE-SETTINGS
	defaultInGame	= 0;	// PERFORMANCE-SETTINGS

	flags = flags | SPRINT_MENU_SHOW_INFO;
};



/*
 *--------------HEADLINE-------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_OPT_HEADING(C_MENU_ITEM_DEF)
{
	text[0]     =   SPRINT_TITLE_DE; 
	type		=	SPRINT_MENU_ITEM_TEXT;
	// Position und Dimension
	posx		=	0;		posy		=	SPRINT_MENU_TITLE_Y;
	dimx		=	8192;
	// Weitere Eigenschaften
	flags		= flags & ~SPRINT_IT_SELECTABLE;
	flags		= flags | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------PERMA SPRINT--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_PERMA_INST(C_MENU_ITEM_DEF)
{
	text[0]		=	"Per Taste"; //Name
	text[1]		= 	"Aktiviert Rennen nur beim Drücken der entsprechenden Taste"; // Kommentar
	// Position und Dimension	
	posx		=	1000;	posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*0;
	dimx		=	3000;	dimy		=	750;
	// Aktionen
	onSelAction[0]	= SPRINT_SEL_ACTION_UNDEF;
	// Weitere Eigenschaften
	flags			= flags | SPRINT_IT_EFFECTS_NEXT;
};
INSTANCE MENUITEM_DE_NINJA_SPRINT_PERMA_CHOICE(C_MENU_ITEM_DEF)
{
	backPic		=	SPRINT_MENU_CHOICE_BACK_PIC;
	type		=	SPRINT_MENU_ITEM_CHOICEBOX;
    text[0]     =   "Aus|An";
    fontName    =   SPRINT_MENU_FONT_DEFAULT;
	// Position und Dimension	
	posx		= 5000;		posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*0 + SPRINT_MENU_CHOICE_YPLUS;
	dimx = SPRINT_MENU_SLIDER_DX;	dimy 		= 	SPRINT_MENU_CHOICE_DY;
	// Aktionen
    onChgSetOption        = "Perma"; //Gothic.ini
    onChgSetOptionSection = "NINJA_SPRINT"; //Gothic.ini
	// Weitere Eigenschaften	
	flags		= flags & ~SPRINT_IT_SELECTABLE;
	flags		= flags  | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------SPRINT ANIM--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_ANIM_INST(C_MENU_ITEM_DEF)
{
	text[0]		=	"Modus"; //Name
	text[1]		= 	"Auswahl der Rennanimation"; // Kommentar
	// Position und Dimension	
	posx		=	1000;	posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*1;
	dimx		=	3000;	dimy		=	750;
	// Aktionen
	onSelAction[0]	= SPRINT_SEL_ACTION_UNDEF;
	// Weitere Eigenschaften
	flags			= flags | SPRINT_IT_EFFECTS_NEXT;
};
INSTANCE MENUITEM_DE_NINJA_SPRINT_ANIM_CHOICE(C_MENU_ITEM_DEF)
{
	backPic		=	SPRINT_MENU_CHOICE_BACK_PIC;
	type		=	SPRINT_MENU_ITEM_CHOICEBOX;
    text[0]     =   "Standard|Alternativ|Remaster";
    fontName    =   SPRINT_MENU_FONT_DEFAULT;
	// Position und Dimension	
	posx		= 5000;		posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*1 + SPRINT_MENU_CHOICE_YPLUS;
	dimx = SPRINT_MENU_SLIDER_DX;	dimy 		= 	SPRINT_MENU_CHOICE_DY;
	// Aktionen
    onChgSetOption        = "Anim"; //Gothic.ini
    onChgSetOptionSection = "NINJA_SPRINT"; //Gothic.ini
	// Weitere Eigenschaften	
	flags		= flags & ~SPRINT_IT_SELECTABLE;
	flags		= flags  | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------STÄRKE--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_STRENGTH_INST(C_MENU_ITEM_DEF)
{
	text[0]		=	"Stärke"; //Name
	text[1]		= 	"Erforderliche Mindeststärke"; // Kommentar
	// Position und Dimension	
	posx		=	1000;	posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*2;
	dimx		=	3000;	dimy		=	750;
	// Aktionen
	onSelAction[0]	= SPRINT_SEL_ACTION_UNDEF;
	// Weitere Eigenschaften
	flags			= flags | SPRINT_IT_EFFECTS_NEXT;
};
INSTANCE MENUITEM_DE_NINJA_SPRINT_STRENGTH_CHOICE(C_MENU_ITEM_DEF)
{
	backPic		=	SPRINT_MENU_CHOICE_BACK_PIC;
	type		=	SPRINT_MENU_ITEM_CHOICEBOX;
    text[0]     =   "Keine|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100";
    fontName    =   SPRINT_MENU_FONT_DEFAULT;
	// Position und Dimension	
	posx		= 5000;		posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*2 + SPRINT_MENU_CHOICE_YPLUS;
	dimx = SPRINT_MENU_SLIDER_DX;	dimy 		= 	SPRINT_MENU_CHOICE_DY;
	// Aktionen
    onChgSetOption        = "Strength"; //Gothic.ini
    onChgSetOptionSection = "NINJA_SPRINT"; //Gothic.ini
	// Weitere Eigenschaften	
	flags		= flags & ~SPRINT_IT_SELECTABLE;
	flags		= flags  | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------WEAPON--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_WEAPON_INST(C_MENU_ITEM_DEF)
{
	text[0]		=	"Mit Waffen"; //Name
	text[1]		= 	"Aktiviert Rennen bei gezogener Waffe und Zaubern"; // Kommentar
	// Position und Dimension	
	posx		=	1000;	posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*3;
	dimx		=	3000;	dimy		=	750;
	// Aktionen
	onSelAction[0]	= SPRINT_SEL_ACTION_UNDEF;
	// Weitere Eigenschaften
	flags			= flags | SPRINT_IT_EFFECTS_NEXT;
};
INSTANCE MENUITEM_DE_NINJA_SPRINT_WEAPON_CHOICE(C_MENU_ITEM_DEF)
{
	backPic		=	SPRINT_MENU_CHOICE_BACK_PIC;
	type		=	SPRINT_MENU_ITEM_CHOICEBOX;
    text[0]     =   "Aus|An";
    fontName    =   SPRINT_MENU_FONT_DEFAULT;
	// Position und Dimension	
	posx		= 5000;		posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*3 + SPRINT_MENU_CHOICE_YPLUS;
	dimx = SPRINT_MENU_SLIDER_DX;	dimy 		= 	SPRINT_MENU_CHOICE_DY;
	// Aktionen
    onChgSetOption        = "Weapon"; //Gothic.ini
    onChgSetOptionSection = "NINJA_SPRINT"; //Gothic.ini
	// Weitere Eigenschaften	
	flags		= flags & ~SPRINT_IT_SELECTABLE;
	flags		= flags  | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------PARTY SPRINT--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_PARTY_INST(C_MENU_ITEM_DEF)
{
	text[0]		=	"Begleiter"; //Name
	text[1]		= 	"Begleiter und Gegner rennen ebenfalls (Auch beim Rennen per Taste)"; // Kommentar
	// Position und Dimension	
	posx		=	1000;	posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*4;
	dimx		=	3000;	dimy		=	750;
	// Aktionen
	onSelAction[0]	= SPRINT_SEL_ACTION_UNDEF;
	// Weitere Eigenschaften
	flags			= flags | SPRINT_IT_EFFECTS_NEXT;
};
INSTANCE MENUITEM_DE_NINJA_SPRINT_PARTY_CHOICE(C_MENU_ITEM_DEF)
{
	backPic		=	SPRINT_MENU_CHOICE_BACK_PIC;
	type		=	SPRINT_MENU_ITEM_CHOICEBOX;
    text[0]     =   "Aus|An";
	fontName    =   SPRINT_MENU_FONT_DEFAULT;
	// Position und Dimension	
	posx		= 5000;		posy		=	SPRINT_MENU_START_Y + SPRINT_MENU_DY*4 + SPRINT_MENU_CHOICE_YPLUS;
	dimx = SPRINT_MENU_SLIDER_DX;	dimy 		= 	SPRINT_MENU_CHOICE_DY;
	// Aktionen
    onChgSetOption        = "Party"; //Gothic.ini
    onChgSetOptionSection = "NINJA_SPRINT"; //Gothic.ini
	// Weitere Eigenschaften	
	flags		= flags & ~SPRINT_IT_SELECTABLE;
	flags		= flags  | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------ZURÜCK--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_OPT_BACK(C_MENU_ITEM_DEF)
{
	text[0]		=	"Zurück";
	// Position und Dimension
	posx		=	1000;		posy		=	SPRINT_MENU_BACK_Y+300;
	dimx		=	6192;
	// Aktionen
	onSelAction[0]	= 	SPRINT_SEL_ACTION_BACK;
	// Weitere Eigenschaften
	flags			= flags | SPRINT_IT_TXT_CENTER;
};



/*
 *--------------Tastenzuweisungs Menü--------------
 *
 *------Deutsch------1
 */
INSTANCE MENUITEM_DE_NINJA_SPRINT_KEY(C_MENU_ITEM_DEF)
{
    text[0]             	=   "Rennen";
    text[1]             	=   "Taste ENTF zum Löschen und RETURN zum definieren";

    onSelAction[0]      	=   SPRINT_SEL_ACTION_EXECCOMMANDS;
    onSelAction_S[0]    	=   "RUN MENUITEM_DE_NINJA_SPRINT_INP";
};
INSTANCE MENUITEM_DE_NINJA_SPRINT_INP(C_MENU_ITEM_DEF)
{
    type        			=   SPRINT_MENU_ITEM_INPUT;
    text[1]     			=   "Gewünschte Taste betätigen.";

    onChgSetOption          = "Ninja_Sprint_UseKey";
    onChgSetOptionSection   = "KEYS";
	flags					= flags & ~SPRINT_IT_SELECTABLE;
};