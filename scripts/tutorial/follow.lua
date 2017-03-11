followed_entity = -1
speed = 5.0
Editor.setPropertyType("followed_entity", Editor.ENTITY_PROPERTY)
local ANIM_CONTROLLER_TYPE = Engine.getComponentType("anim_controller")
local anim_ctrl = -1
local speed_input_idx = -1
local attack_input_idx = -1
local next_follow = 2

function init()
	anim_ctrl = Engine.getComponent(g_universe, this, ANIM_CONTROLLER_TYPE)
	speed_input_idx = Animation.getControllerInputIndex(g_scene_animation, anim_ctrl, "speed")
	attack_input_idx = Animation.getControllerInputIndex(g_scene_animation, anim_ctrl, "attack")
end

function onPathFinished()
	Animation.setControllerBoolInput(g_scene_animation, anim_ctrl, attack_input_idx, true)
end

function update(time_delta)
	local agent_speed = Navigation.getAgentSpeed(g_scene_navigation, this)
	Animation.setControllerFloatInput(g_scene_animation, anim_ctrl, speed_input_idx, agent_speed)

	next_follow = next_follow - time_delta
	if next_follow > 0 then return end
	
	Engine.logError("follow")
	next_follow = 5
	local pos = Engine.getEntityPosition(g_universe, followed_entity)
	Navigation.navigate(g_scene_navigation, this, pos, speed)
end