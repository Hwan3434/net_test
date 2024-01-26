import 'package:flutter/material.dart';
import 'package:net_test/test_screen/buffer/buffer_page.dart';
import 'package:net_test/test_screen/provider/provider_page.dart';

enum SampleScreen {
  provider,
  buffer,
}

final Map<SampleScreen, Widget> screenWidgets =
    SampleScreen.values.asMap().map((key, value) {
  switch (value) {
    case SampleScreen.provider:
      return MapEntry(value, const ProviderPage());
    case SampleScreen.buffer:
      return MapEntry(value, const BufferPage());
  }
});

class TestScreenModel {
  final SampleScreen selectedTab;

  TestScreenModel({
    required this.selectedTab,
  });

  TestScreenModel copyWith({
    SampleScreen? selectedTab,
  }) {
    return TestScreenModel(selectedTab: selectedTab ?? this.selectedTab);
  }
}
