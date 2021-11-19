//
//  ViewController.swift
//  SquareUp
//
//  Created by Betina Kreiman on 9/9/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var redBlock1: UIImageView!
    @IBOutlet weak var orangeBlock1: UIImageView!
    @IBOutlet weak var greenBlock1: UIImageView!
    @IBOutlet weak var blueBlock1: UIImageView!
    @IBOutlet weak var indigoBlock1: UIImageView!
    @IBOutlet weak var purpleBlock1: UIImageView!
    
    @IBOutlet weak var bigTable: UIImageView!
    
    
    
    func distance(locationOne: CGPoint, locationTwo: CGPoint) -> CGFloat {
        var differenceInX = locationOne.x - locationTwo.x
        var differenceInY = locationOne.y - locationTwo.y
        var squareRoot = sqrt(differenceInX * differenceInX + differenceInY * differenceInY)
        return squareRoot
    }
    func touchingSquares(squareOne: UIImageView, squareTwo: UIImageView) -> Bool {
        var widthSquare = squareOne.frame.width
        var distanceAway = distance(locationOne: squareOne.center, locationTwo: squareTwo.center)
        if distanceAway <= widthSquare+2 && distanceAway >= widthSquare-2 {
            return true
        }
        return false
    }
    func upDownLeftRight(squareOne: UIImageView, squareTwo: UIImageView) -> Int {
        // 0 = down
        // 1 == up
        // 2 == left
        // 3 == right
        var distanceX = squareOne.center.x - squareTwo.center.x
        var distanceY = squareOne.center.y - squareTwo.center.y
        if abs(distanceX) > abs(distanceY) {
            // same y value
            if distanceX < 0 {
                // square one left of square two
                return 2
            }
            return 3
        } else {
            if distanceY < 0 {
                // square one below square two
                return 0
            }
            return 1
        }
    }
    func moveTwoTouchingBlocks(squareOne: UIImageView, squareTwo: UIImageView, place: CGPoint) {
        var whereBlock2 = upDownLeftRight(squareOne: squareOne, squareTwo: squareTwo)
        var widthSquare = squareTwo.frame.width
        
        if whereBlock2 == 0 {
            // orange block is below red block
            squareTwo.center = CGPoint(x: place.x, y: place.y + widthSquare)
        } else if whereBlock2 == 1 {
            // orange block is above red block
            squareTwo.center = CGPoint(x: place.x, y: place.y - widthSquare)
        } else if whereBlock2 == 2 {
            // orange is left of red block
            squareTwo.center = CGPoint(x: place.x + widthSquare, y: place.y)
        } else {
            // orange is right of red
            squareTwo.center = CGPoint(x: place.x - widthSquare, y: place.y)
        }
    }
    func tooClose(squareOne: UIImageView, squareTwo: UIImageView) -> Bool {
        var widthSquare = squareOne.frame.width
        var distanceAwayCenter = distance(locationOne: squareOne.center, locationTwo: squareTwo.center)
        if distanceAwayCenter < widthSquare - 2 {
            return true
        }
        return false
    }
    func inAnotherSquare(square: UIImageView, place: CGPoint) -> Bool {
        var allBlocks = [redBlock1, orangeBlock1, greenBlock1, blueBlock1, indigoBlock1, purpleBlock1]
        
        for i in allBlocks {
            if i != square {
                if tooClose(squareOne: square, squareTwo: i!) {
                    return true
                }
            }
        }
        return false
    }
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.randomElement()! as UITouch
        for touch in (touches as! Set<UITouch>) {
            let location = touch.location(in: self.view)
            
            if orangeBlock1.frame.contains(location) {
                orangeBlock1.center = location
            } else if redBlock1.frame.contains(location) {
                redBlock1.center = location
            } else if greenBlock1.frame.contains(location) {
                greenBlock1.center = location
            } else if blueBlock1.frame.contains(location) {
                blueBlock1.center = location
            } else if indigoBlock1.frame.contains(location) {
                indigoBlock1.center = location
            } else if purpleBlock1.frame.contains(location) {
                purpleBlock1.center = location
            }
        }
    } 
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.randomElement()! as UITouch
        var widthSquare = redBlock1.frame.width
        var listBlocks = [redBlock1, orangeBlock1, greenBlock1, blueBlock1, indigoBlock1, purpleBlock1]
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.location(in: self.view)
            
            if orangeBlock1.frame.contains(location) {
                for i in 0...listBlocks.count-1 {
                    if listBlocks[i] != orangeBlock1 {
                        
                        
                        if tooClose(squareOne: orangeBlock1, squareTwo: listBlocks[i]!) == false {
                            orangeBlock1.center = location
                            for j in 0...listBlocks.count-1 {
                                if listBlocks[j] != orangeBlock1 {
                                    if touchingSquares(squareOne: orangeBlock1, squareTwo: listBlocks[j]!) == true {
                                        moveTwoTouchingBlocks(squareOne: orangeBlock1, squareTwo: listBlocks[j]!, place: location)
                                    }
                                }
                            }
                        }
                    }
                }
                
            } else if redBlock1.frame.contains(location) {
                redBlock1.center = location
                for i in 0...listBlocks.count-1 {
                    if listBlocks[i] != redBlock1 {
                        if touchingSquares(squareOne: redBlock1, squareTwo: listBlocks[i]!) == true {
                            moveTwoTouchingBlocks(squareOne: redBlock1, squareTwo: listBlocks[i]!, place: location)
                        }
                    }
                }
            } else if greenBlock1.frame.contains(location) {
                greenBlock1.center = location
                for i in 0...listBlocks.count-1 {
                    if listBlocks[i] != greenBlock1 {
                        if touchingSquares(squareOne: greenBlock1, squareTwo: listBlocks[i]!) == true {
                            moveTwoTouchingBlocks(squareOne: greenBlock1, squareTwo: listBlocks[i]!, place: location)
                        }
                    }
                }
            } else if blueBlock1.frame.contains(location) {
                blueBlock1.center = location
                for i in 0...listBlocks.count-1 {
                    if listBlocks[i] != blueBlock1 {
                        if touchingSquares(squareOne: blueBlock1, squareTwo: listBlocks[i]!) == true {
                            moveTwoTouchingBlocks(squareOne: blueBlock1, squareTwo: listBlocks[i]!, place: location)
                        }
                    }
                }
            } else if indigoBlock1.frame.contains(location) {
                indigoBlock1.center = location
                for i in 0...listBlocks.count-1 {
                    if listBlocks[i] != indigoBlock1 {
                        if touchingSquares(squareOne: indigoBlock1, squareTwo: listBlocks[i]!) == true {
                            moveTwoTouchingBlocks(squareOne: indigoBlock1, squareTwo: listBlocks[i]!, place: location)
                        }
                    }
                }
            } else if purpleBlock1.frame.contains(location) {
                purpleBlock1.center = location
                for i in 0...listBlocks.count-1 {
                    if listBlocks[i] != purpleBlock1 {
                        if touchingSquares(squareOne: purpleBlock1, squareTwo: listBlocks[i]!) == true {
                            moveTwoTouchingBlocks(squareOne: purpleBlock1, squareTwo: listBlocks[i]!, place: location)
                        }
                    }
                }
            }
        }
    }
    



    
    
    
    @IBOutlet weak var EndGamePraise: UILabel!
    @IBOutlet weak var playagainOutlet: UIButton!
    
    @IBAction func PlayAgainButtonFunction(_ sender: Any) {
        EndGamePraise.isHidden = true
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //playagain.isHidden = false
        // Do any additional setup after loading the view.
        var allBlocks = [redBlock1, orangeBlock1, greenBlock1, blueBlock1, indigoBlock1, purpleBlock1]
        
        self.view .bringSubviewToFront(redBlock1)
        self.view .bringSubviewToFront(orangeBlock1)
        self.view .bringSubviewToFront(greenBlock1)
        self.view .bringSubviewToFront(blueBlock1)
        self.view .bringSubviewToFront(indigoBlock1)
        self.view .bringSubviewToFront(purpleBlock1)
        var lengthSquare = (UIScreen.main.bounds.width - 10) * 0.179
        
        redBlock1.frame = CGRect(x: redBlock1.center.x, y: redBlock1.center.y, width: lengthSquare, height: lengthSquare)
        orangeBlock1.frame = CGRect(x: orangeBlock1.center.x, y: orangeBlock1.center.y, width: lengthSquare, height: lengthSquare)
        greenBlock1.frame = CGRect(x: greenBlock1.center.x, y: greenBlock1.center.y, width: lengthSquare, height: lengthSquare)
        blueBlock1.frame = CGRect(x: blueBlock1.center.x, y: blueBlock1.center.y, width: lengthSquare, height: lengthSquare)
        indigoBlock1.frame = CGRect(x: indigoBlock1.center.x, y: indigoBlock1.center.y, width: lengthSquare, height: lengthSquare)
        purpleBlock1.frame = CGRect(x: purpleBlock1.center.x, y: purpleBlock1.center.y, width: lengthSquare, height: lengthSquare)
        
        // hello world
        
    }
}

