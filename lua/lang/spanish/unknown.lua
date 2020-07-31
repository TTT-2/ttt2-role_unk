L = LANG.GetLanguageTableReference("spanish")

-- GENERAL ROLE LANGUAGE STRINGS
L[UNKNOWN.name] = "Incógnito"
L["info_popup_" .. UNKNOWN.name] = [[Puedes decidir quién ser...
¡Sé asesinado y obtiene el rol de tu asesino!]]
L["body_found_" .. UNKNOWN.abbr] = "¡Era un Incógnito!"
L["search_role_" .. UNKNOWN.abbr] = "Esta persona era un Incógnito."
L["target_" .. UNKNOWN.name] = "Incógnito"
L["ttt2_desc_" .. UNKNOWN.name] = [[El Incógnito puede decidir (más o menos) qué rol tener.
Al ser asesinado, obtienes el rol de esa persona y reaparecerás luego de unos segundos.]]

-- OTHER ROLE LANGUAGE STRINGS
L["unknown_revival"] = "¡Serás revivido!"
L["unknown_revival_text"] = "Serás revivido como {role} en {time} segundos. Prepárate."
L["unknown_revival_canceled"] = "Reaparición cancelada"
L["unknown_revival_canceled_text"] = "Tu reaparición fue cancelada porque tu asesino murió prematuramente."
