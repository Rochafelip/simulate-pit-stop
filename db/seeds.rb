Car.create([
  {model: "Porsche 911 GT3 R", power: 520, weight: 1220, fuel_capacity: 120},
  {model: "Ferrari 488 GT3 Evo 2020", power: 620, weight: 1220, fuel_capacity: 110},
  {model: "Audi R8 LMS GT3 Evo II", power: 585, weight: 1230, fuel_capacity: 115},
  {model: "Mercedes-AMG GT3", power: 570, weight: 1250, fuel_capacity: 120},
  {model: "McLaren 720S GT3", power: 620, weight: 1230, fuel_capacity: 115}
])

Track.create([
  {name: "Autodromo Nazionale Monza", distance: 5.793, number_of_curves: 11, country: "Italy", elevation_track: 0.2},
  {name: "Autódromo José Carlos Pace (Interlagos)", distance: 4.309, number_of_curves: 15, country: "Brazil", elevation_track: 0.5},
  {name: "Fuji Speedway", distance: 4.563, number_of_curves: 16, country: "Japan", elevation_track: 0.4},
  {name: "Circuit de la Sarthe", distance: 13.629, number_of_curves: 38, country: "France", elevation_track: 0.6},
  {name: "Bahrain International Circuit", distance: 5.412, number_of_curves: 15, country: "Bahrain", elevation_track: 0.3}
])