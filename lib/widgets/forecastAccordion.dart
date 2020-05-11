import 'package:flutter/material.dart';

import 'package:weatherapp/widgets/material/customExpansionPanelList.dart'
    as custom;

class ForecastAccordionItem {
  ForecastAccordionItem({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class ForecastAccordion extends StatefulWidget {
  @override
  _ForecastAccordionState createState() => _ForecastAccordionState();
}

List<ForecastAccordionItem> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return ForecastAccordionItem(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _ForecastAccordionState extends State<ForecastAccordion> {
  List<ForecastAccordionItem> _data = generateItems(7);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return Theme(
        data: Theme.of(context).copyWith(
          cardColor: Colors.transparent,
          textTheme: new TextTheme(
            body1: new TextStyle(color: Colors.white),
          ),
        ),
        child: custom.ExpansionPanelList(
          showIcon: false,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((ForecastAccordionItem item) {
            return ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTileTheme(
                  child: ListTile(
                    title: Text(
                      item.headerValue,
                    ),
                  ),
                );
              },
              body: ListTile(
                  title: Text(
                    item.expandedValue,
                  ),
                  onTap: () {
                    setState(() {
                      _data.removeWhere((currentItem) => item == currentItem);
                    });
                  }),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ));
  }
}
