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
  final String? id;

  Expense({
    required this.date,
    required this.amount,
    required this.title,
    required this.category,
    this.description,
    String? id,
  }) : id = id ?? uuid.v4();

  String get dateDay {
    return date.day.toString();
  }

  String get dateMonth {
    String monthName = DateFormat('MMM').format(date);
    return monthName;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: Category.values.firstWhere((e) => e.name == map['category']),
      description: map['description'],
    );
  }
}
