class Donor {
  String email;
  String pass;
  String name;
  String number;
  String bloodType;
  String state;
  String district;
  String neighborhood;
  String image;
  String brithDate;
  String gender;
  String isShown;
  String isShownNumber;
  String gbs;

  Donor(
      {required this.email,
      required this.pass,
      required this.name,
      required this.number,
      required this.bloodType,
      required this.state,
      required this.district,
      required this.neighborhood,
      required this.image,
      required this.brithDate,
      this.gender = "male",
      this.isShown = "1",
      this.isShownNumber = "1",
      this.gbs = "0"});

  static Map<String, String> toMap(Donor donor) => {
        "name": donor.name,
        "number": donor.number,
        "blood_type": donor.bloodType,
        "state": donor.state,
        "district": donor.district,
        "neighborhood": donor.neighborhood,
        "image": donor.image,
        "brithdate": donor.brithDate,
        "gender": donor.brithDate,
        "is_shown": donor.isShown,
        "is_shown_number": donor.isShownNumber,
        "gbs": donor.gbs
      };
  static Donor fromJson(donor) => Donor(
      email: donor["email"],
      pass: donor["pass"],
      name: donor["name"],
      number: donor["number"],
      bloodType: donor["bloodType"],
      state: donor["state"],
      district: donor["district"],
      neighborhood: donor["neighborhood"],
      image: donor["image"],
      brithDate: donor["brithDate"]);
}
