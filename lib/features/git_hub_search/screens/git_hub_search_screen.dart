import 'package:flutter/material.dart';
import 'package:pioneer_alpha_ltd_task/utils/dimensions.dart';

class GitHubSearchScreen extends StatelessWidget {
  const GitHubSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Explorer', style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Dimensions.paddingSizeDefault,
            children: [

              Text('Enter GitHub Username', style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),

              TextField(
                style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                decoration: InputDecoration(
                  hintText: 'Search by username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                  fixedSize: Size(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height * 0.07)
                ),
                onPressed: () {},
                child:  Text('Search',style: TextStyle(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
