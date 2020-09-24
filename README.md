King Of The Hill
=
Made by Neco and chip.

What is KOTH?
=

King of the Hill is a "hold the area" game mode where three teams compete against each other. The team with the most players in the designated area will gain points. If there are equal amounts of allied and enemy team members in the area, then no points are awarded until someone takes the lead. Once a team has 100 points it is game over.

Requirements
=

The most up to date version of `baseevents` from [cfx-server-data](https://github.com/citizenfx/cfx-server-data) is required to register player kills. (<b>Please use [this](https://github.com/The-Neco/cfx-server-data) repo until PR [114](https://github.com/citizenfx/cfx-server-data/pull/114) is merged into CFX-Server-Data.</b>)

How Do I install KOTH on my server?
=

It's pretty simple

1. Download the latest CFX-Server-Data from [here](https://github.com/citizenfx/cfx-server-data). (<b>Please use [this](https://github.com/The-Neco/cfx-server-data) repo until PR [114](https://github.com/citizenfx/cfx-server-data/pull/114) is merged into CFX-Server-Data.</b>)
2. Download the latest koth from the [releases](https://github.com/The-Neco/KOTH/releases/latest) section of this repo.
3. Drag the `KOTH` folder to the resources folder in your server.
4. Add `ensure baseevents` to your `server.cfg`
5. Add `ensure KOTH` to your `server.cfg`
6. Start your server and your done!

Server Configuration
=

In `shared/init.lua` there are a few lines that allow for configuration of the gamemode.

`KOTH.Debug` This turns on more logging for the gamemode, only use this if you are experiencing issues with the gamemode.</br>
`KOTH.XPTimer` This is the time in sconds that it takes for the player to gain XP inside the zone.</br>
`KOTH.PointTimer` This is the time in seconds that it takes for teams to gain a point.</br>
`KOTH.PrioZoneTimer` This is the time in seconds that it takes for the priority circle to move.</br>
`Koth.WinThreshold` This is the amount of points needed to win.</br>
`KOTH.Spawn` This is where the players with no team spawn for the first time.</br>
`KOTH.LockTeamsIfUneaven` This will lock the teams if they are uneven.</br>
`KOTH.FriendlyFire` This toggles friendly fire.</br>
`KOTH.TimeEnabled` This toggles time being enabled `true` = Time will tick for all clients `false` = Time will be frozen for all clients.</br>
`KOTH.WeatherEnabled` This toggles weather being enabled `true` = Weather will change if the percentage check succeeds. `false` = The weather will be frozen for all clients.</br>
`KOTH.WeatherTypes` This is a table of all of the weather types enabled for this gamemode, remove/add ones that you want.</br>
`KOTH.Mumble.Config.Range` This is the range that players can hear other players on local chat.</br>
`KOTH.Mumble.Config.RadioControl` This is the control key for the radio's push to talk.</br>
`KOTH.ShowMap` This toggles the minimap.</br>
`KOTH.Weapons` This is a table containing all of the weapons in the shop. (use weapons already in the table as an example to add more)</br>

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

Roadmap/TODO List
=

- [x] Add a "resource needs updating" warning to the console if the server owners version is out of date.
- [ ] Add vehicles shop to the gamemode where players can purchase vehicles depending on thier level.
- [x] Add weapon shops where players are able to use thier money to buy different guns for this life.
- [x] Allow the player to see thier rank, XP and money.
- [x] Add exports to allow for external resources to interact with KOTH.
- [x] Add a friendly fire config option.
- [x] Add spawn immunity to prevent spawn camping.
- [x] Add a spawn guard to maybe restrict players from entering enemy team spawns.
- [x] Update UI's to look better.
- [x] Add chat commands (bug report, help, etc.).
- [x] Add local voip system.
- [x] Add radio system for team radios.
- [x] Add mumble filters for radio sounds.
- [x] TP/kill players if they go outside the AOP.
- [x] Make weather and time sync across clients.

If you find any bugs or have any sugestions to add to the resource please add them to the forum post on the fivem forums or submit a feature request using the [issues](https://github.com/The-Neco/KOTH/issues) section of github.

Want to contribute?

Submit a pull request and I'll take a look, if it is something that will benifit the resource then I will consider adding it to the master branch.
