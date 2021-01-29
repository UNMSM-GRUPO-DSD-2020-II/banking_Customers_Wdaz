import 'dart:convert';
import 'package:banking_app/src/models/Customer.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  Future<List<Customer>> getCustomers() async {
    var client = http.Client();
    final String baseURI = "https://api-banking-customer.mybluemix.net/api";

    var headers = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3ROYW1lIjoiSnVhbiIsImxhc3ROYW1lIjoiUMOpcmV6IiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMjEtMDEtMTRUMjA6MjA6MDcuMDAwWiIsInVwZGF0ZWRBdCI6IjIwMjEtMDEtMTRUMjA6MjA6MDcuMDAwWiIsImVtYWlsIjoianBlcmV6QGdtYWlsLmNvbSIsInBob25lIjoiKzUxOTcyNjQ1ODc0MCIsImFnZSI6MzIsImdlbmRlciI6Ik0iLCJkb2N1bWVudE51bWJlciI6IjQ1MDY1OTc4IiwiYnJhbmNoSWQiOjEsInVzZXIiOnsiaWQiOjEsInVzZXJuYW1lIjoianBlcmV6QGdtYWlsLmNvbSIsInBhc3N3b3JkIjpudWxsLCJjdXN0b21lcklkIjoiMSIsInJvbCI6IlVTRVIiLCJpc0FjdGl2ZSI6dHJ1ZX0sImJyYW5jaCI6eyJpZCI6MSwib2ZmaWNlIjoiU2VkZSBDZW50cmFsIExpbWEiLCJhZGRyZXNzIjoiQXYuIFVuaXZlcnNpdGFyaWEgcy9uLiBjcnVjZSBjb24gQXYuIFZlbmV6dWVsYSBjZHJhLiAzNCwgTGltYSIsInViaWdlbyI6IkxpbWEvTGltYS9MaW1hIiwicGhvbmUiOiIrMDEgOTg1NDc0NTIiLCJlbWFpbCI6InNlcnZpY2lvLmJhbmNvc0B1bm1zbS5lZHUucGUifX0.gyA1rfhPxYAjQWAEHPvW9ZRUY7Aqc2TOZXgvDQw1nHE"
    };
    var list = [];
    try {
      var response = await client.get(baseURI + "/customers", headers: headers);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var customers = body as List;
        list =
            customers.map<Customer>((json) => Customer.fromJson(json)).toList();
      }
    } catch (Exception) {
      return list;
    }
    return list;
  }

  Future<int> delCustomer(int id) async {
    var client = http.Client();
    final String baseURI = "https://api-banking-customer.mybluemix.net/api";
    int rst = 0;
    var headers = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3ROYW1lIjoiSnVhbiIsImxhc3ROYW1lIjoiUMOpcmV6IiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMjEtMDEtMTRUMjA6MjA6MDcuMDAwWiIsInVwZGF0ZWRBdCI6IjIwMjEtMDEtMTRUMjA6MjA6MDcuMDAwWiIsImVtYWlsIjoianBlcmV6QGdtYWlsLmNvbSIsInBob25lIjoiKzUxOTcyNjQ1ODc0MCIsImFnZSI6MzIsImdlbmRlciI6Ik0iLCJkb2N1bWVudE51bWJlciI6IjQ1MDY1OTc4IiwiYnJhbmNoSWQiOjEsInVzZXIiOnsiaWQiOjEsInVzZXJuYW1lIjoianBlcmV6QGdtYWlsLmNvbSIsInBhc3N3b3JkIjpudWxsLCJjdXN0b21lcklkIjoiMSIsInJvbCI6IlVTRVIiLCJpc0FjdGl2ZSI6dHJ1ZX0sImJyYW5jaCI6eyJpZCI6MSwib2ZmaWNlIjoiU2VkZSBDZW50cmFsIExpbWEiLCJhZGRyZXNzIjoiQXYuIFVuaXZlcnNpdGFyaWEgcy9uLiBjcnVjZSBjb24gQXYuIFZlbmV6dWVsYSBjZHJhLiAzNCwgTGltYSIsInViaWdlbyI6IkxpbWEvTGltYS9MaW1hIiwicGhvbmUiOiIrMDEgOTg1NDc0NTIiLCJlbWFpbCI6InNlcnZpY2lvLmJhbmNvc0B1bm1zbS5lZHUucGUifX0.gyA1rfhPxYAjQWAEHPvW9ZRUY7Aqc2TOZXgvDQw1nHE"
    };

    try {
      var response = await client
          .delete(baseURI + "/customers/" + id.toString(), headers: headers);
      if (response.statusCode == 200) {
        rst = 1;
        print(rst);
      }

      print(rst);
    } catch (Exception) {
      return rst;
    }
    return rst;
  }

  Future<int> insertCustomer(Customer customers) async {
    var client = http.Client();
    final String baseURI = "https://api-banking-customer.mybluemix.net/api";
    int rst = 0;

    var body = jsonEncode(<String, dynamic>{
      "firstName": customers.firstName,
      "lastName": customers.lastName,
      "email": customers.email,
      "phone": customers.phone,
      "age": customers.age != null ? customers.age : null,
      "gender": customers.gender,
      "documentNumber": customers.documentNumber,
      "branchId": 1
    });

    print(body);

    var headers = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3ROYW1lIjoiSnVhbiIsImxhc3ROYW1lIjoiUMOpcmV6IiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMjEtMDEtMTRUMjA6MjA6MDcuMDAwWiIsInVwZGF0ZWRBdCI6IjIwMjEtMDEtMTRUMjA6MjA6MDcuMDAwWiIsImVtYWlsIjoianBlcmV6QGdtYWlsLmNvbSIsInBob25lIjoiKzUxOTcyNjQ1ODc0MCIsImFnZSI6MzIsImdlbmRlciI6Ik0iLCJkb2N1bWVudE51bWJlciI6IjQ1MDY1OTc4IiwiYnJhbmNoSWQiOjEsInVzZXIiOnsiaWQiOjEsInVzZXJuYW1lIjoianBlcmV6QGdtYWlsLmNvbSIsInBhc3N3b3JkIjpudWxsLCJjdXN0b21lcklkIjoiMSIsInJvbCI6IlVTRVIiLCJpc0FjdGl2ZSI6dHJ1ZX0sImJyYW5jaCI6eyJpZCI6MSwib2ZmaWNlIjoiU2VkZSBDZW50cmFsIExpbWEiLCJhZGRyZXNzIjoiQXYuIFVuaXZlcnNpdGFyaWEgcy9uLiBjcnVjZSBjb24gQXYuIFZlbmV6dWVsYSBjZHJhLiAzNCwgTGltYSIsInViaWdlbyI6IkxpbWEvTGltYS9MaW1hIiwicGhvbmUiOiIrMDEgOTg1NDc0NTIiLCJlbWFpbCI6InNlcnZpY2lvLmJhbmNvc0B1bm1zbS5lZHUucGUifX0.gyA1rfhPxYAjQWAEHPvW9ZRUY7Aqc2TOZXgvDQw1nHE"
    };

    try {
      var response = await client.post(baseURI + "/customers",
          headers: headers, body: body);
      print(baseURI);
      print(response.statusCode);
      if (response.statusCode == 201) {
        rst = 1;
        print(rst);
      }

      print(rst);
    } catch (Exception) {
      return rst;
    }
    return rst;
  }
}
