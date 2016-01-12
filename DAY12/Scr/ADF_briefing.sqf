/****************************************************************
ARMA Mission Development Framework
ADF version: 1.43 / JANUARY 2016

Script: Mission Briefing
Author: Whiztler
Script version: 1.41

Game type: COOP
File: ADF_Briefing.sqf
****************************************************************
Instructions:

Note the reverse order of topics. Start from the bottom.
Change the "Text goes here..." line with your info. Use a <br/> to
start a new line.
****************************************************************/

diag_log "ADF RPT: Init - executing briefing.sqf"; // Reporting. Do NOT edit/remove
if (!hasInterface) exitWith {};

///// CREDITS
player createDiaryRecord ["Diary",["Credits","<br/>
<img width='380' height='380' image='Img\NRF_credit.paa'/>
<br/><br/><font size='18'>CREDITS</font><br/><br/>
<font color='#9DA698'>
Concept and development: whiztler
</font><br/><br/>

<font size='14' color='#d7dbd5'>2SIERRA.COM</font><font color='#9DA698'><br/>
<font color='#9DA698'>
More information and latest version of the Two Sierra campaign can be found at the official website: www.2sierra.com
</font><br/><br/>

<font size='14' color='#d7dbd5'>SPECIAL THANKS TO</font><font color='#9DA698'><br/>
- Bohemia Interactive for creating the ultimate MilSim<br/>
  platform.<br/>
- Nopryl Community (nopryl.no) for testing.<br/>
- CBA Team for creating and maintaining their CBA framework.<br/>
- Kju/CUP team for keeping the ARMA2 maps alive.<br/>
- ACE team for spicing up the ARMA3 MilSim experience.
</font><br/><br/>

<font size='14' color='#d7dbd5'>TOOLING AND SCRIPTS</font><font color='#9DA698'><br/>
The Two Sierra campaign uses the following tooling/scripts (with thanks to the authors):<br/>
- F3 Spectator from the F3 Framework.<br/>
- TAW View Distance by Tonic.<br/>
- ZBE_caching by Zorrobyte.<br/>
- MAD Ambient Life by MAD T.<br/>
- Repetitive Cleanup by Aeroson.<br/><br/>
The Two Sierra campaign is powered by ADF.
</font><br/><br/>

<font size='14' color='#d7dbd5'>OTHER MISSIONS/CAMPAIGNS</font><font color='#9DA698'><br/>

- Wolfpack Volume 1 (http://whiztler.github.io/Wolfpack).<br/>
- Wolfpack Volume 2 (http://whiztler.github.io/Wolfpack).
</font><br/><br/>"]];

///// OPORD
player createDiarySubject ["2SOPORD","Two Sierra OPORD"];

// call signs
player createDiaryRecord ["2SOPORD",["Call Signs","<br/><br/>
<font size='18'>CALL SINGS</font><br/><br/>

<font color='#9DA698'>
ACO	- VADER<br/>
SatNav AJR - ACE<br/>
VJTF 5 BAT TOC - MOTHER<br/>
NRF 2 SPT GRP - UNCLE<br/>
Sahr. Armed Forces - TOMMY<br/><br/>
	
VIPER def grids	ALPHA, OSCAR, DELTA, ZULU<br/><br/>
	
CSAT Quds - VIPER

</font><br/><br/><font size='14' color='#d7dbd5'>NOTAF</font><br/>

<font color='#9DA698'>
NICE - Primary MSR

<br/><br/></font><font size='14' color='#d7dbd5'>CHALLENGES</font><br/>

<font color='#9DA698'>
Challenge: BIGMAC<br/>
Password: JUGGERNAUT
</font><br/><br/>
"]];

// notes
player createDiaryRecord ["2SOPORD",["Notes","<br/><br/>
<font size='18'>NOTES</font><br/><br/>
<font color='#9DA698'>
CSAT is trying to get away. Operation WARLORD triggered a full retreat. They had this planned all along. CSAT is using commercial aircraft to evac personnel and research material. A Boeing 797 lands every 15 minutes.<br/><br/>
MOTHER anticipated CSAT’s evac plans and put together a flash strike operation. MOTHER wishes to capture as many assets and personnel as possible. Unfortunately NATO cannot stop the commercial aircraft from arriving and leaving Paraiso airport.<br/><br/>
Two Sierra will join 3RD and 4TH PLT to form a strike force. It is vital that the airport is secured as soon as possible. End game time!
</font><br/><br/>
"]];

// command & signal
player createDiaryRecord ["2SOPORD",["Command & Signal","<br/><br/>
<font size='18'>COMMAND AND SIGNAL</font><br/><br/>

<font size='14' color='#d7dbd5'>COMMAND</font><br/>

<font color='#9DA698'>
Commander leader location: SOP, Commanders intent<br/>
Chain of Command: 2 PC, 2 SQL, 2 WTL, 2 FTL
<br/><br/></font>

<font size='14' color='#d7dbd5'>SIGNAL</font><br/>

<font color='#9DA698'>
Frequencies and call signs: Annex B<br/>
Pyrotechnics and signals: SOP<br/>
Challenges and passwords: Annex B<br/>
Code words: SOP
</font><br/><br/>
"]];

// service & support
player createDiaryRecord ["2SOPORD",["Service & Support","<br/><br/>
<font size='18'>SERVICE AND SUPPORT</font><br/><br/>

<font size='14' color='#d7dbd5'>SUPPLY</font><br/>

<font color='#9DA698'>
SOPs in effect for sustainment operations. CCPs to be established on-site.<br/><br/>
Rations: Rations: ammo and material supply in vehicles, NRF SOP. NRF SOP. 2SPG has 1 Ammo truck in hangar 2. Ample medical supplies can be found in hangar 1..<br/>
Uniforms: NRF VJTF 2 PLT SOP<br/>
Arms and ammunitions: NRF VJTF 2 PLT SOP

</font><br/><br/><font size='14' color='#d7dbd5'>VEHICLES</font><br/>

<font color='#9DA698'>
PC – 1 x MRAP<br/>
2-1 Squad/2-2 Squad – 4 x MRAP, 2 x MRAP HMG<br/>
2-3 Squad – 2 x MRAP GMG<br/>
Captured material: SOP
<br/><br/></font>

<font size='14' color='#d7dbd5'>SUPPORT</font><br/>

<font color='#9DA698'>
Via 5 BAT:<br/>
1. CAS: FIREBIRD, 2 x AH-99 ex CVN-78. Station: VICTOR.<br/>
2. CAP: KINGKONG 2 x A-164 ex MILAN. Station: FOXTROT<br/>
3. CAP: CONDOR: 4 x F-35G ex CVN-78. Station: NOVEMBER.

</font><br/><br/>
"]];

// execution
player createDiaryRecord ["2SOPORD",["Execution","<br/><br/>
<font size='18'>EXECUTION</font><br/><br/>

<font size='14' color='#d7dbd5'>CONCEPT OF OPERATIONS</font><br/>

<font color='#9DA698'>
1. 2PLT to move out ex BRONSON and drive NORTH to RV with 3RD and 4TH PLT.
2. 2PLT to assault OSCAR grid.
3. 2PLT to assault and secure Paraiso AB.
4. ORP’s to be established prior to departure.
5. Execution of mission objectives to be briefed on site by PC.
<br/><br/></font>

<font size='14' color='#d7dbd5'>COMMANDERS INTENT</font><br/>

<font color='#9DA698'>
2PLT will travel in SOP convoy to grid. 1150.1010, where 2PLT will RV with 3PLT and 4PLT . 2PLT will join the assault of OSCAR and secure the Paraiso airbase.
<br/><br/></font>

<font size='14' color='#d7dbd5'>SUB UNIT MISSIONS</font><br/>

<font color='#9DA698'>
None.<br/><br/>
</font>

<font size='14' color='#d7dbd5'>COORDINATING INSTRUCTIONS</font><br/>

<font color='#9DA698'>
1. Order of movement, formations: On-site commanders intent, SOP<br/>
2. Actions at halts (short/long): SOP<br/>
3. Routes (primary/alternate): MSR TAMPA.<br/>
4. IRP: MSR TAMPA.<br/>
5. Actions at danger areas: SOP<br/>
6. Actions on enemy contact: SOP<br/>
7. Reorganization and consolidation: SOP<br/>
8. Fire control measures: On-site commanders intent, SOP<br/>
9. Priority Intelligence Requirements: On-site, MOTHER<br/>
10. Debriefing requirements: Commanders intent<br/>
11. Reports: ACE: SOP, SALUTE: SOP<br/>
12. ROE: On-site commanders intent, SOP
</font><br/><br/>
"]];

// mission
player createDiaryRecord ["2SOPORD",["Mission","<br/><br/>
<font size='18'>MISSION</font><br/><br/>
<font color='#9DA698'>
Assault OSCAR and secure Paraiso AB.
</font><br/><br/>
"]];

// situation
player createDiaryRecord ["2SOPORD",["Situation","<br/><br/>
<font size='18'>SITUATION</font><br/><br/>

<font color='#9DA698'>
OpFor: CSAT 3rd Quds (WOLF).
<br/><br/>
</font>

<font size='14' color='#d7dbd5'>ENEMY FORCES</font><br/>

<font color='#9DA698'>
1. VIPER M.O.B. is at Paraiso AB.<br/>
2. VIPER has concentrated its defensive forces at ALPHA, DELTA and OSCAR.<br/>
3. Paraiso and Paraiso AB have been fortified.<br/>
4. CSAT 3RD Quds unit 4oo has taken up positions around ZULU.<br/>
5. ALPHA: 3 x MBT sqdr, 2 x mech inf coy, 1 x PMA sqdr plus supporting elements.<br/>
6. DELTA: 5-7 x para inf coy, 1 x mech inf coy, 3 x Heli Transport Sqdr, 2 x Heli Attack sqdr plus supporting elements.<br/>
7. OSCAR: 2 x inf coy, 1 x SF coy, 1 x mech inf coy. <br/>
8. MPCOA: VIPER to secure captured research and evac ex Paraiso AB.<br/>
9. VIPER arms: Superior CSAT arms incl. LRR sniper, thermal capability.<br/>
   AT capability: MPRL.<br/>
10. VIPER CR: Superior CR. CSAT Special forces outfit with customized body armor.
<br/><br/>
</font>

<font size='14' color='#d7dbd5'>FRIENDLY FORCES</font><br/>

<font color='#9DA698'>
1. VJTF 5 BAT, 2nd Platoon. OUS: ANNEX A.<br/>
2. VJTF 5 BAT 1ST, 3RD, 4TH, 5TH Platoon.<br/>
3. 22SPT, 1st and 3RD Section stationed ex BRUSSELS.<br/>
4. 4 VJTF Recon ex LIMA.<br/>
5. 2SPT at CONAN.<br/>
6. NRF 5 BAT HQ.<br/>
7. CVN-78 Carrier Support Group.<br/>
8. 2 SAF INF BAT.
<br/><br/>
</font>

<font size='14' color='#d7dbd5'>NEUTRAL</font><br/>

<font color='#9DA698'>
1. None<br/><br/>
</font>

<font size='14' color='#d7dbd5'>CIVILIANS</font><br/>

<font color='#9DA698'>
1. Civilians in the AO are generally indifferent towards coalition forces.
<br/><br/></font>

<font size='14' color='#d7dbd5'>ATTACHMENTS AND DETACHMENTS</font><br/>

<font color='#9DA698'>
1. Attachments: none.<br/>
2. Detachments: none.
<br/><br/></font>
"]];

// terrain & weather
player createDiaryRecord ["2SOPORD",["Terrain & weather","<br/><br/>
<font size='18'>TERRAIN AND WEATHER</font><br/><br/>

<font size='14' color='#d7dbd5'>TERRAIN SOUTH ISLAND</font><br/>

<font color='#9DA698'>
1. 112 Km2 semi-arid and mountainous with sandy coastlines.<br/>
2. MSL ranging from 0.1 m to 397 m.<br/>
3. Two MSR’s running from North to South and East to West.<br/>
4. MSR tarmac roads are off good quality.<br/>
5. Largest cities are concentrated in the East, South East and North of the Island. Various industrial installations in proximity of large cities.<br/>
6. Smaller village’s around the coast south and west of the Island.<br/>
7. Effects on enemy: usage of urban areas and mountainous areas for cover and operating bases.<br/>
8. Effects on friendly: None.<br/>
9. Key terrain: Semi-arid, sparse vegetation in lower areas.
<br/><br/>
</font>

<font size='14' color='#d7dbd5'>WEATHER</font><br/>

<font color='#9DA698'>
1. Temperature High: 27C.<br/>
2. Temperature Low: 20C, Dew point: 18C.<br/>
3. Wind: Moderate, 11-14 Knots.<br/>
4. Clear, dry.
<br/><br/></font>
"]];

///// CAMPAIGN
player createDiarySubject ["2SCPGN","Two Sierra Campaign"];

player createDiaryRecord ["2SCPGN",["Game Master/Commander Info","<br/><br/>
<font size='18'>GAME MASTER/COMMANDER INFORMATION</font><br/><br/>
<font color='#9DA698'>
Game Masters/Commanders, please note the following:<br/><br/>
01. All Two Sierra missions have pre-defined objectives.<br/>
02. All communication (hints) is logged in the 'Two Sierra log'<br/>
    which can be accessed from the map screen menu.<br/>
03. Please pay attention to additional objective orders or end<br/>
    mission information. Check the log frequently.<br/>
04. All missions have been play tested. If you discover a bug,<br/>
    please report the bug on the BIS forum or on GitHub. Contact<br/>
    information can be found on 2sierra.com.<br/>
05. Usage of 1 or more headless clients is recommended for smooth<br/>
    game play. AI's are automatically distributed across multiple<br/>
    headless clients for optimal performance.<br/>
    Note that AI's are spawned on the server. The load balancer kicks<br/>
    in after 120 seconds after mission start.<br/>
05. Most missions are time-sensitive. Command will be informed in<br/>
    case they run out of time (2-3 hours, depending on the<br/>
    mission).<br/>
06. All player roles are equipped with pre-defined role loadout.<br/>
    Additional gear and supplies can be found in the vehicles.<br/>
07. Most missions offer CAS support. CAS can be called in by the<br/>
    platoon commander using the action menu.<br/>
08. Two Sierra has a pre-configured platoon radio net.<br/>
    Settings/frequencies can be found under 'Two Sierra Roster'<br/>
    in the map screen menu	
<br/><br/>
<font size='14' color='#d7dbd5'>FEEDBACK</font><br/>
I would love to hear feedback about your game night. If you have a YouTube cam recording or screen shots, please let me know. I'll post them on the 2sierra.com website.<br/><br/>
Contact details and links can be found on 2sierra.com.<br/><br/>
I hope your community/clan have as much fun playing the missions as I had making them!<br/><br/>
-Whiz
</font><br/><br/>"]];

player createDiarySubject ["2SCPGN","Two Sierra Campaign"];

player createDiaryRecord ["2SCPGN",["Mission Testing","<br/><br/>
<font size='18'>MISSION TESTING</font><br/><br/>

<font color='#9DA698'>
Each mission has its own 'Mission Objectives Test Script' to test mission critical triggers and exfil. The script works in a dedicated server environment and can be evoked by a server admin (or anyone who has server admin access).<br/><br/>
1. Make sure you are logged in as server admin<br/>
2. Hit the escape key to bring up the 'debug console';<br/>
3. In the execute window enter: null = execVM 'mots.sqf';<br/>
4. Click on SERVER EXEC (or LOCAL EXEC if you are testing<br/>
   in the mission editor);<br/>
5. Follow instructions as presented on screen in-game.<br/><br/>
Please note that when testing from within the ARMA III editor, the mission load time is longer as the client (player) and the server are considered the same.
</font><br/><br/>"]];

player createDiaryRecord ["2SCPGN",["Server information","<br/><br/>
<font size='18'>SERVER INFORMATION</font><br/><br/>

<font size='14' color='#d7dbd5'>REQUIRED ADD-ONS</font><br/>
<font color='#9DA698'>
The server requires the following add-ons:<br/><br/>
- Community Based Addons ARMA 3 (CBA_A3)<br/>
- All in ARMA Terrain Pack (AIATP) or CUP Terrains<br/><br/>

Two Sierra missions have been tested (to work with) with the optional AI behaviour add-on ASR AI.
</font><br/><br/>

<font size='14' color='#d7dbd5'>SERVER SETTINGS</font><br/>
<font color='#9DA698'>
Recommend server settings for optimal game play:<br/><br/>
Difficulty: Expert.<br/>
Style: COOP.<br/>
Slots: 37 (30 + 4 players + 3 optional Headless Client).<br/>
Duration: 2-3 hours depending on style of game play.
</font><br/><br/>"]];

player createDiaryRecord ["2SCPGN",["Client Information","<br/><br/>
<font size='18'>CLIENT INFORMATION</font><br/><br/>

<font size='14' color='#d7dbd5'>REQUIRED ADD-ONS</font><br/>
<font color='#9DA698'>
The Two Sierra campaign requires the following Add-Ons:<br/><br/>
- Community Based Addons ARMA 3 (CBA_A3)<br/>
- All in ARMA Terrain Pack (AIATP) or CUP Terrains<br/><br/>
<font size='14' color='#d7dbd5'>RECOMMENDED ADD-ONS</font><br/>
To enhance game play, the following client add-ons are recommended:<br/><br/>
- Advanced Combat Radio Environment (ACRE 2) -or-<br/>
  TaskForce Arrowhead Radio (TFAR)<br/>
- Commanders Tablet (cTAB)<br/>
- Advanced Combat Environment 3 (ACE3). 
<br/><br/></font>
"]];

player createDiaryRecord ["2SCPGN",["NRF VJTF 2 SIERRA","<br/><br/>
<font size='18'>NRF VJTF 2 SIERRA</font><br/><br/>

<font color='#9DA698'>
The NRF is a highly ready and technologically advanced multinational force made up of land, air, maritime and Special Operations Forces (SOF) components that NATO can deploy quickly, wherever needed. NATO Allies decided to enhance the NRF in 2014 by creating a “spearhead force” within it, known as the Very High Readiness Joint Task Force (VJTF).<br/><br/>
Two Sierra, or 2 Sierra is a VJTF platoon, currently based at the temporarily home of NRF 5 BAT in Doha. Highly flexible, motivated and well trained, Two Sierra is seen by many as the pride of NRF.
<br/><br/></font>

<font size='14' color='#d7dbd5'>ORBAT</font><br/>
<img width='380' height='380' image='Img\ORBAT_NRF_5-1-2PLT.paa'/>
<font color='#9DA698'>
Two Sierra SOP: one command element, two rifle squads and one weapons squad. Total 30 pax.
</font><br/><br/>
"]];

player createDiaryRecord ["2SCPGN",["Background","<br/><br/>
<font size='18'>BACKGROUND</font><br/><br/>

<font color='#9DA698'>
Two Sierra Tour 3 | Sahrani, September 2019.  On 19 August 2019, elements of CSAT’s elite 3rd Quds Brigade invaded the South Island of the United Republic of Sahrani (URS). The Sahrani Armed Forces (SAF) were taken by surprise. After a short and decisive operation, the SAF were forced to retreat to the north island. CSAT quickly took control of the South Island, including the Republic’s capital Corazol.<br/><br/>
It is unclear why CSAT has taken such an interest in Sahrani. Besides the Oil facilities at Cayo, Sahrani offers little of value in terms of minerals, industry or military assets. An Aegis detail was tasked with the security of the oil facilities at Cayo. At this point the current status of the Aegis detail is unknown. <br/><br/>
The URS is a member of NATO. All diplomatic avenues have seized as CSAT has denied any involvement and refuses to commit to any form of dialogue.<br/><br/>
Elements of 4th VJTF Recon carried out an operation to assess CSAT’s forces on the South Island. It seems that CSAT 3RD Quds has quickly established themselves at all major strategic POI’s.<br/><br/>
Two NATO recon UAV’s were shot down as soon as they entered the air space of the South Island. ACE has been unable to obtain quality intelligence on CSAT movements and activity due to bad weather. 
<br/><br/></font>

<font size='14' color='#d7dbd5'>CSAT 3RD QUDS</font><br/>

<font color='#9DA698'>
CSAT Quds is a Special Forces unit of Iran's Revolutionary Guards responsible for their extraterritorial operations. Little is known about the secretive CSAT Quds. It was formed during the Iran – Iraq war. It has since then provided support for insurgent forces around the Middle East and Asia. NATO believes CSAT Quds is responsible for training and arming The Pashtun. NATO MIS believes there are 5 brigades with 800-2500 operators and support units each. CSAT Quds recruit the best of the best from all elements of the CSAT Armed Forces across formally Iran, Iraq, Russia, China and United Korea. Members are chosen both for their skill and ‘allegiance to the doctrine of the Islamic Revolution’.<br/><br/>
3rd Quds is a joint operations unit consisting of special forces, elements of the 112 special operations air division and elements of the elite 5th armored republican brigade. This joint operations rapid expeditionary force is believed to be responsible for recent operational successes in Afghanistan, Takistan and India. 

</font><br/><br/>
"]];

player createDiaryRecord ["2SCPGN",["About TWO SIERRA Campaign","<br/><br/>
<font size='18'>ABOUT TWO SIERRA CAMPAIGN</font><br/><br/>

<font size='14' color='#d7dbd5'>DESCRIPTION</font><br/>

<font color='#9DA698'>
Two Sierra is a CO-37 multiplayer (30 + 4 player slots) NRF infantry campaign for MilSim communities. Three tours with each tour consisting of 4 challenging missions and a warm-up mission.
<br/><br/></font>

<font size='14' color='#d7dbd5'>FEATURES</font><br/>

<font color='#9DA698'>
- 30 Player slots + 4 JIP Support Slots + 3 (optional) headless<br/>
  clients.<br/>
- 4 missions per tour, offering challenging and immersive game play<br/>
  in a lively area of operations;<br/>
- Warm-up Missions for warming up, mod-line testing and general<br/>
  training;<br/>
- Detailed OPORD’s (in-game and PDF/TXT for forum briefings);<br/>
- Join in Progress (JIP) supported.;<br/>
- No respawn;<br/>
- Optimized for dedicated server play with up to 3 headless clients<br/>
  with load balancing;<br/>
- Challenging opponents;<br/>
- Automatic detection of ACRE2, TFAR, cTab and ACE3 add-ons.
</font><br/><br/>

<font size='14' color='#d7dbd5'>LICENSE</font><br/>

<font color='#9DA698'>
The Two Sierra campaign is licensed under the Arma Public License (APL).

</font><br/><br/>"]];