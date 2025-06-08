import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/config/env_config.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;
  
  static Future<void> initialize() async {
    if (!EnvConfig.isValidConfig) {
      throw Exception(
        'Supabase configuration is incomplete. Please check your environment variables.',
      );
    }
    
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
      debug: EnvConfig.debugMode,
    );
  }
  
  // Auth helpers
  static User? get currentUser => client.auth.currentUser;
  static String? get currentUserId => currentUser?.id;
  static bool get isAuthenticated => currentUser != null;
  
  // Session helpers
  static Session? get currentSession => client.auth.currentSession;
  static Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;
  
  // Sign out
  static Future<void> signOut() async {
    await client.auth.signOut();
  }
  
  // Database helpers
  static PostgrestQueryBuilder from(String table) => client.from(table);
  static RealtimeChannel channel(String name) => client.channel(name);
  
  // Storage helpers
  static SupabaseStorageClient get storage => client.storage;
  
  // Real-time helpers
  static RealtimeClient get realtime => client.realtime;
}

// Extension for easier auth state handling
extension AuthStateExtension on AuthState {
  bool get isSignedIn => session != null;
  bool get isSignedOut => session == null;
  String? get userId => session?.user.id;
} 