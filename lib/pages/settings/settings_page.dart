import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/userPreferences.dart';
import 'package:weatherapp/providers/global/preferences/preferences_provider.dart';
import 'package:weatherapp/routes.dart';
import 'package:weatherapp/widgets/checkboxFormField.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<FormState> _formKey;
  String _customLocation;
  bool _useGeolocation;
  Future<UserPreferences> _initialPreferences;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    PreferencesProvider preferencesProvider =
        Provider.of<PreferencesProvider>(context, listen: false);
    // TODO: either write a function in the provider or start working with JSON
    _initialPreferences = Future.wait([
      preferencesProvider.getCustomLocation(),
      preferencesProvider.getUseGeolocation()
    ]).then((res) {
      return UserPreferences(
          customLocation: res[0] != null ? res[0] : "",
          useGeolocation: res[1] != null ? res[1] : false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setUseGeolocation(bool value) {
    setState(() {
      _useGeolocation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<UserPreferences>(
              future: _initialPreferences,
              builder: (BuildContext context,
                  AsyncSnapshot<UserPreferences> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    _customLocation =
                        _customLocation ?? snapshot.data.customLocation;
                    _useGeolocation =
                        _useGeolocation ?? snapshot.data.useGeolocation;
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _buildUseGeolocationCheckbox(),
                          _buildCustomLocationField(),
                          _buildSubmitButton(context),
                        ],
                      ),
                    );
                }
              })),
    );
  }

  Widget _buildCustomLocationField() {
    return TextFormField(
      initialValue: _customLocation,
      enabled: !_useGeolocation,
      decoration: InputDecoration(
        labelText: 'City or ZIP',
      ),
      // The validator receives the text that the user has entered.
      validator: (String value) {
        if (!_useGeolocation) {
          if (value.isEmpty) return 'Please enter a city or ZIP code.';
        }

        return null;
      },
      onSaved: (String value) => _customLocation = value,
    );
  }

  Widget _buildUseGeolocationCheckbox() {
    return CheckboxFormField(
      context: context,
      title: const Text('Use current location'),
      initialValue: _useGeolocation,
      onChange: _setUseGeolocation,
      onSaved: (bool value) => _useGeolocation = value,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      onPressed: () {
        _formKey.currentState.save();

        if (_formKey.currentState.validate()) {
          PreferencesProvider preferencesProvider =
              Provider.of<PreferencesProvider>(context, listen: false);
          // TODO: either write a function in the provider or start working with JSON
          Future.wait([
            preferencesProvider.setCustomLocation(_customLocation),
            preferencesProvider.setUseGeolocation(_useGeolocation)
          ]).then((res) {
            if (res.every((res) => res == true))
              AppRoutes.navigateTo(context, AppRoutes.home);
          });
        }
      },
      child: Text('Save'),
    );
  }
}
