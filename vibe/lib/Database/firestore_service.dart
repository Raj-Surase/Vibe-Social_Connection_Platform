import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(
    String docId, // Add this parameter for the document ID
    String username,
    String email,
    String profile,
    bool sessionJoined,
    bool sessionCreated,
    int sessionId,
    int friendsCount,
    List friendsId,
  ) async {
    try {
      await _db.collection('users').doc(docId).set({
        'user_id': docId,
        'user_name': username,
        'user_email': email,
        'user_profile': profile,
        'session_joined': sessionJoined,
        'session_created': sessionCreated,
        'session_id': sessionId,
        'friends_count': friendsCount,
        'friends_id': friendsId,
      });
      print("User Added");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  Future<void> updateUser(String docId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(docId).update(data);
  }

  Future<void> deleteUser(String docId) async {
    await _db.collection('users').doc(docId).delete();
  }

  Future<Map<String, dynamic>?> getUser(String docId) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(docId).get();
      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (error) {
      print("Failed to get user: $error");
      return null;
    }
  }

  Future<UserModel?> getUserById(String docId) async {
    DocumentSnapshot doc = await _db.collection('users').doc(docId).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Session Table Operations
  Future<void> addSession(int id, String title, String host,
      List<String> usersConnected, String mediaLink, String playerLink) async {
    await _db.collection('session').add({
      'session_id': id,
      'session_title': title,
      'session_host': host,
      'session_usersConnected': usersConnected,
      'session_mediaLink': mediaLink,
      'session_playerLink': playerLink,
      'session_startedAt': FieldValue.serverTimestamp(),
      'session_endedAt': null,
    });
  }

  Future<void> updateSession(String docId, Map<String, dynamic> data) async {
    await _db.collection('session').doc(docId).update(data);
  }

  Future<void> deleteSession(String docId) async {
    await _db.collection('session').doc(docId).delete();
  }

  Stream<List<Session>> getSessions() {
    return _db.collection('session').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Session.fromFirestore(doc.data(), doc.id))
        .toList());
  }

  Future<Session?> getSessionById(String docId) async {
    DocumentSnapshot doc = await _db.collection('session').doc(docId).get();
    if (doc.exists) {
      return Session.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    } else {
      return null;
    }
  }

  // Chat Table Operations
  Future<void> addChat(int id, String sender, String receiver,
      List<String> message, bool isPrivate, bool isSession) async {
    await _db.collection('message').add({
      'chat_id': id,
      'chat_sender': sender,
      'chat_receiver': receiver,
      'chat_message': message,
      'chat_private': isPrivate,
      'chat_session': isSession,
      'time': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateChat(String docId, Map<String, dynamic> data) async {
    await _db.collection('message').doc(docId).update(data);
  }

  Future<void> deleteChat(String docId) async {
    await _db.collection('message').doc(docId).delete();
  }

  Stream<List<Chat>> getChats() {
    return _db.collection('message').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Chat.fromFirestore(doc.data(), doc.id))
        .toList());
  }

  Future<Chat?> getChatById(String docId) async {
    DocumentSnapshot doc = await _db.collection('message').doc(docId).get();
    if (doc.exists) {
      return Chat.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    } else {
      return null;
    }
  }
}

// UserModel model
class UserModel {
  final String id;
  final String user_name;
  final String user_email;
  final String user_profile;
  final bool sessionJoined;
  final int sessionID;
  final bool sessionCreated;
  final List<int> friendsID;
  final int friendsCount;
  static const List<int> friend = [10, 20, 30];

  UserModel({
    required this.id,
    required this.user_name,
    required this.user_email,
    required this.user_profile,
    this.sessionJoined = false,
    this.sessionID = 0,
    this.sessionCreated = false,
    this.friendsID = friend,
    this.friendsCount = 0,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['user_id'],
      user_name: data['user_name'] ?? '',
      user_email: data['user_email'] ?? '',
      user_profile: data['user_profile'] ?? '',
      sessionJoined: data['session_joined'] ?? false,
      sessionID: data['session_id'] ?? null,
      sessionCreated: data['session_created'] ?? false,
      friendsID: data['friends_id'] ?? [10, 20, 30],
      friendsCount: data['friends_count'] ?? 0,
    );
  }
}

// Session model
class Session {
  final String id;
  final String title;
  final String host;
  final List<String> usersConnected;
  final String mediaLink;
  final String playerLink;
  final DateTime startedAt;
  final DateTime? endedAt;

  Session({
    required this.id,
    required this.title,
    required this.host,
    required this.usersConnected,
    required this.mediaLink,
    required this.playerLink,
    required this.startedAt,
    this.endedAt,
  });
  factory Session.fromFirestore(Map<String, dynamic> data, String id) {
    return Session(
      id: id,
      title: data['session_title'] ?? '',
      host: data['session_host'] ?? '',
      usersConnected: List<String>.from(data['session_usersConnected'] ?? []),
      mediaLink: data['session_mediaLink'] ?? '',
      playerLink: data['session_playerLink'] ?? '',
      startedAt: (data['session_startedAt'] as Timestamp).toDate(),
      endedAt: data['session_endedAt'] != null
          ? (data['session_endedAt'] as Timestamp).toDate()
          : null,
    );
  }
}

// Chat model
class Chat {
  final String id;
  final String sender;
  final String receiver;
  final String message;
  final DateTime time;
  final bool isPrivate;
  final bool isSession;

  Chat({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.time,
    required this.isPrivate,
    required this.isSession,
  });

  factory Chat.fromFirestore(Map<String, dynamic> data, String id) {
    return Chat(
      id: id,
      sender: data['chat_sender'] ?? '',
      receiver: data['chat_receiver'] ?? '',
      message: data['chat_message'] ?? '',
      time: (data['time'] as Timestamp).toDate(),
      isPrivate: data['chat_private'] ?? false,
      isSession: data['chat_session'] ?? false,
    );
  }
}
