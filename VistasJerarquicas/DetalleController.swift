//
//  DetalleController.swift
//  VistasJerarquicas
//
//  Created by Oscar Javier Olivos on 13/12/16.
//  Copyright © 2016 Oscar Javier Olivos. All rights reserved.
//

import UIKit

class DetalleController: UIViewController {

    var isbn : String=""
    let url = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    var urlFull : URL?
    @IBOutlet var imgPortada: UIImageView!
    @IBOutlet var txtTitulo: UILabel!
    @IBOutlet var txtAutor: UILabel!
    
    @IBOutlet var txtPortadaNoDisponible: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        urlFull = URL(string: url + isbn)
        do{
            let datos = try Data(contentsOf: urlFull!)
            let jsonResponde = try JSONSerialization.jsonObject(with: datos, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let result = jsonResponde as! [String: AnyObject]
            if((result.count) > 0){
                guard let titulo = result["ISBN:"+isbn]?["title"] as? String,
                let portada = result["ISBN:"+isbn]?["cover"] as? AnyObject,
                let autores = result["ISBN:"+isbn]?["authors"] as? [[String: AnyObject]]
                else {return}
                
                var authors : String = ""
                for autor in autores {
                    authors =  authors + ", " + (autor["name"]! as! String)
                    //print(autor["name"] as? String)
                    
                }
                
                authors.remove(at: authors.startIndex)
                if portada.count != nil {
                    let urlportada = portada["large"] as? String
                    let urlImage = URL(string: urlportada!)
                    txtPortadaNoDisponible.isHidden = true
                    
                    imgPortada.image = try UIImage(data: Data(contentsOf: urlImage!))

                }
                txtTitulo.text = titulo
                txtAutor.text = authors
                
            }else{
                print("No Found!!")
            }

        }catch  {
            print("Error")
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
