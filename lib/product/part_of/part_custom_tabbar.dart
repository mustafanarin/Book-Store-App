
part of '../../view/catalog_page.dart';
class _CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabSelected;

  const _CustomTabBar({
    Key? key,
    required this.tabs,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<_CustomTabBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.055),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tabs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.lowValue1),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTabSelected(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: context.lowValue2, vertical: context.lowValue1),
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? ProjectColors.majoreBlue 
                      : ProjectColors.maWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.tabs[index],
                  style: TextStyle(
                    color: _selectedIndex == index
                        ? ProjectColors.maWhite
                        : ProjectColors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}