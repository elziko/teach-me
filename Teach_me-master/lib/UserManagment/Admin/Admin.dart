

import 'package:teach_me/DBManagment/Course.dart';
import 'package:teach_me/DBManagment/Exam.dart';

import '../../DBManagment/FireBase_Service.dart';
import '../Userbg.dart';

class Admin extends Userbg{
  Admin(String email, String password, String verifyPassword, String fullName, String birthDate, String phoneNumber, String location) : super(email, password, verifyPassword, fullName, birthDate, phoneNumber, location);




 Future<void>  addCourse(Course course)async{


     Map<String,dynamic> data={"CourseName":course.courseName
       ,"CourseSubject":course.courseSubject
       ,"videoTitles":course.videosTitles};


    return await addCourseToFireBase(data);
 }

 Future<void>  addExam(Exam exam)async{

   Map<String,dynamic> data={
     "ExamName":exam.examName,
     "ExamSubject":exam.examSubject,
     "Questions":exam.questions,
     "answers":exam.answers,
   };


return await addExamToFireBase(data);

 }





}