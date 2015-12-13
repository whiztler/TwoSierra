/****************************************************************
ARMA Mission Development Framework
ADF version: 1.42 / SEPTEMBER 2015

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
- Delete All by Anjan.<br/><br/>
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
ACO	- FAIRCHILD<br/>
CAS	- RAVEN<br/>
SatNav AJR - ACE<br/>
VJTF 5 BAT TOC - MOTHER<br/>
NRF 2 SPT GRP - UNCLE<br/>
Chernarussian Armed Forces - DONALD<br/><br/>

BALOTA AB - FARGO<br/>
Ammo Cache - BULLDOG<br/>
Search Grid - NOVEMBER<br/><br/>

Soborian Separatists - KUJO<br/>
CSAT Russian Forces - BORIS

</font><br/><br/><font size='14' color='#d7dbd5'>NOTAF</font><br/>

<font color='#9DA698'>
VEGAS - Primary MSR<br/>
YORK - Secondary MSR

<br/><br/></font><font size='14' color='#d7dbd5'>CHALLENGES</font><br/>

<font color='#9DA698'>
Challenge: TRUMP<br/>
Password: BUSH
</font><br/><br/>
"]];

// notes
player createDiaryRecord ["2SOPORD",["Notes","<br/><br/>
<font size='18'>NOTES</font><br/><br/>
<font color='#9DA698'>
Soborian Separatists have launched blitz attacks in combination with artillery barrages on cities in the green zone. Last nights’ barrages caused hundreds of civilian casualties. Widespread coverage on global media resulted in NATO finally getting a mandate to assist CAF (DONALD) with the security of Eastern Chernarus. Time to get some real work done! <br /><br />
MOTHER believes that the Soborian Separatists are trying to break through to Solnichniy and create a corridor that divides the green CAF zone. This will result in Disha AB being cut-off by road.<br />
The Soborian Separatists are being supplied from various cache locations north of Balota AB. Finding and destroying these weapons and ammunition caches will slow down the Soborian Separatists advance and will give CAF time to regroup.
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
SOPs in effect for sustainment operations. CCPs to be established on-site. MediVac available at FARGO.<br/><br/>
Rations: ammo and material supply in vehicles, NRF SOP<br/>
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
CAS: RABBIT, AH-99 ex FARGO. Station: DELTA
</font><br/><br/>
"]];

// execution
player createDiaryRecord ["2SOPORD",["Execution","<br/><br/>
<font size='18'>EXECUTION</font><br/><br/>

<font size='14' color='#d7dbd5'>CONCEPT OF OPERATIONS</font><br/>

<font color='#9DA698'>
1. 2PLT to move out ex FARGO and drive north towards DONALD CP via YORK.<br/>
2. 2PLT to enter NOVEMBER grid.<br/>
3. 2PLT to search and destroy BULLDOG.<br/>
4. 2PLT to return to FARGO for debrief.<br/>
5. ORP’s to be established prior to departure.<br/>
6. Execution of mission objectives to be briefed on site by PC.

<br/><br/></font>

<font size='14' color='#d7dbd5'>COMMANDERS INTENT</font><br/>

<font color='#9DA698'>
2PLT will travel in SOP convoy to NOVEMBER. 2PLT will locate BULLDOG. 2PLT destroy BULLDOG. 2PLT will travel in SOP convoy to FARGO. 
<br/><br/></font>

<font size='14' color='#d7dbd5'>SUB UNIT MISSIONS</font><br/>

<font color='#9DA698'>
None.<br/><br/>
</font>

<font size='14' color='#d7dbd5'>COORDINATING INSTRUCTIONS</font><br/>

<font color='#9DA698'>
1. Order of movement, formations: On-site commanders intent, SOP<br/>
2. Actions at halts (short/long): SOP<br/>
3. Routes (primary/alternate): MSR YORK / MSR VEGAS.<br/>
4. IRP: MSR YORK.<br/>
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
Search and destroy ammo caches in NOVEMBER grid.
</font><br/><br/>
"]];

// situation
player createDiaryRecord ["2SOPORD",["Situation","<br/><br/>
<font size='18'>SITUATION</font><br/><br/>

<font color='#9DA698'>
OpFor: Soborian Separatists (KUJO) and Armed Forces of the Russian Federation (BORIS).<br/>
KUJO’s recent successes partly depend on their ability to rapidly re-supply their forces. MOTHER suggests they have various ammo caches hidden throughout the Soborian grid. 
<br/><br/>
</font>

<font size='14' color='#d7dbd5'>ENEMY FORCES</font><br/>

<font color='#9DA698'>
1. KUJO has a moderate presence in most urban areas north of the green zone.<br/>
2. BORIS is actively patrolling the Russian grid. ACE suggests they cross over into the Soborian zone occasionally.<br/>
3. KUJO: Small arms and IFV’s patrol north of the green zone and occasionally cross over into DONALD territory.<br/>
4. Strength KUJO: Est. 3000-4000 separatists in the Sobor Province.<br/>
5. Strength BORIS: 3 Infantry Battalions, 1 Cavalry Battalion and 2 Air Wings + support coy’s. Est. 2700 pax.<br/>
6. MPCOA: Additional security for BULLDOG locations. No intel on reinforcements.<br/>
7. KUJO arms: various small arms, mostly Russian, some Iranian and unknown origin. <br/>
   AT capability: RPG, MPRL.<br/>
8. KUJO CR: mostly casual clothing + light body armor + improvised vests. Most KUJO carry backpacks with IED’s and limited supplies.

<br/><br/>
</font>

<font size='14' color='#d7dbd5'>FRIENDLY FORCES</font><br/>

<font color='#9DA698'>
1. VJTF 5 BAT, 2nd Platoon. OUS: ANNEX A.<br/>
2. NRF 2 SPT GRP at FARGO.<br/>
3. CAF 3rd and 4th BATT at Disha AB.<br/>
4. CAF 2nd AIRBORN INF BRIG at Elektrozavodsko

<br/><br/>
</font>

<font size='14' color='#d7dbd5'>NEUTRAL</font><br/>

<font color='#9DA698'>
1. None<br/><br/>
</font>

<font size='14' color='#d7dbd5'>CIVILIANS</font><br/>

<font color='#9DA698'>
1. Civilians in the AO are generally neutral towards coalition forces.
</font><br/><br/>

<font size='14' color='#d7dbd5'>ATTACHMENTS AND DETACHMENTS</font><br/>

<font color='#9DA698'>
Attachments: 1 x AH-99, 6 CAVBAT, 6TH SQDR, ex FARGO.<br/>
Detachments: none.
</font><br/><br/>
"]];

// terrain & weather
player createDiaryRecord ["2SOPORD",["Terrain & weather","<br/><br/>
<font size='18'>TERRAIN AND WEATHER</font><br/><br/>

<font size='14' color='#d7dbd5'>TERRAIN</font><br/>

<font color='#9DA698'>
1.	225 Km2 of which 100+ Km2 forest areas and rocky coastlines.<br/>
2.	Semi-mountainous. MSL ranging from 0.1 m to 714.15 m.<br/>
3.	Four MSR’s running from North to South and West to North.<br/>
4.	MSR tarmac roads are off good quality. Dirt roads off-side MSR’s.<br/>
5.	Forest areas provide good cover. <br/>
6.	Largest cities are concentrated in the South and South East. Various industrial installations in proximity of large cities.<br/>
7.	Smaller village’s inland, situated in deep valleys, hidden in forested ridges or on elevated plateaus with lush meadows.<br/>
8.	Effects on enemy: usage of forests for cover and operating bases.<br/>
9.	Effects on friendly: hill and forest provide cover even when travelling on the MSR’s.<br/>
10.	Key terrain: Lush, Forest, dense vegetation, 
<br/><br/>
</font>

<font size='14' color='#d7dbd5'>WEATHER</font><br/>

<font color='#9DA698'>
1.	Temperature High: 17C.<br/>
2.	Temperature Low: 11C, Dew point: 14C.<br/>
3.	Wind: Moderate, 7-12 Knots.
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
07. If you play with ACE3 enabled, please note that Two Sierra<br/>
    missions have advanced ballistics and advanced medical<br/>
    settings enabled by default.<br/>
08. Most missions offer CAS support. CAS can be called in by the<br/>
    platoon commander using the action menu.<br/>
09. Two Sierra has a pre-configured platoon radio net.<br/>
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
- All in ARMA Terrain Pack (AIATP)<br/><br/>

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
- All in ARMA Terrain Pack (AIATP)<br/><br/>
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
Two Sierra Tour 2 | Chernarus, June 2019. Since CSAT Russia annexed the Lopatino district in 2014 a local insurgency faction emerged and declared the Sobor region as independent. Aptly naming it Soborisk. The Soborian Separatists quickly gained ground with the unofficial support of CSAT Russia. Over the years several attempts have been made to solve the crisis, but neither Chernarussian Government nor the Soborian separatists were willing to give in. Now, nearly 4 years later, CSAT Russia has issued an ultimatum to the Chernarussian Government: 'recognize Soborisk as an independent state'. All diplomatic solutions seem to have been exhausted.<br /><br /> 
Two Sierra is relieving Third Platoon who has been training Chernarussian Armed Forces (CAF) and assisting with humanitarian operations. NRF forces are considered neutral. NATO does not have a mandate to get involved in the escalation between Soborian Separatists and CAF. That said, last week a patrol from Third Platoon got engaged by presumably Soborian Separatists. And two weeks ago a HEMTT from 2ND SPT GRP was taken out by an improvised explosive device. On both occasions, vehicles were clearly marked as NRF vehicles. Things are heating up and the world is watching. 
<br/><br/></font>

<font size='14' color='#d7dbd5'>SOBORIAN SEPARATISTS</font><br/>

<font color='#9DA698'>
In April 2014, pro-Russian activists seized control of government buildings in towns and cities across the Sobor region. The events were a repeat of what had happened in the Lopatino region. .<br /><br />
Gunmen there seized government buildings in February 2014 and raised the Russian flag a week after elected President Boris Yanukotov, friendly to Moscow, fled during massive pro-EU street protests in Novigrad. An early attempt by nationalists to remove the status of Russian as a second language alarmed many Russian speakers, and officials in Moscow portrayed the new leaders in Novigrad as NATO-backed Chernarussian nationalists bent on violating minority rights. A flawed referendum on joining Russia was quickly held in Lopatino and within a month the region's annexation was complete. .<br /><br />
There was little bloodshed in Lopatino, but Chernarus' fledgling revolutionary government was in no position to fight back, with only 6,000 troops reportedly ready for combat. However, when pro-Russian separatists made a move on Chernarus' industrial east and Russian forces appeared to be building up on the borders, the authorities in Novigrad ordered an 'anti-terrorist operation'. The start of a conflict that has dragged on for nearly 5 years.
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