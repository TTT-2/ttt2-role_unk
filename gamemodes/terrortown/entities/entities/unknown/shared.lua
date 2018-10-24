if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/icon_unk.vmt")
	resource.AddFile("materials/vgui/ttt/sprite_unk.vmt")
end

-- important to add roles with this function,
-- because it does more than just access the array ! e.g. updating other arrays
InitCustomRole("UNKNOWN", { -- first param is access for ROLES array => ROLES.UNKNOWN or ROLES["UNKNOWN"]
		color = Color(0, 0, 0, 255), -- ...
		dkcolor = Color(50, 50, 50, 255), -- ...
		bgcolor = Color(50, 50, 50, 200), -- ...
		name = "unknown", -- just a unique name for the script to determine
		abbr = "unk", -- abbreviation
		team = "unks", -- the team name: roles with same team name are working together
		unknownTeam = true,
		defaultEquipment = SPECIAL_EQUIPMENT, -- here you can set up your own default equipment
		surviveBonus = 1, -- bonus multiplier for every survive while another player was killed
		scoreKillsMultiplier = 2, -- multiplier for kill of player of another team
		scoreTeamKillsMultiplier = -4, -- multiplier for teamkill
		preventWin = true -- set true if role can't win (maybe because of own / special win conditions)
	}, {
		pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 6, -- minimum amount of players until this role is able to get selected
		random = 10 -- randomness of getting this role selected in a round
})

-- if sync of roles has finished
hook.Add("TTT2_FinishedSync", "UnkInitT", function(ply, first)
	if CLIENT and first then -- just on client and first init !
		infMat = Material("vgui/ttt/sprite_" .. ROLES.UNKNOWN.abbr)

		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", ROLES.UNKNOWN.name, "Unknown")
		LANG.AddToLanguage("English", "info_popup_" .. ROLES.UNKNOWN.name, [[You can decide who you want to be...]])
		LANG.AddToLanguage("English", "body_found_" .. ROLES.UNKNOWN.abbr, "This was an Unknown...")
		LANG.AddToLanguage("English", "search_role_" .. ROLES.UNKNOWN.abbr, "This person was an Unknown!")
		LANG.AddToLanguage("English", "target_" .. ROLES.UNKNOWN.name, "Unknown")
		LANG.AddToLanguage("English", "ttt2_desc_" .. ROLES.UNKNOWN.name, [[The Unknown can decide (more or less) the role.
Get killed by someone to copy the role of your killer!]])

		-- optional for toggling whether player can avoid the role
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.UNKNOWN.abbr, "Avoid being selected as Unknown!")
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.UNKNOWN.abbr .. "_tip",
		[[Enable this to ask the server not to select you as Unknown if possible. Does not mean you are Traitor more often.]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", ROLES.UNKNOWN.name, "Unbekannter")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. ROLES.UNKNOWN.name, [[Du hast die Wahl, wer du sein willst...]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. ROLES.UNKNOWN.abbr, "Er war ein Unbekannter...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. ROLES.UNKNOWN.abbr, "Diese Person war ein Unbekannter!")
		LANG.AddToLanguage("Deutsch", "target_" .. ROLES.UNKNOWN.name, "Unbekannter")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. ROLES.UNKNOWN.name, [[Die Unbekannten können sich ihre Rolle (mehr oder weniger) aussuchen.
Werde von jemanden getötet, um dessen Rolle zu kopieren.]])

		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.UNKNOWN.abbr, "Vermeide als Unbekannter ausgewählt zu werden!")
		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.UNKNOWN.abbr .. "_tip",
		[[Aktivieren, um beim Server anzufragen, nicht als Unbekannter ausgewählt zu werden. Das bedeuted nicht, dass du öfter Traitor wirst!]])
	end
end)

if SERVER then
	hook.Add("PlayerDeath", "UnknownDeath", function(victim, infl, attacker)
		if victim:GetRole() == ROLES.UNKNOWN.index and IsValid(attacker) and attacker:IsPlayer() and attacker:GetRole() ~= ROLES.UNKNOWN.index then
			victim.unknownKiller = attacker
		end
	end)

	hook.Add("PostPlayerDeath", "UnknownPostDeath", function(ply)
		if ply:GetRole() == ROLES.UNKNOWN.index and IsValid(ply.unknownKiller) then
			timer.Simple(1, function() -- respawn delay
				ply:SetRole(ROLES.INNOCENT.index)
				ply:SpawnForRound(true)

				local killer = ply.unknownKiller

				ply.unknownKiller = nil

				ply:UpdateRole(killer:GetRole())
				ply:SetDefaultCredits()

				SendFullStateUpdate()
			end)
		end
	end)
end
