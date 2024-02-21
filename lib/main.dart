import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rickandmortys/repositories/charasters_repository/charactars_repository.dart';
import 'package:rickandmortys/repositories/charasters_repository/models/character_model.dart';


void main() {
  runApp(const RickAndMortys());
}

class RickAndMortys extends StatelessWidget {
  const RickAndMortys({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RickAndMortysCharacters',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow,
        dividerColor: Color.fromARGB(255, 255, 0, 0),
        appBarTheme: const AppBarTheme(
          backgroundColor:Colors.yellow,
          titleTextStyle: TextStyle(
            color: Colors.black, 
            fontSize: 25, fontWeight: 
            FontWeight.w700,
            )
        ),        
        
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w400,
            fontSize: 12
          ),
        ),
      ),

      routes: {
        '/':(context) => MainPageScreen(title: 'Rick and Mortys Characters',),
        '/detail' :(context) => DetailInfoScreen(),
      },
    );
  }
}

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key, required this.title});

  final String title;

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}




class _MainPageScreenState extends State<MainPageScreen> {
  List<CharactersModel>? _charactersList;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('Rick And Mortys Characters', style: TextStyle(color: Colors.black),),
      ),
      body: (_charactersList == null) 
      ? const SizedBox() 
      : ListView.separated(
        itemCount: _charactersList!.length,
        separatorBuilder: (context, index) => const Divider( color: Colors.black,),
        itemBuilder: (context,i) { 
          final charName = _charactersList![i] ;
        
          return ListTile(
          leading: SvgPicture.asset('assets/1707748504man22b.svg', height: 40,width: 40,),
          trailing: SvgPicture.asset('assets/1704703189BigCat15b.svg',height: 40,width: 40,),
       //   onTap: () {
       //     Navigator.of(context).pushNamed('/detail', 
       //     arguments: characterName, 
        //    );
       //   },
          title: Text(charName.name, style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Text('ALIVE',
          style: Theme.of(context).textTheme.bodySmall, 
          ),
        ); 
        },
      ),
floatingActionButton: FloatingActionButton(
  child: const Icon(Icons.download),
  onPressed: () async {

     _charactersList = await CharactersRepository().getCharacterList(true);
     setState(() {
       
         });
        },
      ),
   );
  }
}



class DetailInfoScreen extends StatefulWidget {
  const DetailInfoScreen({super.key});

  @override
  State<DetailInfoScreen> createState() => _DetailInfoScreenState();
}

class _DetailInfoScreenState extends State<DetailInfoScreen> {
String? characterName;
@override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if(args == null) {
      log('You must provide args' as num);
      return;
    }

    if(args is! String) {
      log('You must provide String args' as num);
      return;
    }
    characterName = args;
    setState(() {
      
    });
    super.didChangeDependencies();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(characterName ?? '...')),
    );
  }
}
