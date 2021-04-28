// Name des Overlays was zum Rennen benutzt wird
var string Ninja_Sprint_Anim;

var int Ninja_Sprint_canPartySprint;

var int isPartyOn;

//************************************************
//   Bestimme Anzahl der Begleiter des Helden
//   die gerade in der KI-Glocke sind und lässt sie gegebenfalls Sprinten wenn auch der Hero Sprintet
//************************************************

func void Ninja_Sprint_getPartyMembers(var C_NPC slf) {

	const int BS_STAND		    =   0	| 32768 | 65536;
	const int BS_RUN            =   3;
    const int ACTION_WATERWALK         = 4;          // oCAniCtrl_Human.actionMode
    const int oCNpc__SetWeaponMode2_G1 = 6904416; //0x695A60
    const int oCNpc__SetWeaponMode2_G2 = 7573120; //0x738E80
	
	var oCNpc party; party = Hlp_GetNpc(slf);
	var oCAniCtrl_Human partyAi; partyAi = _^(party.human_ai);
	
	if (slf.aivar[AIV_PARTYMEMBER] == TRUE || (Npc_GetDistToNpc(slf, hero) < slf.aivar[AIV_FollowDist]))
	&& (Ninja_Sprint_BodyStateContains(slf,BS_STAND) || Ninja_Sprint_BodyStateContains(slf,BS_RUN))//NPC steht oder läuft	
	&& (Ninja_Sprint_canPartySprint == 1)
    && (partyAi.actionMode < ACTION_WATERWALK) {		
		if (!Ninja_Sprint_Mdl_OverlayMdsIsActive(slf, Ninja_Sprint_Anim)) {
			Mdl_ApplyOverlayMds(party, Ninja_Sprint_Anim);
		};		
    } else if (slf.aivar[AIV_PARTYMEMBER] == TRUE || (Npc_GetDistToNpc(slf, hero) > slf.aivar[AIV_FollowDist])) && (Ninja_Sprint_Mdl_OverlayMdsIsActive(slf, Ninja_Sprint_Anim)) && (Ninja_Sprint_canPartySprint == 0){
        // Check if mid-air, copied from GothicFreeAim <http://github.com/szapp/GothicFreeAim>
        if (lf(partyAi._zCAIPlayer_aboveFloor, mkf(10))) {
            Mdl_RemoveOverlayMds(party, Ninja_Sprint_Anim);
            // Fix ranged combat by re-initializing weapon mode
            if (Npc_HasReadiedRangedWeapon(slf)) {
			    var int othPtr; othPtr = _@(party);
				var int fmode; fmode = party.fmode;
				var int zero;
				const int call = 0;
				if (CALL_Begin(call)) {
					CALL_IntParam(_@(zero));
					CALL__thiscall(_@(othPtr), MEMINT_SwitchG1G2(oCNpc__SetWeaponMode2_G1, oCNpc__SetWeaponMode2_G2));
					CALL_IntParam(_@(fmode));
					CALL__thiscall(_@(othPtr), MEMINT_SwitchG1G2(oCNpc__SetWeaponMode2_G1, oCNpc__SetWeaponMode2_G2));
					call = CALL_End();
				};
			};
        };
    };
};

/* 
 * Falls nach dem Starten oder Laden eines Spiels, es bereits einen Begleiter gibt und der Spieler noch nicht gesprintet ist, 
 * wird hier die Party bereits in den Speicher geladen, damit sie vor dem ersten Tastendruck sprinten können, etwas Dirty aber naja :D
 */
func void Ninja_Sprint_initParty() {
	NinjaSprintDoForSphere(Ninja_Sprint_getPartyMembers);
};

/* 
 * Holt sich aus Gothic.ini welche Animation gewählt ist.
 */
func string Ninja_Sprint_getSprintAnim() {
	var int getSprintAnim; getSprintAnim = STR_ToInt(MEM_GetGothOpt("NINJA_SPRINT", "Anim"));
	if (getSprintAnim == 0) {
		return "NINJA_SPRINT_ST.MDS";
	} else if (getSprintAnim == 2) {
		return "HUMANS_SPRINT.MDS";
	};
	return "NINJA_SPRINT_AL.MDS";
};

func void Ninja_Sprint_endSprint() {

    const int oCNpc__SetWeaponMode2_G1 = 6904416; //0x695A60
    const int oCNpc__SetWeaponMode2_G2 = 7573120; //0x738E80 

    var oCNpc her; her = Hlp_GetNpc(hero);
    var oCAniCtrl_Human ai; ai = _^(her.human_ai);
	
	if (lf(ai._zCAIPlayer_aboveFloor, mkf(10))) {
		Mdl_RemoveOverlayMds(her, Ninja_Sprint_Anim);
		if (isPartyOn == 1) {
			Ninja_Sprint_canPartySprint = 0;
			NinjaSprintDoForSphere(Ninja_Sprint_getPartyMembers);
		};
		// Fix ranged combat by re-initializing weapon mode
		if (Npc_HasReadiedRangedWeapon(hero)) {
			var int herPtr; herPtr = _@(her);
            var int fmode; fmode = her.fmode;
            var int zero;
            const int call = 0;
            if (CALL_Begin(call)) {
                CALL_IntParam(_@(zero));
                CALL__thiscall(_@(herPtr), MEMINT_SwitchG1G2(oCNpc__SetWeaponMode2_G1, oCNpc__SetWeaponMode2_G2));
                CALL_IntParam(_@(fmode));
                CALL__thiscall(_@(herPtr), MEMINT_SwitchG1G2(oCNpc__SetWeaponMode2_G1, oCNpc__SetWeaponMode2_G2));
                call = CALL_End();
            };
		};
	};
};


/*
* Abruf
*/
func void Ninja_Sprint_Main() {

	if (!mem_game.timestep) { return; };	
	
	//Prüft Welche Sprache, Standart Sprache 0 wird am anfang Definiert
	var int Ninja_Sprint_Language; Ninja_Sprint_Language = Ninja_Sprint_GuessLocalization();
	
	//Prüft Stärke in Gothic.ini
	var string Ninja_Sprint_Strength; Ninja_Sprint_Strength = MEM_GetGothOpt("NINJA_SPRINT", "Strength");
	
	// Englische Version
	var string Ninja_Sprint_Nicht_Gelernt_1;Ninja_Sprint_Nicht_Gelernt_1 = "I still don't have the strength!"; 
	var string Ninja_Sprint_Nicht_Gelernt_2;Ninja_Sprint_Nicht_Gelernt_2 = ConcatStrings("Strength required: " ,Ninja_Sprint_Strength);

	if (Ninja_Sprint_Language == 1){	// Deutsche Version
        Ninja_Sprint_Nicht_Gelernt_1 = "Dafür fehlt mir noch die Kraft!";
        Ninja_Sprint_Nicht_Gelernt_2 = ConcatStrings("Nötige Stärke: " ,Ninja_Sprint_Strength);		
	} else if (Ninja_Sprint_Language == 2){	// Polnische Version
		Ninja_Sprint_Nicht_Gelernt_1 = "Nadal nie mam si‚y!";
		Ninja_Sprint_Nicht_Gelernt_2 = ConcatStrings("Wymagana si‚a: ",Ninja_Sprint_Strength);
    } else if (Ninja_Sprint_Language == 3){ //Russische Version
		Ninja_Sprint_Nicht_Gelernt_1 = "U menja ese net na èto sil!";
        Ninja_Sprint_Nicht_Gelernt_2 = ConcatStrings("Trebuemaja sila: " ,Ninja_Sprint_Strength);	
	};
	
	//Prüft welche Tasten konfiguriert sind und holt sich die Optionen Party und Perma Sprint
	var int Ninja_Sprint_returnState1;Ninja_Sprint_returnState1 = MEM_KeyState(MEM_GetKey("keyUp"));
	var int Ninja_Sprint_returnState2;Ninja_Sprint_returnState2 = MEM_KeyState(MEM_GetSecondaryKey("keyUp"));
	var string sprintKey; sprintKey = "Ninja_Sprint_UseKey";
	
	var int isPermaSprintActive; isPermaSprintActive = STR_ToInt(MEM_GetGothOpt("NINJA_SPRINT", "Perma"));
	var int sprintWeapon; sprintWeapon = STR_ToInt(MEM_GetGothOpt("NINJA_SPRINT", "Weapon"));	
	var int hasWeapon; hasWeapon = 1;
	isPartyOn = STR_ToInt(MEM_GetGothOpt("NINJA_SPRINT", "Party"));
	
	//Holt sich die gewählte Animation
	Ninja_Sprint_Anim = Ninja_Sprint_getSprintAnim();
	
	const int FMODE_MAGIC			   = 7;
	const int ACTION_WATERWALK         = 4;          // oCAniCtrl_Human.actionMode	
	var oCNpc her; her = Hlp_GetNpc(hero);
    var oCAniCtrl_Human ai; ai = _^(her.human_ai);

/*
 * Und los geht das Sprinten
 */	
	if ((MEM_KeyPressed(MEM_GetKey(sprintKey))) || (MEM_KeyPressed(MEM_GetSecondaryKey(sprintKey))))
	&& hero.attribute[ATR_HITPOINTS] >= 1 //Prüft ob Leben unter 1 ist
	&& hero.attribute[ATR_STRENGTH] >= (STR_ToInt(Ninja_Sprint_Strength)) //Prüft ob die benötigte Stärke vorhanden ist	
	|| ((MEM_KeyPressed(MEM_GetKey("keyUp"))) || (MEM_KeyPressed(MEM_GetSecondaryKey("keyUp")))) && (isPermaSprintActive == 0) //Ist Permanent an? 
	&& hero.attribute[ATR_HITPOINTS] >= 1 //Prüft ob Leben unter 1 ist
	&& hero.attribute[ATR_STRENGTH] >= (STR_ToInt(Ninja_Sprint_Strength)) { //Prüft ob die benötigte Stärke vorhanden ist	
		if 	(ai.actionMode < ACTION_WATERWALK) {
			if (Ninja_Sprint_Npc_IsRunning(hero)) {	
				if (!Ninja_Sprint_Mdl_OverlayMdsIsActive(hero, Ninja_Sprint_Anim)) {
					if((Npc_HasReadiedWeapon(hero)) || (Npc_IsInFightMode(hero, FMODE_MAGIC))) && (sprintWeapon == 0) {
						hasWeapon = 1;
					} else {
						Mdl_ApplyOverlayMds(her, Ninja_Sprint_Anim);
						if (isPartyOn == 1) {
							Ninja_Sprint_canPartySprint = 1;
							NinjaSprintDoForSphere(Ninja_Sprint_getPartyMembers);
						};
					};					
				};
			};
		};
	} else if((MEM_KeyPressed(MEM_GetKey(sprintKey))) || (MEM_KeyPressed(MEM_GetSecondaryKey(sprintKey))))  
	&& (hero.attribute[ATR_STRENGTH] <= (STR_ToInt(Ninja_Sprint_Strength))) {//Prüft ob die benötigte Stärke vorhanden ist
		if (isPermaSprintActive == 0) {};
		PrintScreen(Ninja_Sprint_Nicht_Gelernt_1, -1, -1, "FONT_OLD_10_WHITE.tga", 2);
		PrintScreen(Ninja_Sprint_Nicht_Gelernt_2, 44, 51, "FONT_OLD_10_WHITE.tga", 2);
	} else if (Ninja_Sprint_Mdl_OverlayMdsIsActive(hero, Ninja_Sprint_Anim)) {
		FF_ApplyOnceExtGT(Ninja_Sprint_endSprint, 0, 1);
	}; 
	if(Ninja_Sprint_Mdl_OverlayMdsIsActive(hero, Ninja_Sprint_Anim)) && (sprintWeapon == 0) && (hasWeapon == 1) {
		if (Npc_IsInFightMode(hero, FMODE_MAGIC)) {
			hasWeapon = 0;
			FF_ApplyOnceExtGT(Ninja_Sprint_endSprint, 100, 1);
		} else if(Npc_HasReadiedWeapon(hero)) {
			hasWeapon = 0;
			FF_ApplyOnceExtGT(Ninja_Sprint_endSprint, 900, 1);
		};
	};

/*
 * Falls keyUp zuerst losgelassen wird, hört die Party auch auf zu Sprinten
 */	
	if (isPartyOn == 1)
	&& (isPermaSprintActive == 1)
	&& hero.attribute[ATR_HITPOINTS] >= 1 //Prüft ob Leben unter 1 ist
	&& hero.attribute[ATR_STRENGTH] >= (STR_ToInt(Ninja_Sprint_Strength)) { //Prüft ob die benötigte Stärke vorhanden ist
		if (Ninja_Sprint_returnState1 == KEY_RELEASED || Ninja_Sprint_returnState2 == KEY_RELEASED) 
		&& (Ninja_Sprint_canPartySprint == 1){
			Ninja_Sprint_canPartySprint = 0;
			NinjaSprintDoForSphere(Ninja_Sprint_getPartyMembers);
		} else if (Ninja_Sprint_returnState1 == KEY_PRESSED || Ninja_Sprint_returnState2 == KEY_PRESSED) 
		&& ((MEM_KeyPressed(MEM_GetKey(sprintKey))) || (MEM_KeyPressed(MEM_GetSecondaryKey(sprintKey)))) 
		&& (Ninja_Sprint_canPartySprint == 0) {
			Ninja_Sprint_canPartySprint = 1;
			NinjaSprintDoForSphere(Ninja_Sprint_getPartyMembers);
		};
	};
};