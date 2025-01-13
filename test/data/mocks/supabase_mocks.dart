import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<Supabase>(), MockSpec<SupabaseClient>(), MockSpec<GoTrueClient>() ])
import 'supabase_mocks.mocks.dart';
