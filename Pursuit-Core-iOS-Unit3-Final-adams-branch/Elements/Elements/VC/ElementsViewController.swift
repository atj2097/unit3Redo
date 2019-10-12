//
//  ElementsViewController.swift
//  Elements
//
//  Created by God on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    var elements = [Element]() {
        didSet {
            elementTable.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            loadElements()
           elementTable.reloadData()
            
        }
    }
    
    
    @IBOutlet weak var elementTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementTable.delegate = self
        elementTable.dataSource = self
        loadElements()
        // Do any additional setup after loading the view.
    }
    

    
    private func loadElements() {
            ElementAPIManager.shared.getElements{ (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let elementsFromOnline):
                        self.elements = elementsFromOnline
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        
    }

}
extension ElementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = elementTable.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as! CellsTableViewCell
        let element = elements[indexPath.row]
        cell.nameLabel.text = element.name
        cell.numberLabel.text = "\(element.number ?? 0)"
        var mass = element.atomicMass ?? 0.0
        cell.atomicWeightLabel.text = mass.description
        
        var elementString = String()
        
        if element.number! < 10 || element.number! < 100  {
            elementString = String(format: "%03d", element.number!)
        }

        ImageHelper.shared.getImage(urlStr: "http://www.theodoregray.com/periodictable/Tiles/\(elementString)/s7.JPG") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.elementImage.image = imageFromOnline
                }
            }
        }
        return cell
   
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let elementSelected = elements[indexPath.row]
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let elementDetailVC = storyBoard.instantiateViewController(withIdentifier: "showElement") as! ElementDVC
        elementDetailVC.element = elementSelected
        self.navigationController?.pushViewController(elementDetailVC, animated: true)
    }
    
    
}
