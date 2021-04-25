local L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[UNKNOWN.name] = "Неизвестный"
L["info_popup_" .. UNKNOWN.name] = [[Вы можете решить, кем вы хотите быть...
Надо чтобы вас кто-то убил, чтобы получить роль своего убийцы!]]
L["body_found_" .. UNKNOWN.abbr] = "Он был Неизвестным."
L["search_role_" .. UNKNOWN.abbr] = "Этот человек был Неизвестным!"
L["target_" .. UNKNOWN.name] = "Неизвестный"
L["ttt2_desc_" .. UNKNOWN.name] = [[Неизвестный может решить (более или менее) о своей роли.
Надо чтобы вас кто-то убил, чтобы получить роль своего убийцы!]]

-- OTHER ROLE LANGUAGE STRINGS
L["unknown_revival"] = "Вы воскреснете!"
L["unknown_revival_text"] = "Вы будете возрождены как {role} через {time} сек. Будьте готовы."
L["unknown_revival_canceled"] = "Возрождение отменено"
L["unknown_revival_canceled_text"] = "Ваше возрождение было отменено, потому что ваш убийца умер преждевременно."
