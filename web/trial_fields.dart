//TODO: copyright
library acr.client.trial_fields;

import 'dart:html';
import 'example_data.dart';

List<OptionElement> getUserList() {
  List<OptionElement> options;
  for (String s in User.names) {
    options.add(new OptionElement(value: s, data: s));
  }
  return options;
}

List<OptionElement> getSiteList() {
  List<OptionElement> options;
  for (String s in Site.names) {
    options.add(new OptionElement(value: s));
  }
  return options;
}


