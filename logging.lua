local LOGLEVEL = { 
    OFF   = 0,
    ERROR = 1,
    WARN  = 2,
    INFO  = 3,
    DEBUG = 4,
}

WHOA_LIB_LOGLEVEL_CHARSTATS = "INFO"

-- # msg    = the message that should be logged
-- # lvl    = the level of that message
-- # loglvl = the loglevel of the addon
function whoaLog(msg, lvl, loglvl, addon)
    local color = WHOA_LIB_COLOR_WHITE
    if lvl == "ERROR" then
        color = WHOA_LIB_COLOR_RED
    elseif lvl == "WARN" then
        color = WHOA_LIB_COLOR_ORANGE
    elseif lvl == "DEBUG" then
        color = WHOA_LIB_COLOR_BLUE
    end
    -- # check configuration
    if LOGLEVEL[loglvl] >= LOGLEVEL[lvl] and loglevel ~= nil and loglevel ~= "OFF" then
        print("|cff"..WHOA_LIB_COLOR_GOLD.."[|r |cff"..color..lvl.."|r |cff"..WHOA_LIB_COLOR_GOLD.."] [|r "..addon.." |cff"..WHOA_LIB_COLOR_GOLD.."]|r "..msg)
    end
end

------------------------------
WHOA_LIB_LOGGING_LOADED = true
------------------------------
