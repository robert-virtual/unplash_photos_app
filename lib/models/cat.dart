class Cat {
  String name;
  List<String> items;
  Cat({required this.name, required this.items});
}

List<Cat> data = [
  Cat(name: "Aves", items: List.generate(20, (i) => "Ave # $i")),
  Cat(name: "Insectos", items: List.generate(20, (i) => "Insecto # $i")),
  Cat(name: "Mamiferos", items: List.generate(20, (i) => "Mamifero # $i")),
  Cat(name: "Peces", items: List.generate(20, (i) => "Pez # $i")),
  Cat(name: "Bacterias", items: List.generate(20, (i) => "Bacteria # $i")),
  Cat(name: "Plantas", items: List.generate(20, (i) => "Planta # $i"))
];
