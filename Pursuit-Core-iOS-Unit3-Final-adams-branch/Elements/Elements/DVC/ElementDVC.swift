//
//  ElementDVC.swift
//  Elements
//
//  Created by God on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDVC: UIViewController {
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var symbolText: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    var user: User!
    var element: Element!

    @IBAction func favoriteButton(_ sender: UIButton) {
        var favorite = FavoriteElement(elementName: element.name!, elementSymbol: element.symbol!, favoritedby: "Adam")
        ElementAPIManager.shared.postElement(element: favorite, completionHandler: {result in
           
                switch result {
                case .success:
                    print("we posted our favorite!")
                case .failure(let error) :
                    print(error)
                }
            }
        )
    }
    @IBOutlet weak var discoveredBy: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var atomicMass: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElement()
        elementDetails()
        // Do any additional setup after loading the view.
    }
    func loadElement() {
        ElementAPIManager.shared.getElements { result in
    DispatchQueue.main.async {
    switch result {
    case .success:
    print("we posted our element!")
    case .failure(let error) :
    print(error)
    }
}
        }
    }

    private func elementDetails() {
        symbolText.text = element.symbol
        elementNumber.text = "\(element.number)"
        discoveredBy.text = "\(element.discoveredBy)"
        meltingPoint.text = "\(element.melt)"
        atomicMass.text = "\(element.atomicMass)"
        boilingPoint.text = "\(element.boil)"
        
        ImageHelper.shared.getImage(urlStr: "http://images-of-elements.com/\(element.name?.lowercased() ?? "").jpg") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.elementImage.image = imageFromOnline
                }
            }
        }
        
        
    }


}
