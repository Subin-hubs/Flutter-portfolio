import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


const Color kDark = Color(0xFF0E1320); // darker landing background
const Color kPrimary1 = Color(0xFF0EA5FF); // electric blue (primary)
const Color kPrimary2 = Color(0xFF00B4C4); // cyan-teal (secondary)
const Color kAccent = Color(0xFF9BE7FF); // soft cyan (accent)

class UltimatePortfolio extends StatefulWidget {
  const UltimatePortfolio({super.key});

  @override
  State<UltimatePortfolio> createState() => _UltimatePortfolioState();
}

class _UltimatePortfolioState extends State<UltimatePortfolio>
    with TickerProviderStateMixin {
  bool showEducation = true;
  final scrollController = ScrollController();

  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'subintmg39@gmail.com',
      query: Uri(queryParameters: {
        'subject': 'Collaboration',
        'body': 'Hello Subin,\n\nI would like to talk about...'
      }).query,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> viewCV() async {
    const cvUrl = "https://your-cv-link.com"; // replace with your CV
    final uri = Uri.parse(cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> openGithub() async {
    final uri = Uri.parse('https://github.com/yourname');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  late AnimationController landingBtnController;
  late Animation<double> landingBtnAnimation;

  @override
  void initState() {
    super.initState();
    landingBtnController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    landingBtnAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: landingBtnController, curve: Curves.easeInOut),
    )
      ..addStatusListener((status) {
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
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text("Subin Tamang",
            style:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
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
              color: kDark,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hi, I’m Subin 👋",
                      style: GoogleFonts.poppins(fontSize: 22, color: kAccent)),
                  const SizedBox(height: 10),
                  Text("Flutter Developer",
                      style: GoogleFonts.poppins(
                          fontSize: 44, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 15),
                  DefaultTextStyle(
                    style: GoogleFonts.poppins(
                        fontSize: 20, color: Colors.white70, fontWeight: FontWeight.w500),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText("Cross-Platform Apps"),
                        TyperAnimatedText("Clean & Responsive UI"),
                        TyperAnimatedText("Modern Digital Solutions"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  ScaleTransition(
                    scale: landingBtnAnimation,
                    child: GestureDetector(
                      onTap: () => scrollTo(projectsKey),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [kPrimary1, kPrimary2]),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6)),
                            ],
                          ),
                          child: Text("🚀 View My Work",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 15),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) =>
                        Transform.translate(offset: Offset(0, value), child: child),
                    child: const Icon(Icons.keyboard_double_arrow_down,
                        size: 40, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // About (developer-focused)
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
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 8)),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("I build production-ready apps.",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 8),
                                Text(
                                  "I'm a Flutter developer focused on building maintainable, high-performance cross-platform apps. "
                                      "I emphasize clean architecture, state management, automated testing, and CI/CD so what I ship is reliable and scalable.\n\n"
                                      "Tech highlights: Flutter, Dart, Firebase, REST APIs, responsive design, and animation-driven UX.",
                                  style: GoogleFonts.inter(
                                      fontSize: 15, color: Colors.grey[800], height: 1.6),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 12),
                                Text("Core strengths",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _devBullet("Clean architecture & modular code"),
                                    _devBullet("State management (Provider / Riverpod)"),
                                    _devBullet("Unit/widget testing & CI/CD pipelines"),
                                    _devBullet("Performance optimization & accessibility"),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _smallChip("Flutter"),
                                    _smallChip("Dart"),
                                    _smallChip("Firebase"),
                                    _smallChip("Riverpod"),
                                    _smallChip("CI/CD"),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    _miniStat(kPrimary1, "3+ Apps shipped"),
                                    const SizedBox(width: 12),
                                    _miniStat(kPrimary2, "Fast iteration"),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: openGithub,
                                      icon: const Icon(Icons.code),
                                      label: const Text("View GitHub"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimary1,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                      onPressed: () => scrollTo(contactKey),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: kPrimary2.withOpacity(0.9)),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                      child: const Text("Contact Me"),
                                    )
                                  ],
                                ),
                              ],
                            ),
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

            // Projects — attach key so landing CTA scroll works
            ProjectsSection(key: projectsKey),

            // Education (professional cards)
            SectionContainer(
              key: educationKey,
              title: "Education & Certificates",
              child: Column(
                children: [
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(12),
                    selectedColor: Colors.white,
                    fillColor: kPrimary1,
                    color: Colors.black,
                    isSelected: [showEducation, !showEducation],
                    onPressed: (index) => setState(() => showEducation = index == 0),
                    children: const [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("Education")),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("Certificates")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (showEducation)
                    Column(
                      children: const [
                        EduCard(
                          year: "2021 - 2025",
                          title: "B.Sc. Computer Science",
                          subtitle: "Tribhuvan University",
                          details: "Relevant: Algorithms, Web & Mobile App development, DB systems.",
                        ),
                        SizedBox(height: 14),
                        EduCard(
                          year: "2019",
                          title: "High School (+2 Science)",
                          subtitle: "Kathmandu Model College",
                          details: "Focus: Physics, Maths, Computer Science",
                        ),
                      ],
                    ),
                  if (!showEducation)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: const [
                          CertificateCard(image: "assets/firebase.png"),
                          CertificateCard(image: "assets/firebase.png"),
                          CertificateCard(image: "assets/firebase.png"),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Contact & CV Buttons (big, responsive)
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
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      ContactInfo(icon: Icons.email, text: "subintmg39@gmail.com"),
                      ContactInfo(icon: Icons.phone, text: "+977-9841265416"),
                      ContactInfo(icon: Icons.location_on, text: "Kathmandu, Nepal"),
                    ],
                  ),
                  const SizedBox(height: 22),
                  LayoutBuilder(builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 520;
                    return Flex(
                      direction: isMobile ? Axis.vertical : Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: sendEmail,
                            icon: const Icon(Icons.send),
                            label: const Text("Send Message"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimary1,
                              padding: const EdgeInsets.symmetric(horizontal: 28),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 6,
                            ),
                          ),
                        ),
                        SizedBox(width: isMobile ? 0 : 18, height: isMobile ? 12 : 0),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: viewCV,
                            icon: const Icon(Icons.download),
                            label: const Text("View CV"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimary2,
                              padding: const EdgeInsets.symmetric(horizontal: 28),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 6,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 18),
                  Divider(thickness: 1, color: Colors.grey[400]),
                  const SizedBox(height: 10),
                  Text("© 2025 Subin Tamang", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _smallChip(String t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.08)),
      ),
      child: Text(t, style: GoogleFonts.inter(fontSize: 13)),
    );
  }

  Widget _miniStat(Color c, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Icon(Icons.star, color: c, size: 16),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.inter(fontSize: 13)),
      ]),
    );
  }

  Widget _devBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 16, color: kPrimary1),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 14))),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: const Color(0xFF1C1C2E))),
          const SizedBox(height: 22),
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
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        transform: hover ? (Matrix4.identity()..scale(1.04)) : Matrix4.identity(),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(widget.asset, height: widget.height, fit: BoxFit.cover)),
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
        Image.asset(asset, height: 64, width: 64),
        const SizedBox(height: 8),
        Text(name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// Certificate Card (uses HoverImage)
class CertificateCard extends StatelessWidget {
  final String image;
  const CertificateCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return HoverImage(asset: image, height: 160);
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
        Icon(icon, color: kPrimary1),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

//===========================//
// Projects Section
//===========================//

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Projects",
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: const [
          ProjectCard(
            title: "Portfolio Website",
            description: "Responsive portfolio built with Flutter Web, Firebase hosting, and animations.",
            image: "assets/firebase.png",
            link: "https://your-portfolio-link.com",
          ),
          ProjectCard(
            title: "Chat App",
            description: "Real-time messaging app using Firebase Auth, Firestore, and Cloud Messaging.",
            image: "assets/firebase.png",
            link: "https://github.com/yourname/chatapp",
          ),
          ProjectCard(
            title: "E-Commerce App",
            description: "Cross-platform shopping app with cart, payments, and admin dashboard.",
            image: "assets/firebase.png",
            link: "https://github.com/yourname/ecommerce",
          ),
          ProjectCard(
            title: "Task Manager",
            description: "A productivity app with Firebase backend, notifications, and cloud sync.",
            image: "assets/firebase.png",
            link: "https://github.com/yourname/taskmanager",
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String link;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.link,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _openLink() async {
    final uri = Uri.parse(widget.link);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        width: 340,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: isHovered ? kPrimary2.withOpacity(0.16) : Colors.black12,
              blurRadius: isHovered ? 20 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        transform: isHovered ? (Matrix4.identity()..scale(1.02)) : Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(widget.image, height: 160, width: double.infinity, fit: BoxFit.cover)),
            const SizedBox(height: 12),
            Text(widget.title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: kPrimary2)),
            const SizedBox(height: 8),
            Text(widget.description, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700])),
            const SizedBox(height: 14),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: _openLink,
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text("View My Work"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary1,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}

//===========================//
// Education Card
//===========================//

class EduCard extends StatelessWidget {
  final String year;
  final String title;
  final String subtitle;
  final String details;

  const EduCard({super.key, required this.year, required this.title, required this.subtitle, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: kPrimary1,
            child: Text(year.split(" ").first, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle, style: GoogleFonts.inter(color: Colors.grey[700])),
              const SizedBox(height: 6),
              Text(details, style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13)),
            ]),
          ),
          Text(year, style: GoogleFonts.inter(color: Colors.grey[500])),
        ],
      ),
    );
  }
}
