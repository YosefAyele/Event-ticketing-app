import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/domain/organizer/organizer.dart';

class OrganizerDataSource implements OrganizerRepository {
  final http.Client client;
  final API_URL = "http://localhost:3000";

  OrganizerDataSource({
    required this.client,
  });
  @override
  Future<Either<OrganizerFailure, OrganizerModel>> getOrganizerData(
      String id) async {
    final response = await client.get(
      Uri.parse('$API_URL/organizer/$id'),
    );
    if (response.statusCode == 200) {
      return Right(OrganizerModel.fromJson(json.decode(response.body)));
    } else if (response.statusCode == 400) {
      return const Left(OrganizerFailure.invalidOrganizer());
    } else {
      return const Left(OrganizerFailure.serverError());
    }
  }

  @override
  Future<Either<OrganizerFailure, List<OrganizerModel>>> getAllOrganizers(
      OrganizerModel allOrganizer) async {
    try {
      final response = await client.get(
        Uri.parse('$API_URL/organizer'),
      );

      final organizerIds = json.decode(response.body) as List;
      final List<OrganizerModel> organizers = [];
      for (var organizerId in organizerIds) {
        final organizer = await client.get(
          Uri.parse('$API_URL/organizer/$organizerId'),
        );
        organizers.add(OrganizerModel.fromJson(json.decode(organizer.body)));
      }
      return Right(organizers);
    } catch (e) {
      return const Left(OrganizerFailure.serverError());
    }
  }
  
  @override
  Future<Either<OrganizerFailure, OrganizerUpdateModel>> updateOrganizer(String organizerId,
      OrganizerUpdateModel newOrganizer) async {
    final response = await client.put(
      Uri.parse('$API_URL/organizer/$organizerId'),
      body: newOrganizer.toJson(),
    );
    if (response.statusCode == 200) {
      return Right(OrganizerUpdateModel.fromJson(json.decode(response.body)));
    } else if (response.statusCode == 400) {
      return const Left(OrganizerFailure.invalidOrganizer());
    } else {
      return const Left(OrganizerFailure.serverError());
    }
  }

  @override
  Future<Either<OrganizerFailure, Object>> deleteOrganizer(String id) async {
    final response = await client.delete(
      Uri.parse('$API_URL/organizer/$id'),
    );
    if (response.statusCode == 200) {
      return const Right(Object);
    } else if (response.statusCode == 400) {
      return const Left(OrganizerFailure.invalidOrganizer());
    } else {
      return const Left(OrganizerFailure.serverError());
    }
  }
}
