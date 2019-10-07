if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_unk.vmt")
end

function ROLE:PreInitialize()
	self.color = Color(190, 207, 210, 255) -- ...
	self.dkcolor = Color(95, 135, 143, 255) -- ...
	self.bgcolor = Color(255, 242, 230, 255) -- ...
	self.abbr = "unk" -- abbreviation
	self.unknownTeam = true
	self.surviveBonus = 1 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 2 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -4 -- multiplier for teamkill
	self.preventWin = true -- set true if role can't win (maybe because of own / special win conditions)
	
	self.defaultTeam = TEAM_NONE -- the team name: roles with same team name are working together
	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment

	self.conVarData =  {
		pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 6, -- minimum amount of players until this role is able to get selected
		random = 10 -- randomness of getting this role selected in a round
	}
end

function ROLE:Initialize()
	if CLIENT then -- just on client and first init !
		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", self.name, "Unknown")
		LANG.AddToLanguage("English", "info_popup_" .. self.name, [[You can decide who you want to be...]])
		LANG.AddToLanguage("English", "body_found_" .. self.abbr, "This was an Unknown...")
		LANG.AddToLanguage("English", "search_role_" .. self.abbr, "This person was an Unknown!")
		LANG.AddToLanguage("English", "target_" .. self.name, "Unknown")
		LANG.AddToLanguage("English", "ttt2_desc_" .. self.name, [[The Unknown can decide (more or less) the role.
	Get killed by someone to copy the role of your killer!]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", self.name, "Unbekannter")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. self.name, [[Du hast die Wahl, wer du sein willst...]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. self.abbr, "Er war ein Unbekannter...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. self.abbr, "Diese Person war ein Unbekannter!")
		LANG.AddToLanguage("Deutsch", "target_" .. self.name, "Unbekannter")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. self.name, [[Die Unbekannten können sich ihre Rolle (mehr oder weniger) aussuchen.
	Werde von jemanden getötet, um dessen Rolle zu kopieren.]])
	end
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

			if IsValid(killer) and not ply.reviving then

				-- revive after 3s
				ply:Revive(3, function(p)
					if SIDEKICK and killer:GetSubRole() == ROLE_SIDEKICK then
						killer = killer:GetSidekickMate() or nil
					end

					if IsValid(killer) and killer:IsActive() then
						p:SetRole(killer:GetSubRole(), killer:GetTeam())
						p:SetDefaultCredits()

						SendFullStateUpdate()
					end
				end,
				function(p)
					return IsValid(p) and IsValid(killer) and killer:IsActive() and killer:Alive()
				end)
			end
		end
	end)
end
