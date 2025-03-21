import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kwik/constants/colors.dart';
import 'package:kwik/models/product_model.dart';

class ProductModel2 extends StatelessWidget {
  // final ProductModel product;
  final String name;
  final double price;
  final String imageurl;
  final String productcolor;
  final String sellingpricecolor;
  final String mrpColor;
  final String offertextcolor;
  final String productBgColor;
  final String sellingPriceColor;
  final String buttontextcolor;
  final String unitbgcolor;
  final String unitTextcolor;
  final String seeAllButtonBG;
  final String seeAllButtontext;
  final BuildContext context;
  const ProductModel2({
    super.key,
    required this.name,
    required this.price,
    required this.imageurl,
    required this.productcolor,
    required this.sellingpricecolor,
    required this.mrpColor,
    required this.offertextcolor,
    required this.productBgColor,
    required this.sellingPriceColor,
    required this.buttontextcolor,
    required this.unitbgcolor,
    required this.unitTextcolor,
    required this.seeAllButtonBG,
    required this.seeAllButtontext,
    required this.context,
    // required this.product
  });

  @override
  build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      // onTap: () => context.push(
      //   '/productdetails',
      //   // extra: product
      // ),
      child: SizedBox(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: const Color.fromARGB(255, 233, 255, 234),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: parseColor("F9F9F9"),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(imageurl), fit: BoxFit.fill)),
                    ),
                  ),
                  Text(
                    name,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: parseColor(unitTextcolor),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "100 g",
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: parseColor('A19DA3'),
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Text(
                        "₹ 85",
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: parseColor(unitTextcolor),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹ 45",
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: parseColor("A19DA3"),
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: parseColor("#FFFFFF"),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: parseColor("#E23338")),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(0)),
                      child: Text(
                        'Add',
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: parseColor("E23338"),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                width: 40,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "30%",
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: parseColor("233D4D"),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      "OFF",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: parseColor("233D4D"),
                        fontFamily: "Inter",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 10);

    double x = 0;
    double y = size.height - 10;
    double step = size.width / 10;

    for (int i = 0; i < 10; i++) {
      x += step;
      y = (i % 2 == 0) ? size.height : size.height - 10;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(ZigZagClipper oldClipper) => false;
}
