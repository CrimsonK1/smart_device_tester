import 'package:flutter_test/flutter_test.dart';
import 'package:smart_device_tester/thermostat.dart';
import 'mock_sensor.dart';

void main() {
  //Group similar tests together
  group('Thermostat Unit Tests', () {

    //Arrange: declare instance variable
    late Thermostat thermostat;
    
    // setUp runs BEFORE each test, ensuring clean state
    setUp(() {
      //Arrange: Initialize thermostat instance
      thermostat = Thermostat(MockSensor());
    });

    test('shoukd set temperature within normal range', () {
      //Act: Execute the function to test
      final message = thermostat.setTargetTemperature(25.5);

      //Assert: Verify unit behaved as expected
      expect(thermostat.targetTemperature, 25.5);
      expect(message, 'Temperature set to 25.5 C.');
    });

    test('should limit to 30.0 C when set too high', () {
      //Act: Attempt to set extreme temperature
      thermostat.setTargetTemperature(40.0);

      //Assert: Verify it limited to maximum value
      expect(thermostat.targetTemperature, 30.0);
      expect(
        thermostat.setTargetTemperature(40.0),
        contains ('WARNING')
      );
    });
    
    test('should limit to 15.0 C when set too low', () {
      //Act: Attempt to set extreme temperature
      thermostat.setTargetTemperature(10.0);

      //Assert: Verify it limited to minimum value
      expect(thermostat.targetTemperature, 15.0);
      expect(
        thermostat.setTargetTemperature(10.0),
        contains ('WARNING')
      );
    });
  });
}