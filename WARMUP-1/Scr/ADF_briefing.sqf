/****************************************************************
ARMA Mission Development Framework
ADF version: 1.41 / JULY 2015

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

player createDiaryRecord ["Diary",["Credits","
<br/><br/><font size='18'>CREDITS</font><br/><br/>
<font color='#9DA698'>Concept and development: whiztler

</font><br/><br/><font size='14' color='#d7dbd5'>SPECIAL THANKS TO:</font><font color='#9DA698'><br/>
- XXXX
- XXXX
- XXXX

</font><br/><br/>"]];


///// OPORD

player createDiarySubject ["2SOPORD","Two Sierra OPORD"];

player createDiaryRecord ["2SOPORD",["Warmup","<br/><br/>
<font size='18'>TWO SIERRA WamUp</font><br/><br/>
<font color='#6c7169'>
WarmUp for a TWO SIERRA mission, train your (motorized) infantry skill and/or test the community mods required for the missions.<br/><br/>
The Island of Porto is an excellent training ground for rapid deployment warmup missions. Porto City is well defended by 100+ Pashtun forces. 
Several victors patrol the island. The Pashtun are notorious for their IED skills. The IED's are nearly impossible to disarm.<br/><br/>
The warmup mission ends once all OpFOR Pashtun forces have been neutralized.
<br/><br/></font>

<font size='14' color='#d7dbd5'>PLAYER RESPAWN / PLAYER JIP</font><br/>
<font color='#6C7169'>
- Respawn: 30 seconds at JOHNSON. You can teleport to your team leader using the NRF flagpole at base.<br/>
- JIP is enabled.
</font><br/><br/>

<font size='14' color='#d7dbd5'>LOADOUT AND SUPPLIES</font><br/>
<font color='#6C7169'>
- Vanilla role-specific loadout.<br/>
- Additional supplies are available in the vehicles.
</font><br/><br/>
"]];


///// CAMPAIGN

player createDiarySubject ["2SCPGN","Two Sierra Campaign"];

player createDiaryRecord ["2SCPGN",["Mission Testing","<br/><br/>
<font size='18'>MISSION TESTING</font><br/><br/>

<font color='#9DA698'>
Each mission has its own 'Mission Objectives Test Script' to test mission critical triggers and exfil. The script works in a dedicated server environment and can be evoked by a server admin (or anyone who has server admin access).<br/><br/>
1.	Make sure you are logged in as server admin<br/>
2.	Hit the escape key to bring up the 'debug console';<br/>
3.	in the execute window enter: null = execVM 'mots.sqf';<br/>
4.	Click on GLOBAL EXEC (or LOCAL EXEC if testing in mission editor).<br/>
5.	Follow instructions as presented on screen in-game.

</font><br/><br/>"]];

player createDiaryRecord ["2SCPGN",["Server information","<br/><br/>
<font size='18'>SERVER INFORMATION</font><br/><br/>

<font size='14' color='#d7dbd5'>REQUIRED ADD-ONS</font><br/>
<font color='#9DA698'>
The server requires the following add-ons:<br/><br/>
- Community Based Addons ARMA 3 (CBA_A3)<br/>
- All in ARMA Terrain Pack (AIATP)<br/><br/>

Two Sierra missions have been tested (to work with) with the optional AI behavior add-on ASR AI.
</font><br/><br/>

<font size='14' color='#d7dbd5'>SERVER SETTINGS</font><br/>
<font color='#9DA698'>
Recommend server settings for optimal gameplay:<br/><br/>
Difficulty: Expert.<br/>
Style: COOP.<br/>
Slots: 37 (34 players + 3 optional Headless Client).<br/>
Duration: 2-3 hours depending on style of gameplay.
</font><br/><br/>"]];

player createDiaryRecord ["2SCPGN",["Client Information","<br/><br/>
<font size='18'>CLIENT INFORMATION</font><br/><br/>

<font size='14' color='#d7dbd5'>REQUIRED ADD-ONS</font><br/>
<font color='#9DA698'>
The Two Sierra campaign requires the following Add-Ons:<br/><br/>
- Community Based Addons ARMA 3 (CBA_A3)<br/>
- All in ARMA Terrain Pack (AIATP)<br/><br/>
<font size='14' color='#d7dbd5'>RECOMMENDED ADD-ONS</font><br/>
To enhance gameplay, the following client add-ons are recommended:<br/><br/>
- Advanced Combat Radio Environment (ACRE 2) -or-<br/>
  Taskforce Arrowhead Radio (TFAR)<br/>
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
Two Sierra SOP: one command element, two rifle squads and one weapons squad. Total 34 pax.
</font><br/><br/>
"]];

player createDiaryRecord ["2SCPGN",["Background","<br/><br/>
<font size='18'>BACKGROUND</font><br/><br/>

<font color='#9DA698'>
On 11 February 2019 the Taliban ceased to exist after a coalition forces UAV successfully targeted and killed the entire Taliban leadership council. The majority of Taliban fighters joined The Pashtun within the following weeks.
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
Two Sierra is a CO-37 multiplayer (34 player slots) NRF infantry campaign for MilSim communities. Volume 1 consists of 4 challenging missions and a warm-up mission. 
<br/><br/></font>

<font size='14' color='#d7dbd5'>FEATURES</font><br/>

<font color='#9DA698'>
- 4 missions offering challenging and immersive gameplay in a lively<br/>
  area of operations;<br/>
- 1 Warm-up Mission for warming up, mod-line testing and general<br/>
  training;<br/>
- Detailed OPORD’s (in-game and PDF/TXT for forum briefings);<br/>
- Optimized for dedicated server play;<br/>
- Challenging opponents;<br/>
- Automatic detection of ACRE2, TFAR, cTab and ACE3 add-ons.
</font><br/><br/>

<font size='14' color='#d7dbd5'>LICENSE</font><br/>

<font color='#9DA698'>
The Two Sierra campaign is licensed under the Arma Public License (APL).

</font><br/><br/>"]];