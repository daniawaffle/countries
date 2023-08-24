import 'package:countries_app/models/country_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CountriesMdoel should be correctly parsed from JSON', () {
    final Map<String, dynamic> json = {
      'data': [
        {
          'id': 1,
          'flag_image': 'flag_url',
          'name': 'Country Name',
          'currency': 'Currency',
          'dialCode': '+123',
          'minLength': 6,
          'maxLength': 15,
        },
      ],
      'message': 'Success',
    };

    final countriesModel = CountriesMdoel.fromJson(json);

    expect(countriesModel.data, isA<List<Country>>());
    expect(countriesModel.data?.length, 1);
    expect(countriesModel.data?[0].id, 1);
    expect(countriesModel.data?[0].flagImage, 'flag_url');
    expect(countriesModel.data?[0].name, 'Country Name');
    expect(countriesModel.data?[0].currency, 'Currency');
    expect(countriesModel.data?[0].dialCode, '+123');
    expect(countriesModel.data?[0].minLength, 6);
    expect(countriesModel.data?[0].maxLength, 15);
    expect(countriesModel.message, 'Success');
  });

  test('Country should be correctly parsed from JSON', () {
    final Map<String, dynamic> json = {
      'id': 1,
      'flag_image': 'flag_url',
      'name': 'Country Name',
      'currency': 'Currency',
      'dialCode': '+123',
      'minLength': 6,
      'maxLength': 15,
    };

    final country = Country.fromJson(json);

    expect(country.id, 1);
    expect(country.flagImage, 'flag_url');
    expect(country.name, 'Country Name');
    expect(country.currency, 'Currency');
    expect(country.dialCode, '+123');
    expect(country.minLength, 6);
    expect(country.maxLength, 15);
  });

  test('CountriesMdoel should be correctly converted to JSON', () {
    final countriesModel = CountriesMdoel(
      data: [
        Country(
          id: 1,
          flagImage: 'flag_url',
          name: 'Country Name',
          currency: 'Currency',
          dialCode: '+123',
          minLength: 6,
          maxLength: 15,
        ),
      ],
      message: 'Success',
    );

    final json = countriesModel.toJson();

    expect(json['data'], isA<List>());
    expect(json['data'][0]['id'], 1);
    expect(json['data'][0]['flag_image'], 'flag_url');
    expect(json['data'][0]['name'], 'Country Name');
    expect(json['data'][0]['currency'], 'Currency');
    expect(json['data'][0]['dialCode'], '+123');
    expect(json['data'][0]['minLength'], 6);
    expect(json['data'][0]['maxLength'], 15);
    expect(json['message'], 'Success');
  });

  test('Country should be correctly converted to JSON', () {
    final country = Country(
      id: 1,
      flagImage: 'flag_url',
      name: 'Country Name',
      currency: 'Currency',
      dialCode: '+123',
      minLength: 6,
      maxLength: 15,
    );

    final json = country.toJson();

    expect(json['id'], 1);
    expect(json['flag_image'], 'flag_url');
    expect(json['name'], 'Country Name');
    expect(json['currency'], 'Currency');
    expect(json['dialCode'], '+123');
    expect(json['minLength'], 6);
    expect(json['maxLength'], 15);
  });
}
