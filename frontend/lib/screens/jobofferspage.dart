import 'package:fht_linkedin/components/confirmation_dialog.dart';
import 'package:fht_linkedin/components/offer_card.dart';
import 'package:fht_linkedin/models/candidacy.dart';
import 'package:fht_linkedin/models/job_offer.dart';
import 'package:fht_linkedin/screens/joboffer_screen.dart';
import 'package:fht_linkedin/utils/constants.dart';
import 'package:fht_linkedin/utils/filters.dart';
import 'package:fht_linkedin/utils/utils.dart';
import '../module/client.dart';
import '../components/header.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class JobOffersPage extends StatefulWidget {
  const JobOffersPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<JobOffersPage> createState() => _JobOffersPageState();
}

class _JobOffersPageState extends State<JobOffersPage> {
  User? _currentUser;
  List<JobOffer>? _jobOffers;
  int _columnRatio = 1;
  double _cardRatio = 200;
  var isLoading = false;
  List<JobOfferCandidacy>? _children;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setCurrentUser().then((value) {
      if (_currentUser!.isCompany) {
        setCompanyJobOffers();
      } else {
        setCandidacies().then((value) => setJobOffersList());
      }
    });
    return;
  }

  Future<void> setCandidacies() async {
    var candidacies =
        await Client.getCurrentUserAllCandidacies(_currentUser!.getId());
    setState(() {
      _children = candidacies;
    });
  }

  Future<void> setJobOffersList() async {
    List<JobOffer> jobOff = List.empty(growable: true);
    if (_children == null) return;
    for (JobOfferCandidacy candidacy in _children!) {
      if (candidacy.offer.getId() == "") continue;
      jobOff.add(await Client.getJobOfferById(candidacy.offer.getId()));
    }
    setState(() {
      _jobOffers = jobOff;
    });
  }

  Future<void> setCurrentUser() async {
    User? user = await Client.getCurrentUser();
    user ??= {} as User;
    setState(() {
      _currentUser = user;
    });
  }

  void setCompanyJobOffers() async {
    Filter filter = Filter();
    filter.addCompanyName(_currentUser!.companyName);
    var offers = await Client.getAllOffers(filters: filter);
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
      setCompanyJobOffers();
    }
  }

  void updateGridColumRatio(double dimens) {
    int columnRatio;
    double cardRatio;
    if (dimens <= kMobileBreakpoint) {
      columnRatio = 1;
      cardRatio = MediaQuery.of(context).size.height / 2.5;
    } else if (dimens > kMobileBreakpoint && dimens <= kTabletBreakpoint) {
      columnRatio = 2;
      cardRatio = MediaQuery.of(context).size.height / 4;
    } else if (dimens > kTabletBreakpoint && dimens <= kDesktopBreakpoint) {
      columnRatio = 3;
      cardRatio = MediaQuery.of(context).size.height / 5;
    } else {
      columnRatio = 4;
      cardRatio = MediaQuery.of(context).size.height / 5.7;
    }
    if (columnRatio != _columnRatio) {
      setState(() {
        _columnRatio = columnRatio;
        _cardRatio = cardRatio;
      });
    }
  }

  List<OfferCard> _buildOfferGridTileList(int max, int pageNumber) {
    if (max * pageNumber > _jobOffers!.length) {
      max = _jobOffers!.length;
    }
    if (_currentUser!.isCompany) {
      return List.generate(
          max, (index) => _buildCompanyOfferCard(_jobOffers![index]));
    }
    return List.generate(
        max, (index) => _buildUserOfferCard(_jobOffers![index]));
  }

  OfferCard _buildCompanyOfferCard(JobOffer jobOffer) {
    return OfferCard(
      title: jobOffer.title,
      description: jobOffer.description ?? "",
      companyName: jobOffer.companyName,
      onTapHandle: () {
        showDialog(
            context: context,
            builder: (context) => JobOfferDialog(
                  companyName: _currentUser!.companyName!,
                  jobOffer: jobOffer,
                ));
      },
      firstButton: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => JobOfferDialog(
                    companyName: _currentUser!.companyName!,
                    isEdditing: true,
                    jobOffer: jobOffer,
                    updateJobOffersList: setCompanyJobOffers,
                  ));
        },
        child: const Text('Modifier'),
      ),
      secondButton: TextButton(
        child: const Text('Supprimer'),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => ConfirmationDialog(
                    title: "Confirmation Dialog",
                    message: "Êtes vous sûr de vouloir supprimer cette offre ?",
                    confirmHandle: () => deleteJobOffers(
                      jobOffer.getId(),
                    ),
                  ));
        },
      ),
      cardHeight: _cardRatio,
    );
  }

  OfferCard _buildUserOfferCard(JobOffer jobOffer) {
    return OfferCard(
      title: jobOffer.title,
      description: jobOffer.description ?? "",
      companyName: jobOffer.companyName,
      onTapHandle: () {
        showDialog(
            context: context,
            builder: (context) => JobOfferDialog(
                  companyName: _currentUser!.companyName!,
                  jobOffer: jobOffer,
                ));
      },
      cardHeight: _cardRatio,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser != null && _jobOffers == null) {
      if (_currentUser!.isCompany) {
        setCompanyJobOffers();
      } else {
        setJobOffersList();
      }
    }
    updateGridColumRatio(MediaQuery.of(context).size.width);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: Header(
        title:
            'Bonjour ${_currentUser != null ? ' - ${_currentUser!.firstname} ${_currentUser!.lastname}' : ''}',
        isCompany: _currentUser?.isCompany ?? false,
      ),
      body: LayoutBuilder(
        builder: (context, dimens) {
          return _currentUser != null &&
                  _jobOffers != null &&
                  _jobOffers!.isNotEmpty
              ? GridView.count(
                  crossAxisCount: _columnRatio,
                  padding: const EdgeInsets.all(20),
                  children: _buildOfferGridTileList(10, 1))
              : Center(
                  child: Text(_currentUser != null && _currentUser!.isCompany
                      ? "Vous n'avez pas encore posté d'offre. N'attendez plus pour accueillir les chômeurs du trottoir voisin!"
                      : "Vous n'avez pas encore postulé à une offre. N'attendez plus pour traverser la rue !"),
                );
        },
      ),
      floatingActionButton: _currentUser != null && _currentUser!.isCompany
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return JobOfferDialog(
                      companyName: _currentUser!.companyName!,
                      isCreating: true,
                      updateJobOffersList: setCompanyJobOffers,
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
