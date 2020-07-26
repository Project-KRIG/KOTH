King Of The Hill
=

What is KOTH?
=

King of the Hill is a "hold the area" game mode where three teams compete against each other. The team with the most players in the designated area will gain points. If there are equal amounts of allied and enemy team members in the area, then no points are awarded until someone takes the lead. Once a team has 100 points it is game over.


How Do I install KOTH on my server?
=

It's pretty simple

1. Download the latest Koth-[Version Number] from the [releases](https://github.com/The-Neco/KOTH/releases) section of this repo.
2. Drag the `koth` folder to the resources folder in your server. (Make sure the folder name is all lowercase `koth` otherwise the UI will not work)
3. Add `ensure baseevents` to your `server.cfg`
4. Add `ensure koth` to your `server.cfg`
5. Start your server and your done!

Server Configuration
=

In `shared/init.lua` there are a few lines that allow for configuration of the gamemode.

`KOTH.Debug` This turns on more logging for the gamemode, only use this if you are experiencing issues with the gamemode.</br>
`KOTH.XPTimer` This is the time in sconds that it takes for the player to gain XP inside the zone.</br>
`KOTH.PointTimer` This is the time in seconds that it takes for teams to gain a point.</br>
`KOTH.PrioZoneTimer` This is the time in seconds that it takes for the priority circle to move.</br>
`Koth.WinThreshold` This is the amount of points needed to win.</br>
`KOTH.Spawn` This is where the players with no team spawn for the first time.</br>

Another file you are able to edit is the `shared/maps.lua` this file allows you to add more mapps to the gamemode.

A map is added by adding another value to the table `KOTH.Maps` a template is given to you below. (Please note that the car and helicopter spawns are planned for a future release and are not functional as of yet)

```lua
[2] = {
Circle = {Coords = {x = 0.0, y = 0.0, z = 0.0},Size = 300.0,PlayersInside = {}}, -- This is the XYZ coordinates and the size of the main circle.
Spawns = {
  ["Yellow"] = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}}, -- This is the XYZ coordinates for the spawn of the Yellow team.
  ["Blue"] = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}}, -- This is the XYZ coordinates for the spawn of the Blue team.
  ["Green"] = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}}, -- This is the XYZ coordinates for the spawn of the Green team.
},
```

The last file you are able to edit is `shared/levels.lua` this file manages level names and thier required XP.

To add another level you need to add another value to the table `KOTH.Levels` a template is given to you below (Please note that at this current time levels do not change any aspect of the game nor do players know thier level, this is planned for a future release.)

```lua
[11] = {
  Threshold = 1000000, -- this is the amount of XP needed to achieve this rank, players are reset to 0 every time they rank up.
  Rank = "Sergeant Major" -- this is the name of the rank.
},
```

Roadmap
=

- [x] Add a "resource needs updating" warning to the console if the server owners version is out of date.
- [ ] Add vehicles to the gamemode
- [ ] Add weapon shops where players are able to use thier money to buy different guns for this life.
- [ ] Allow the player to see thier rank, XP and money
- [x] Add exports to allow for external resources to interact with KOTH

If you find any bugs or have any sugestions to add to the resource please add them to the forum post on the fivem forums or submit a feature request using the [issues](https://github.com/The-Neco/KOTH/issues) section of github.

Want to contribute?

Submit a pull request and I'll take a look, if it is something that will benifit the resource then I will consider adding it to the master branch.
