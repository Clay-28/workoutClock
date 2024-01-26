import 'package:auto_size_text/auto_size_text.dart';
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
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Center(
              child: AutoSizeText( fetchQuote().first,
                  maxLines: 5,
                  minFontSize: 25,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 35,
                      color: Colors.blueAccent),
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10.0),
              child: TextButton(
                onPressed: (){
                  print(fetchQuote());
                  setState(() {
                    fetchQuote();
                  });
                },
                child: Text('Refresh',
                    style: GoogleFonts.bebasNeue( fontSize: 30, color: Colors.blueAccent)
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
