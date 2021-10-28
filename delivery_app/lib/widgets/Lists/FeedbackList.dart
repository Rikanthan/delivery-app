import 'package:delivery_app/models/feedback.dart';
import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/providers/FeedbackProvider.dart';
import 'package:delivery_app/widgets/FeedbackContainer.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

ServicesClicked servicesClicked = ServicesClicked.delivery;
late FeedbacksProvider _feedbacksProvider;

class FeedbackList extends StatefulWidget {
  const FeedbackList({ Key? key }) : super(key: key);

  @override
  _FeedbackListState createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  late Future<List<Feedbacks>> feedbackList;
  @override
  void initState(){
    super.initState();
       SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);  
    _feedbacksProvider = Provider.of<FeedbacksProvider>(context,listen:false);
    feedbackList = _feedbacksProvider.fetchAllFeedbacks();
  }
  @override
  Widget build(BuildContext context) {
    _feedbacksProvider = Provider.of<FeedbacksProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_)=> AdminPage()
                      )
                    );
            },
          ),
        ),
      body: Container(
        child: FutureBuilder<List<Feedbacks>>(
          future: feedbackList,
          builder: (BuildContext context,snapshot)
          {
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
            {
              final feed = snapshot.data;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  List<Feedbacks> showFeedbacks = feed!;
                  Feedbacks feedbacks = showFeedbacks[index];
                  return Dismissible(
                    key: UniqueKey(),
                    child: FeedbackItem(
                      feedback: feedbacks,
                      index: index+1,
                      ),
                      onDismissed: (direction){
                          _feedbacksProvider
                          .deleteSpecificFeedbacks(feedbacks);
                         showFeedbacks.removeAt(index);
                      },
                  );
                }
                );
            }
            if(!snapshot.hasData)
            {
              return Center(
              child: CircularProgressIndicator()
              );
            }
            return Center(
              child: Text('No Feedbacks to show')
              );
          }
             
        ),
      ),
    );
  }
}

