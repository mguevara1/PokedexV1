//
//  ViewController.swift
//  Pokedex
//
//  Created by Marco Guevara on 13/08/22.
//

import UIKit

class ListaPokemonViewController: UIViewController {

    @IBOutlet var tablaPokemon: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    var pokemonManager = PokemonManager()
    
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        pokemonManager.delegado = self
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        pokemonManager.verPokemon()
    }


}

extension ListaPokemonViewController: pokemonManagerDelegado{
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        DispatchQueue.main.async {
            self.tablaPokemon.reloadData()
        }
    }
}

extension ListaPokemonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        celda.nombrePokemon.text = pokemons[indexPath.row].name
        celda.ataquePokemon.text = "Ataque: \(pokemons[indexPath.row].attack)"
        celda.defensaPokemon.text = "Defensa: \(pokemons[indexPath.row].defense)"
        
        if let urlString = pokemons[indexPath.row].imageUrl as? String {
            if let imagenUrl = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenUrl) else{
                        return
                    }
                        let image = UIImage(data:imagenData)
                        DispatchQueue.main.async {
                            celda.imagenPokemon.image = image
                    }
                }
            }
        }
        celda.imagenPokemon.image = UIImage(named: "bulbasaur")
        
        return celda
    }
}
