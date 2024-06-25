import 'package:example/app/enums/genre.dart';
import 'package:flutter/material.dart';

extension GenreExtension on Genre {
  IconData get icon {
    switch (this) {
      case Genre.fiction:
        return Icons.book;
      case Genre.nonFiction:
        return Icons.menu_book;
      case Genre.scienceFiction:
        return Icons.science;
      case Genre.horror:
        return Icons.bolt;
      case Genre.mystery:
        return Icons.search;
      case Genre.thriller:
        return Icons.warning;
      case Genre.romance:
        return Icons.favorite;
      case Genre.historicalFiction:
        return Icons.history;
      case Genre.fantasy:
        return Icons.wallet;
      case Genre.dystopian:
        return Icons.warning_amber;
      case Genre.biography:
        return Icons.person;
      case Genre.memoir:
        return Icons.bookmark;
      case Genre.selfHelp:
        return Icons.healing;
      case Genre.health:
        return Icons.medical_services;
      case Genre.travel:
        return Icons.airplanemode_active;
      case Genre.poetry:
        return Icons.format_quote;
      case Genre.childrens:
        return Icons.child_care;
      case Genre.youngAdult:
        return Icons.emoji_people;
      case Genre.graphicNovel:
        return Icons.access_alarm_outlined;
      case Genre.shortStory:
        return Icons.article;
      case Genre.other:
        return Icons.more_horiz;
    }
  }
}
