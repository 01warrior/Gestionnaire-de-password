class Password {
  int? id;
  String websiteName;
  String? websiteLogoUrl; // Ajout du champ pour l'URL du logo
  String username;
  String password;
  String? websiteAddress;
  String? notes;
  String? category;
  String? connectedAccount;


  Password({
    this.id,
    required this.websiteName,
    this.websiteLogoUrl,
    required this.username,
    required this.password,
    this.websiteAddress,
    this.notes,
    this.category,
    this.connectedAccount,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'websiteName': websiteName,
      'websiteLogoUrl': websiteLogoUrl,
      'username': username,
      'password': password,
      'websiteAddress': websiteAddress,
      'notes': notes,
      'category': category,
      'connectedAccount': connectedAccount,
    };
  }

  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(
      id: map['id'],
      websiteName: map['websiteName'],
      websiteLogoUrl: map['websiteLogoUrl'],
      username: map['username'],
      password: map['password'],
      websiteAddress: map['websiteAddress'],
      notes: map['notes'],
      category: map['category'],
      connectedAccount: map['connectedAccount'],
    );
  }
}