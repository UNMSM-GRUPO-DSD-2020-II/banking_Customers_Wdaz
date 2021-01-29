import 'package:flutter/material.dart';
import 'package:banking_app/src/models/Customer.dart';
import 'package:banking_app/src/services/Customer.service.dart';

CustomerService ws = new CustomerService();

final List<String> choices = const <String>[
  'Save Customer & Back',
  'Delete Customer',
  'Back to List'
];

const mnuSave = 'Save Customer & Back';
const mnuDelete = 'Delete Customer';
const mnuBack = 'Back to List';

class CustomerDetailPage extends StatefulWidget {
  final Customer customer;
  CustomerDetailPage(this.customer);

  @override
  State<StatefulWidget> createState() => CustomerDetailPageState(customer);
}

class CustomerDetailPageState extends State<CustomerDetailPage> {
  Customer customer;
  CustomerDetailPageState(this.customer);

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController documentNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstnameController.text = this.customer.firstName;
    lastnameController.text = customer.lastName;
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(customer.firstName),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      controller: firstnameController,
                      style: textStyle,
                      onChanged: (value) => this.updateFirstname(),
                      decoration: InputDecoration(
                          labelText: "First name",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: lastnameController,
                          style: textStyle,
                          onChanged: (value) => this.updateLastname(),
                          decoration: InputDecoration(
                              labelText: "Last name",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: emailController,
                          style: textStyle,
                          onChanged: (value) => this.updateEmail(),
                          decoration: InputDecoration(
                              labelText: "email",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: phoneController,
                          style: textStyle,
                          onChanged: (value) => this.updatePhone(),
                          decoration: InputDecoration(
                              labelText: "phone",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: ageController,
                          style: textStyle,
                          onChanged: (value) => this.updateAge(),
                          decoration: InputDecoration(
                              labelText: "Age",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: genderController,
                          style: textStyle,
                          onChanged: (value) => this.updateGender(),
                          decoration: InputDecoration(
                              labelText: "genero",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: documentNumberController,
                          style: textStyle,
                          onChanged: (value) => this.updateDocumentNumber(),
                          decoration: InputDecoration(
                              labelText: "numero Documento",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                  ],
                )
              ],
            )));
  }

  void select(String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (customer.id == null) {
          return;
        }
        result = await ws.delCustomer(customer.id);
        //result = await CustomerService.
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Deleteo Customer"),
            content: Text("el Customer fue deleteado"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case mnuBack:
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void save() {
    if (customer.id != null) {
      debugPrint('update');
      //CustomerService.update(customer);
    } else {
      debugPrint('insert');
      ws.insertCustomer(customer);
    }
    Navigator.pop(context, true);
  }

  void updateFirstname() {
    customer.firstName = firstnameController.text;
  }

  void updateLastname() {
    customer.lastName = lastnameController.text;
  }

  void updateEmail() {
    customer.email = emailController.text;
  }

  void updatePhone() {
    customer.phone = phoneController.text;
  }

  void updateAge() {
    customer.age = int.parse(ageController.text);
  }

  void updateGender() {
    customer.gender = genderController.text;
  }

  void updateDocumentNumber() {
    customer.documentNumber = documentNumberController.text;
  }
}
