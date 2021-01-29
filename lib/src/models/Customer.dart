class Customer {
  int id;
  String firstName;
  String lastName;
  bool isActive;
  String createdAt;
  String updatedAt;
  String email;
  String phone;
  int age;
  String gender;
  String documentNumber;
  int branchId;
  Customer.withId(this.firstName, this.lastName, this.email, this.phone,
      this.age, this.gender, this.documentNumber);

  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.phone,
      this.age,
      this.gender,
      this.documentNumber,
      this.branchId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    email = json['email'];
    phone = json['phone'];
    age = json['age'];
    gender = json['gender'];
    documentNumber = json['documentNumber'];
    branchId = json['branchId'];
  }
}
