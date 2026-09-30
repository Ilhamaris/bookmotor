const servicePrices = <String, int>{
  'Servis Rutin': 85000,
  'Ganti Oli': 65000,
  'Servis CVT': 120000,
  'Rem': 75000,
  'Kelistrikan': 95000,
  'Lainnya': 50000,
};

const partPrices = <String, int>{
  'AHM Oil MPX 1': 58000,
  'Busi NGK': 28000,
  'Kampas rem': 75000,
};

class Bike {
  Bike(this.name, this.plate, this.km, {this.year = '2023'});
  final String name;
  final String plate;
  final String km;
  final String year;
  bool selected = true;
  bool configured = false;
  final Set<String> services = {'Servis Rutin'};
  String partMode = 'Bengkel';
  String complaint = '';
  final Map<String, bool> selectedParts = {
    'AHM Oil MPX 1': false,
    'Busi NGK': false,
    'Kampas rem': false,
  };
  String get service => services.join(', ');
  int get price => services.fold(0, (sum, name) => sum + servicePrices[name]!);
  int get partsPrice => partMode == 'Bengkel'
      ? selectedParts.entries
            .where((part) => part.value)
            .fold(0, (sum, part) => sum + partPrices[part.key]!)
      : 0;
}
