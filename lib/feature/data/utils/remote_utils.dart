const baseUrl = "https://api.themoviedb.org/3/";
const posterPath = "https://image.tmdb.org/t/p/w342/";
const apiKey = "3249dba9ba8a81c53f42a124fe89e8e5";
const authKey =
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjQ5ZGJhOWJhOGE4MWM1M2Y0MmExMjRmZTg5ZThlNSIsIm5iZiI6MTYzNjE4MTYxNy4xNzI5OTk5LCJzdWIiOiI2MTg2MjY3MTcwMzA5ZjAwNDM5MjQ0MjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.LTrNwQs2TNcIGZZG9PcGZqpYElYwb-WN6cXm8qRq6YM";

const responseLanguage = "ru";
const searchMovieEndpoint = "search/movie";
const movieDetailsEndpoint = "movie/";

const nowPlayingEndpoint = "movie/now_playing";
const popularMoviesEndpoint = "movie/popular";
const upcomingMoviesEndpoint = "movie/upcoming";
const topRatedMoviesEndpoint = "movie/top_rated";

const similarMoviesEndpoint = "movie/{movie_id}/similar";
const recommendMoviesEndpoint = "movie/{movie_id}/recommendations";

const allPersonsEndpoint = "person/popular?language=$responseLanguage&page=";
const personDetailsEndpoint = "person/{person_id}";
const searchPersonEndpoint = "search/person?query=";
