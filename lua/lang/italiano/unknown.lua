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
L["unknown_revival"] = "Verrai rianimato!"
L["unknown_revival_text"] = "Verrai rianimato come {role} in {time} secondi. Stai pronto!."
L["unknown_revival_canceled"] = "Rianimazione cancellata"
L["unknown_revival_canceled_text"] = "La tua rianimazione è stata cancellata perchè il tuo assassino è morto prematuramente."
