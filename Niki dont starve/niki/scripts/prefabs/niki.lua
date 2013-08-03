
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
        Asset( "ANIM", "anim/niki.zip" ),
}
local prefabs = {}

local badAnimalsToKill = {"rabbit", "beefalo"}

local function killedSomething(inst, data)
	-- THIS STILL DOES NOT WORK 
	-- I DON'T KNOW WHY I CAN'T GET THE VICTIM OF THE ATTACK?!
	print("Got killed event! Inst: ", inst)
end

local fn = function(inst)
	
	-- choose which sounds this character will play
	inst.soundsname = "willow"

	-- a minimap icon must be specified
	inst.MiniMapEntity:SetIcon( "wilson.png" )

	-- todo: Add an example special power here.

	-- Remove scary to prey tag to allow play to get close to birds and rabbits
	inst:RemoveTag("scarytoprey")

	-- Add beefalo tag to keep beefalo from attacking during mating season
	inst:AddTag("beefalo")

	inst:ListenForEvent("killed", killedSomething)
end


-- strings! Any "WOD" below would have to be replaced by the prefab name of your character.

-- First up, the character select screen lines 
-- note: these are lower-case character name
STRINGS.CHARACTER_TITLES.niki = "The Starving Artist"
STRINGS.CHARACTER_NAMES.niki = "Niki"
STRINGS.CHARACTER_DESCRIPTIONS.niki = "* Really Likes animals."
STRINGS.CHARACTER_QUOTES.niki = "\"Well... Fuck.\""

-- You can also add any kind of custom dialogue that you would like. Don't forget to make
-- categores that don't exist yet using = {}
-- note: these are UPPER-CASE charcacter name
STRINGS.CHARACTERS.NIKI = {}
STRINGS.CHARACTERS.NIKI.DESCRIBE = {}
STRINGS.CHARACTERS.NIKI.DESCRIBE.EVERGREEN = "I'm allergic to you."
STRINGS.CHARACTERS.NIKI.DESCRIBE.ASH = "Achoo."
STRINGS.CHARACTERS.NIKI.DESCRIBE.AXE = "Those trees won't know what hit em."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BACKPACK = "Like a pack for your back."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BATBAT = "This thing is terrifying."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BATCAVE = "I don't want to go in."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BATWING = "Won't be flying any time soon."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BEARDHAIR = "These apparently itch really bad."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BEE = "Fat and busy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BEE_BOX = "My home made honey factory."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BEEFALO = "Look at em all."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BEEFALO_SHAVED = "Sorry, buddy. I need this more than you."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BEEFALO_WOOL = "Kidnda stinks, but warm."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BEEHIVE = "If only I had a stuck to poke it with."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BERRIES = "I hope they aren't poisonous."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BERRYBUSH = "Now all I need is a basket."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BERRYBUSH2 = "Cmon... grow back."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BIRDCAGE = "A little birdy prison :D."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BIRD_EGGS = "I'm not going to give you a change to hatch."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BIRDTRAP = "Here goes nothing."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BISHOP = "Who made this guy?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.BLOWDART = "This is how I practice blowing."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BLUEPRINT = "who took the time to make these?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.BOARDS = "Better quality than a hardware stores."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BONFIRE = "Protection from the dark."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BOOMERANG = "I come from the land down under."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BUGNET = "Well this is just dainty."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BULB = "Weird plant."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BUTTER = "I don't even."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BUTTERFLY = "Pretty."
STRINGS.CHARACTERS.NIKI.DESCRIBE.BUTTERFLY_WINGS = "I guess I should... eat them?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.CAMPFIRE = "Toasty warm."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CAMPFIRE_FIRE = "Better not get too close."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CANE = "Stylish."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CARROT = "It sure its a carrot."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CAVE_ENTERENCE = "I don't want to go in."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CHARCOAL = "With paper I could draw with this."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CHESTER = "Hey, Chester! :D."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CHESTER_EYEBONE = "Quit looking at me like that."
STRINGS.CHARACTERS.NIKI.DESCRIBE.COOK_POT = "Better food will be made."
STRINGS.CHARACTERS.NIKI.DESCRIBE.COOK_POT_FOOD = "Smells good."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CORN = "Popped or boiled?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.CROW = "Caw Caw."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CUTGRASS = "All ready for use."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CUTREEDS = "People managed to turn this in to paper, somehow."
STRINGS.CHARACTERS.NIKI.DESCRIBE.CUTSTONE = "Oh yeah, look at those smooth edges."
STRINGS.CHARACTERS.NIKI.DESCRIBE.DEERCLOPS = "OH SHIT!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.DEERCLOPS_EYEBALL = "Eeeeeeew..."
STRINGS.CHARACTERS.NIKI.DESCRIBE.DIVININGROD = "Find me an exit."
STRINGS.CHARACTERS.NIKI.DESCRIBE.DRAGONFRUIT = "Never eaten one before."
STRINGS.CHARACTERS.NIKI.DESCRIBE.DRUMSTICK = "Spoils of war."
STRINGS.CHARACTERS.NIKI.DESCRIBE.DS_PIG = "Creepy pig."
STRINGS.CHARACTERS.NIKI.DESCRIBE.DS_RABBIT = "Hi Bunny."
STRINGS.CHARACTERS.NIKI.DESCRIBE.DS_SPIDER = "Ugh Gross. Like they weren't bad enough small."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FIRE = "Hot Hot Hot"
STRINGS.CHARACTERS.NIKI.DESCRIBE.FIREFLIES = "They're like living stars."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FIRESTAFF = "THE POWER OF RED GUARD!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.FISH = "Watch it flop about."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FISHINGROD = "Teach a man to fish.. Blah Blah Blah"
STRINGS.CHARACTERS.NIKI.DESCRIBE.FLINT = "A pointy rock."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FLOWER_PETALS = "I think I can eat these."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FLOWER_PETALS_EVIL = "Douche chills."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FLOWERS = "They smell lovely."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FLOWERS_EVIL = "They look like monsters."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FROG = "You look tasty."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FROG_LEGS = "Yummy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.FROZEN = "I'm freezing my nips off!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.GEARS = "The guts of robots."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GEMS = "They twinkle in the light."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GHOST = "Not as scary as I imagined they'd be."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GOLD_NUGGET = "Clearly I'm the richest person here."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GLODENAXE = "Fancy axe."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GOLDENPICKAXE = "It makes lovely music as I work."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GOLDENSHOVEL = "I'm a Gold Digger!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.GRASS = "Tufty."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GRASS1 = "Grow back please?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.GUANO = "Smaller poop."
STRINGS.CHARACTERS.NIKI.DESCRIBE.GUNPOWDER = "BOOM!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAM_BAT = "Meat hammer."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_BEE = "Protection from the bees."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAMMER = "It's Hammer Time!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_BEEFALO = "I have become one with their people."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_BUSH = "A cleaver disguise."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_EARMUFFS = "Nothing's warmer than a couple of dead rabbits."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_FEATHER = "Pow wow."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_FLOWER = "And now... I'm BEAUTIFUL"
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_FOOTBALL = "Hut, Hut, HIKE!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_MINER = "Into the caves."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_STRAW = "I'm a farmer"
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_TOP = "I will never be more stylish."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_WALRUS = "I will never be more stylish."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HAT_WINTER = "Fuzzy winter protection."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HEAT_ROCK = "Keep me warm."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HONEY = "Awesome."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HONEYCOMB = "Its hard and a little waxy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HORN = "Not as heavy as it looks."
STRINGS.CHARACTERS.NIKI.DESCRIBE.HOUND = "AAAAAH!!!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.HOUNDS_TOOTH = "Pointy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.ICE_BOX = "It's a fridge."
STRINGS.CHARACTERS.NIKI.DESCRIBE.iCESTAFF = "The power of FROST! I AM THE ICE KING!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.IGLOO_TRACK = "Someone will be back here."
STRINGS.CHARACTERS.NIKI.DESCRIBE.KNIGHT = "Who Made This?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.KOALEFANT = "Majestic and full of meat."
STRINGS.CHARACTERS.NIKI.DESCRIBE.KOALEFANT_TRACKS = "Hmm... let's track it down."
STRINGS.CHARACTERS.NIKI.DESCRIBE.KOALEFANT_TRUNK = "Nose... it's a delicacy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.KRAMPUS = "EVIL SANTA!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.LANTERN = "It's pretty."
STRINGS.CHARACTERS.NIKI.DESCRIBE.LIGHTNING_ROD = "Lightning insurance."
STRINGS.CHARACTERS.NIKI.DESCRIBE.LIVINGLOG = "They scream at me."
STRINGS.CHARACTERS.NIKI.DESCRIBE.LOG = "Heavy wood."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MANDRAKE = "Noisiest of all vegies."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MANRABBIT = "Hug me, Fluffy!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.MANRABBIT_TAIL = "Poof Poof."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MARBLE = "Can I make something with this?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.MARBLE_PILLAR = "Looks pretty old."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MARBLE_TREE = "Not a tree."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MEAT = "Spoils of the hunt."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MEAT_SMALL = "Bunny... tastes so good."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MERM = "Those guys are butt ugly."
STRINGS.CHARACTERS.NIKI.DESCRIBE.MOSQUITO = "It's HUGE!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.NIGHTMAREFUEL = "Blobby terror."
STRINGS.CHARACTERS.NIKI.DESCRIBE.NITRE = "The hell is this?"
STRINGS.CHARACTERS.NIKI.DESCRIBE.PAN_FLUTE = "Musical genious"
STRINGS.CHARACTERS.NIKI.DESCRIBE.PAPYRUS = "Sketch paper."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PENGUIN = "KILLERS!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.PICKAXE = "Minecraft... wait no."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PIG_GUARD = "Bigger tanner meaner."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PIG_HEAD = "sucks for him."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PIG_HOUSE = "It stinks"
STRINGS.CHARACTERS.NIKI.DESCRIBE.PIG_KING = "Fat lazy rich son of a bitch"
STRINGS.CHARACTERS.NIKI.DESCRIBE.PIG_TORCH = "Like a regular torch, but with pigs."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PIGGYBACK = "Hunchy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PIGSKIN = "Bacon with a tail."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PINECONE = "There's a baby tree in there."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PITCHFORK = "farmvile"
STRINGS.CHARACTERS.NIKI.DESCRIBE.PLANT_MEAT = "it looks slimy and gross."
STRINGS.CHARACTERS.NIKI.DESCRIBE.POOP = "Poop oHo "
STRINGS.CHARACTERS.NIKI.DESCRIBE.PUMPKIN = "let's carve it"
STRINGS.CHARACTERS.NIKI.DESCRIBE.PUMPKIN_LANTERN = "This is Halloween."
STRINGS.CHARACTERS.NIKI.DESCRIBE.PURPLE_GEM = "Pretty and purple."
STRINGS.CHARACTERS.NIKI.DESCRIBE.RABBIT_HOUSE = "Home for a bunny."
STRINGS.CHARACTERS.NIKI.DESCRIBE.RAIN_METER = "Wetness meter."
STRINGS.CHARACTERS.NIKI.DESCRIBE.RAZOR = "I dont need this... but oh well."
STRINGS.CHARACTERS.NIKI.DESCRIBE.REEDS = "like bamboo but smaller."
STRINGS.CHARACTERS.NIKI.DESCRIBE.RESURRECTION_STONE = "I guess... I'll touch it."
STRINGS.CHARACTERS.NIKI.DESCRIBE.ROBIN = "Tweet Tweet."
STRINGS.CHARACTERS.NIKI.DESCRIBE.ROCK = "It's a rock."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SAPLING = "gotta get those sticks."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SEEDS = "you might made something awesome."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SEWING_KIT = "Lets fix some stuff."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SHOVEL = "I can dig it."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SIGN_HOME = "Niki was here."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SILK = "So useful."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SKELETONS = "Tough luck, buddy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SMALLBIRD = "Aaaaw <3."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SPEAR = "Stab stab."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SPIDER_COCOON = "It's brewing evil."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SPIDER_EGG_SAC = "These things better not hatch soon."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SPIDER_GLAND = "Gross but good for you."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SPIDER_GLAND_SALV = "Burney ointment."
STRINGS.CHARACTERS.NIKI.DESCRIBE.SPIDER_QUEEN = "NOPE NOPE NOPE NOPE"
STRINGS.CHARACTERS.NIKI.DESCRIBE.SPOILED_FOOD = "Gross."
STRINGS.CHARACTERS.NIKI.DESCRIBE.STATUE_MAXWELL = "What an ego."
STRINGS.CHARACTERS.NIKI.DESCRIBE.STINGER = "Sharp and poisonous."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TALLBIRD_EGG = "Cook... or hatch.."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TALLBIRD = "Dem legs."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TALLBIRD_TEEN = "They grow up so fast."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TELEPORRTATO = "Onward to Adventure."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TELEPORTER_SICKWORM = "it looks grosser than usual"
STRINGS.CHARACTERS.NIKI.DESCRIBE.TELEPORTER_WORM = "Hope I don't get eaten..."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TENT = "Warm and Cozy."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TENTACLE = "You stay away from my tatas, monster!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.TENTACLE_SPIKE = "The death of so many explorers."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TENTACLESPOTS = "Some kinda skin."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TORCH = "Light up the night."
STRINGS.CHARACTERS.NIKI.DESCRIBE.TWIGS = "Now I just need something to poke."
STRINGS.CHARACTERS.NIKI.DESCRIBE.UMBRELLA = "I'm singin in the rain."
STRINGS.CHARACTERS.NIKI.DESCRIBE.WALRUS = "It's Daddy Mc Tusk! GO AWAY!"
STRINGS.CHARACTERS.NIKI.DESCRIBE.WALRUS_BABY = "Smallrus."
STRINGS.CHARACTERS.NIKI.DESCRIBE.WALRUS_HOUSE = "Wonder if it's cold inside."
STRINGS.CHARACTERS.NIKI.DESCRIBE.WALRUS_TUSK = "It's pearly white."
STRINGS.CHARACTERS.NIKI.DESCRIBE.WEREPIG = "FUUUUUUUUUU..."



return MakePlayerCharacter("niki", prefabs, assets, fn)
