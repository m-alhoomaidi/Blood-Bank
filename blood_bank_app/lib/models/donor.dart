class Donor {
  String email;
  String password;
  String name;
  String phone;
  String bloodType;
  String state;
  String district;
  String neighborhood;
  String image;
  String brithDate;
  String gender;
  String isShown;
  String isShownNumber;
  String isGpsOn;

  Donor({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.bloodType,
    required this.state,
    required this.district,
    required this.neighborhood,
    this.brithDate = '',
    this.image = '',
    this.gender = "male",
    this.isShown = "1",
    this.isShownNumber = "1",
    this.isGpsOn = "1",
  });

  static Map<String, String> toMap(Donor donor) => {
        "name": donor.name,
        "number": donor.phone,
        "blood_type": donor.bloodType,
        "state": donor.state,
        "district": donor.district,
        "neighborhood": donor.neighborhood,
        "image": donor.image,
        "brithdate": donor.brithDate,
        "gender": donor.brithDate,
        "is_shown": donor.isShown,
        "is_shown_number": donor.isShownNumber,
        "is_gps_on": donor.isGpsOn
      };

  static Donor fromJson(donor) => Donor(
        email: donor["email"],
        password: donor["pass"],
        name: donor["name"],
        phone: donor["number"],
        bloodType: donor["bloodType"],
        state: donor["state"],
        district: donor["district"],
        neighborhood: donor["neighborhood"],
        image: donor["image"],
        brithDate: donor["brithDate"],
        isShown: donor["is_shown"],
        isShownNumber: donor["is_shown_number"],
        isGpsOn: donor["is_gps_on"],
      );
}
