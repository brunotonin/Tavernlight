local duration = 5000
local interval = 200
local maxTicks = duration / interval
local effectChance = 0.30

local area = {
    { 0, 0, 0, 1, 0, 0, 0 },
    { 0, 0, 1, 1, 1, 0, 0 },
    { 0, 1, 1, 1, 1, 1, 0 },
    { 1, 1, 1, 2, 1, 1, 1 },
    { 0, 1, 1, 1, 1, 1, 0 },
    { 0, 0, 1, 1, 1, 0, 0 },
    { 0, 0, 0, 1, 0, 0, 0 },
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_SPELL)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setArea(createCombatArea(area))

function onGetFormulaValues(creature, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onTargetTile(creature, position)
    if math.random() < effectChance then
        position:sendMagicEffect(CONST_ME_ICETORNADO)
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function castSpell(cid, position, tick)
    local creature = Creature(cid)
    if not creature then
        return
    end

    combat:execute(creature, position)

    if tick < maxTicks then
        addEvent(castSpell, interval, cid, position, tick + 1)
    end
end

function onCastSpell(creature, variant)
    castSpell(creature:getId(), variant, 1)
    return true
end
