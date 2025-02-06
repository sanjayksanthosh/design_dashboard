import 'package:flutter/material.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:provider/provider.dart';

class UserStatusButtons extends StatefulWidget {
  final dynamic user; // Ensure this user object has a `status` property and a `userId`
  const UserStatusButtons({Key? key, required this.user}) : super(key: key);

  @override
  _UserStatusButtonsState createState() => _UserStatusButtonsState();
}

class _UserStatusButtonsState extends State<UserStatusButtons> {
  bool _isBlockedHovered = false;
  bool _isFreezedHovered = false;

  // This method shows a dialog to enter remarks.
  void _showRemarksDialog(String newStatus) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter remarks for $newStatus"),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              hintText: "Enter remarks",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String reason = reasonController.text.trim();
                if (reason.isEmpty) {
                  // Optionally show an error or do nothing if remarks are empty.
                  return;
                }
                // Call the provider's updateStatus method with the new status and remarks.
                bool success = await Provider.of<UserProvider>(context, listen: false)
                    .updateStatus(widget.user.userId, newStatus, reason);
                if (success) {
                  Navigator.of(context).pop(); // Close the dialog on success
                } else {
                  // Optionally, display an error message here.
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the current status (make sure to use a consistent lowercase format).
    final status = widget.user.status.toString().toLowerCase();
    final blockButtonText = status == 'blocked' ? "UnBlock" : "Block";
    final freezeButtonText = status == 'frozen' ? "UnFreeze" : "Freeze";

    return SizedBox(
      // If user is blocked, we only show the block/unblock button.
      width: status == 'blocked' ? 100 : 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Block/UnBlock Button
          MouseRegion(
            onEnter: (_) {
              setState(() {
                _isBlockedHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                _isBlockedHovered = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                if (blockButtonText == "Block") {
                  // When blocking, show the dialog to get remarks.
                  _showRemarksDialog("Blocked");
                } else {
                  // When unblocking, call updateStatus directly (revert status to Active).
                  Provider.of<UserProvider>(context, listen: false)
                      .updateStatus(widget.user.userId, "Active", "");
                }
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  // If blocked, show a solid red background. Otherwise, use a hover effect.
                  color: status == 'blocked'
                      ? Colors.redAccent
                      : _isBlockedHovered
                          ? Colors.redAccent.withOpacity(0.2)
                          : Colors.transparent,
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    blockButtonText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Freeze/UnFreeze Button - only show if the user is NOT blocked.
          if (status != 'blocked')
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  _isFreezedHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _isFreezedHovered = false;
                });
              },
              child: GestureDetector(
                onTap: () {
                  if (freezeButtonText == "Freeze") {
                    // When freezing, show the dialog to get remarks.
                    _showRemarksDialog("Frozen");
                  } else {
                    // When unfreezing, call updateStatus directly (revert status to Active).
                    Provider.of<UserProvider>(context, listen: false)
                        .updateStatus(widget.user.userId, "Active", "");
                  }
                },
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    // If frozen, show a solid blue background. Otherwise, use a hover effect.
                    color: status == 'frozen'
                        ? Colors.blueAccent
                        : _isFreezedHovered
                            ? Colors.blueAccent.withOpacity(0.2)
                            : Colors.transparent,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      freezeButtonText,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
