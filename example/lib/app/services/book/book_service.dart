import 'dart:math';

import 'package:example/app/enums/genre.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'dart:async';

import 'package:example/app/services/book/models/books_pagination_model.dart';

class BookService {
  const BookService();

  Future<BookModel> loadRandomBook() async {
    final random = Random();
    await Future.delayed(const Duration(seconds: 2));
    return _books[random.nextInt(_books.length)];
  }

  Stream<BookModel> watchRandomBook() async* {
    final random = Random();
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      yield _books[random.nextInt(_books.length)];
    }
  }

  Future<BooksPaginationModel> loadBooks(int page) async {
    const pageSize = 10;
    await Future.delayed(const Duration(seconds: 2));
    final booksPage = _books.skip(page * pageSize).take(pageSize).toList();

    return BooksPaginationModel(
      items: booksPage,
      totalCount: _books.length,
    );
  }

  Future<BooksPaginationModel> loadBooksByQuery(int page, String query) async {
    const pageSize = 10;
    await Future.delayed(const Duration(seconds: 2));
    final filteredBooks =
        _books.where((book) => book.title.contains(query)).toList();
    final booksPage =
        filteredBooks.skip(page * pageSize).take(pageSize).toList();

    return BooksPaginationModel(
      items: booksPage,
      totalCount: filteredBooks.length,
    );
  }
}

final _books = <BookModel>[
  BookModel(
    title: 'The Great Gatsby',
    description:
        'The story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.',
    author: 'F. Scott Fitzgerald',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'To Kill a Mockingbird',
    description:
        'A novel about the serious issues of rape and racial inequality.',
    author: 'Harper Lee',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: '1984',
    description:
        'A dystopian social science fiction novel and cautionary tale.',
    author: 'George Orwell',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Pride and Prejudice',
    description:
        'A romantic novel that charts the emotional development of the protagonist Elizabeth Bennet.',
    author: 'Jane Austen',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Moby-Dick',
    description:
        'The narrative of the sailor Ishmael\'s adventures in pursuit of Moby Dick, a giant white sperm whale.',
    author: 'Herman Melville',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'War and Peace',
    description:
        'A novel that intertwines the lives of families and their connections to the Napoleonic Wars.',
    author: 'Leo Tolstoy',
    genre: Genre.fiction,
    available: false,
  ),
  BookModel(
    title: 'The Catcher in the Rye',
    description:
        'A story about adolescent Holden Caulfield\'s disillusionment with the adult world.',
    author: 'J.D. Salinger',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Hobbit',
    description:
        'Bilbo Baggins embarks on a grand adventure with dwarves to reclaim their homeland from the dragon Smaug.',
    author: 'J.R.R. Tolkien',
    genre: Genre.fantasy,
    available: true,
  ),
  BookModel(
    title: 'The Chronicles of Narnia',
    description:
        'A series of fantasy novels revolving around the adventures in the magical land of Narnia.',
    author: 'C.S. Lewis',
    genre: Genre.fantasy,
    available: false,
  ),
  BookModel(
    title: 'Jane Eyre',
    description:
        'The experiences of the orphan Jane Eyre, including her growth to adulthood and her love for Mr. Rochester.',
    author: 'Charlotte Brontë',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Brave New World',
    description:
        'A dystopian novel set in a futuristic world state where society is kept in check by technology and control.',
    author: 'Aldous Huxley',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Wuthering Heights',
    description:
        'The turbulent and passionate relationship between Catherine Earnshaw and Heathcliff.',
    author: 'Emily Brontë',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Lord of the Rings',
    description:
        'An epic fantasy adventure in the land of Middle-earth, focusing on the quest to destroy the One Ring.',
    author: 'J.R.R. Tolkien',
    genre: Genre.fantasy,
    available: true,
  ),
  BookModel(
    title: 'Anna Karenina',
    description:
        'A complex novel that details the tragic romance between Anna Karenina and Count Vronsky.',
    author: 'Leo Tolstoy',
    genre: Genre.fiction,
    available: false,
  ),
  BookModel(
    title: 'Crime and Punishment',
    description:
        'The psychological and moral dilemmas faced by the impoverished student Raskolnikov who commits a murder.',
    author: 'Fyodor Dostoevsky',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Odyssey',
    description:
        'The epic journey of Odysseus as he returns home after the Trojan War.',
    author: 'Homer',
    genre: Genre.biography,
    available: true,
  ),
  BookModel(
    title: 'The Divine Comedy',
    description:
        'Dante\'s epic poem describing his journey through Hell, Purgatory, and Paradise.',
    author: 'Dante Alighieri',
    genre: Genre.poetry,
    available: true,
  ),
  BookModel(
    title: 'The Iliad',
    description:
        'An epic poem detailing the events of the Trojan War and the Greek siege of the city of Troy.',
    author: 'Homer',
    genre: Genre.nonFiction,
    available: true,
  ),
  BookModel(
    title: 'Frankenstein',
    description:
        'The story of Victor Frankenstein, who creates a sapient creature in an unorthodox scientific experiment.',
    author: 'Mary Shelley',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Dracula',
    description:
        'The story of Count Dracula\'s attempt to move from Transylvania to England to spread the undead curse.',
    author: 'Bram Stoker',
    genre: Genre.fiction,
    available: false,
  ),
  BookModel(
    title: 'The Picture of Dorian Gray',
    description:
        'A philosophical novel about a man whose portrait ages instead of him.',
    author: 'Oscar Wilde',
    genre: Genre.fiction,
    available: false,
  ),
  BookModel(
    title: 'Les Misérables',
    description:
        'The struggles of ex-convict Jean Valjean and his experience of redemption.',
    author: 'Victor Hugo',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Great Expectations',
    description: 'The growth and personal development of an orphan named Pip.',
    author: 'Charles Dickens',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Brothers Karamazov',
    description:
        'A complex novel that explores deep philosophical and spiritual themes through the story of a family.',
    author: 'Fyodor Dostoevsky',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Sense and Sensibility',
    description:
        'The story of the Dashwood sisters as they navigate love and heartbreak.',
    author: 'Jane Austen',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'Don Quixote',
    description:
        'The adventures of a nobleman who reads so many chivalric romances that he loses his sanity and decides to become a knight-errant.',
    author: 'Miguel de Cervantes',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'A Tale of Two Cities',
    description:
        'A historical novel set during the time of the French Revolution.',
    author: 'Charles Dickens',
    genre: Genre.fiction,
    available: false,
  ),
  BookModel(
    title: 'Madame Bovary',
    description:
        'The story of a doctor\'s wife, Emma Bovary, who has adulterous affairs and lives beyond her means.',
    author: 'Gustave Flaubert',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Scarlet Letter',
    description:
        'A story of an affair between a young woman and a minister in Puritan New England.',
    author: 'Nathaniel Hawthorne',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Metamorphosis',
    description:
        'The story of a man who wakes up to find himself transformed into a giant insect.',
    author: 'Franz Kafka',
    genre: Genre.fiction,
    available: false,
  ),
  BookModel(
    title: 'The Stranger',
    author: 'Albert Camus',
    description: 'The story',
    genre: Genre.fiction,
    available: false,
  ),
  BookModel(
    title: 'The Trial',
    author: 'Franz Kafka',
    description: 'The story',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Plague',
    author: 'Albert Camus',
    description:
        'A novel that tells the story of a plague sweeping the French Algerian city of Oran.',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Master and Margarita',
    author: 'Mikhail Bulgakov',
    description:
        'A novel that blends the supernatural and the mundane in a satirical critique of Soviet society.',
    genre: Genre.fiction,
    available: true,
  ),
  BookModel(
    title: 'The Unbearable Lightness of Being',
    author: 'Milan Kundera',
    description:
        'A novel that explores the lives of four characters in the aftermath of the Prague Spring.',
    genre: Genre.fiction,
    available: true,
  ),
];
