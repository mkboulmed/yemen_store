import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({
    Key? key,
    required this.room,
  }) : super(key: key);

  final types.Room room;

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool _isAttachmentUploading = false;
  bool _isPhotoUploading = false;

  TextEditingController _textController = InputTextFieldController();

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleImageSelection();
                    },
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Photo'),
                    ),
                    icon: Icon(CupertinoIcons.photo),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleFileSelection();
                    },
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('File'),
                    ),
                    icon: Icon(Icons.attach_file),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Cancel'),
                    ),
                    icon: Icon(CupertinoIcons.clear_circled),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      //TODO uncomment _setAttachmentUploading when not using customBottomWidget
      //_setAttachmentUploading(true);
      _setPhotoUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        //TODO uncomment _setAttachmentUploading when not using customBottomWidget
        //_setAttachmentUploading(false);
        _setPhotoUploading(false);
      } finally {
        //TODO uncomment _setAttachmentUploading when not using customBottomWidget
        //_setAttachmentUploading(false);
        _setPhotoUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  void _setPhotoUploading(bool uploading) {
    setState(() {
      _isPhotoUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        //systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Chat'),
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) {
          return StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) {
              return Chat(
                customBottomWidget: Container(
                  color: isDark ? Colors.grey[900] : Colors.grey[100],
                  child: SafeArea(
                    child: Row(
                      children: [
                        _isAttachmentUploading ? Container(
                          width: 40,
                          child: Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isDark ? Colors.white.withOpacity(0.5) : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ) :
                        Container(
                          width: 40,
                          child: IconButton(onPressed: () {
                            _handleFileSelection();
                          }, icon: Icon(Icons.attach_file, color: isDark ? Colors.white.withOpacity(0.5) : Colors.black54,)),
                        ),
                        Expanded(
                          child: CupertinoTextField(
                            controller: _textController,
                            placeholder: 'Message',
                            onEditingComplete: () {
                              _handleEditingComplete();
                            },
                            suffix: _textController.text.isNotEmpty ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(onTap: () {
                                _handleEditingComplete();
                              },child: Icon(Icons.send, color: isDark ? Colors.white.withOpacity(0.5) : Colors.black54,)),
                            ) : null,
                            //prefixIcon: Container(height: 0),
                            //suffixIcon: Icon(CupertinoIcons.camera),
                            suffixMode: OverlayVisibilityMode.always,
                            style: TextStyle(color: isDark ? Colors.white : Colors.black),
                            onChanged: (String value) {
                              setState(() {});
                            },
                            onSubmitted: (String value) {
                              //print('Submitted text: $value');
                            },
                          ),
                        ),
                        _isPhotoUploading ? Container(
                          width: 40,
                          child: Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isDark ? Colors.white.withOpacity(0.5) : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ) : Container(
                          width: 40,
                          child: IconButton(onPressed: () {
                            _handleImageSelection();
                          }, icon: Icon(CupertinoIcons.camera, color: isDark ? Colors.white.withOpacity(0.5) : Colors.black54)),
                        ),
                      ],
                    ),
                  ),
                ),
                isAttachmentUploading: _isAttachmentUploading,
                messages: snapshot.data ?? [],
                onAttachmentPressed: _handleAtachmentPressed,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                theme: Theme.of(context).brightness == Brightness.light ? DefaultChatTheme(
                  //inputBackgroundColor: Colors.black.withOpacity(0.2),
                    inputTextDecoration: new InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      filled: true,
                      contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    )
                ) : DarkChatTheme(
                  inputTextDecoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.transparent)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.transparent)),
                    filled: true,
                    contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                  ),
                ),
                user: types.User(
                  id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _handleEditingComplete() {
    final trimmedText = _textController.text.trim();
    if (trimmedText != '') {
      final partialText = types.PartialText(text: trimmedText);
      _handleSendPressed(partialText);

      if (InputClearMode.always == InputClearMode.always) {
        _textController.clear();
      }
    }
  }
}