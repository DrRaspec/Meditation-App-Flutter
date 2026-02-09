import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/core/extensions/theme_extension.dart';
import 'package:meditation_app/core/widgets/no_tap_feedback.dart';
import 'package:meditation_app/gen/assets.gen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child, this.username});

  final Widget child;
  final String? username;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;
    final selected = theme.selectedItemColor ?? Colors.white;
    final unselected = theme.unselectedItemColor ?? Colors.grey;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NoTapFeedback(
        child: BottomNavigationBar(
          currentIndex: _index,
          selectedItemColor: context.colors.primary,
          // selectedLabelStyle: TextStyle(color: context.colors.primary),
          selectedLabelStyle:
              (context.text.labelLarge ?? const TextStyle(fontSize: 14))
                  .copyWith(color: context.colors.primary),
          unselectedLabelStyle:
              (context.text.labelLarge ?? const TextStyle(fontSize: 14))
                  .copyWith(color: unselected),
          onTap: (i) => setState(() => _index = i),
          items: [
            BottomNavigationBarItem(
              icon: _NavIcon(
                path: Assets.icons.shell.home.path,
                isSelected: _index == 0,
                selectedColor: selected,
                unselectedColor: unselected,
              ),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: _NavIcon(
                path: Assets.icons.shell.sleep.path,
                isSelected: _index == 1,
                selectedColor: selected,
                unselectedColor: unselected,
              ),
              label: 'Sleep',
            ),

            BottomNavigationBarItem(
              icon: _NavIcon(
                path: Assets.icons.shell.meditate.path,
                isSelected: _index == 2,
                selectedColor: selected,
                unselectedColor: unselected,
              ),
              label: 'Meditate',
            ),

            BottomNavigationBarItem(
              icon: _NavIcon(
                path: Assets.icons.shell.music.path,
                isSelected: _index == 3,
                selectedColor: selected,
                unselectedColor: unselected,
              ),
              label: 'Music',
            ),

            BottomNavigationBarItem(
              icon: _NavIcon(
                path: Assets.icons.shell.profile.path,
                isSelected: _index == 4,
                selectedColor: selected,
                unselectedColor: unselected,
              ),
              label: widget.username ?? 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.path,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
  });

  final String path;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(12),
      width: 46,
      decoration: BoxDecoration(
        borderRadius: .circular(18),
        color: isSelected ? context.colors.primary : null,
      ),
      child: Center(
        child: SvgPicture.asset(
          path,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isSelected ? selectedColor : unselectedColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
