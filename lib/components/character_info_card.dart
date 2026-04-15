import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterInfoCard extends StatelessWidget {
  final dynamic char; 

 const CharacterInfoCard({Key? key, required this.char}) : super(key: key); 

 @override 
 Widget build(BuildContext context) { 
   return Container( 
     width: 160, 
     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), 
     child: Card( 
       elevation: 4, 
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)), 
       color: const Color(0xFFFFFCFF), 
       child: Padding( 
         padding: const EdgeInsets.all(9.0), 
         child: Column( 
           crossAxisAlignment: CrossAxisAlignment.start, 
           children: [ 
             Center( 
               child: ClipRRect( 
                 borderRadius: BorderRadius.circular(15), 
                 child: CachedNetworkImage( 
                   imageUrl: char['image'], 
                   height: 90, 
                   width: 90, 
                   fit: BoxFit.cover, 
                   placeholder: 
                       (context, url) => const CircularProgressIndicator(), 
                   errorWidget: 
                       (context, url, error) => const Icon(Icons.error), 
                 ), 
               ), 
             ), 
             const SizedBox(height: 8), 

             _buildInfoRow("Name:", char['name'], isBold: true), 

             _buildInfoRow("Status:", char['status']), 

             _buildInfoRow("Species:", char['species']), 

             _buildInfoRow( 
               "Type:", 
               char['type'] == "" ? "Unknown" : char['type'], 
             ), 

             _buildInfoRow("Gender:", char['gender']), 
           ], 
         ), 
       ), 
     ), 
   ); 
 } 

 Widget _buildInfoRow(String label, String value, {bool isBold = false}) { 
   return Padding( 
     padding: const EdgeInsets.symmetric(vertical: 1.0), 
     child: Row( 
       crossAxisAlignment: CrossAxisAlignment.start, 
       children: [ 
         Text( 
           "$label ", 
           style: const TextStyle(fontSize: 10, color: Colors.grey), 
         ), 
         SizedBox(width: 6), 
         Expanded( 
           child: Text( 
             value, 
             overflow: TextOverflow.ellipsis, 
             style: TextStyle( 
               fontSize: 11, 
               fontWeight: isBold ? FontWeight.bold : FontWeight.normal, 
               color: Colors.black, 
             ), 
           ), 
         ), 
       ], 
     ), 
   ); 
 }

}
