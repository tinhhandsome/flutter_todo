// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(number) => "${number} completed";

  static m1(number) => "${number} deleted";

  static m2(number) => "${number} marked incomplete";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addLabel" : MessageLookupByLibrary.simpleMessage("Add"),
    "addTimeLabel" : MessageLookupByLibrary.simpleMessage("Add time"),
    "allLabel" : MessageLookupByLibrary.simpleMessage("All"),
    "appName" : MessageLookupByLibrary.simpleMessage("To Do"),
    "backAgainToLeaveMessage" : MessageLookupByLibrary.simpleMessage("Back again to leave"),
    "completedLabel" : MessageLookupByLibrary.simpleMessage("Completed"),
    "darkModeTitle" : MessageLookupByLibrary.simpleMessage("Dark mode"),
    "descriptionHintText" : MessageLookupByLibrary.simpleMessage("Description"),
    "incompleteLabel" : MessageLookupByLibrary.simpleMessage("Incomplete"),
    "languageTitle" : MessageLookupByLibrary.simpleMessage("Language"),
    "myTasksTitle" : MessageLookupByLibrary.simpleMessage("My Tasks"),
    "oneCompletedMessage" : m0,
    "oneDeletedMessage" : m1,
    "oneMarkedIncompleteMessage" : m2,
    "saveLabelButton" : MessageLookupByLibrary.simpleMessage("Save"),
    "titleHintText" : MessageLookupByLibrary.simpleMessage("Title"),
    "undoLabelButton" : MessageLookupByLibrary.simpleMessage("Undo")
  };
}
