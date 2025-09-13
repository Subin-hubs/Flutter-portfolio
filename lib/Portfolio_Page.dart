import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UltimatePortfolio(),
  ));
}

class UltimatePortfolio extends StatefulWidget {
  const UltimatePortfolio({super.key});

  @override
  State<UltimatePortfolio> createState() => _UltimatePortfolioState();
}

class _UltimatePortfolioState extends State<UltimatePortfolio> with TickerProviderStateMixin {
  bool showEducation = true;
  final scrollController = ScrollController();

  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  late AnimationController landingBtnController;
  late Animation<double> landingBtnAnimation;

  @override
  void initState() {
    super.initState();
    landingBtnController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    landingBtnAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: landingBtnController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        landingBtnController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        landingBtnController.forward();
      }
    });
    landingBtnController.forward();
  }

  @override
  void dispose() {
    landingBtnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text("Subin Tamang", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        actions: [
          TextButton(onPressed: () => scrollTo(aboutKey), child: const Text("About")),
          TextButton(onPressed: () => scrollTo(projectsKey), child: const Text("Projects")),
          TextButton(onPressed: () => scrollTo(educationKey), child: const Text("Education")),
          TextButton(onPressed: () => scrollTo(contactKey), child: const Text("Contact")),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Landing
            Container(
              height: size.height,
              width: double.infinity,
              color: const Color(0xFF0F172A),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hi, I’m Subin 👋", style: GoogleFonts.poppins(fontSize: 22, color: Colors.tealAccent)),
                  const SizedBox(height: 10),
                  Text("Flutter Developer", style: GoogleFonts.poppins(fontSize: 44, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 15),
                  DefaultTextStyle(
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.white70, fontWeight: FontWeight.w500),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText("Cross-Platform Apps"),
                        TyperAnimatedText("Clean & Responsive UI"),
                        TyperAnimatedText("Modern Digital Solutions"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ScaleTransition(
                    scale: landingBtnAnimation,
                    child: GestureDetector(
                      onTap: () => scrollTo(projectsKey),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Colors.teal, Colors.indigo]),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 6)),
                            ],
                          ),
                          child: Text("🚀 View My Work", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 15),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) => Transform.translate(offset: Offset(0, value), child: child),
                    child: const Icon(Icons.keyboard_double_arrow_down, size: 40, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // About
            SectionContainer(
              key: aboutKey,
              title: "About Me",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 700;
                  return Flex(
                    direction: isMobile ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, bottom: 20),
                          child: Text(
                            "I am a Flutter developer passionate about creating responsive, visually appealing, and scalable apps. "
                                "I focus on building full-cycle apps from UI design to backend integration. "
                                "I strive to deliver smooth user experiences and robust digital solutions for mobile and web.\n\n"
                                "When not coding, I explore new tools, frameworks, and design trends to stay ahead.",
                            style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[800], height: 1.6),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Expanded(
                        child: HoverImage(asset: "assets/firebase.png", height: 250),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Technologies
            SectionContainer(
              title: "Technologies & Tools",
              child: Wrap(
                spacing: 40,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: const [
                  TechIcon(name: "Dart", asset: "assets/firebase.png"),
                  TechIcon(name: "Flutter", asset: "assets/firebase.png"),
                  TechIcon(name: "Firebase", asset: "assets/firebase.png"),
                  TechIcon(name: "Python", asset: "assets/firebase.png"),
                ],
              ),
            ),

            // Projects
            SectionContainer(
              key: projectsKey,
              title: "Projects",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxis = constraints.maxWidth > 1000 ? 4 : constraints.maxWidth > 700 ? 2 : 1;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxis,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1,
                    children: const [
                      ProjectCard(
                        title: "📱 Facebook Clone",
                        description: "A social media app built with Flutter & Firebase.",
                        technologies: ["Flutter", "Firebase"],
                        image: "assets/firebase.png",
                      ),
                      ProjectCard(
                        title: "🌐 Portfolio Website",
                        description: "Showcasing skills, projects & achievements.",
                        technologies: ["Flutter Web", "Dart"],
                        image: "assets/firebase.png",
                      ),
                      ProjectCard(
                        title: "💬 Aadan Pradan",
                        description: "Community exchange app for goods & services.",
                        technologies: ["Flutter", "Firebase"],
                        image: "assets/firebase.png",
                      ),
                      ProjectCard(
                        title: "🍴 Food Recipe App",
                        description: "Recipe app with search & save functionality.",
                        technologies: ["Flutter", "SQLite"],
                        image: "assets/firebase.png",
                      ),
                    ],
                  );
                },
              ),
            ),

            // Education & Certificates
            SectionContainer(
              key: educationKey,
              title: "Education & Certificates",
              child: Column(
                children: [
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(12),
                    selectedColor: Colors.white,
                    fillColor: Colors.teal,
                    color: Colors.black,
                    isSelected: [showEducation, !showEducation],
                    onPressed: (index) => setState(() => showEducation = index == 0),
                    children: const [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("Education")),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("Certificates")),
                    ],
                  ),
                  const SizedBox(height: 30),
                  if (showEducation)
                    Column(
                      children: const [
                        TimelineTile(year: "2021 - 2025", title: "B.Sc. Computer Science", subtitle: "Tribhuvan University"),
                        TimelineTile(year: "2019", title: "High School (+2 Science)", subtitle: "Kathmandu Model College"),
                      ],
                    ),
                  if (!showEducation)
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: const [
                        CertificateCard(image: "assets/firebase.png"),
                        CertificateCard(image: "assets/firebase.png"),
                        CertificateCard(image: "assets/firebase.png"),
                      ],
                    ),
                ],
              ),
            ),

            // Contact
            SectionContainer(
              key: contactKey,
              title: "Get In Touch",
              child: Column(
                children: [
                  Text(
                    "I’m always open to new opportunities and collaborations.\nLet’s create something great together!",
                    style: GoogleFonts.inter(fontSize: 16, height: 1.5, color: Colors.grey[800]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      ContactInfo(icon: Icons.email, text: "subintmg39@gmail.com"),
                      ContactInfo(icon: Icons.phone, text: "+977-9841265416"),
                      ContactInfo(icon: Icons.location_on, text: "Kathmandu, Nepal"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {},
                    child: const Text("Send Message", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
                  Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text("© 2025 Subin Tamang", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//===========================//
// Reusable Widgets
//===========================//

class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B))),
          const SizedBox(height: 30),
          child,
        ],
      ),
    );
  }
}

class HoverImage extends StatefulWidget {
  final String asset;
  final double height;
  const HoverImage({super.key, required this.asset, required this.height});

  @override
  State<HoverImage> createState() => _HoverImageState();
}

class _HoverImageState extends State<HoverImage> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: hover ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(widget.asset, height: widget.height, fit: BoxFit.cover)),
      ),
    );
  }
}

class TechIcon extends StatelessWidget {
  final String name;
  final String asset;
  const TechIcon({super.key, required this.name, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(asset, height: 70, width: 70),
        const SizedBox(height: 8),
        Text(name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final String image;
  const ProjectCard({super.key, required this.title, required this.description, required this.technologies, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.indigo.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HoverImage(asset: image, height: 120),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(description, style: GoogleFonts.inter(fontSize: 14, height: 1.4)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: technologies.map((e) => Chip(label: Text(e, style: const TextStyle(color: Colors.white, fontSize: 12)), backgroundColor: Colors.indigo)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final String year, title, subtitle;
  const TimelineTile({super.key, required this.year, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: [
          CircleAvatar(backgroundColor: Colors.teal, child: Text(year.split(" ")[0], style: const TextStyle(color: Colors.white))),
          Container(width: 2, height: 40, color: Colors.teal),
        ]),
        const SizedBox(width: 20),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          Text(subtitle),
          Text(year),
        ]),
      ],
    );
  }
}

class CertificateCard extends StatelessWidget {
  final String image;
  const CertificateCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return HoverImage(asset: image, height: 180);
  }
}

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  const ContactInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
