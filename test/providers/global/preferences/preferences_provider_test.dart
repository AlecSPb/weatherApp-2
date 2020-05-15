import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:weatherapp/providers/global/preferences/preferences_provider.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  final PreferencesProvider preferencesProvider = PreferencesProvider();

  group("PreferencesProvider", () {
    test("Should set and return preference values.", () async {
      expect(await preferencesProvider.setUseGeolocation(true), true);
      expect(await preferencesProvider.getUseGeolocation(), true);

      expect(await preferencesProvider.setCustomLocation("Stuttgart"), true);
      expect(await preferencesProvider.getCustomLocation(), "Stuttgart");
    });
  });
}
