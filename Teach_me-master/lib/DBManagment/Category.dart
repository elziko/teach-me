


import 'package:cloud_firestore/cloud_firestore.dart';


class Category{
  final String name;
  final int numofCourses;

  Category(this.name, this.numofCourses);


}



var resultcategories=getcategoriesFromFireBase();





// List<Category> categories =  resultcategories.map((item) => Category(item['name'], item['courses'])).toList();





    Future<List<Map<String,dynamic>>> getcategoriesFromFireBase() async{


      QuerySnapshot<dynamic> d= await FirebaseFirestore.instance.collection('CoursesData').get();
      List<String> categories=[];
      List<Map<String,dynamic>> categoriesList=[];

      d.docs.forEach((element) {
        categories.add(element.id);
      });

      for (int i=0;i<categories.length;i++) {
        final int documents = await FirebaseFirestore.instance.collection(
            'CoursesData').doc(categories[i]).collection("Courses").get()
            .then((QuerySnapshot querySnapshot) {
          return querySnapshot.docs.length;
        });

        categoriesList.add({"name":categories[i],"Courses":documents});

      }








     print(categoriesList);

      return categoriesList;

    }






getCoursesFromFireBaseincategory(){

}











//
//
// var categorydata=[
//   {"name":"english","courses":10,"image":"assets/images/image1.jpg"},
//   {"name":"math","courses":12,"image":"assets/images/image2.jpg"},
//   {"name":"arabic","courses":14,"image":"assets/images/image3.jpg"},
//   {"name":"html","courses":13,"image":"assets/images/image4.jpg"}
// ];