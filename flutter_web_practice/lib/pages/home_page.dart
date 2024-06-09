import 'package:flutter/material.dart';
import 'package:flutter_web_practice/constants/colors.dart';
import 'package:flutter_web_practice/constants/size.dart';
import 'package:flutter_web_practice/widgets/contact_section.dart';
import 'package:flutter_web_practice/widgets/drawer_mobile.dart';
import 'package:flutter_web_practice/widgets/footer.dart';
import 'package:flutter_web_practice/widgets/header_desktop.dart';
import 'package:flutter_web_practice/widgets/header_mobile.dart';
import 'package:flutter_web_practice/widgets/main_desktop.dart';
import 'package:flutter_web_practice/widgets/main_mobile.dart';
import 'package:flutter_web_practice/widgets/projects_section.dart';
import 'package:flutter_web_practice/widgets/skills_desktop.dart';
import 'package:flutter_web_practice/widgets/skills_mobile.dart';
import 'dart:js' as js;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: CustomColor.scaffoldBg,
        endDrawer: constraints.maxWidth >= kMinDesktopWidth
            ? null
            : DrawerMobile(
                onNavItemTap: (int navIndex) {
                  scaffoldKey.currentState?.closeEndDrawer();
                  // call func
                  scrollToSection(navIndex);
                },
              ),
        body: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Main
              SizedBox(
                key: navbarKeys.first,
              ),
              if (constraints.maxWidth >= kMinDesktopWidth)
                HeaderDesktop(
                  onNavMenuTap: (int navIndex) {
                    // call func
                    scrollToSection(navIndex);
                  },
                )
              else
                HeaderMobile(
                  onLogoTap: () {},
                  onMenuTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),

              if (constraints.maxWidth >= kMinDesktopWidth)
                const MainDesktop()
              else
                const MainMobile(),

              // Skills
              Container(
                key: navbarKeys[1],
                width: screenWidth,
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
                color: CustomColor.bgLight1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // title
                    const Text(
                      'What can I do',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whitePrimary,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // platforms and skills
                    if (constraints.maxWidth >= kMedDesktopWidth)
                      const SkillsDesktop()
                    else
                      const SkillsMobile(),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // Projects
              ProjectsSection(
                key: navbarKeys[2],
              ),

              const SizedBox(
                height: 30,
              ),

              // Contact
              ContactSection(
                key: navbarKeys[3],
              ),

              const SizedBox(
                height: 30,
              ),

              // Footer
              const Footer(),
            ],
          ),
        ),
      );
    });
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      // open blog
      js.context.callMethod('open', ["https://google.com"]);

      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
