import 'package:countries_app/constants.dart';
import 'package:test/test.dart';
import 'package:flutter/material.dart'; // You might not need this import for the variables themselves

void main() {
  test('Check colors are assigned correctly', () {
    expect(primaryColor, Colors.green.shade700);

    expect(secendaryColor, Colors.green.shade50);

    expect(selectedItemColor, Colors.green.shade300);
  });
}
