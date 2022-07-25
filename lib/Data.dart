class InputData {
  String selectedType = "initial";
  String selectedFrequency = "monthly";
  String selectedExtras = '';
  int date;
  int month;
  int year;
  int area;
  String address;
  String phoneNumber;
  String email;
  String customerName;

  InputData(
      {this.customerName,
      this.selectedType,
      this.selectedFrequency,
      this.selectedExtras,
      this.date,
      this.area,
      this.address,
      this.phoneNumber,
      this.email});
}
