import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api_data/api_serv.dart';
import '../model/list_model.dart';
import '../restarurant_detail_page.dart';
import '../ui/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      leading: Hero(
        tag: restaurant.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            "${ApiServ.baseUrlImg}small/${restaurant.pictureId}",
            width: 100,
            height: 110,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ).copyWith(
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        children: [
          Row(children: [
            Icon(
              Icons.location_pin,
              size: 12,
              color: Colors.grey,
            ),
            Text(
              " " + restaurant.city,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ).copyWith(
                fontSize: 14,
              ),
            ),
          ]),
          Row(children: [
            Icon(
              Icons.star,
              size: 12,
              color: Colors.yellow,
            ),
            Text(
              " " + restaurant.rating.toString(),
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ).copyWith(
                fontSize: 12,
              ),
            ),
          ]),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant);
      },
    ));
  }
}
