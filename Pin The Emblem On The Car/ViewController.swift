//
//  ViewController.swift
//  Pin The Emblem On The Car
//
//  Created by Jeffrey  on 5/15/20.
//  Copyright © 2020 BMCC. All rights reserved.
//

import UIKit

struct Cars{
    var noEmblem: String
    var image: String
    var emblem: String
}


class ViewController: UIViewController {
    
    
    @IBOutlet weak var carImage: UIImageView! //ImageView for Car on View
    
    @IBOutlet weak var correctLabel: UILabel! //Displays if Emblem is correct for Car
    
    @IBOutlet var carEmblems: [UIImageView]! //Outlet Collection for all car emblems
    
    
    //Array of structs representing each car
    let cars: [Cars] = [
        
        Cars(noEmblem: "bugatti2", image: "bugatti", emblem: "bugattiEmblem"),
        Cars(noEmblem: "porsche2", image: "porsche", emblem: "porscheEmblem"),
        Cars(noEmblem: "tesla2", image: "tesla", emblem: "teslaEmblem"),
        Cars(noEmblem: "aston2", image: "aston", emblem: "astonEmblem"),
        Cars(noEmblem: "mclaren2", image: "mclaren", emblem: "mclarenEmblem"),
        Cars(noEmblem: "lambo2", image: "lambo", emblem: "lamboEmblem"),
        Cars(noEmblem: "ferrari2", image: "ferrari", emblem: "ferrariEmblem")
    
    ]
    
    var emblemStartingPoints: [CGPoint] = [CGPoint]() //Array of the starting point of each emblem
    var carEmblem:String = "" //String id to keep track of which car is currently displayed
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carImage.image = UIImage(named: cars[0].noEmblem) //set image to first car
        carEmblem = cars[0].emblem //set string id to first car
        
        //After imageViews are loaded get starting point for each UIImageView
        let emblemPoints: [CGPoint] = [carEmblems[0].center,carEmblems[1].center,carEmblems[2].center,carEmblems[3].center,carEmblems[4].center,carEmblems[5].center,carEmblems[6].center]
        
        emblemStartingPoints = emblemPoints //insert starting points into emblemStartingPoints variable
    }
    
    
    
    @IBAction func changeImage(_ sender: UIStepper) {
        let i: Int = Int(sender.value)
        carImage.image = UIImage(named: cars[i].noEmblem)
        carEmblem = cars[i].emblem
        correctLabel.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point: CGPoint = touch.location(in: view)
            
            for emblem in carEmblems{
                let emblemLocation: CGRect = emblem.frame
                
                if emblemLocation.contains(point){
                    emblem.center = point
                    correctLabel.text = ""
                }
            }
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point: CGPoint = touch.location(in: view)
            
            //run loop through emblem uiimageview collection to move the currently touched uiimageview for emblem
            
            for (i,emblem) in zip(0 ... 6,carEmblems){
                let emblemLocation: CGRect = emblem.frame
                
                if emblemLocation.contains(point){
                    emblem.center = point
                }
                //check when emblem crosses car uiimageview frame
                if emblem.frame.intersects(carImage.frame){
                    
                    //check if the emblem that intersects image is equal to the current car being shown
                    if emblem.restorationIdentifier == carEmblem{
                        correctLabel.text = "Correct"
                        carImage.image = UIImage(named: cars[i].image)
                    }
                    else{
                        correctLabel.text = "Try Again"
                    }
                    
                }
                
                
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //return emblems to their starting position if user releases touch
        for (i,emblem) in zip(0 ... 6,carEmblems){
            let emblemStartingPoint: CGPoint = emblemStartingPoints[i]
            emblem.center = emblemStartingPoint
            
            
        }
        
    }
    
}

