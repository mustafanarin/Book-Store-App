
part of '../../view/catalog_page.dart';
class _CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabSelected;

  const _CustomTabBar({
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<_CustomTabBar> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.055),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tabs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.lowValue1),
            child: GestureDetector(
              onTap: () {
                context.read<CatalogViewModel>().changeCustomTabbarIndex(index);
                widget.onTabSelected(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: context.lowValue2, vertical: context.lowValue1),
                decoration: BoxDecoration(
                  color: context.watch<CatalogViewModel>().customTabBarIndex == index
                      ? ProjectColors.majoreBlue 
                      : ProjectColors.maWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.tabs[index],
                  style: TextStyle(
                    color: context.watch<CatalogViewModel>().customTabBarIndex == index
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