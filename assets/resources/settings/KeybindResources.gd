class_name KeybindRessource
extends Resource

const MOVE_LEFT : String = "Left"
const MOVE_RIGHT: String = "Right"
const MOVE_UP : String = "Up"
const MOVE_DOWN : String = "Down"
const JUMP : String = "Jump"
const ATTACK : String = "Attack"
const ACTION : String = "Action"

@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_JUMP = InputEventKey.new()
@export var DEFAULT_ATTACK = InputEventKey.new()
@export var DEFAULT_ACTION = InputEventKey.new()

var move_left_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var move_up_key = InputEventKey.new()
var move_down_key = InputEventKey.new()
var jump_key = InputEventKey.new()
var attack_key = InputEventKey.new()
var action_key = InputEventKey.new()
