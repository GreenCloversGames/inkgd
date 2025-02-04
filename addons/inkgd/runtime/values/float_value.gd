# warning-ignore-all:shadowed_variable
# warning-ignore-all:unused_class_variable
# ############################################################################ #
# Copyright © 2015-2021 inkle Ltd.
# Copyright © 2019-2022 Frédéric Maquin <fred@ephread.com>
# All Rights Reserved
#
# This file is part of inkgd.
# inkgd is licensed under the terms of the MIT license.
# ############################################################################ #

extends InkValue

class_name InkFloatValue

# ############################################################################ #

func get_value_type():
	return ValueType.FLOAT

func get_is_truthy():
	return value != 0.0

func _init():
	value = 0.0

func cast(new_type):
	if new_type == self.value_type:
		return self

	if new_type == ValueType.BOOL:
		return BoolValue().new_with(false if value == 0 else true)

	if new_type == ValueType.INT:
		return IntValue().new_with(int(value))

	if new_type == ValueType.STRING:
		return StringValue().new_with(str(value)) # TODO: Check formating

	Utils.throw_story_exception(bad_cast_exception_message(new_type))
	return null

# ######################################################################## #
# GDScript extra methods
# ######################################################################## #

func is_class(type):
	return type == "FloatValue" || super.is_class(type)

func get_class():
	return "FloatValue"

static func new_with(val):
	var value = FloatValue().new()
	value._init_with(val)
	return value
