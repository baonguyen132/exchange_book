import 'package:flutter/material.dart';

class MenuModal {
  final int id ;
  final IconData icon ;
  final String title ;

  final int status ;

  const MenuModal({required this.id, required this.icon , required this.title , this.status = 0}) ;

}