import '../consts/images.dart';
import '../model/user.dart';

List<User> users = [
  User(
      location: 'Innopolis, 7km',
      images: [imageMan, imageMan, imageMan],
      name: 'Sergey',
      age: 21,
      audio: "audio/sample3.aac",
      favourites: [imageDrink, imageFood, imageDog, imageMusic, imageGames]),
  User(
      location: 'Istanbul, 1078km',
      images: [imageGirl, imageGirl, imageGirl],
      name: 'Irina',
      age: 24,
      audio: "audio/sample1.aac",
      favourites: [imageFood, imageDog, imageMusic]),
  User(
      location: 'London, 4532km',
      images: [imageMan, imageMan, imageMan],
      name: 'Mark',
      age: 30,
      audio: "audio/sample3.aac",
      favourites: [imageDrink, imageMusic, imageGames])
];