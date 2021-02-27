class UserProfile {
  String userId;
  String name;
  String profileImage;

  UserProfile({
    this.userId,
    this.name,
    this.profileImage,
  });

  UserProfile.newuser(userId, name, profileImage, emailId) {
    this.userId = userId;
    this.name = name;
    this.profileImage = profileImage;
  }

  Map<String, dynamic> toJson() => {
        'userId': this.userId,
        'name': this.name,
        'profileImage': this.profileImage
      };
}
