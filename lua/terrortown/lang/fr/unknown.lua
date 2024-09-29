local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[UNKNOWN.name] = "Inconnu"
L["info_popup_" .. UNKNOWN.name] = [[Vous pouvez décider qui vous voulez être...
Faites-vous tuer par quelqu'un pour recevoir son rôle !]]
L["body_found_" .. UNKNOWN.abbr] = "C'était un Inconnu !"
L["search_role_" .. UNKNOWN.abbr] = "C'était un Inconnu !"
L["target_" .. UNKNOWN.name] = "Inconnu"
L["ttt2_desc_" .. UNKNOWN.name] = [[L'Inconnu peut décider (plus ou moins) de son rôle.
Faites-vous tuer par quelqu'un pour recevoir son rôle!]]

-- OTHER ROLE LANGUAGE STRINGS
L["unknown_revival"] = "Vous allez être réanimé!"
L["unknown_revival_text"] = "Vous allez être réanimé en tant que {role} dans {time} seconde(s). Soyez prêt."
L["unknown_revival_canceled"] = "Réanimation annulée"
L["unknown_revival_canceled_text"] = "Votre réanimation a été annulée car votre meurtrier est mort prématurément."

L["label_unknown_respawn_time"] = "Temps de réanimation en secondes"
