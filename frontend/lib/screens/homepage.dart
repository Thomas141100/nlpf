import 'package:fht_linkedin/components/confirmation_dialog.dart';
import 'package:fht_linkedin/components/offer_card.dart';
import 'package:fht_linkedin/models/job_offer.dart';
import 'package:fht_linkedin/screens/joboffer_screen.dart';
import 'package:fht_linkedin/utils/constants.dart';
import 'package:fht_linkedin/components/search.dart';
import 'package:fht_linkedin/utils/filters.dart';
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
  int _columnRatio = 1;
  double _cardRatio = 200;
  var isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setCurrentUser();
    setJobOffers();
  }

  void setCurrentUser() async {
    User? user = await Client.getCurrentUser();
    user ??= {} as User;
    setState(() {
      _currentUser = user;
    });
  }

  void setJobOffers({Filter? filters}) async {
    var offers = await Client.getAllOffers(filters: filters);
    setState(() {
      _jobOffers = offers;
    });
  }

  bool userAlreadyCandidate(JobOffer jobOffer) {
    return _currentUser != null &&
        jobOffer.candidacies
            .map((e) => e.candidateId)
            .contains(_currentUser!.getId());
  }

  void deleteJobOffers(String jobOfferId) async {
    var response = await Client.deleteJobOffer(jobOfferId);
    if (response.statusCode == 500) {
      showSnackBar(context, "Une erreur est survenue lors de la supression",
          isError: true);
    } else {
      showSnackBar(context, "Cette offre a ??t?? supprim??e");
      setJobOffers();
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
    TextButton? firstButton = null;
    TextButton? secondButton = null;
    if (jobOffer.companyName == _currentUser!.companyName!) {
      firstButton = TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => JobOfferDialog(
                    isEdditing: true,
                    jobOffer: jobOffer,
                    updateJobOffersList: setJobOffers,
                    companyName: _currentUser!.companyName!,
                  ));
        },
        style: Theme.of(context).textButtonTheme.style,
        child: Text('Modifier', style: Theme.of(context).textTheme.bodyMedium),
      );
      secondButton = TextButton(
        style: Theme.of(context).textButtonTheme.style,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => ConfirmationDialog(
                    title: "S??rieusement ?",
                    message: "??tes vous s??r de vouloir supprimer cette offre ?",
                    confirmHandle: () => deleteJobOffers(
                      jobOffer.getId(),
                    ),
                  ));
        },
        child: Text('Supprimer', style: Theme.of(context).textTheme.bodyMedium),
      );
    }
    return OfferCard(
      title: jobOffer.title,
      description: jobOffer.description ?? "",
      companyName: jobOffer.companyName,
      onTapHandle: () {
        showDialog(
            context: context,
            builder: (context) => JobOfferDialog(
                  jobOffer: jobOffer,
                  companyName: _currentUser!.companyName!,
                ));
      },
      firstButton: firstButton,
      secondButton: secondButton,
      cardHeight: _cardRatio,
    );
  }

  OfferCard _buildUserOfferCard(JobOffer jobOffer) {
    void candidateHandle() async {
      try {
        var response = await Client.addCandidacy2JobOffer(jobOffer.getId());
        if (response.statusCode == 200) {
          showSnackBar(context, "Candidature envoy??e");
          setJobOffers();
        } else {
          throw ErrorDescription("Failed to candidate");
        }
      } catch (e) {
        showSnackBar(context, "Une erreur est survenue", isError: true);
      }
    }

    return OfferCard(
      title: jobOffer.title,
      description: jobOffer.description ?? "",
      companyName: jobOffer.companyName,
      onTapHandle: () {
        showDialog(
            context: context,
            builder: (context) => JobOfferDialog(
                jobOffer: jobOffer, companyName: _currentUser!.companyName!));
      },
      firstButton: TextButton(
        onPressed:
            userAlreadyCandidate(jobOffer) ? null : () => candidateHandle(),
        child: userAlreadyCandidate(jobOffer)
            ? const Text('Vous avez d??j?? postul??')
            : const Text('Postuler'),
      ),
      cardHeight: _cardRatio,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser != null && _jobOffers == null) {
      setJobOffers();
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
            'Bienvenue ${_currentUser != null ? ' - ${_currentUser!.firstname} ${_currentUser!.lastname}' : ''}',
        isCompany: _currentUser?.isCompany ?? false,
      ),
      body: LayoutBuilder(
        builder: (context, dimens) {
          Widget bodyWidget = _currentUser != null &&
                  _jobOffers != null &&
                  _jobOffers!.isNotEmpty
              ? GridView.count(
                  crossAxisCount: _columnRatio,
                  padding: const EdgeInsets.all(20),
                  children: _buildOfferGridTileList(10, 1))
              : Center(
                  child: Text(
                    _currentUser != null && _currentUser!.isCompany
                        ? "Vous n'avez pas encore post?? d'offre. N'attendez plus pour accueillir les ch??meurs du trottoir voisin!"
                        : "Il n'y pas d'offre disponible en ce moment. Ne traversez pas la rue maintenant !",
                  ),
                );
          return Row(
            children: [
              Flexible(
                flex: 1,
                child: Scrollbar(
                  child: SingleChildScrollView(
                      child: SizedBox(
                          height: (MediaQuery.of(context).size.height - 56),
                          child:
                              Search(searchOffersWithFilters: setJobOffers))),
                ),
              ),
              Flexible(flex: 4, child: bodyWidget)
            ],
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
