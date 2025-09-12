import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioScrollPage extends StatelessWidget {
  const PortfolioScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        leading: Image.asset("assets/logo.png", width: 40, height: 40),
        title:  Center(child: Text("Subin's Portfolio")),
      ),
      body: SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Landing Section (full screen)
            Container(
              height: size.height,
              width: double.infinity,
              color: Colors.blue.shade900,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Subin Tamang",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                          fontSize: 40, fontWeight: FontWeight.bold)),
                   SizedBox(height: 10),
                  DefaultTextStyle(
                    style:  GoogleFonts.poppins(
                      fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                            'Flutter Developer & Cross App developer'),
                      ],
                    ),

                  ),
                   SizedBox(height: 10,),
                   Text(" I Craft beautiful mobile & desktop applications with Flutter.",style: GoogleFonts.inter(fontSize: 15,color: Colors.white),),
                   Text(" Create seamless user experiences and innovative digital solutions.",style: GoogleFonts.inter(fontSize: 15,color: Colors.white),),
                   SizedBox(height: 40),
                   Icon(Icons.keyboard_double_arrow_down,
                      size: 40, color: Colors.grey),
                ],
              ),
            ),


            Container(
              height: size.height * 0.5, // half of the screen height
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                children: [
                  // Left Side - About Me Text
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // center vertically
                      crossAxisAlignment: CrossAxisAlignment.start, // align left
                      children: [
                        Text(
                          "About Me",
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "I'm a passionate developer and designer with a love for creating digital experiences that make a difference. My journey in technology started with curiosity and has evolved into a deep commitment to crafting solutions that are both beautiful and functional.\n\n"
                              "When I'm not coding, you can find me exploring new design trends, contributing to open-source projects, or learning about the latest developments in web technology.",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 20),

                  // Right Side - Image (or Text + Image)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // center vertically
                      children: [
                        Image.asset(
                          "assets/firebase .png", // replace with your image path
                          height: size.height * 0.25, // scale image proportionally
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            Row(
              children: [
                Column(
                  children: [
                    Image.asset("assets/dart.png"),
                    Text("Dart"),
                  ],
                )
              ],
            ),





            // ✅ Projects Section (full screen)
            Container(
              height: size.height,
              width: double.infinity,
              color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.all(40),
              child: Text(
                "📱 Facebook Clone\n🔥 Built with Flutter & Firebase\n\n"
                    "📱 School Works Pro\n🚀 A student management system app",
                style: GoogleFonts.roboto(fontSize: 18, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
