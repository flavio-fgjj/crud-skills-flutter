class SkillModel{
  SkillModel({
    required this.skill,
    required this.level,
    required this.timeExperience,
    required this.userId
  });

  String skill;
  String level;
  String timeExperience;
  String userId;

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
    skill: json['skill'],
    level: json['level'],
    timeExperience: json['timeExperience'],
    userId: json['userId']
  );
}