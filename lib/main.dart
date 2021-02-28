import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;
  final String images;
  final int prices;
  Todo(this.title, this.description, this.images, this.prices);
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodosScreen(todos: [
      Todo(
          'Starwar Episode I',
          'The Phantom Menance',
          'https://upload.wikimedia.org/wikipedia/en/4/40/Star_Wars_Phantom_Menace_poster.jpg',
          150),
      Todo(
          'Starwar Episode II',
          'Attack of the Clones',
          'https://upload.wikimedia.org/wikipedia/en/3/32/Star_Wars_-_Episode_II_Attack_of_the_Clones_%28movie_poster%29.jpg',
          130),
      Todo(
          'Starwar Episode III',
          'Revenge of the Sith',
          'https://upload.wikimedia.org/wikipedia/en/thumb/9/93/Star_Wars_Episode_III_Revenge_of_the_Sith_poster.jpg/220px-Star_Wars_Episode_III_Revenge_of_the_Sith_poster.jpg',
          145),
      Todo(
          'Starwar Episode VII',
          'The Force Awakens',
          'https://upload.wikimedia.org/wikipedia/en/a/a2/Star_Wars_The_Force_Awakens_Theatrical_Poster.jpg',
          170),
      Todo(
          'Starwar Episode VIII',
          'The Last Jedi',
          'https://upload.wikimedia.org/wikipedia/en/7/7f/Star_Wars_The_Last_Jedi.jpg',
          180),
      Todo(
          'Starwar Episode IV',
          'A New Hope',
          'https://images-na.ssl-images-amazon.com/images/I/81aA7hEEykL.jpg',
          145),
      Todo(
          'Starwar Episode V',
          'The Empire Strikes Back',
          'https://upload.wikimedia.org/wikipedia/en/3/3c/SW_-_Empire_Strikes_Back.jpg',
          190),
      Todo(
          'Starwar Episode VI',
          'Return of the Jedi',
          'https://upload.wikimedia.org/wikipedia/en/b/b2/ReturnOfTheJediPoster1983.jpg',
          135),
      Todo(
          'Starwar Episode IX',
          'The Rise of Skywalker',
          'https://upload.wikimedia.org/wikipedia/en/a/af/Star_Wars_The_Rise_of_Skywalker_poster.jpg',
          185),
      Todo('Rogue One', 'A Star Wars Story',
          'http://f.ptcdn.info/688/047/000/oho9v1rxi63ssf8YWXG-o.jpg', 145),
      Todo(
          'Solo',
          'A Star Wars Story',
          'https://upload.wikimedia.org/wikipedia/en/5/54/Solo_A_Star_Wars_Story_poster.jpg',
          150),
    ]),
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;
  int AccumulatedPrice = 0;
  TodosScreen({Key key, @required this.todos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starwars movies shop'),
      ),
      body: ListView.builder(
        itemCount: todos.length + 1,
        itemBuilder: (context, index) {
          if (index > -1 && index < todos.length) {
            return ListTile(
              title: Text(todos[index].title),
              onTap: () {
                _navigateAndDisplaySelection(context, index);
              },
            );
          } else {
            return ListTile(
              title: Text('Quotation Screen'),
              onTap: () {
                _navigateAndDisplayNextSelection(context);
              },
            );
          }
        },
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context, index) async {
    AccumulatedPrice = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DetailScreen(todo: todos[index], totalprice: AccumulatedPrice)),
    );
    Scaffold.of(context).showSnackBar(new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Text("Total Price: $AccumulatedPrice \$")));
  }

  _navigateAndDisplayNextSelection(BuildContext context) async {
    AccumulatedPrice = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => quotationScreen(totalprice: AccumulatedPrice)),
    );
    if (AccumulatedPrice == null) {
      AccumulatedPrice = 0;
    }
    Scaffold.of(context).showSnackBar(new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Text("Thank you for puchase!")));
  }
}

class DetailScreen extends StatelessWidget {
// Declare a field that holds the Todo.
  final Todo todo;
  int totalprice = 0;
// In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo, this.totalprice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
// Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: new Image.network(todo.images),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: Text(todo.description),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: Text("\$ " + todo.prices.toString()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: Text("Buy " + todo.title + "?"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      totalprice += todo.prices;
                      Navigator.pop(context, totalprice);
                      print(totalprice);
                    },
                    child: Text('Yes'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, totalprice);
                    },
                    child: Text('No'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class quotationScreen extends StatelessWidget {
  int totalprice = 0;
  quotationScreen({Key key, @required this.totalprice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotation Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total Price: '),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("\$" + totalprice.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    totalprice = 0;
                    Navigator.pop(context, totalprice);
                    print(totalprice);
                  },
                  child: Text('Pay for your Movies'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, totalprice);
                  },
                  child: Text('Not yet, I need to buy more stuff!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
