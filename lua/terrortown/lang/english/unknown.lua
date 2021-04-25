local L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[UNKNOWN.name] = "Unknown"
L["info_popup_" .. UNKNOWN.name] = [[You can decide who you want to be...
Get killed by someone to receive the role of your killer!]]
L["body_found_" .. UNKNOWN.abbr] = "They were an Unknown."
L["search_role_" .. UNKNOWN.abbr] = "This person was an Unknown!"
L["target_" .. UNKNOWN.name] = "Unknown"
L["ttt2_desc_" .. UNKNOWN.name] = [[The Unknown can decide (more or less) about his role.
Get killed by someone to receive the role of your killer!]]

-- OTHER ROLE LANGUAGE STRINGS
L["unknown_revival"] = "You will be revived!"
L["unknown_revival_text"] = "You will be revived as {role} in {time} second(s). Be prepared."
L["unknown_revival_canceled"] = "Revival Canceled"
L["unknown_revival_canceled_text"] = "Your revival was canceled because your killer died prematurely."
