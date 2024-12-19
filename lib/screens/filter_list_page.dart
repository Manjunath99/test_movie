import 'package:flutter/material.dart';
import 'package:movie_test/model/movie_model.dart';
import 'package:movie_test/providers/movie_fetch_provider.dart';
import 'package:movie_test/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';

class MovieFilterList extends StatefulWidget {
  const MovieFilterList({Key? key}) : super(key: key);

  @override
  State<MovieFilterList> createState() => _MovieFilterListState();
}

class _MovieFilterListState extends State<MovieFilterList> {
  TextEditingController searchController = TextEditingController();
  List<Movie> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterMovies);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterMovies);
    searchController.dispose();
    super.dispose();
  }

  void _filterMovies() {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    final query = searchController.text.toLowerCase();

    setState(() {
      if(query.isEmpty){
        filteredMovies=[];
      }
      filteredMovies = postProvider.posts.where((movie) {
        return movie.title.toLowerCase().contains(query) ||
            movie.director.toLowerCase().contains(query) ||
            movie.year.toLowerCase().contains(query);
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    if (postProvider.posts.isEmpty && !postProvider.isLoading) {
      postProvider.fetchPosts();
    }

    // Define filters
    List<String> filterList = [
      'Year',
      'Genre',
      'Directors',
      'Actors',
      "All Movies"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by movie name, director, or year...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),

      ),
      body: filteredMovies.isEmpty?

      ListView.separated(
        separatorBuilder: (context, i) => const Divider(),
        itemCount: filterList.length,
        itemBuilder: (context, i) {
          List<String> dataList = [];
          switch (filterList[i]) {
            case 'Year':
              dataList = postProvider.getUniqueYears();
              break;
            case 'Genre':
              dataList = postProvider.getUniqueGenres();
              break;
            case 'Directors':
              dataList = postProvider.getUniqueDirectors();
              break;
            case 'Actors':
              dataList = postProvider.getUniqueActors();
              break;
            case 'All Movies':
              dataList = postProvider.getAllMovieTitles();
              break;
          }
          return ExpansionTile(
            title: Text(filterList[i]),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      List<Movie> list=[];

                      switch (filterList[i]) {
                        case 'Year':
                           list = postProvider.searchMovies(year: dataList[index]);

                          break;
                        case 'Genre':
                         list = postProvider.searchMovies(genre: dataList[index]);

                          break;
                        case 'Directors':
                         list = postProvider.searchMovies(director: dataList[index]);

                          break;
                        case 'Actors':
                         list = postProvider.searchMovies(actor: dataList[index]);

                          break;
                        case 'All Movies':

                          break;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  MovieListScreen(mainFilter: list,)),
                      );
                    },
                    child: ListTile(
                      title: Text(dataList[index]),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ):ListView.builder(
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          final movie = filteredMovies[index];
          return ListTile(
            leading: Container(
              width: 50,
              height: 75,
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              movie.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Director: ${movie.director}\nYear: ${movie.year}',
              style: const TextStyle(fontSize: 14),
            ),
          );
        },
      ),
    );
  }
}
