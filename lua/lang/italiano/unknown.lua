L = LANG.GetLanguageTableReference("italiano")

-- GENERAL ROLE LANGUAGE STRINGS
L[UNKNOWN.name] = "Unknown"
L["info_popup_" .. UNKNOWN.name] = [[Puoi decidere chi vuoi essere...
Fatti uccidere da qualcuno per prendere il suo ruolo!]]
L["body_found_" .. UNKNOWN.abbr] = "Era un Unknown..."
L["search_role_" .. UNKNOWN.abbr] = "Questa persona era un Unknown!"
L["target_" .. UNKNOWN.name] = "Unknown"
L["ttt2_desc_" .. UNKNOWN.name] = [[L'Unknown può decidere (più o meno) il ruolo.
Fatti uccidere da qualcuno per prendere il suo ruolo!]]

-- OTHER ROLE LANGUAGE STRINGS
--L["unknown_revival"] = "You will be revived!"
--L["unknown_revival_text"] = "You will be revived as {role} in {time} second(s). Be prepared."
--L["unknown_revival_canceled"] = "Revival Canceled"
--L["unknown_revival_canceled_text"] = "Your revival was canceled because your killer died prematurely."
