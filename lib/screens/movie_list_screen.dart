import 'package:flutter/material.dart';
import 'package:movie_test/model/movie_model.dart';
import 'package:movie_test/providers/movie_fetch_provider.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatelessWidget {
  final List<Movie> mainFilter;

  MovieListScreen({required this.mainFilter});


  @override
  Widget build(BuildContext context) {

    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body:
      ListView.separated(
        separatorBuilder: (context,i){
          return SizedBox(height: 10,);
        },
        itemCount: mainFilter.length,
        itemBuilder: (context, index) {
          final post = mainFilter[index];
          return InkWell(
            onTap: (){
              _showMovieRatingDialog(context, post);
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                      height:120,
                      width:120,
                      child: Image.network(post.poster)),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${post.title}",style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),),
                        Text("Lanuage: ${post.language}",style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        )),
                        Text("Year: ${post.year}",style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        ))
                      ],
                    ),
                  ),

                ],
              ),

            ),
          );
        },
      ),
    );
  }
  void _showMovieRatingDialog(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900], // Dark background for modern look
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          title: Text(
            "${movie.title} Ratings",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White title text
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: movie.ratings.isNotEmpty
                  ? movie.ratings
                  .map(
                    (rating) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star, // Rating icon
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${rating.source}: ${rating.value}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70, // Slightly faded white text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .toList()
                  : [
                const Text(
                  "No ratings available",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent, // Red text for emphasis
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Close",
                style: TextStyle(
                  color: Colors.amber, // Accent color for button
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
