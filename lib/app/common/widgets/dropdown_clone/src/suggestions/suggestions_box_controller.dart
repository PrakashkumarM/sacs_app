import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/dropdown_clone/drop_down_search_field.dart';

/// Supply an instance of this class to the [DropDownSearchField.suggestionsBoxController]
/// property to manually control the suggestions box
class SuggestionsBoxController {
  SuggestionsBox? suggestionsBox;
  FocusNode? effectiveFocusNode;

  /// Opens the suggestions box
  void open() {
    effectiveFocusNode?.requestFocus();
  }

  bool isOpened() {
    return suggestionsBox?.isOpened ?? false;
  }

  /// Closes the suggestions box
  void close() {
    effectiveFocusNode?.unfocus();
  }

  /// Opens the suggestions box if closed and vice-versa
  void toggle() {
    if (suggestionsBox?.isOpened ?? false) {
      close();
    } else {
      open();
    }
  }

  /// Recalculates the height of the suggestions box
  void resize() {
    suggestionsBox!.resize();
  }
}
