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

class_name InkStringValue

# ############################################################################ #

func get_value_type():
	return ValueType.STRING

func get_is_truthy():
	return value.length() > 0

var is_newline # bool
var is_inline_whitespace # bool
var is_non_whitespace setget , get_is_non_whitespace # bool
func get_is_non_whitespace():
	return !is_newline && !is_inline_whitespace

func _init():
	value = ""
	self._sanitize_value()

func _init_with(val):
	super._init_with(val)
	self._sanitize_value()

func cast(new_type):
	if new_type == self.value_type:
		return self

	if new_type == ValueType.INT:
		if self.value.is_valid_int():
			return IntValue().new_with(int(self.value))
		else:
			return null

	if new_type == ValueType.FLOAT:
		if self.value.is_valid_float():
			return FloatValue().new_with(float(self.value))
		else:
			return null

	Utils.throw_story_exception(bad_cast_exception_message(new_type))
	return null

# ######################################################################## #
# GDScript extra methods
# ######################################################################## #

func is_class(type):
	return type == "StringValue" || super.is_class(type)

func get_class():
	return "StringValue"

func _sanitize_value():
	is_newline = (self.value == "\n")
	is_inline_whitespace = true

	for c in self.value:
		if c != ' ' && c != "\t":
			is_inline_whitespace = false
			break

static func new_with(val):
	var value = StringValue().new()
	value._init_with(val)
	return value
