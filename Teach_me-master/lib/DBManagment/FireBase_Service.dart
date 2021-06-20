import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';





Future<void> userSetup(Map <String,dynamic> data,CollectionReference collectionReference,String userId)async{



   collectionReference.doc(userId).set(data);
   return;

}

// ignore: non_constant_identifier_names






Future<String> uploadImagetofireStorage(File imageFile,String userFullName,String userId)async{


   final _firebaseStorage = FirebaseStorage.instance;
   var file = File(imageFile.path);

   var snapshot = await _firebaseStorage.ref()
       .child('ProfileImages/$userFullName${userId}ProImage')
       .putFile(file).whenComplete(() => null);
   String downloadUrl = await snapshot.ref.getDownloadURL();
   return downloadUrl.toString();


}

Future<String> getProfileImageFromFireBase()async{

  String url = (await FirebaseStorage.instance.ref().child("abdallaProImage").getDownloadURL()).toString();
  return url;
}



// here we connect to the database collections and retrieve the specific Teacher Data
// Stream<List<Teacher>> getTeachersDetailsFromFireBase(String Subject,String Location){
// // try {
//   Stream<QuerySnapshot<Map<String, dynamic>>> Teachers =  FirebaseFirestore.instance.collection(
//       "Teachers").where("Location" ,isEqualTo: Location);
// //   List<Teacher> TeachersDet = [];
// //
// //   Teachers.forEach((element) {
// //     element.docs.asMap().
// //     if (element.get(FieldPath(["subjects"])) == Subject &&
// //         element.get(FieldPath(["Location"])) == Location) {
// //       Teacher teacher = new Teacher(element.get(FieldPath(["email"])), "password"," verifyPassword", element.get(FieldPath(["FullName"])), element.get(FieldPath(["BirthDate"])), element.get(FieldPath(["PhoneNumber"])), element.get(FieldPath(["Location"])), element.get(FieldPath(["subjects"])), element.get(FieldPath(["More"])));
// //
// //        TeachersDet.add(teacher);
// //     }
// //   });
// // if (TeachersDet!=null)
// //      return TeachersDet;
// // } catch(e){
// //   print (e);
// //   }
//
//
//
//
//
// }






Future<List<dynamic>> getCoursesFromFireBase(String subject)async
{





    List<dynamic> resultCourses =[];
    QuerySnapshot courses = await FirebaseFirestore.instance.collection(
        "CoursesData").get();
    courses.docs.forEach((element) {
      if (element.get(FieldPath(["CourseSubject"])) == subject) {
        resultCourses.add(element.data());
      }
    });
    return resultCourses;


}



Future<List<dynamic>> getExamsFromFireBase(String subject)async{




    List<dynamic> resultExams =[];
    QuerySnapshot exams = await FirebaseFirestore.instance.collection(
        "Exams").get();
    exams.docs.forEach((element) {
      if (element.get(FieldPath(["ExamSubject"])) == subject) {
        resultExams.add(element.data());
      }
    });
    return resultExams;

}

Future<List<dynamic>> getMeetingsFromFireBase(String userID)async{




  List<dynamic> resultMeetings =[];
  QuerySnapshot meetings = await FirebaseFirestore.instance.collection(
      "meetings").get();
  meetings.docs.forEach((element) {
    if (element.get(FieldPath(["StudentId"])) == userID || element.get(FieldPath(["TeacherId"]))==userID) {
      resultMeetings.add(element.data());
    }
  });
  return resultMeetings;

}

Future<void> addMeetingToFireStoreAsTeacher(Map <String,dynamic> data)async{
  CollectionReference meetings =  FirebaseFirestore.instance.collection("Meetings");

 await meetings.add(data);

}

Future<void> editMeetingToFireStoreAsTeacher(Map <String,dynamic> data,String meetingId)async{
  CollectionReference meetings = FirebaseFirestore.instance.collection("Meetings");

  await meetings.doc(meetingId).update(data);

}

Future<List<dynamic>> getStudentFromFireBaseAsTeacher(String fullName)async{

  List<dynamic> resultStudents =[];
  QuerySnapshot students = await FirebaseFirestore.instance.collection(
      "Students").get();
  students.docs.forEach((element) {

    if (element.get(FieldPath(["FullName"]))==fullName) {
      resultStudents.add(element.data());
    }
  });
  return resultStudents;

}
Future<DocumentReference<Map<String, dynamic>>> getStudentFromFireBaseAsStudent(String userid)async{

  DocumentReference<Map<String, dynamic>> student =  FirebaseFirestore.instance.collection(
      "Students").doc(userid);
 return student;



}

Future<void> addCourseToFireBase(Map<String,dynamic> data)async{

  CollectionReference courses = FirebaseFirestore.instance.collection("CoursesData");

  await courses.add(data);

}

Future<void> addExamToFireBase(Map<String,dynamic> data )async{

  CollectionReference exams = FirebaseFirestore.instance.collection("Exams");

  await exams.add(data);

}

Future<void>  updateTeacherDetails(Map<String,dynamic> data, String userId)async{

  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");

  await teachers.doc(userId).update(data);


}