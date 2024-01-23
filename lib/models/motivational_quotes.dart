import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/quotes.dart';

class MotivationalQuotes extends StatefulWidget {
  const MotivationalQuotes({super.key});

  @override
  State<MotivationalQuotes> createState() => _MotivationalQuotesState();
}

List<String> fetchQuote(){
  return Quotes().randomQuote();
}

class _MotivationalQuotesState extends State<MotivationalQuotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Center(
              child: Container(
                child: Text( fetchQuote().first,
                    maxLines: 4,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 35,
                        color: Colors.blueAccent),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text( '-${fetchQuote().last}',
                style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    color: Colors.blueAccent,
                ) ,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: (){
                setState(() {
                  fetchQuote();
                });
              },
              child: Text('Refresh',
                  style: GoogleFonts.bebasNeue( fontSize: 30, color: Colors.blueAccent)
              )
            ),
          )
        ],
      ),
    );
  }
}
