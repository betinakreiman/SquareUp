// doing it the wrong way 
//
//  GameScene.swift
//  SquareUpWithSpriteKit
//
//  Created by Betina Kreiman on 9/15/21.
//

import SpriteKit
import GameplayKit

class Square: SKSpriteNode { }

class GameScene: SKScene {
    var squares = ["red", "orange", "yellow", "green", "blue", "purple"]
    
    //var temp = SKSpriteNode(imageNamed: "blue")
    var allSquares = [SKSpriteNode]()
    
    var  myTileMapBig = SKTileMapNode()

    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.size = CGSize(width: frame.width, height: frame.height)
        
        //addChild(temp)
        
        
        
        let background = SKSpriteNode(imageNamed: "square")
        background.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        background.alpha = 0.8
        background.zPosition = -1
        background.size = CGSize(width: frame.width * 0.94, height: frame.width * 0.94)
        addChild(background)
        
        let square = SKSpriteNode(imageNamed: "red")
        square.size = CGSize(width: background.frame.width / 5, height: background.frame.height / 5)
        let squareRadius = square.frame.width / 2.0
        
        let xCoordinates = [Float]()
        let yCoordinates = [Float]()
        
        
        for i in squares {
            for j in 1...4 {
                let square = Square(imageNamed: i)
                square.size = CGSize(width: (background.frame.width - 25) / 5.03, height: (background.frame.width - 25) / 5.03)
                //print(square.size)
                square.position = CGPoint(x: j*10, y: j * 10)
                square.name = i
                
                square.physicsBody = SKPhysicsBody(circleOfRadius: squareRadius)
                square.physicsBody?.allowsRotation = false
                square.physicsBody?.affectedByGravity = false
                square.physicsBody?.friction = 1.0
                square.physicsBody?.allowsRotation = false
                square.physicsBody?.restitution = 0
                square.physicsBody?.usesPreciseCollisionDetection = true
                
                allSquares.append(square)
                addChild(square)
                
                
            }
        }
        myTileMapBig.numberOfColumns = 5
        myTileMapBig.numberOfRows = 5
        myTileMapBig.color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        myTileMapBig.tileSize = CGSize(width: square.frame.width, height: square.frame.width)
        addChild(myTileMapBig)
        
        
        /*for i in stride(from: squareRadius, to: view.bounds.width - squareRadius, by: square.frame.width) {
            for j in stride(from: 100, to: view.bounds.height - squareRadius, by: square.frame.height) {
                let squareType = squares.randomElement()!
                let square = Square(imageNamed: squareType)
                square.size = CGSize(width: background.frame.width / 5, height: background.frame.height / 5)
                square.position = CGPoint(x: i, y: j)
                square.name = squareType
                
                square.physicsBody = SKPhysicsBody(circleOfRadius: squareRadius)
                square.physicsBody?.allowsRotation = false
                square.physicsBody?.affectedByGravity = false
                //square.physicsBody?.usesPreciseCollisionDetection = true
                
                allSquares.append(square)
                addChild(square)
            }
            
            //temp.physicsBody = SKPhysicsBody(circleOfRadius: temp.frame.width/2)
            //temp.physicsBody?.affectedByGravity = false
        } */
        
        
        // create container
        let backgroundRadius = background.frame.width / 2.0
        let leftRightIndent = (frame.width - background.frame.width) / 2.0 + 12
        let bottomIndent = ((frame.height / 2.0) - 50) - backgroundRadius + 12
        let topIndent = ((frame.height / 2.0) + 50) - backgroundRadius + 13
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: bottomIndent, left: leftRightIndent, bottom: topIndent, right: leftRightIndent)))
        
        
        //allSquares.append(temp)
        
       /*
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        } */
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    
        for touch in (touches as! Set<UITouch>) {
            let location = touch.location(in: self)
            print(location)
            for square in allSquares {
                if square.contains(location) {
                    square.position = location
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.location(in: self)
            for square in allSquares {
                if square.contains(location) {
                    square.position = location
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
