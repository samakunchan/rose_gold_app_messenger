import 'dart:typed_data';

import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> initializeAndPublishKeys();
  Future<Either<Failure, String>> getLocalPublicKey();
  Future<Either<Failure, String?>> getPeerPublicKey({required String userId});
  Future<Either<Failure, MessageEntity>> sendEncryptedMessage({required SendEncryptedMessageParams params});
  Stream<Either<Failure, List<MessageEntity>>> getChatMessagesStream({required GetChatMessagesStreamParams params});
  Future<Either<Failure, List<MessageEntity>>> searchMessages({required SearchMessagesParams params});
  Future<Either<Failure, String>> getPassphrase();
  Future<Either<Failure, void>> updatePassphrase({required String newPassphrase});
  Future<Either<Failure, String>> regenerateRandomPassphrase();
  Future<Either<Failure, Uint8List>> downloadAndDecryptMedia({required EncryptedMediaAttachment attachment});
}
