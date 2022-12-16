import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_submission1/model/detail_model.dart';

import '../api_data/api_serv.dart';
import '../provider/detail_provider.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final DetailProvider provider;

  const DetailRestaurant({required this.restaurant, required this.provider});

  /*@override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(25)),
                  child: Hero(
                      tag: restaurant.id,
                      child: Image.network(
                        "${ApiServ.baseUrlImg}medium/" + restaurant.pictureId,
                        width: 450,
                        height: 300,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15, left: 20),
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withOpacity(0.50)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Container(
                  height: 30,
                  margin: EdgeInsets.only(top: 260, left: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Theme(
                            data: Theme.of(context)
                                .copyWith(canvasColor: Colors.transparent),
                            child: Chip(
                              backgroundColor: Colors.amber.withOpacity(0.7),
                              label: Text(
                                restaurant.categories[index].name,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                  width: null,
                ),
                Text(
                  restaurant.address,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.black54,
                  ),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ]),
                // Bagian Deskripsi
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Tentang", style: Theme.of(context).textTheme.subtitle2),
                SizedBox(
                  height: 10,
                ),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  children: List.generate(
                      150 ~/ 5,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey,
                              height: 2,
                            ),
                          )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Review", style: Theme.of(context).textTheme.subtitle2),

                SizedBox(
                  height: 10,
                ),

                Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.customerReviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          width: 200,
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      restaurant.customerReviews[index].name,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      restaurant.customerReviews[index].date,
                                      style:
                                          Theme.of(context).textTheme.overline,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '\"' +
                                          restaurant
                                              .customerReviews[index].review +
                                          '\"',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                TextButton(
                  child: Text(
                    "Tambahkan review",
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          ReviewDialog(provider: provider, id: restaurant.id),
                    );
                  },
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: List.generate(
                      150 ~/ 5,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey,
                              height: 2,
                            ),
                          )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Menu", style: Theme.of(context).textTheme.subtitle2),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 400,
                    child: GridView.count(
                      crossAxisCount: 2,
                      primary: false,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.5,
                      children: <Widget>[
                        Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text("Makanan",
                                    style:
                                        Theme.of(context).textTheme.subtitle2)),
                            Column(
                              children: restaurant.menus.foods
                                  .map(
                                    (food) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          food.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        )),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Text("Minuman",
                                    style:
                                        Theme.of(context).textTheme.subtitle2)),
                            Column(
                              children: restaurant.menus.drinks
                                  .map(
                                    (food) => Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          food.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        )),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        // )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    Color blackColor = Color(0xff000000);
    Color whiteColor = Color(0xffFFFFFF);
    Color greyColor = Color(0xff82868E);

    double edge = 24;
    double mediumFontSize = 14;

    TextStyle blackTextStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: blackColor,
    );

    TextStyle greyTextStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w300,
      color: greyColor,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              "${ApiServ.baseUrlImg}medium/" + restaurant.pictureId,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.none,
            ),
            Positioned(
              top: 110.0,
              left: 20.0,
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Card(
                  elevation: 11.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(17.0),
                        // bottomRight: Radius.circular(14),
                        // topRight: Radius.circular(14),
                      ),
                      side: BorderSide(
                          width: 2, color: Color.fromARGB(255, 215, 219, 225))),
                  child: ClipRRect(
                    child: Image.network(
                      "${ApiServ.baseUrlImg}medium/" + restaurant.pictureId,
                      width: 450,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(23.0),
                  ),
                ),
              ),
            ),
            ListView(
              children: [
                SizedBox(
                  height: 225,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ).copyWith(
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'City : ',
                                      style: greyTextStyle.copyWith(
                                        fontSize: mediumFontSize,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' ${restaurant.city}',
                                          style: blackTextStyle.copyWith(
                                            fontSize: mediumFontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Description',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ).copyWith(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: edge, right: edge),
                              child: Text(
                                restaurant.description,
                                textAlign: TextAlign.justify,
                                style: blackTextStyle.copyWith(
                                  fontSize: 14,
                                  wordSpacing: 2,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            Container(
                              height: 130,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurant.customerReviews.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: SizedBox(
                                      width: 200,
                                      child: Card(
                                        elevation: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  restaurant
                                                      .customerReviews[index]
                                                      .name,
                                                  style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ).copyWith(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  restaurant
                                                      .customerReviews[index]
                                                      .date,
                                                  style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ).copyWith(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\"' +
                                                      restaurant
                                                          .customerReviews[
                                                              index]
                                                          .review +
                                                      '\"',
                                                  style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ).copyWith(
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Food Menu',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ).copyWith(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              height: 34,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: restaurant.menus.foods
                                    .map(
                                      (food) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            food.name,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Drink Menu',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ).copyWith(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 17.0),
                              height: 34,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: restaurant.menus.drinks
                                    .map(
                                      (food) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            food.name,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 27,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edge,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Color.fromARGB(255, 96, 93, 93),
                        width: 2.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 158, 158, 158),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
