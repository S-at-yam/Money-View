import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();
final formatter = DateFormat.yMMMMd();

enum Category {
  food,
  outsideFood,
  travel,
  shopping,
  enjoyment,
  essentials,
  medical,
  others,
}

const categoryIcons = {
  Category.enjoyment: Icons.celebration,
  Category.essentials: Icons.home_filled,
  Category.food: Icons.restaurant_menu_rounded,
  Category.medical: Icons.local_hospital_outlined,
  Category.others: Icons.category_outlined,
  Category.outsideFood: Icons.fastfood_outlined,
  Category.shopping: Icons.shopping_cart_checkout,
  Category.travel: Icons.flight_takeoff_outlined,
};

class Expense {
  final DateTime date;
  final double amount;
  final String title;
  final Category category;
  final String? description;
  final String id;

  Expense({
    required this.date,
    required this.amount,
    required this.title,
    required this.category,
    this.description,
  }) : id = uuid.v4();

  String get dateDay {
    return date.day.toString();
  }

  String get dateMonth {
    String monthName = DateFormat('MMM').format(date);
    return monthName;
  }
}
