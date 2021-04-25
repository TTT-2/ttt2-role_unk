local L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[UNKNOWN.name] = "Unbekannter"
L["info_popup_" .. UNKNOWN.name] = [[Du hast die Wahl, wer du sein willst...
Werde von jemanden getötet, um dessen Rolle zu kopieren.]]
L["body_found_" .. UNKNOWN.abbr] = "Er war ein Unbekannter..."
L["search_role_" .. UNKNOWN.abbr] = "Diese Person war ein Unbekannter!"
L["target_" .. UNKNOWN.name] = "Unbekannter"
L["ttt2_desc_" .. UNKNOWN.name] = [[Die Unbekannten können sich ihre Rolle (mehr oder weniger) aussuchen.
Werde von jemanden getötet, um dessen Rolle zu kopieren.]]

-- OTHER ROLE LANGUAGE STRINGS
L["unknown_revival"] = "Du witst wiederbelebt!"
L["unknown_revival_text"] = "Du wirst in {time} Sekunde(n) als {role} wiederbeleben. Sei vorbereitet."
L["unknown_revival_canceled"] = "Wiederbelebung abgebrochen."
L["unknown_revival_canceled_text"] = "Deine Wiederbelebung wurde abgebrochen, da dein Mörder zu früh gestorben ist."
