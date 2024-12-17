import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turbo_shark/widgets/buttons.dart';
import 'package:turbo_shark/widgets/searchBar.dart';

class CustomAppBarForDownloads extends StatelessWidget
    implements PreferredSizeWidget {
  final String appBarTitle;
  final Function onNewDownloadPressed;

  const CustomAppBarForDownloads({
    Key? key,
    required this.appBarTitle,
    required this.onNewDownloadPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth > 600;

        return AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          toolbarHeight: 150,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Flexible(
                    child: Text(
                      appBarTitle,
                      style: GoogleFonts.ubuntu(
                        color: Colors.black,
                        fontSize: isWideScreen ? 30 : 24,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Responsive layout for search and download button
                  if (isWideScreen)
                    Row(
                      children: [
                        Searchbar(constraints: constraints),
                        const SizedBox(width: 20),
                        DownloadPromptButton(
                            onNewDownloadPressed: onNewDownloadPressed),
                      ],
                    )
                ],
              ),

              // On smaller screens, place search and download button below title
              if (!isWideScreen)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Searchbar(constraints: constraints),
                    const SizedBox(height: 10),
                    DownloadPromptButton(
                        onNewDownloadPressed: onNewDownloadPressed),
                  ],
                ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              color: Colors.blue.withOpacity(0.1),
              height: 1,
              thickness: 1,
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String textContent;
  CustomAppbar({super.key, required this.textContent});
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isWideScreen = constraints.maxWidth > 600;
      return AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        title: Column(
          children: [
            Text(
              textContent,
              style: GoogleFonts.ubuntu(
                  fontSize: isWideScreen ? 30 : 24,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            color: Colors.blue.withOpacity(0.1),
            height: 1,
            thickness: 1,
          ),
        ),
      );
    });
  }

  Size get preferredSize => const Size.fromHeight(150);
}
