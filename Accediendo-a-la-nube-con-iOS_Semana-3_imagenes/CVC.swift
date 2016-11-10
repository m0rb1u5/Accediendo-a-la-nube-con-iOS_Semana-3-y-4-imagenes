//
//  CVC.swift
//  Accediendo-a-la-nube-con-iOS_Semana-3_imagenes
//
//  Created by Juan Carlos Carbajal Ipenza on 10/11/16.
//  Copyright © 2016 Juan Carlos Carbajal Ipenza. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

struct Seccion {
    var nombre: String
    var imagenes: [UIImage]
    
    init(nombre: String, imagenes: [UIImage]) {
        self.nombre = nombre
        self.imagenes = imagenes
    }
}

class CVC: UICollectionViewController {
    var imagenes = [Seccion]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buscar(_ sender: UITextField) {
        let seccion = Seccion(nombre: sender.text!, imagenes: self.busquedaGoogle(termino: sender.text!))
        imagenes.append(seccion)
        self.collectionView!.reloadData()
    }
    func busquedaGoogle(termino: String) -> [UIImage] {
        var imgs = [UIImage]()
        let urls = "https://www.googleapis.com/customsearch/v1?key=AIzaSyBcSosES15xfmaDPpJiOi8-h_g0gn-NonI&cx=008164932087334712365:5vn_jst974o&searchType=image&q=" + termino
        let url: NSURL? = NSURL(string: urls)
        let datos: NSData? = NSData(contentsOf: url! as URL)
        do {
            let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            let dico1 = json as! NSDictionary
            let dico2 = dico1["items"] as! NSArray
            for elemento in dico2 {
                let dico3 = elemento as! NSDictionary
                let dico4 = dico3["image"] as! NSDictionary
                let img_urls = dico4["thumbnailLink"] as! NSString as String
                let img_url: NSURL? = NSURL(string: img_urls)
                let img_datos: NSData? = NSData(contentsOf: img_url! as URL)
                if let imagen = UIImage(data: img_datos! as Data) {
                    imgs.append(imagen)
                }
            }
        }
        catch _ {
        }
        return imgs
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return imagenes.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imagenes[section].imagenes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImgCelda
    
        cell.imagen.image = imagenes[indexPath.section].imagenes[indexPath.item]
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
