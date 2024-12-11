import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:bus_resolver/models/person.dart';


// Fetch Google Sheet data as CSV
// example with: 1797ht3TrtkEdV5427wxcIE2EKuc_p7S2WUkNjYrFVxI
// !! remmeber to share the sheet (with link and editor permission) to get the data
Future<List<Person>> fetchAndParseSheet(String sheetId) async {
  final url =
      'https://docs.google.com/spreadsheets/d/$sheetId/export?format=csv';
  try {
    final response = await http.get(Uri.parse(url));

    // Check and log the status code and response body for debugging
    print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final csvData = response.body;
      return parseCSV(csvData);
    } else {
      throw Exception('Failed to load Google Sheet: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching sheet: $e');
  }
}

// Parse CSV and map to List<Person>
List<Person> parseCSV(String csvData) {
  final rows = const CsvToListConverter().convert(csvData, eol: '\n');

  // Assuming the first row contains headers
  final headers = rows[0];
  final dataRows = rows.sublist(1);

  // Map fields to Person class
  return dataRows.map((row) {
    final map = Map.fromIterables(headers, row);

    return Person(
      code: map['Codice Membro']?.toString() ?? '',
      name: map['Nome']?.toString() ?? '',
      surname: map['Cognome']?.toString() ?? '',
      fiscalCode: map['Codice Fiscale']?.toString() ?? '',
      cellphone: map['Cellulare']?.toString() ?? '',
      isStaff: map['note']?.toString().toLowerCase() == 'Direttivo',
    );
  }).toList();
}
