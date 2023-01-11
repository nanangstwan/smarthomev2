import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final String icon;
  final String nama;
  final VoidCallback onclick;

  const MyCard(
      {Key? key, required this.icon, required this.nama, required this.onclick})
      : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onclick,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage(
          //       widget.icon,
          //     ),
          //     fit: BoxFit.cover),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(1.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.all(10),
            // ),
            Image.asset(widget.icon, color: const Color(0XFF763626)),
            const SizedBox(height: 10),
            Text(
              widget.nama,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
