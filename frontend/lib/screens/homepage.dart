import 'package:fht_linkedin/components/offer_card.dart';
import 'package:fht_linkedin/models/job_offer.dart';
import 'package:fht_linkedin/screens/jobofferscreen.dart';
import 'package:fht_linkedin/utils/utils.dart';
import '../module/client.dart';
import '../components/header.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _currentUser;
  List<JobOffer>? _jobOffers;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  void setCurrentUser() async {
    User? user = await Client.getCurrentUser();
    user ??= {} as User;
    setState(() {
      _currentUser = user;
    });
  }

  void setJobOffers() async {
    var offers = await Client.getAllOffers();
    setState(() {
      _jobOffers = offers;
    });
  }

  void deleteJobOffers(String jobOfferId) async {
    var response = await Client.deleteJobOffer(jobOfferId);
    if (response.statusCode == 500) {
      showSnackBar(context, "Une erreur est survenue lors de la supression",
          isError: true);
    } else {
      showSnackBar(context, "Cette offre a été supprimée");
      setJobOffers();
    }
  }

  List<OfferCard> _buildOfferGridTileList(int max, int pageNumber) {
    if (max * pageNumber > _jobOffers!.length) {
      max = _jobOffers!.length;
    }
    return List.generate(max, (index) {
      var jobOffer = _jobOffers![index];
      return OfferCard(
          title: jobOffer.title,
          description: jobOffer.description ?? "",
          companyName: jobOffer.companyName,
          onTapHandle: () {
            showDialog(
                context: context,
                builder: (context) => JobOfferDialog(
                      jobOffer: jobOffer,
                    ));
          },
          firstButton: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => JobOfferDialog(
                        isEdditing: true,
                        jobOffer: jobOffer,
                        updateJobOffersList: setJobOffers,
                      ));
            },
            child: const Text('Modifier'),
          ),
          secondButton: TextButton(
            child: const Text('Supprimer'),
            onPressed: () {
              deleteJobOffers(jobOffer.getId());
            },
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      setCurrentUser();
    } else if (_currentUser!.isCompany && _jobOffers == null) {
      setJobOffers();
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: Header(
          title:
              'Bonjour ${_currentUser != null ? ' - ${_currentUser!.firstname} ${_currentUser!.firstname}' : ''}'),
      body:
          _currentUser != null && _currentUser!.isCompany && _jobOffers != null
              ? GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  padding: const EdgeInsets.all(20),
                  children: _buildOfferGridTileList(10, 1))
              : const Center(
                  child: Text('toto'),
                ),
      floatingActionButton: _currentUser != null && _currentUser!.isCompany
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return JobOfferDialog(
                      isCreating: true,
                      updateJobOffersList: setJobOffers,
                    );
                  },
                );
              },
              tooltip: 'Post a JobOffer',
              child: const Icon(Icons.add),
            )
          : null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
