
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

                -- Don't forget to include your character's custom assets!
        Asset( "ANIM", "anim/zenel.zip" ),
}
local prefabs = {}

local fn = function(inst)
        
        -- choose which sounds this character will play
        inst.soundsname = "wilson"

        -- a minimap icon must be specified
        inst.MiniMapEntity:SetIcon( "wilson.png" )

        -- Double the cold resistance, equivalent to about a puffy vest and a little bit.
        inst.components.temperature.inherentinsulation = TUNING.INSULATION_LARGE + 10 -- 250

        -- 1/4 damage if cold
        --inst.compnents.combat.damagemultiplier =
end


-- strings! Any "WOD" below would have to be replaced by the prefab name of your character.

-- First up, the character select screen lines 
-- note: these are lower-case character name
STRINGS.CHARACTER_TITLES.zenel = "The Coder"
STRINGS.CHARACTER_NAMES.zenel = "Zenel"
STRINGS.CHARACTER_DESCRIPTIONS.zenel = "* I am one with the demons.\n* More resistant to the cold."
STRINGS.CHARACTER_QUOTES.zenel = "\"¡A la chingada!\""

-- You can also add any kind of custom dialogue that you would like. Don't forget to make
-- categores that don't exist yet using = {}
-- note: these are UPPER-CASE charcacter name
STRINGS.CHARACTERS.ZENEL = {}
STRINGS.CHARACTERS.ZENEL.DESCRIBE = {}
STRINGS.CHARACTERS.ZENEL.DESCRIBE.EVERGREEN = "Reminds me of home \:( ."


return MakePlayerCharacter("zenel", prefabs, assets, fn)
