class CommunityMembership {
  final int id;
  final int userId;
  final int communityId;
  bool isAdministrator;
  bool isModerator;
  final String communityName;
  final String communityTitle;
  String color;

  CommunityMembership( 
      {this.id,
      this.userId,
      this.communityId,
      this.isAdministrator,
      this.isModerator,
      this.communityName, 
      this.communityTitle,
      this.color,
      }
  );

  factory CommunityMembership.fromJSON(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) return null;
    return CommunityMembership(
        id: parsedJson['id'],
        communityId: parsedJson['community_id'],
        userId: parsedJson['user_id'],
        communityName: parsedJson['community_name'],
        communityTitle: parsedJson['community_title'],
        color: parsedJson['community_color'],
        isAdministrator: parsedJson['is_administrator'],
        isModerator: parsedJson['is_moderator']);
  }

  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'user_id': userId,
    'community_id': communityId,
    'community_name': communityName,
    'community_title': communityTitle,
    'community_color': color,
    'is_administrator': isAdministrator,
    'is_moderator': isModerator 
    };
  }

  void updateFromJson(Map<String, dynamic> json) {
    if (json.containsKey('is_administrator'))
      isAdministrator = json['is_administrator'];
    if (json.containsKey('is_moderator')) isModerator = json['is_moderator'];
  }
}
