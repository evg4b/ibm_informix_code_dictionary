class StatusCode {
  String code;

  String shortDescriptionRus;
  String descriptionRus;

  String shortDescriptionEng;
  String descriptionEng;

  StatusCode(
      {this.code,
      this.descriptionEng = "No description",
      this.descriptionRus = "Нет описания",
      this.shortDescriptionEng = "No description",
      this.shortDescriptionRus = "Нет описания"});
}
