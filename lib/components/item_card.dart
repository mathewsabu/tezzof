import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String shopName;
  final double distance;
  final String price;
  final int? offer;
  const ItemCard({
    Key? key,
    required this.name,
    required this.shopName,
    required this.distance,
    required this.price,
    this.offer,
    this.imageUrl =
        'https://i.pinimg.com/736x/fc/7e/ce/fc7ece8e8ee1f5db97577a4622f33975--photo-icon-sad.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Styling
    ///Main Text Style
    const kMainTextStyle = TextStyle(
        fontSize: 20.0,
        fontFamily: 'poppins',
        fontWeight: FontWeight.w500,
        color: Colors.black);

    ///Sub Text Syle
    const kSubTextStyle = TextStyle(
        fontSize: 15.0,
        fontFamily: 'poppins',
        fontWeight: FontWeight.w200,
        color: Colors.black);

    const kDistanceTextStyle = TextStyle(
        fontSize: 15.0,
        fontFamily: 'poppins',
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(211, 47, 47, 1));

    const kPriceStyle = TextStyle(
        fontSize: 40.0,
        fontFamily: 'poppins',
        fontWeight: FontWeight.w200,
        color: Colors.black);
    const kOfferStyle = TextStyle(
        fontSize: 20.0,
        fontFamily: 'poppins',
        fontWeight: FontWeight.w500,
        color: Colors.white);

    ///Container Box Decoration
    const kContainerDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(71, 0, 0, 0),
          offset: Offset(0, 4.0), //(x,y)
          blurRadius: 6.0,
        )
      ],
    );
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          height: 300.0,
          decoration: kContainerDecoration,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0),
                              width: double.infinity,
                              child: Text(
                                name,
                                textAlign: TextAlign.left,
                                style: kMainTextStyle,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0),
                              width: double.infinity,
                              child: Text(
                                shopName,
                                textAlign: TextAlign.left,
                                style: kSubTextStyle,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0),
                              width: double.infinity,
                              child: Text(
                                distanceToString(distance),
                                textAlign: TextAlign.left,
                                style: kDistanceTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            price + ' Rs',
                            style: kPriceStyle,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (offer != null)
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                margin: const EdgeInsets.all(10.0),
                width: 100,
                height: 60,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(33, 0, 0, 0),
                      offset: Offset(0, 4.0), //(x,y)
                      blurRadius: 6.0,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: Color.fromRGBO(211, 47, 47, 1),
                ),
                child: Center(
                    child: Text(
                  '${offer!}% off',
                  style: kOfferStyle,
                )),
              ),
            ],
          ),
      ],
    );
  }
}

String distanceToString(double distance) {
  int distanceInt = distance.toInt();
  String distanceString = distanceInt.toString();
  if (distanceString.length <= 3) {
    return '$distanceString m';
  } else {
    return '${distanceInt % 1000}.${distanceInt / 1000} Km';
  }
}