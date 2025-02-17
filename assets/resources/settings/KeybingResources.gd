class_name KeybingRessource
extends Resource

const MOVE_LEFT : String = "move_left"
const MOVE_RIGHT: String = "move_right"
const MOVE_UP : String = "up"
const MOVE_DOWN : String = "down"
const ATTACK : String = "attack"
const ACTION : String = "action"

@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_ATTACK = InputEventKey.new()
@export var DEFAULT_ACTION = InputEventKey.new()

var move_left_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var move_up_key = InputEventKey.new()
var move_down_key = InputEventKey.new()
var attack_key = InputEventKey.new()
var action_key = InputEventKey.new()
