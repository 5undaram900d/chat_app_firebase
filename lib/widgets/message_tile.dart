
import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sendByMe;

  const MessageTile({super.key, required this.message, required this.sender, required this.sendByMe});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: widget.sendByMe ? 0 : 24, right: widget.sendByMe ? 24 : 0),
      alignment: widget.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sendByMe ? const EdgeInsets.only(left: 30) : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        decoration: BoxDecoration(
          color: widget.sendByMe ? Theme.of(context).primaryColor : Colors.grey[700],
          borderRadius: widget.sendByMe ? BorderRadius.circular(20).copyWith(bottomRight: const Radius.circular(0),) : BorderRadius.circular(20).copyWith(bottomLeft: const Radius.circular(0),),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.sender.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5,),),
            const SizedBox(height: 8,),
            Text(widget.message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.white,),),
          ],
        ),
      ),
    );
  }
}
