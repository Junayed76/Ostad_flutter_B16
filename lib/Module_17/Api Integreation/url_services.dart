class ApiConfig {
  static final baseApiUrl = Uri.parse(
    'https://crud-api-ostad-live.onrender.com/api/v1',
  );
  static final readProductApi = Uri.parse('$baseApiUrl/ReadProduct');
  static final createProductApi = Uri.parse('$baseApiUrl/CreateProduct');
  static Uri deleteProductApi(Id) {
    return Uri.parse('$baseApiUrl/deleteProduct/$Id');
  }
}
