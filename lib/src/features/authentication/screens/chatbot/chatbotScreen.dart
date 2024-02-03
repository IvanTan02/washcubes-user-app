import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:device_run_test/config.dart';
import 'package:device_run_test/src/features/authentication/screens/chatbot/predefinedScripts.dart';
import '../../../../utilities/theme/widget_themes/elevatedbutton_theme.dart';
import 'package:device_run_test/src/constants/image_strings.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _openAI = OpenAI.instance.build(
    token: OPEN_AI_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser =
      ChatUser(id: '1');

  final ChatUser _trimi =
      ChatUser(id: '2', firstName: 'Trimi');

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];
  final List<ChatMessage> _quickAccessName = quickAccess;

  @override
  void initState() {
    super.initState();

    // Add initial message from Trimi when the screen is loaded
    _messages.add(ChatMessage(
      user: _trimi,
      createdAt: DateTime.now(),
      text: "Hello! I'm Trimi! Thank you for choosing WashCubes. How can I assist you today?",
    ));
    _messages.add(ChatMessage(
      user: _trimi,
      createdAt: DateTime.now(),
      text: "To Ensure a smoother experience, you may choose a topic from the list below or type any of your question directly.",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //   title: const Text(
      //     'Trimi',
      //     style: TextStyle(
      //       color: Color.fromARGB(255, 0, 0, 0),
      //     ),
      //   ),
      // ),
      title: Row(
          children: [
            Image.asset(cChatBotLogo),
            const SizedBox(width: 8.0,),
            Text('Trimi', style: Theme.of(context).textTheme.displaySmall,),
          ],
        ),
        actions: [
          //End Button
          ElevatedButton(
            onPressed: (){},
            style: CElevatedButtonTheme.lightElevatedButtonTheme.style,
            child: Text("End", style: Theme.of(context).textTheme.headlineMedium,),
            ),
        ],
      ),
      body: DashChat(
        currentUser: _currentUser,
        typingUsers: _typingUsers,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Color.fromRGBO(215,236,255,1),
          currentUserTextColor: Color.fromARGB(255, 0, 0, 0),
          containerColor: Color.fromRGBO(237, 237, 237, 1),
          textColor: Color.fromARGB(255, 0, 0, 0),
          showOtherUsersAvatar: false
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        quickReplyOptions: QuickReplyOptions(
          onTapQuickReply: (QuickReply r) {
            final ChatMessage m = ChatMessage(
              user: _currentUser,
              text: r.value ?? r.title,
              createdAt: DateTime.now()
            );
            setState(() {
              getPredefinedResponse(m);
            });
          },
          quickReplyStyle: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(190, 190, 190, 1),
              width: 3.0
            ),
            borderRadius: BorderRadius.circular(10.0)
          ),
          quickReplyTextStyle: const TextStyle(
            color: Color.fromRGBO(128, 128, 128, 1)
          )
        ),
        messages: _quickAccessName + _messages,
        inputOptions: InputOptions (
          alwaysShowSend: true,
          cursorStyle: const CursorStyle(color: Color.fromRGBO(67, 143, 247, 1)),
          sendButtonBuilder: defaultSendButton(
            color: const Color.fromRGBO(67, 143, 247, 1),
          ),
          inputDecoration: defaultInputDecoration(
            hintText: "Write your message here...",
          ),
          sendOnEnter: true
        )
      )
    );
  }

  void getPredefinedResponse(ChatMessage m) {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_trimi);
    });
    
    String response = '';
    switch (m.text) {
      case 'Reserve Locker':
        response = "Unfortunately, this service is currently unavailable. Please stay tuned for future updates.";
        break;
      case 'Create Order':
        response = "To create an order, simply navigate to the order page of the app and press the 'Create' button.";
        break;
      case 'User Guide':
        response = "How-to Guide and Video on how to use the app are able to be found on our website.";
        break;
      case 'Size Guide':
        response = "Size guide are available on our website.";
        break;
      case 'Price':
        response = "Pricing details are available on our website.";
        break;
    }
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          user: _trimi,
          createdAt: DateTime.now(),
          text: response
        ),
      );
    });
    setState(() {
      _typingUsers.remove(_trimi);
    });
  }


  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_trimi);
    });
    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: [{"role": "system", "content": learning_scripts}, {"role": "user", "content": m.text + prompt}]
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _trimi,
              createdAt: DateTime.now(),
              text: element.message!.content
            ),
          );
        });
      }
    }
    setState(() {
      _typingUsers.remove(_trimi);
    });
  }
}