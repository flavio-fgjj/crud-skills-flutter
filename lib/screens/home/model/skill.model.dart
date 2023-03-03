class SkillModel{
  SkillModel({
    required this.id,
    required this.skill,
    required this.level,
    required this.timeExperience,
    required this.userId
  });

  String id;
  String skill;
  String level;
  String timeExperience;
  String userId;

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
    id: json['id'],
    skill: json['skill'],
    level: json['level'],
    timeExperience: json['timeExperience'],
    userId: json['userId']
  );
}