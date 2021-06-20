

import 'package:teach_me/DBManagment/Lession.dart';

class AgendaCalender{

final List<Lesson> lessons;

  AgendaCalender(this.lessons);

  void addLesson(Lesson lesson){
    this.lessons.add(lesson);
  }

  void deleteLesson(Lesson lesson){
    this.lessons.remove(lesson);

  }



}