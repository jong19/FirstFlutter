class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  Address(this.street, this.suite, this.city, this.zipcode);

 String toString() => 'street : $street, suite : $suite, city : $city, zipcode : $zipcode';

 String get getStreet => street;
 String get getSuite => suite;
 String get getCity => city;
 String get getZipcode => zipcode;
}