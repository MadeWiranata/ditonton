import 'package:aplikasiditonton/data/datasources/db/tv/database_helper.dart';
import 'package:aplikasiditonton/data/datasources/movie_local_data_source.dart';
import 'package:aplikasiditonton/data/datasources/movie_remote_data_source.dart';
import 'package:aplikasiditonton/data/datasources/tv/tv_local_data_source.dart';
import 'package:aplikasiditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:aplikasiditonton/domain/repositories/movie_repository.dart';
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
