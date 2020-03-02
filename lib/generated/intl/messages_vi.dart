// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static m0(number) => "Đã hoàn thành ${number} mục";

  static m1(number) => "Đã xóa ${number} mục";

  static m2(number) => "Đã đánh dấu chưa hoàn thành ${number} mục";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addLabel" : MessageLookupByLibrary.simpleMessage("Thêm"),
    "addTimeLabel" : MessageLookupByLibrary.simpleMessage("Thêm thời gian"),
    "allLabel" : MessageLookupByLibrary.simpleMessage("Tất cả"),
    "appName" : MessageLookupByLibrary.simpleMessage("To Do"),
    "backAgainToLeaveMessage" : MessageLookupByLibrary.simpleMessage("Bấm trở về lần nữa để thoát"),
    "completedLabel" : MessageLookupByLibrary.simpleMessage("Hoàn thành"),
    "darkModeTitle" : MessageLookupByLibrary.simpleMessage("Giao diện tối"),
    "descriptionHintText" : MessageLookupByLibrary.simpleMessage("Mô tả"),
    "incompleteLabel" : MessageLookupByLibrary.simpleMessage("Chưa hoàn thành"),
    "languageTitle" : MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "myTasksTitle" : MessageLookupByLibrary.simpleMessage("Nhiệm vụ của tôi"),
    "oneCompletedMessage" : m0,
    "oneDeletedMessage" : m1,
    "oneMarkedIncompleteMessage" : m2,
    "saveLabelButton" : MessageLookupByLibrary.simpleMessage("Lưu"),
    "titleHintText" : MessageLookupByLibrary.simpleMessage("Tiêu đề"),
    "undoLabelButton" : MessageLookupByLibrary.simpleMessage("Hủy")
  };
}
