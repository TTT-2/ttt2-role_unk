if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_unk.vmt")

	-- CONVAR HANDLING
	CreateConVar("ttt_unknown_respawn_time", 3, {FCVAR_NOTIFY, FCVAR_ARCHIVE})

	hook.Add("TTT2SyncGlobals", "ttt2_unknown_sync_convars", function()
		SetGlobalInt("ttt_unknown_respawn_time", GetConVar("ttt_unknown_respawn_time"):GetInt())
	end)

	cvars.AddChangeCallback("ttt_unknown_respawn_time", function(cv, old, new)
		SetGlobalInt("ttt_unknown_respawn_time", tonumber(new))
	end)
end

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_unknown_convars", function(tbl)
	tbl[ROLE_UNKNOWN] = tbl[ROLE_UNKNOWN] or {}

	table.insert(tbl[ROLE_UNKNOWN], {cvar = "ttt_unknown_respawn_time", slider = true, min = 0, max = 60, decimal = 0, desc = "ttt_unknown_respawn_time (def. 3)"})
end)

function ROLE:PreInitialize()
	self.color = Color(190, 207, 210, 255)

	self.abbr = "unk" -- abbreviation
	self.unknownTeam = true
	self.surviveBonus = 1 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 2 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -4 -- multiplier for teamkill
	self.preventWin = true -- set true if role can't win (maybe because of own / special win conditions)

	self.defaultTeam = TEAM_NONE -- the team name: roles with same team name are working together
	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment

	self.conVarData = {
		pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 6, -- minimum amount of players until this role is able to get selected
		random = 10 -- randomness of getting this role selected in a round
	}
end

if SERVER then
	util.AddNetworkString("ttt2_net_unknown_show_popup")

	local function ShowPopup(ply, killer, id)
		net.Start("ttt2_net_unknown_show_popup")
		net.WriteString(id)
		net.WriteBool(true)
		net.WriteUInt(killer:GetSubRole(), ROLE_BITS)
		net.Send(ply)
	end

	local function RemovePopup(ply, id)
		net.Start("ttt2_net_unknown_show_popup")
		net.WriteString(id)
		net.WriteBool(false)
		net.Send(ply)
	end

	-- NOTIFY KILLED UNKNOWNS THAT THEIR KILLER DIED
	hook.Add("PostPlayerDeath", "ttt2_role_unknown_killer_death", function(ply)
		vics = ply.killedUnknownsTable

		if not vics or #vics == 0 then return end

		for i = 1, #vics do
			local vic = vics[i]

			RemovePopup(vic, "unknownRevival")
			ShowPopup(vic, ply, "unknownRevivalCanceled")
		end
	end)

	-- HANDLE UNKNOWN PLAYER DEATH
	hook.Add("TTT2PostPlayerDeath", "ttt2_role_unknown_death", function(victim, inflictor, attacker)
		if victim:GetSubRole() ~= ROLE_UNKNOWN or victim:IsReviving() then return end

		if not IsValid(attacker) or not attacker:IsPlayer()
			or attacker:GetSubRole() == ROLE_UNKNOWN or attacker:GetSubRole() == ROLE_INFECTED
		then return end

		-- add player to killer table in case he prematureley dies
		attacker.killedUnknownsTable[#attacker.killedUnknownsTable + 1] = victim

		-- show revival info popup
		ShowPopup(victim, attacker, "unknownRevival")

		-- start revival provess
		victim:Revive(GetGlobalInt("ttt_unknown_respawn_time", 10),
			function(p)
				-- reset confirm Unknown player, in case their body was confirmed
				p:ResetConfirmPlayer()

				if SIDEKICK and attacker:GetSubRole() == ROLE_SIDEKICK then
					attacker = attacker:GetSidekickMate() or nil
				end

				p:SetRole(attacker:GetSubRole(), attacker:GetTeam())
				p:SetDefaultCredits()

				SendFullStateUpdate()

				-- remove victim from victim table so he will no longer be
				-- notified about the attacker death
				table.RemoveByValue(attacker.killedUnknownsTable, p)
			end,
			function(p)
				return IsValid(p) and IsValid(attacker) and attacker:IsActive() and attacker:Alive()
			end,
			true,
			true
		)
	end)

	hook.Add("TTTBeginRound", "ttt2_role_unknown_reset", function()
		local plys = player.GetAll()

		for i = 1, #plys do
			plys[i].killedUnknownsTable = {}
		end
	end)
end

if CLIENT then
	net.Receive("ttt2_net_unknown_show_popup", function()
		local client = LocalPlayer()
		client.epopId = client.epopId or {}

		local id = net.ReadString()
		local shouldAdd = net.ReadBool()

		if shouldAdd then
			local role = roles.GetRoleByIndex(net.ReadUInt(ROLE_BITS))

			if id == "unknownRevival" then
				client.epopId[id] = EPOP:AddMessage(
					{
						text = LANG.GetTranslation("unknown_revival"),
						color = INNOCENT.ltcolor
					},
					LANG.GetParamTranslation("unknown_revival_text", {role = LANG.GetTranslation(role.name), time = GetGlobalInt("ttt_unknown_respawn_time", 10)}),
					GetGlobalInt("ttt_unknown_respawn_time", 10)
				)
			elseif id == "unknownRevivalCanceled" then
				client.epopId[id] = EPOP:AddMessage(
					{
						text = LANG.GetTranslation("unknown_revival_canceled"),
						color = COLOR_ORANGE
					},
					LANG.GetTranslation("unknown_revival_canceled_text"),
					10
				)
			end
		else
			if client.epopId[id] then
				EPOP:RemoveMessage(client.epopId[id])
			end
		end
	end)
end
