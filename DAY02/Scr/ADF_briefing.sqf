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
ACO – FIRESTONE<br/>
CAS - AARDFARK<br/>
SatNav AJR - ACE<br/>
VJTF 5 BAT TOC - MOTHER<br/>
NRF 2 SPT GRP - UNCLE<br/><br/>	
Shapur Regional - SATAN<br/>
KENNEDY - KENNEDY<br/>
HUGO - HUGO<br/>
Aegis CP - BALTIMORE<br/><br/>	
Pashtun Forces - JONAH</font><br/><br/>

<font size='14' color='#d7dbd5'>NOTAF</font><br/>

<font color='#9DA698'>
PARIS - Main MSR<br/>
LONDON - Secondary MSR</font><br/><br/></font>

<font size='14' color='#d7dbd5'>CHALLENGES</font><br/>
<font color='#9DA698'>
Challenge: HIGHLANDS<br/>
Password: JUPITER
</font><br/><br/>
"]];

// notes
player createDiaryRecord ["2SOPORD",["Notes","<br/><br/>
<font size='18'>NOTES</font><br/><br/>
<font color='#9DA698'>
The Pashtun started an offensive against oil production districts all over the Middle East and western Asia. Control of oil production will give The Pashtun a financial boost and will enable them to extend and modernize their forces.<br/><br/>
PMC Aegis is contracted to provide security for most oil production sites. The Pashtun offensive took them by surprise. Aegis lost control of most of the Shapur site and retreated back to the airfield where they dug in. Aegis maintains security at check point BALTIMORE and at the Oil Storage Facility. <br/><br/>
MOTHER expects The Pashtun to assault the airfield at dusk on 22 MAY 2015. The primary objective is to defeat the assault and stay in control of the BluFor zone.
</font><br/><br/>
"]];

// command & signal
player createDiaryRecord ["2SOPORD",["Command & Signal","<br/><br/>
<font size='18'>COMMAND AND SIGNAL</font><br/><br/>

<font size='14' color='#d7dbd5'>COMMAND</font><br/>

<font color='#9DA698'>
Commander leader location: SOP, Commanders intent<br/>
Chain of Command: 2 PC, 2 SQL, 2 WTL, 2 FTL<br/><br/>
</font>

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
SOPs in effect for sustainment operations. CCPs to be established on-site. MediVac available at KENNEDY.<br/><br/>
Rations: ammo and material supply in vehicles, NRF SOP<br/>
Uniforms: NRF VJTF 2 PLT SOP<br/>
Arms and ammunitions: NRF VJTF 2 PLT SOP<br/><br/>

<font size='14' color='#d7dbd5'>VEHICLES</font><br/>

PC – 1 x MRAP<br/>
2-1 Squad/2-2 Squad – 4 x MRAP, 2 x MRAP HMG<br/>
2-3 Squad – 2 x MRAP GMG<br/>
Captured material: SOP<br/><br/>
</font>

<font size='14' color='#d7dbd5'>SUPPORT</font><br/>

<font color='#9DA698'>
CAS: AARDVARK, AH-99 ex LMAB. Station: ROMEO.
</font><br/><br/>
"]];

// execution
player createDiaryRecord ["2SOPORD",["Execution","<br/><br/>
<font size='18'>EXECUTION</font><br/><br/>

<font size='14' color='#d7dbd5'>CONCEPT OF OPERATIONS</font><br/>

<font color='#9DA698'>
1. 2PLT to move out ex LMAB towards MSR PARIS. ARR NLT 19:00Z.<br/>
2. 2PLT to regroup at KENNEDY.<br/>
3. 2PLT PC to receiving briefing from Aegis CO.<br/>
4. 2PLT to assist with operations and defences at KENNEDY<br/>
5. ORP’s to be established on-site.<br/>
6. Non-linear and linear danger area’s to be crossed according to SOP.<br/>
7. Execution of mission objectives to be briefed on site by PC.
<br/><br/>
</font>

<font size='14' color='#d7dbd5'>COMMANDERS INTENT</font><br/>

<font color='#9DA698'>
2PLT will travel in SOP convoy formation to MSR PARIS. 2PLT will regroup at KENNEDY and assist Aegis with the defense of KENNEDY. 2PLT 3 will set-up BOF in and around airfield perimeter. 2PLT 1 and 2 will coordinate and establish defensive positions at KENNEDY. 2PLT will patrol the BluFor safe area. 2PLT will control and hold the BluFor safe zone till reinforcements arrive.
<br/><br/></font>

<font size='14' color='#d7dbd5'>SUB UNIT MISSIONS</font><br/>

<font color='#9DA698'>
None.<br/><br/>
</font>

<font size='14' color='#d7dbd5'>COORDINATING INSTRUCTIONS</font><br/>

<font color='#9DA698'>
1. Order of movement, formations: On-site commanders intent, SOP<br/>
2. Actions at halts (short/long): SOP<br/>
3. Routes (primary/alternate): MSR PARIS, MSR LONDON<br/>
4. IRP: MSR PARIS, KENNEDY<br/>
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
2PLT to infil at MSR PARIS NLT 19:00Z. 2PLT to assist PMC Aegis with operations at KENNEDY and HUGO.
</font><br/><br/>
"]];

// situation
player createDiaryRecord ["2SOPORD",["Situation","<br/><br/>
<font size='18'>SITUATION</font><br/><br/>

<font color='#9DA698'>
OpFor: Pashtun forces (JONAH).<br/>
PMC Aegis is tasked with providing security for the oil facilities at Shapur (SATAN).  As off 21 MAY 2019 04:00Z, JONAH has taken control of most of the oil facilities in SATAN. Aegis retreated to the airfield (KENNEDY).  
<br/><br/></font>

<font size='14' color='#d7dbd5'>ENEMY FORCES</font><br/>

<font color='#9DA698'>
1. JONAH controls northern part of Shapur.<br/>
2. Small arms and IFV’s patrol throughout Shapur. JONAH has not crossed red zone since 21 MAY 2015, 11:20Z.<br/>
3. Strength: 20-25 squads + support.<br/>
4. MPCOA: JONAH to assault airfield.<br/>
5. JONAH arms: various small arms, Russian, Iranian and US origin.<br/>
   - AT capability: RPG, MPRL.<br/>
   - IFV’s and MRAP’s. Possible: APC's<br/>
6. JONAH CR: mostly casual clothing + light body armor + improvised vests. Most JONAH carry backpacks with explosives, IED’s and supplies.<br/>

<br/><br/></font>

<font size='14' color='#d7dbd5'>FRIENDLY FORCES</font><br/>

<font color='#9DA698'>
1. VJTF 5 BAT, 2nd Platoon. OUS: ANNEX A.<br/>
2. PMC Aegis, 50% strength
<br/><br/></font>

<font size='14' color='#d7dbd5'>NEUTRAL</font><br/>

<font color='#9DA698'>
None.
<br/><br/></font>

<font size='14' color='#d7dbd5'>CIVILIANS</font><br/>

<font color='#9DA698'>
1. JONAH is holding the majority of the civilian populous hostage in a detainee camp 20 mikes North-West of SATAN.
<br/><br/></font>

<font size='14' color='#d7dbd5'>ATTACHMENTS AND DETACHMENTS</font><br/>

<font color='#9DA698'>
1. Attachments: 1 x AH-99, 6 CAVBAT, 6TH SQDR, ex FOB Calder.<br/>
2. Detachments: none.
</font><br/><br/>
"]];

// terrain & weather
player createDiaryRecord ["2SOPORD",["Terrain & weather","<br/><br/>
<font size='18'>TERRAIN AND WEATHER</font><br/><br/>

<font size='14' color='#d7dbd5'>TERRAIN</font><br/>

<font color='#9DA698'>
1. MSR PARIS provides a handrail for rapid (re-) deployment and assault.<br/>
2. SATAN area offers many vehicle wrecks that provide cover and BOF.<br/>
3. Overall terrain is desert, with MSL ranging from -1.2 m to 6.2 m.<br/>
4. Various petro-chemical installations provide cover and ow positions.<br/>
5. Immediate area surrounding the airfield provides good FOV.<br/>
6. Effects on enemy: usage of facilities for cover and fortification.<br/>
7. Effects on friendly: none.<br/>
8. Key terrain: Arid, desert, sparse vegetation, very limited cover outside of urban and commercial areas.
<br/><br/></font>

<font size='14' color='#d7dbd5'>WEATHER</font><br/>

<font color='#9DA698'>
1. Temperature High: 38C.<br/>
2. Temperature Low: 22C, Dew point: 19C.<br/>
3. Wind: Moderate to strong, 13-29 Knots.<br/>
4. Strong winds cause visibility to drop to <25 meters due to sand dispersion.
</font><br/><br/>
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
Two Sierra Tour 1 | Takistan, May 2019. On 11 February 2019 the Taliban ceased to exist after a coalition forces UAV successfully targeted and killed the entire Taliban leadership council. The majority of Taliban fighters joined The Pashtun within the following weeks.
<br/><br/></font>

<font size='14' color='#d7dbd5'>THE PASHTUN</font><br/>

<font color='#9DA698'>
The Pashtun are a race of warriors who originate from Afghanistan, Takistan and Pakistan. The Pashtun consists of about sixty tribes, each with its own territory.<br/><br/>

The Pashtun has rapidly been expanding its foothold in Asia and the Middle East after the fall of the Taliban, and previously the fall of IS and other factions. The Pashtun are well funded, moderately well organized and very ambitious. Little is known about their goals as they keep a low public relations profile. Intelligence agencies are busy mapping the Pashtun organization. So far reliable intelligence is scares at best.<br/><br/>

CSAT has on several occasions tried to open diplomatic channels. Up till now the Pashtun and CSAT are maintaining neutral relations. Allied Command Operations (ACO) is monitoring the CSAT/Pashtun situation closely.<br/><br/>
Currently The Pashtun are moderately armed with mostly small arms and 2nd generation RPG’s. The BBC reported last week that The Pashtun are in progress of purchasing Iranian-made APC’s and M-ATV’s.  

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