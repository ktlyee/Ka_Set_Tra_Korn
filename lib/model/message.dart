import 'dart:async';
import 'package:flutter/material.dart';

@immutable
class MessageDB {
  final String title;
  final String body;

  const MessageDB({
    @required this.title,
    @required this.body
  });
}

