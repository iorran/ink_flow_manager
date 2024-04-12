import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {
  final String title;
  final Timestamp created;
  final String subTitle;
  final Function() onTap;

  const MyCard({
    super.key,
    required this.title,
    required this.created,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 5),
                      Text(title),
                      Container(height: 5),
                      Text(subTitle),
                      Container(height: 10),
                      Text(DateFormat('dd/MM/yyyy, HH:mm')
                          .format(created.toDate())),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
