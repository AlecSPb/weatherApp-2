import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/dailyForecast.dart';
import 'package:weatherapp/models/weatherDataset.dart';
import 'package:weatherapp/providers/global/config/config_provider.dart';

import 'package:weatherapp/widgets/material/customExpansionPanelList.dart'
    as custom;

class ForecastAccordionItem {
  ForecastAccordionItem({
    this.data,
    this.isExpanded = false,
  });

  DailyForecast data;
  bool isExpanded;
}

class ForecastAccordion extends StatefulWidget {
  const ForecastAccordion(this.data);

  final List<DailyForecast> data;

  @override
  _ForecastAccordionState createState() => _ForecastAccordionState();
}

List<ForecastAccordionItem> generateItems(List<DailyForecast> data) {
  return List.generate(data.length, (int index) {
    return ForecastAccordionItem(data: data.elementAt(index));
  });
}

class _ForecastAccordionState extends State<ForecastAccordion> {
  List<ForecastAccordionItem> _data;

  @override
  void initState() {
    super.initState();
    _data = generateItems(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    ConfigProvider configProvider = Provider.of<ConfigProvider>(context);

    return Theme(
      data: Theme.of(context).copyWith(
        cardColor: Colors.white12,
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white),
        ),
      ),
      child: custom.ExpansionPanelList(
        elevation: 0,
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
              return Row(
                children: <Widget>[
                  _buildDailyHeader(item.data.datasets.elementAt(0),
                      configProvider.appConfig.openWeatherImageUrl),
                  Spacer(),
                  _buildDailyMinMax(item.data),
                ],
              );
            },
            body: Container(
              color: Colors.white12,
              height: 120.0,
              child: _buildDailyDetail(item.data.datasets,
                  configProvider.appConfig.openWeatherImageUrl),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDailyHeader(WeatherDataset dataset, String imgUrl) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Image.network(
            '$imgUrl/${dataset.icon}@2x.png',
            height: 50.0,
          ),
        ),
        Text(
          DateFormat('EEEE').format(dataset.dateTime),
        ),
      ],
    );
  }

  Widget _buildDailyMinMax(DailyForecast dailyForecast) {
    return Row(
      children: <Widget>[
        Container(
          width: 50.0,
          child: Text("${dailyForecast.tempMin.toString()}°"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: 50.0,
          child: Text("${dailyForecast.tempMax.toString()}°"),
        ),
      ],
    );
  }

  Widget _buildDailyDetail(List<WeatherDataset> datasets, String imgUrl) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: datasets.length,
      itemBuilder: (context, index) {
        return Container(
          height: 120.0,
          width: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(DateFormat("HH:mm")
                  .format(datasets.elementAt(index).dateTime)),
              Image.network(
                "$imgUrl/${datasets.elementAt(index).icon}@2x.png",
                height: 50,
              ),
              Text("${datasets.elementAt(index).temp.toString()}°"),
            ],
          ),
        );
      },
    );
  }
}
