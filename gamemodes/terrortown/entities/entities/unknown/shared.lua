if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/icon_unk.vmt")
	resource.AddFile("materials/vgui/ttt/sprite_unk.vmt")
end

-- important to add roles with this function,
-- because it does more than just access the array ! e.g. updating other arrays
InitCustomRole("UNKNOWN", { -- first param is access for ROLES array => UNKNOWN or ROLES["UNKNOWN"]
		color = Color(150, 150, 150, 255), -- ...
		dkcolor = Color(46, 46, 46, 255), -- ...
		bgcolor = Color(120, 120, 120, 255), -- ...
		abbr = "unk", -- abbreviation
		defaultTeam = TEAM_NONE, -- the team name: roles with same team name are working together
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

if CLIENT then -- just on client and first init !
	-- if sync of roles has finished
	hook.Add("TTT2FinishedLoading", "UnkInitT", function()
		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", UNKNOWN.name, "Unknown")
		LANG.AddToLanguage("English", "info_popup_" .. UNKNOWN.name, [[You can decide who you want to be...]])
		LANG.AddToLanguage("English", "body_found_" .. UNKNOWN.abbr, "This was an Unknown...")
		LANG.AddToLanguage("English", "search_role_" .. UNKNOWN.abbr, "This person was an Unknown!")
		LANG.AddToLanguage("English", "target_" .. UNKNOWN.name, "Unknown")
		LANG.AddToLanguage("English", "ttt2_desc_" .. UNKNOWN.name, [[The Unknown can decide (more or less) the role.
Get killed by someone to copy the role of your killer!]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", UNKNOWN.name, "Unbekannter")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. UNKNOWN.name, [[Du hast die Wahl, wer du sein willst...]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. UNKNOWN.abbr, "Er war ein Unbekannter...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. UNKNOWN.abbr, "Diese Person war ein Unbekannter!")
		LANG.AddToLanguage("Deutsch", "target_" .. UNKNOWN.name, "Unbekannter")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. UNKNOWN.name, [[Die Unbekannten können sich ihre Rolle (mehr oder weniger) aussuchen.
Werde von jemanden getötet, um dessen Rolle zu kopieren.]])
	end)
end

if SERVER then
	hook.Add("PlayerDeath", "UnknownDeath", function(victim, infl, attacker)
		if victim:GetSubRole() == ROLE_UNKNOWN and IsValid(attacker) and attacker:IsPlayer() and attacker:GetSubRole() ~= ROLE_UNKNOWN then
			if INFECTED and attacker:GetSubRole() == ROLE_INFECTED then return end

			victim.unknownKiller = attacker
		end
	end)

	hook.Add("PostPlayerDeath", "UnknownPostDeath", function(ply)
		if ply:GetSubRole() == ROLE_UNKNOWN then
			local killer = ply.unknownKiller

			ply.unknownKiller = nil

			if IsValid(killer) then

				-- revive after 3s
				ply:Revive(3, function(p)
					if SIDEKICK and killer:GetSubRole() == ROLE_SIDEKICK then
						killer = killer:GetSidekickMate() or nil
					end

					if IsValid(killer) and killer:IsActive() then
						p:UpdateRole(killer:GetSubRole(), killer:GetTeam())
						p:SetDefaultCredits()

						SendFullStateUpdate()
					end
				end,
				function(p)
					return IsValid(p) and IsValid(killer) and killer:IsActive()
				end)
			end
		end
	end)
end
