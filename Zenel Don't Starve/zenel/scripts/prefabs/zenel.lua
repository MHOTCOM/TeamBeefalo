
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
        -- Don't forget to include your character's custom assets!
        Asset( "ANIM", "anim/zenel.zip"),
        Asset( "ANIM", "anim/zenel_cold.zip" ),
        Asset( "ANIM", "anim/zenel_littlecold.zip" ),
        Asset( "ANIM", "anim/zenel_littlehot.zip" ),
        Asset( "ANIM", "anim/zenel_hot.zip" ),
}
local prefabs = {}

minMultiplier = .5
maxMultiplier = 2
minSpeedMultiplier = .75
maxSpeedMultiplier = 1.25

local function onFreezingChange(inst, data)

        local zeroAdjustedCurrent = inst.components.temperature.current + inst.components.temperature.mintemp
        local multiplier = 1
        if (zeroAdjustedCurrent >= 50) then
            multiplier = minMultiplier
            if (currentState ~= "Hot") then
                currentState = "Hot"
                inst.AnimState:SetBuild("zenel_hot")
                inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED * minSpeedMultiplier
                inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED * minSpeedMultiplier
                if (skipSaying) then
                    skipSaying = false
                    return
                end
                inst.components.talker:Say("I feel so weak...")
            end
        elseif (zeroAdjustedCurrent > 30 and zeroAdjustedCurrent < 50) then
            multiplier = (-1/40) * zeroAdjustedCurrent + 1.75
            if (currentState ~= "LittleHot") then
                currentState = "LittleHot"
                inst.AnimState:SetBuild("zenel_littlehot")
                inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED
                inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED
                if (skipSaying) then
                    skipSaying = false
                    return
                end
                if (lastState ~= "Hot") then
                    inst.components.talker:Say("Awh man, it's getting warmer...")
                else 
                    inst.components.talker:Say("At least it's a little bit cooler now...")
                end
            end
        elseif (zeroAdjustedCurrent > 10 and zeroAdjustedCurrent <= 30) then
            multiplier = (-1/20) * zeroAdjustedCurrent + 2.5
            if (currentState ~= "LittleCold") then
                currentState = "LittleCold"
                inst.AnimState:SetBuild("zenel_littlecold")
                inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED
                inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED
                if (skipSaying) then 
                    skipSaying = false
                    return
                end
                if (lastState ~= "Cold") then
                    inst.components.talker:Say("Oh, it's a little bit more chilly now.")
                else 
                    inst.components.talker:Say("Well, at least it's not TOO hot.")
                end

            end
        elseif (zeroAdjustedCurrent <= 10) then
            multiplier = maxMultiplier
            if (currentState ~= "Cold") then
                inst.AnimState:SetBuild("zenel_cold")
                inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED * maxSpeedMultiplier
                inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED * maxSpeedMultiplier
                currentState = "Cold"
                if (skipSaying) then
                    skipSaying = false
                    return 
                end
                inst.components.talker:Say("<Breathes Deeply> Ahhh... My season.")
            end
        end
        inst.components.combat.damagemultiplier = multiplier
        lastState = currentState
        print("Set multiplier to " .. multiplier .. " State: " .. currentState .. " Temp0: " .. zeroAdjustedCurrent .. "Temp1: " .. inst.components.temperature.current)
end

currentState = "None"
lastState = "None"
skipSaying = true

local fn = function(inst)
        
        -- choose which sounds this character will play
        inst.soundsname = "wolfgang"

        -- a minimap icon must be specified
        inst.MiniMapEntity:SetIcon( "wilson.png" )

        -- Negate cold damage
        inst.components.temperature.hurtrate = 0

        -- Setup temperature to never say that character is freezing
        inst.components.temperature.mintemp = 5
        inst.components.temperature.maxtemp = 65

        inst:ListenForEvent("temperaturedelta", onFreezingChange)


end


-- strings! Any "WOD" below would have to be replaced by the prefab name of your character.

-- First up, the character select screen lines 
-- note: these are lower-case character name
STRINGS.CHARACTER_TITLES.zenel = "The Coder"
STRINGS.CHARACTER_NAMES.zenel = "Zenel"
STRINGS.CHARACTER_DESCRIPTIONS.zenel = "*One with the computer demons.\n*Gets stronger when colder."
STRINGS.CHARACTER_QUOTES.zenel = "\"¡A la chingada!\""

-- You can also add any kind of custom dialogue that you would like. Don't forget to make
-- categores that don't exist yet using = {}
-- note: these are UPPER-CASE charcacter name
STRINGS.CHARACTERS.ZENEL = {
    ACTIONFAIL =
    {
        SHAVE =
        {
            AWAKEBEEFALO = "Yeah sure, if I want to get gored.",
            GENERIC = "I'm not going to waste this razor doing that.",
            NOBITS = "That's a recipe for razor burn...",
        },
        STORE =
        {
            GENERIC = "As much as I try, it's too full...",
            NOTALLOWED = "Trying to put the triangle in the square slot, I see.",
        },
    },
    ACTIONFAIL_GENERIC = "Hahahahahaha... No.",
    ANNOUNCE_ADVENTUREFAIL = "I'm no adventurer, but that went really poorly.",
    ANNOUNCE_BEES = "Awh hell nah! Bees!",
    ANNOUNCE_BOOMERANG = "I think in Australia, one tries to catch those.",
    ANNOUNCE_CHARLIE = "What in the actual fuck was that?",
    ANNOUNCE_CHARLIE_ATTACK = "AUGH! MY LEG!",
    ANNOUNCE_COLD = "",
    ANNOUNCE_CRAFTING_FAIL = "I'm missing something here.",
    ANNOUNCE_DEERCLOPS = "Oh no! Godzirra!",
    ANNOUNCE_DUSK = "Better make a fire... I need light.",
    ANNOUNCE_EAT =
    {
        GENERIC = "That wasn't half bad!",
        PAINFUL = "Now to shit my insides out.",
        SPOILED = "Augh! It was poison!",
        STALE = "Something was almost very wrong with that.",
    },
    ANNOUNCE_ENTER_DARK = "Woah, I can't see my hand in front of my face.",
    ANNOUNCE_ENTER_LIGHT = "Augh, my eyes need to adjust!",
    ANNOUNCE_FREEDOM = "Free from tha chains of the white man!",
    ANNOUNCE_HIGHRESEARCH = "I was smart before, but this is ridiculous.",
    ANNOUNCE_HOUNDS = "Here doggy! Come get some!",
    ANNOUNCE_HUNGRY = "Fuuuck, I'm starving man!",
    ANNOUNCE_HUNT_BEAST_NEARBY = "I have GOT to be getting close now.",
    ANNOUNCE_HUNT_LOST_TRAIL = "Augh. He got away`.",
    ANNOUNCE_INV_FULL = "I can't survive if I can't move my legs...",
    ANNOUNCE_KNOCKEDOUT = "Great. How long was I out for?",
    ANNOUNCE_LOWRESEARCH = "Thanks for teaching me nothing...",
    ANNOUNCE_MOSQUITOS = "Die bloodsuckers!",
    ANNOUNCE_NODANGERSLEEP = "Sure, I'l sleep when the whole world isn't out to kill me.",
    ANNOUNCE_NODAYSLEEP = "No, it's WAY to bright out!",
    ANNOUNCE_NOHUNGERSLEEP = "I'll probably die of starvation in my sleep...",
    ANNOUNCE_NO_TRAP = "Well, okay then. Easy is good.",
    ANNOUNCE_PECKED = "I WILL DESTROY YOU!",
    ANNOUNCE_QUAKE = "What? This isnt California.",
    ANNOUNCE_RESEARCH = "Gotta learn more to get out of here...",
    ANNOUNCE_THORNS = "Pointy!",
    ANNOUNCE_TORCH_OUT = "I hope that I have another one...",
    ANNOUNCE_TRAP_WENT_OFF = "Haha. My bad.",
    ANNOUNCE_UNIMPLEMENTED = "Error: Unimplemented. Just kidding. But seriously.",
    ANNOUNCE_WORMHOLE = "Jumping into gaping assholes with teeth. Great idea...",
    BATTLECRY =
    {
        GENERIC = "I'm the fuck you man!",
        PIG = "Die mobile bacon!",
        PREY = "You must die for my sustenance!",
        SPIDER = "Die spider!",
        SPIDER_WARRIOR = "Here's a weapon for your face!",
    },
    COMBAT_QUIT =
    {
        GENERIC = "You live. For now.",
        PIG = "You're more useful to me alive anyway.",
        PREY = "Damn those things run fast.",
        SPIDER = "Yeah, leaving a man eating spider alive. Great idea.",
        SPIDER_WARRIOR = "Great, let's leave a man eating spider warrior alive. I'm not going to get killed from it later.",
    },
    DESCRIBE =
    {
        SLURPER = "Ew. What the fuck that is.?",
        ORANGEAMULET = "Your forcefield's good, but my teleporting is better.",
        YELLOWSTAFF = "I cast Fireball rank 5!",
        YELLOWGEM = "It looks like a topaz... Almost.",
        ORANGEGEM = "It's the color of amber.",
        TELEBASE = 
        {
                VALID = "Yep, base.ready = true;",
                GEMS = "Error: Base is not valid. Requires more purple gems.",
        },
        GEMSOCKET = 
        {
                VALID = "socket.ready = true;",
                GEMS = "socket.ready = false;",
        },
        STAFFLIGHT = "That's gonna...break something.",
        RESEARCHLAB4 = "What is this?",

        ANCIENT_ALTAR = "I wonder if Cthulu crashed here once or twice.",
        CAVE_BANANA = "BANANAAAAAAA!",
        CAVE_BANANA_COOKED = "Cooked... BANANAAAAAAA",
        CAVE_BANANA_TREE = "Hory shet. They MAKE TREES OF THESE.",
        ROCKY = "It has terrifying claws.",
        
        COMPASS =
        {
                GENERIC="I can't get a reading",
                N = "North",
                S = "South",
                E = "East",
                W = "West",
                NE = "Northeast",
                SE = "Southeast",
                NW = "Northwest",
                SW = "Southwest",
        },
        HOUNDSTOOTH="You'd be more threatening in a hound's mouth.",
        ARMORSNURTLESHELL="I can't believe that I'm thinking of wearing this.",
        BAT="Fuck you, I'm Batman.",
        BATBAT = "Shouldn't it be called (Bat)^2?",
        BATWING="Better dead. Fuck bats.",
        BATWING_COOKED="It smells worse when cooked...",
        BEDROLL_FURRY="It's disgustingly warm.",
        BUNNYMAN="Crikey! Look a random furry in it's natural habitat!",
        FLOWER_CAVE="Is that flower glowing?",
        FLOWER_CAVE_DOUBLE="Is that flower glowing?",
        FLOWER_CAVE_TRIPLE="Is that flower glowing?",
        GUANO="That's batshit... crazy.",
        LANTERN="I feel like a Tonberry is nearby.",
        LIGHTBULB="I wonder if you can use this as a lightbulb?",
        MANRABBIT_TAIL="Ooh, furry tail!",
        MUSHTREE_TALL  ="DUDE. DO YOU WANT TO DO SOME SHROOMS?",
        MUSHTREE_MEDIUM="That's a moderately large shroom.",
        MUSHTREE_SMALL ="It's \"magic\"",
        RABBITHOUSE="It's like Spongebob. But not at all.",
        SLURTLE="Ah, hello shell eel.",
        SLURTLE_SHELLPIECES="Now how do you go back together?",
        SLURTLEHAT="Please don't put this on.",
        SLURTLEHOLE="How about no?",
        SLURTLESLIME="Why did you pick this up? It's got the consistency of cum...",
        SNURTLE="Ah, a snail...eel.",
        SPIDER_HIDER="Oh good, they hide now.",
        SPIDER_SPITTER="Pthew, I spit on you.",
        SPIDERHOLE="That's a whole lot of nope.",
        STALAGMITE="Pointy and vertical. Perfect.",
        STALAGMITE_FULL="Woo. More damn rocks.",
        STALAGMITE_LOW="Woo. More damn rocks.",
        STALAGMITE_MED="Woo. More damn rocks.",
        STALAGMITE_TALL="Ooh these ones are as tall as me!",
        STALAGMITE_TALL_FULL="Ooh these ones are as tall as me!",
        STALAGMITE_TALL_LOW="Ooh these ones are as tall as me!",
        STALAGMITE_TALL_MED="Ooh these ones are as tall as me!",
        TURF_FUNGUS="Ground. That is all.",
        TURF_MUD="Ground. That is all.",
        TURF_SINKHOLE="Ground. That is all.",
        TURF_UNDERROCK="Ground. That is all.",      

        POWCAKE = "Why would I bother eating this?",
        CAVE_ENTRANCE = 
        {
            GENERIC="I bet I could move that rock.",
            OPEN = "I really don't want to go down there. It's dark.",
        },
        CAVE_EXIT = "Fuck that dark, dank hole.",
        MAXWELLPHONOGRAPH = "Ah, the source of the music.",
        BOOMERANG = "Looks like I'm going down under. That means two things.",
        PIGGUARD = "Hey it's just another prick at the door.",
        ABIGAIL = "Holy shit. My dad was right. Ghosts exist.",
        ADVENTURE_PORTAL = "Good, good. Another portal.",
        AMULET = "I bet that I put this on my neck. Just a thought.",
        ANIMAL_TRACK = "Ooh, an animal print. Doesn't look like any animal I know.",
        ARMORGRASS = "Looks like almost... Hawaiian.",
        ARMORMARBLE = "I am a PALADIN.",
        ARMORWOOD = "Hey look, I'm woody.",
        ARMOR_SANITY = "I don't know if I'm strong enough mentally for this armor.",
        ASH =
        {
                GENERIC = "Ash-hole.",
                REMAINS_EYE_BONE = "Oh. You can't teleport with that.",
                REMAINS_THINGIE = "What was this. I can't tell anymore.",
        },
        AXE = "You have my axe!",
        BABYBEEFALO = "Awh. Cute.",
        BACKPACK = "Not a huge fan of normal backpacks. Messenger bags are more my style.",
        BACONEGGS = "Mmmm, breakfast.",
        BANDAGE = "Infection, here I come.",
        BASALT = "Basalt, why you so strong?",
        BATBAT = "Shouldn't it be called (Bat)^2?",
        BEARDHAIR = "I must have been crazy when I collected this.",
        BEDROLL_STRAW = "Yeah, jungle sleeping is not so great.",
        BEE =
        {
                GENERIC = "I don't know if I'm allergic or not. I don't want to find out.",
                HELD = "Why am I holding this thing!?",
        },
        BEEBOX =
        {
                FULLHONEY = "Hell yeah! It's full.",
                GENERIC = "I don't like you bees, and you don't like me. But you should make honey.",
                NOHONEY = "Oh come ON! Do your damn job bees!",
                SOMEHONEY = "Let's wait until it's full.",
        },
        BEEFALO =
        {
                FOLLOWER = "That's good, keep on following me.",
                GENERIC = "It's like a cow buffalo.",
                NAKED = "I hope he's not cold.",
                SLEEPING = "I wish I could sleep like that.",
        },
        BEEFALOHAT = "I'm kinda sad that I had to kill it",
        BEEFALOWOOL = "It seems like it would be warm. Like... too warm.",
        BEEHAT = "Least they can't get my face now.",
        BEEHIVE = "It's throbbing with hate and malice.",
        BEEMINE = "I don't wish this on anybody. But you do what you have to.",
        BEEMINE_MAXWELL = "Bottled mosquito rage!",
        BERRIES = "Never been a big berry fan, but I need to eat.",
        BERRIES_COOKED = "Why did I even cook these?",
        BERRYBUSH = "It's a bush. Of berries. Can you not see that?",
        {
                BARREN = "What's wrong with you? GROW.",
                GENERIC = "Never been a big berry fan, but I do need to eat.",
                PICKED = "I hope that they grow back.",
        },
        BIRDCAGE =
        {
                GENERIC = "I can't believe that I'm planning to keep a bird.",
                OCCUPIED = "Let's get one thing straight bird, I. HATE. You.",
                SLEEPING = "I want to kill you in your sleep so bad.",
        },
        BIRDTRAP = "Hopefully it dies in the trap.",
        BIRD_EGG = "Better eat it before it hatches into suck.",
        BIRD_EGG_COOKED = "A dead bird is the best bird.",
        BISHOP = "Yeah, I'm used to obnoxious church guys now.",
        BLOWDART_FIRE = "This is going to suck if I suck this in. Get it? Suck.",
        BLOWDART_SLEEP = "Maybe I should use this to sleep better.",
        BLUEAMULET = "Aah, It's cold.",
        BLUEGEM = "I think this is how the ice king went crazy if I recall correctly.",
        BLUEPRINT = "Ah man, I thought I'd never have to read these again.",
        BLUE_CAP = "I don't like mushrooms. Especially blue ones.",
        BLUE_CAP_COOKED = "I don't care if it's cooked. I don't like it.",
        BLUE_MUSHROOM =
        {
                GENERIC = "No thanks, I don't want your mushroom.",
                INGROUND = "Never seen mushrooms do that before.",
                PICKED = "It's probably going to come back.",
        },
        BOARDS = "I have the sudden urge to build a deck.",
        BOAT = "I wonder if I can use this on these turbulent seas. Better bring a bucket.",
        BONESTEW = "Just the name is gross.",
        BUGNET = "I feel like I might go jelly fishing.",
        BUSHHAT = "i feel the bugs running through my hair. But I need some kind of protection.",
        BUTTER = "Please don't eat this raw, I'll probably puke.",
        BUTTERFLY =
        {
                GENERIC = "Oh, haven't seen one of you in a while.",
                HELD = "I'm sorry, but I need to use you for something.",
        },                   
        BUTTERFLYMUFFIN = "A butterfly muffin. I bet it doesn't taste good.",
        BUTTERFLYWINGS = "I'm haunted that I ripped these off of a buttefly.",
        CAMPFIRE =
        {
                EMBERS = "No. Nono. Nononononononononono! DON'T GO OUT!",
                GENERIC = "It's warm, just the right amount of warm.",
                HIGH = "Everyone knows bigger fires are better.",
                LOW = "Hm, it could use a bit more fuel.",
                NORMAL = "It's warm, just the right amount of warm.",
                OUT = "Great it's out. Better hope it's not dark.",
        },
        CANE = "I will NOT use a cane. It's degrading.",
        CARROT = "What's up, doc?",
        CARROT_COOKED = "It's would be better if it were steamed.",
        CARROT_PLANTED = "I don't know if I'm feeling carrots today.",
        CARROT_SEEDS = "Oh, I bet I could make a new carrot with this.",
        CAVE_FERN = "What is a fern doing down here?",
        CHARCOAL = "Kinda smells like a dead fire looks.",
        CHESSJUNK1 = "Not like I would have anyone to play chess with anyway.",
        CHESSJUNK2 = "I kinda want to play some chess. Kinda.",
        CHESSJUNK3 = "Maybe I could fix them any play myself?",
        CHESTER = "That pumpkin has a mouth.",
        CHESTER_EYEBONE =
        {
                GENERIC = "Staring contest, GO.",
                WAITING = "Hah I win.",
        },
        COOKEDMANDRAKE = "Thank god it shut up.",
        COOKEDMEAT = "Mmm, steak. It's not steak. But mmm steak.",
        COOKEDMONSTERMEAT = "While I'm down with this meat being purple, I really still don't want to eat it.",
        COOKEDSMALLMEAT = "It's safe to eat now. Probably.",
        COOKPOT =
        {
                COOKING_LONG = "TO HUNGRY TO WAIT.",
                COOKING_SHORT = "Thank god, it's nearly done.",
                DONE = "DINNER TIME!",
                EMPTY = "I really don't want to cook, but I'm so hungry.",
        },
        CORN = "Ermagerd kern!",
        CORN_COOKED = "Ermagerd kerked kern!",
        CORN_SEEDS = "I bet I could grow some corn with this.",
        CROW =
        {
                GENERIC = "Oh good, another bird to hate.",
                HELD = "SUFFER AVIAN MONSTER!",
        },
        CUTGRASS = "Makes me want to sneeze.",
        CUTREEDS = "They look like little corndogs.",
        CUTSTONE = "It looks like a minecraft block.",
        DEERCLOPS = "Oh. My. FUCK.",
        DEERCLOPS_EYEBALL = "It feels like a peeled grape.",
        DEPLETED_GRASS =
        {
                GENERIC = "The tallest grass it cut down. I think that's the saying.",
        },
        DEVTOOL = "I AM GOD HERE.",
        DEVTOOL_NODEV = "This is probably used by the gods.",
        DIRTPILE = "Ah, dirt.",
        DIVININGROD =
        {
                COLD = "It's not even responding.",
                GENERIC = "It looks almost like a metal detector.",
                HOT = "If I get any closer, this thing will probably explode or something.",
                WARM = "It's beeping a bit.",
                WARMER = "It's being loud now. I need to find this thing before I go insane.",
        },
        DIVININGRODBASE =
        {
                GENERIC = "What even is this thing?",
                READY = "It needs to be unlocked.",
                UNLOCKED = "It. Is. READY.",
        },
        DIVININGRODSTART = "This is almost like Galdalf's staff.",
        DRAGONFRUIT = "The fruit of dragons.",
        DRAGONFRUIT_COOKED = "I feel cursed since I cooked it.",
        DRAGONFRUIT_SEEDS = "It's a dragon seed. That means two things.",
        DRAGONPIE = "It's like a dragon pie. Wait. Gross.",
        DRUMSTICK = "Freshly ripped from the body of an animal.",
        DRUMSTICK_COOKED = "Renaissance festival style.",
        DUG_BERRYBUSH = "Portable berries.",
        DUG_GRASS = "Portable grass.",
        DUG_MARSH_BUSH = "Bring me a shrubbery!",
        DUG_SAPLING = "I've always had good luck with planting trees.",
        DURIAN = "Ew. Smels like shit.",
        DURIAN_COOKED = "Now it smells like cooked shit!",
        DURIAN_SEEDS = "It's a shit seed.",
        EARMUFFSHAT = "The rabbit's are still wriggling.",
        EGGPLANT = "I bet you would feel good in my butt.",
        EGGPLANT_COOKED = "I really should eat this instead of... other uses.",
        EGGPLANT_SEEDS = "I bet I could grow this into eggplants.",
        EVERGREEN =
        {
                BURNING = "Wow. Lame. It burst into flames.",
                BURNT = "What a waste.",
                CHOPPED = "I am manly man, hear me roar!",
                GENERIC = "Reminds me of home.",
        },
        EVERGREEN_SPARSE =
        {
                BURNING = "Oops, it's burning now.",
                BURNT = "I really should be more careful with fire.",
                CHOPPED = "I am manly man, hear me roar!",
                GENERIC = "It's a evergreen without cones.",
        },
        EYEPLANT = "It's a plant. Of eyes I guess. Who knows what it is?",
        FARMPLOT =
        {
                GENERIC = "It's farmland.",
                GROWING = "Go plants go!",
                NEEDSFERTILIZER = "I need to fertilize it.",
        },
        FEATHERHAT = "I enjoy wearing carcasses of thinks that I hate.",
        FEATHER_CROW = "Hate crows. Since they're birds.",
        FEATHER_ROBIN = "Hate robins. Sonce they're birds.",
        FEATHER_ROBIN_WINTER = "Hate winter robins too. They're birds.",
        FEM_PUPPET = "She's trapped!",
        FIREFLIES =
        {
                GENERIC = "I bet I could make a lamp or something out of that.",
                HELD = "They make buzzing noises in my pocket.",
        },
        FIREHOUND = "Great, flaming hounds now.",
        FIREPIT =
        {
                EMBERS = "No. Nono. Nononononononononon! DON'T GO OUT!",
                GENERIC = "It's warm, just the right amount of warm.",
                HIGH = "Everyone knows bigger fires are better.",
                LOW = "Hm, it could use a bit more fuel.",
                NORMAL = "It's warm, just the right amount of warm.",
                OUT = "Great it's out. Better hope it's not dark.",
        },
        FIRESTAFF = "Fireballs, from sticks!",
        FISH = "Ooh, a fish.",
        FISHINGROD = "You'll poke your eye out kid!",
        FISHSTICKS = "Hah, funny.",
        FISHTACOS = "Uhm. Vagina. Gross.",
        FISH_COOKED = "Ooh yummy.",
        FLINT = "Damn, that's sharp.",
        FLOWER = "I'd love to smell it, but I'd die.",
        FLOWERHAT = "I can't breathe!",
        FLOWER_EVIL = "I feel like these should belong to a Warlock.",
        FOLIAGE = "Looks like a salad.",
        FOOTBALLHAT = "I hate sports. But I need the protection.",
        FROG =
        {
                DEAD = "One dead frog.",
                GENERIC = "Gross. Imma get warts.",
                SLEEPING = "How is it even sleeping?",
        },
        FROGGLEBUNWICH = "Mmh, I know I'm not going to enjoy this.",
        FROGLEGS = "I'm not French enough to do this.",
        FROGLEGS_COOKED = "Too oily.",
        FRUITMEDLEY = "Ooh, fruits and berries.",
        GEARS = "Some gears.",
        GHOST = "Shit. Dad was right. Ghosts exist.",
        GOLDENAXE = "I really hope this axe is better than the minecraft gold axe.",
        GOLDENPICKAXE = "How is this going to work?",
        GOLDENPITCHFORK = "Looking at this makes me feel wasteful.",
        GOLDENSHOVEL = "Diggin them holes. In style.",
        GOLDNUGGET = "God damn, that's heavy.",
        GRASS =
        {
                BARREN = "Need fertilized. Like everything.",
                BURNING = "Great it's burning down.",
                GENERIC = "Just grass. Makes me want to sneeze.",
                PICKED = "It's going to pay me back in headaches I bet.",
        },
        GREEN_CAP = "That mushroom is...green.",
        GREEN_CAP_COOKED = "Why did I cook this?",
        GREEN_MUSHROOM =
        {
                GENERIC = "No thanks, I don't want your mushroom.",
                INGROUND = "Never seen mushrooms do that before.",
                PICKED = "It's probably going to come back.",
        },
        GUNPOWDER = "Maybe I can make explosives now.",
        HAMBAT = "I feel like a barbarian.",
        HAMMER = "Hello, Mjolnir, meet Thor.",
        HEALINGSALVE = "I needed this. Infections are a bitch.",
        HEATROCK =
        {
                COLD = "God, how is this rock so damn cold?",
                GENERIC = "The thermal properties of this rock are strange, maybe it will stay warm.",
                HOT = "Woah, this is way too hot.",
                WARM = "Too warm still. Just barely.",
        },
        HOME = "There are actually houses here?",
        HOMESIGN = "It says 'You are here'.",
        HONEY = "Sweet!",
        HONEYCOMB = "I actually might like some honeycombs cereal.",
        HONEYHAM = "Oh my god, honey glazed ham is WAY too good!",
        HONEYNUGGETS = "I do love some honey with my nuggets!",
        HORN = "I have the urge to blow this. It might bring help.",
        HOUND = "I love dogs, but I will DESTROY YOU!",
        HOUNDBONE = "Poor doggy.",
        HOUNDMOUND = "I bet the hounds are nearby..",
        ICEBOX = "I could put my soda in here. IF I HAD ANY.",
        ICEHOUND = "My kind of hound. Too bad we can't be freinds.",
        INSANITYROCK =
        {
                ACTIVE = "Embrace the dark side, and rule this world...",
                INACTIVE = "I feel the power of the dark side pulsating from it.",
        },
        JAMMYPRESERVES = "I bet this is going to be okay.",
        KABOBS = "Ooh good.",
        KILLERBEE =
        {
                GENERIC = "I don't know if I'm allergic. I don't want to find out.",
                HELD = "Please don't sting me.",
        },
        KNIGHT = "I need some armor like that.",
        KOALEFANT_SUMMER = "I almost feel bad about wanting to kill it.",
        KOALEFANT_WINTER = "It's looks too warm for me.",
        KRAMPUS = "I WILL DESTROY YOU IF YOU TOUCH THAT.",
        KRAMPUS_SACK = "Ew. It has Krampus slime all over it.",
        LEIF = "He's huge!",
        LEIF_SPARSE = "He's huge!",
        LIGHTNING_ROD =
        {
                CHARGED = "I bet I could use this to make a tesla coil or something.",
                GENERIC = "I hope that this charges well.",
        },
        LITTLE_WALRUS = "Cute... for now.",
        LIVINGLOG = "This log... is screaming.",
        LOCKEDWES = "Woah, what a faggot.",
        LOG =
        {
                BURNING = "It's on fire.",
                GENERIC = "That gives me wood. Just kidding.",
        },
        LUREPLANT = "It's so alluring.",
        LUREPLANTBULB = "Now I can start my very own meat farm.",
        MALE_PUPPET = "He's trapped!",
        MANDRAKE =
        {
                DEAD = "At least it's dead.",
                GENERIC = "If I get that, I'm going to regret it.",
                PICKED = "I really, REALLY hate you.",
        },
        MANDRAKESOUP = "I hope that nothing bad happens.",
        MANDRAKE_COOKED = "I bet something bad is going to happen.",
        MARBLE = "Stroke the marble. BE the marble.",
        MARBLEPILLAR = "Ooh, fancy. In a roman way.",
        MARBLETREE = "Woah, a tree of marble.",
        MARSH_BUSH =
        {
                BURNING = "It's a burning bush. Religions wrote about this.",
                GENERIC = "Prickly.",
                PICKED = "Ow, fuck plants.",
        },
        MARSH_PLANT = "Another. Plant. Damn.",
        MARSH_TREE =
        {
                BURNING = "Spikes and fire!",
                BURNT = "Now it's burnt and spiky",
                CHOPPED = "Can't spike me if you're chopped.!",
                GENERIC = "That is WAY too spiky.",
        },
        MAXWELL = "I really hate your ass right now. And forever. I just hate you.",
        MAXWELLHEAD = "Gross, its all pale.",
        MAXWELLLIGHT = "I wonder how they work.",
        MAXWELLLOCK = "Looks almost like a key hole.",
        MAXWELLTHRONE = "Hah, my computer throne is better.",
        MEAT = "Meat. I prefer man meat, but hey. You can't eat that.",
        MEATBALLS = "Least there's no spaghetti involved.",
        MEATRACK =
        {
                DONE = "Jerky time!",
                DRYING = "This is going to take FOREVER.",
                GENERIC = "I should make some meats.",
        },
        MEAT_DRIED = "Wish I had some teriyakki.",
        MERM = "Hm, not interested, boy.",
        MERMHEAD = "The stinkiest thing I'll smell all day.",
        MERMHOUSE = "Atlantis house?",
        MINERHAT = "Hah, these look ridiculous.",
        MONKEY = "Don't rip my face off. Plase.",
        MONKEYBARREL = "Ahhh, I get it. Monkey's in a barrel.",
        MONSTERLASAGNA = "Doesn't smell like it should.",
        MONSTERMEAT = "This is not good meat.",
        MONSTERMEAT_DRIED = "Why did I bother drying this?",
        MOSQUITO =
        {
                GENERIC = "Fucking bloodsucker.",
                HELD = "I want to kill you so bad.",
        },
        MOUND =
        {
                DUG = "I should probably feel bad about that.",
                GENERIC = "I bet there's all sorts of good stuff down there!",
        },
        NIGHTLIGHT = "Reminds me of being a kid.",
        NIGHTMAREFUEL = "Looks like dark side essence.",
        NIGHTSWORD = "Awesome blade.",
        NITRE = "I have no idea what rock this is.",
        ONEMANBAND = "Straight up Miyavi..",
        PANDORASCHEST = "I bet this is going to go poorly.",
        PANFLUTE = "I can probably play this.",
        PAPYRUS = "Paper, that's what it is.",
        PENGUIN = "Fuck you penguin.",
        PERD = "Touch my berries, I FUCKING DARE YOU.",
        PEROGIES = "I'm surprised I can cook these.",
        PETALS = "Petals, that is all.",
        PETALS_EVIL = "Ooh, dark petals.",
        PICKAXE = "Let's get to picking.",
        PIGGYBACK = "I almost feel bad about that.",
        PIGHEAD = "Of course flies are all over it.",
        PIGHOUSE =
        {
                FULL = "Woah, it's mega full.",
                GENERIC = "I should build one of these.",
                LIGHTSOUT = "You had better stay in there. I'll kill you for this.",
        },
        PIGKING = "That's the pig king? That's it?",
        PIGMAN =
        {
                DEAD = "I can't eat that..",
                FOLLOWER = "He's following me. My 'significant other' is a pig. This where I die",
                GENERIC = "Hm pig man. Interesting.",
                GUARD = "Ah pig bouncer. Or just a normal bouncer.",
                WEREPIG = "What's up with were-things?",
        },
        PIGSKIN = "You could make a football out of this. Or something useful.",
        PIGTENT = "Smells like gross.",
        PIGTORCH = "What makes this so special?",
        PINECONE = 
        {
            GENERIC = "Do these actually grow trees?",
            PLANTED = "I hope I planted it right.",
        },
        PITCHFORK = "Reminds me of that painting with the farmer couple.",
        PLANTMEAT = "How do plants have meat?",
        PLANTMEAT_COOKED = "Now gross warm.",
        PLANT_NORMAL =
        {
                GENERIC = "A plant. Yep.",
                GROWING = "Pretty slow going eh?",
                READY = "Yep nice and ready.",
        },
        POMEGRANATE = "Tim used to eat these.",
        POMEGRANATE_COOKED = "I don't know how I managed to heat this.",
        POMEGRANATE_SEEDS = "They're like meaty seeds.",
        POND = "Really, really murky.",
        POOP = "Shit.",
        PUMPKIN = "Timm's favorite minecraft block.",
        PUMPKINCOOKIE = "How did I make a cookie like this?",
        PUMPKIN_COOKED = "I should have made a pie.",
        PUMPKIN_LANTERN = "Is Halloween coming soon? Does time mean anything here?",
        PUMPKIN_SEEDS = "I can make a pumpkin from it.",
        PURPLEAMULET = "I can feel a teleportational energy from it.",
        PURPLEGEM = "A bit a teloportation energy.",
        RABBIT =
        {
                GENERIC = "Hello little bunny.",
                HELD = "How did I manage to catch you?",
        },
        RABBITHOLE = "My dog would be all over that.",
        RAINOMETER = "Is it a weather meter?",
        RATATOUILLE = "Movie reference?",
        RAZOR = "Oh good, I needed a shave.",
        REDGEM = "Has fire balls inside of it.",
        RED_CAP = "Red mushroom.",
        RED_CAP_COOKED = "Warm, red mushroom.",
        RED_MUSHROOM =
        {
                GGENERIC = "No thanks, I don't want your mushroom.",
                INGROUND = "Never seen mushrooms do that before.",
                PICKED = "It's probably going to come back.",
        },
        REEDS =
        {
                BURNING = "Flaming corn dogs?",
                GENERIC = "Looks like a set of corn dogs!",
                PICKED = "I picked the best parts.",
        },
        RESEARCHLAB = "I don't see how this is science-y.",
        RESEARCHLAB2 = "How is this even more useful?",
        RESEARCHLAB3 = "Looks like even more useful.",
        RESEARCHLAB4 = "Who would name something that?",
        RESURRECTIONSTATUE = "Nice, a statue.",
        RESURRECTIONSTONE = "What does this stone do?",
        ROBIN =
        {
                GENERIC = "I HATE birds.",
                HELD = "I hope you get crushed in my pocket.",
        },
        ROBIN_WINTER =
        {
                GENERIC = "Great more birds.",
                HELD = "I can't wait to kill you.",
        },
        ROBOT_PUPPET = "It's trapped!",
        ROCK_LIGHT =
        {
                GENERIC = "A crusted over lava pit.",
                OUT = "Looks fragile",
                LOW = "The lava's crusting over.",
                NORMAL = "Nice and comfy.",
        },
        ROCK = "That's a big ass rock.",
        ROCKS = "Maybe I can make something with these.",
        ROOK = "Storm the castle!",
        ROPE = "Some rope.",
        ROTTENEGG = "Smells like a hot spring.",
        SANITYROCK =
        {
                ACTIVE = "It's a rather strange looking rock.",
                INACTIVE = "Did part of it disappear?",
        },
        SAPLING =
        {
                BURNING = "Wow those are quick burning.",
                GENERIC = "I should pick the sticks off of it.",
                PICKED = "I got the sticks from him.",
        },
        SEEDS = "I don't know which seed this is.",
        SEEDS_COOKED = "A little more warm seeds.",
        SEWING_KIT = "Damnit, I have to sew really?",
        SHOVEL = "I can dig things with this. Dig it?",
        SILK = "I bet I can make some great stuff from this.",
        SKELETON = "I hope he at least made it worth it.",
        SKULLCHEST = "I really shouldn't open it. But I will anyway.",
        SMALLBIRD =
        {
                GENERIC = "Oh, a small amount of hate.",
                HUNGRY = "Hungry hate.",
                STARVING = "Good, die.",
        },
        SMALLMEAT = "Animal bits.",
        SMALLMEAT_DRIED = "A little jerky.",
        SPEAR = "Weaponry is great.",
        SPIDER =
        {
                DEAD = "Better dead than alive.",
                GENERIC = "Oh, where's my laser?",
                SLEEPING = "I should kill it while it sleeps.",
        },
        SPIDERDEN = "Looks mega gross.",
        SPIDEREGGSACK = "If these hatch,life is gonna be hell.",
        SPIDERGLAND = "It has healing properties.",
        SPIDERHAT = "Gross. Why did I make a hat of this.",
        SPIDERQUEEN = "Nope. Nope. NOPENOPENOPENOPENOPENOPE!",
        SPIDER_WARRIOR =
        {
                DEAD = "Dead spiders are better.",
                GENERIC = "I bet this spider will be more difficult to fight.",
                SLEEPING = "I should kill it now.",
        },
        SPOILED_FOOD = "Gross. Spoiled.",
        STATUEHARP = "What's this statue of?",
        STATUEMAXWELL = "He's a douche to have statues of himself.",
        STINGER = "Don't poke yourself.",
        STRAWHAT = "Reminds me of a sakat.",
        STUFFEDEGGPLANT = "Nice, if I liked eggplants.",
        SUNKBOAT = "Welp. There goes that boat.",
        TAFFY = "And I'm a man who enjoys his taffy.",
        TALLBIRD = "Great. Something I hate that can kill me.",
        TALLBIRDEGG = "I hope it doesn't hatch.",
        TALLBIRDEGG_COOKED = "I WILL DEVOUR THE UNBORN.",
        TALLBIRDEGG_CRACKED =
        {
                COLD = "I really want it to freeze when it can feel it.",
                GENERIC = "I hope it's not actually hatching.",
                HOT = "How is that egg sweating.",
                LONG = "I hope it will take a long time.",
                SHORT = "It probably would be bad when it hatches.",
        },
        TALLBIRDNEST =
        {
                GENERIC = "That's a big ass egg.",
                PICKED = "Now it's just an empty nest.",
        },
        TEENBIRD =
        {
                GENERIC = "It really is too bad that it's a bird.",
                HUNGRY = "It looks hungry. Not that I care.",
                STARVING = "I really need to feed this thing.",
        },
        TELEBASE = 
        {
                VALID = "Yep, base.ready = true;",
                GEMS = "Error: Base is not valid. Requires more purple gems.",
        },
        GEMSOCKET = 
        {
                VALID = "socket.ready = true;",
                GEMS = "socket.ready = false;",
        },
        TELEPORTATO_BASE =
        {
                ACTIVE = "It's like a TARDIS!",
                GENERIC = "Maybe I can use this to do somethign neat?",
                LOCKED = "My TARDIS needs a soul.",
                PARTIAL = "This is probably why they grow TARDIS units.",
        },
        TELEPORTATO_BOX = "This may control the polarity of the whole universe.",
        TELEPORTATO_CRANK = "Tough enough to handle the most intense experiments.",
        TELEPORTATO_POTATO = "This metal potato contains great and fearful power...",
        TELEPORTATO_RING = "A ring that could focus dimensional energies.",
        TELESTAFF = "I can teleport with this.",
        TENT = "NEED SLEEP NOW.",
        TENTACLE = "I've seen enough hentai to know where this is going.",
        TENTACLESPIKE = "This would make better hentai.",
        TENTACLESPOTS = "Gross. Those are just... weird.",
        TENTACLE_PILLAR = "A pillar. Of tentacles.",
        TENTACLE_PILLAR_ARM = "Little slippery tentacle arms.",
        TENTACLE_GARDEN = "Yet another slimy pole. That means two things.",
        TOPHAT = "One dapper mother fucker.",
        TORCH = "It's a torch, you know, for light.",
        TRAP = "Let's catch dinner.",
        TRAP_TEETH = "Yikes, I can catch a bear with that.",
        TRAP_TEETH_MAXWELL = "If I step on that, it's gonna hurt a LOT.",
        TREASURECHEST = "Ah, a chest. Conveinent.",
        TREASURECHEST_TRAP = "Obviously a mimic.",
        TREECLUMP = "It's almost like someone is trying to prevent me from going somewhere",
        TRINKET_1 = "They are all melted together.",
        TRINKET_10 = "I hope I get out of here before I need these",
        TRINKET_11 = "He whispers beautiful lies to me.",
        TRINKET_12 = "I'm not sure what I should do with a dessicated tentacle.",
        TRINKET_2 = "It's just a cheap replica",
        TRINKET_3 = "The knot is stuck. Forever.",
        TRINKET_4 = "It must be some kind of religious artifact.",
        TRINKET_5 = "Sadly, it's too small for me to escape on.",
        TRINKET_6 = "Their electricity carrying days are over.",
        TRINKET_7 = "I have no time for fun and games!",
        TRINKET_8 = "Great. All of my tub stopping needs are met.",
        TRINKET_9 = "I'm more of a zipper person, myself.",
        TRUNKVEST_SUMMER = "Wilderness casual.",
        TRUNKVEST_WINTER = "Winter survival gear.",
        TRUNK_COOKED = "Somehow even more nasal than before.",
        TRUNK_SUMMER = "A light breezy trunk.",
        TRUNK_WINTER = "A thick, hairy trunk.",
        TURF_CARPETFLOOR = "It's surprisingly scratchy.",
        TURF_CHECKERFLOOR = "These are pretty snazzy.",
        TURF_DIRT = "A chunk of ground.",
        TURF_FOREST = "A chunk of ground.",
        TURF_GRASS = "A chunk of ground.",
        TURF_MARSH = "A chunk of ground.",
        TURF_ROAD = "Hastily Cobbled Stones",
        TURF_ROCKY = "A chunk of ground.",
        TURF_SAVANNA = "A chunk of ground.",
        TURF_WOODFLOOR = "These are floorboards.",
        TURKEYDINNER = "Gobble gobble, bitch.",
        TWIGS = "Woo twigs.",
        UMBRELLA = "Awesome, the best part of the rain, I can see you, but you can't hit me.",
        UNIMPLEMENTED = "This is bad. I shouldn't have this.",
        WAFFLES = "And in the morning, I'm makin' these.",
        WALL_HAY = "Isn't that flammable?",
        WALL_HAY_ITEM = "Looks almost useless.",
        WALL_STONE = "For my castle.",
        WALL_STONE_ITEM = "Let's build..",
        WALL_RUINS = "That's a nice wall, if it weren't so ruined.",
        WALL_RUINS_ITEM = "Ruins wall, portable.",
        WALL_WOOD = "It's like a palisade.",
        WALL_WOOD_ITEM = "Palisade points.",
        WALRUS = "I should shoot it with a bow, and gather his soul.",
        WALRUSHAT = "I bet that this is too warm for me.",
        WALRUS_CAMP =
        {
                EMPTY = "Who was camping.",
                GENERIC = "It looks like it would be too warm for me.",
        },
        WALRUS_TUSK = "It's pretty pointy for a tusk.",
        WASPHIVE = "Great. Pissy bees.",
        WETGOOP = "Please don't eat that.",
        WINTERHAT = "It'll be too hot whenever I wear it.",
        WINTEROMETER = "I can detect seasons now.",
        WORMHOLE =
        {
                GENERIC = "Looks like a prolapse.",
                OPEN = "This is a SUPER bad idea.",
        },
        WORMHOLE_LIMITED = "What's wrong with it?",
    },
    DESCRIBE_GENERIC = "It's a... thing.",
    DESCRIBE_TOODARK = "Shit. Shitshitshitshitshitshitshit!!!",
    EAT_FOOD =
    {
            TALLBIRDEGG_CRACKED = "Gross. Too pointy.",
    },
}

return MakePlayerCharacter("zenel", prefabs, assets, fn)
