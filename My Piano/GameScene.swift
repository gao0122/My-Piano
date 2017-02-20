//
//  GameScene.swift
//  My Piano
//
//  Created by 高宇超 on 12/2/16.
//  Copyright © 2016 Yuchao. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum AppState {
    case playing,
    menu, menuHiding, menuShowing,
    record, recording, recordShowing, recordHiding,
    tutorial
}

class GameScene: SKScene {
    
    private let width: CGFloat = 1067
    private let height: CGFloat = 600
    private let rightBorder: CGFloat = 1258
    private let leftBorder: CGFloat = -1258
    private let showMenuX : CGFloat = -221.5
    private let hideMenuX : CGFloat = -300
    private let showSettingX : CGFloat = -52
    private let hideSettingX : CGFloat = -493.5
    private let menuY : CGFloat = -255
    private let settingY : CGFloat = 255
    private let scaleMax = 5
    private let scaleMin = 1
    private let scaleDict : [Int : CGFloat] = [1: 0.384, 2: 0.7, 3: 1, 4: 1.2, 5: 1.4]
    private let scrollingMax : CGFloat = 4
    private let scrollingMin : CGFloat = 1
    private let scrollingLineWidth : CGFloat = 115
    private let showRecordIconX : CGFloat = 215
    private let hideRecordX : CGFloat = 493.5
    private let showRecordX : CGFloat = 140
    private let deltaHidingRecordX : CGFloat = 78.5
    private let recordListX : CGFloat = -140
    private let recordListY : CGFloat = 170
    private let recordListDeltaY : CGFloat = 60
    private let recordArrayKey : String = "recordList"
    private let totalRecordsKey : String = "totalRecordNum"

    private var lastAppState : AppState = .playing
    
    private var spinnyNode : SKShapeNode?
    
    private var keyboardNode: SKNode!
    private var a0Button : SKSpriteNode!
    private var ae0Button : SKSpriteNode!
    private var b0Button : SKSpriteNode!
    private var c0Button : SKSpriteNode!
    private var ce0Button : SKSpriteNode!
    private var d0Button : SKSpriteNode!
    private var de0Button : SKSpriteNode!
    private var e0Button : SKSpriteNode!
    private var f0Button : SKSpriteNode!
    private var fe0Button : SKSpriteNode!
    private var g0Button : SKSpriteNode!
    private var ge0Button : SKSpriteNode!
    private var a1Button : SKSpriteNode!
    private var ae1Button : SKSpriteNode!
    private var b1Button : SKSpriteNode!
    private var c1Button : SKSpriteNode!
    private var ce1Button : SKSpriteNode!
    private var d1Button : SKSpriteNode!
    private var de1Button : SKSpriteNode!
    private var e1Button : SKSpriteNode!
    private var f1Button : SKSpriteNode!
    private var fe1Button : SKSpriteNode!
    private var g1Button : SKSpriteNode!
    private var ge1Button : SKSpriteNode!
    private var a2Button : SKSpriteNode!
    private var ae2Button : SKSpriteNode!
    private var b2Button : SKSpriteNode!
    private var c2Button : SKSpriteNode!
    private var ce2Button : SKSpriteNode!
    private var d2Button : SKSpriteNode!
    private var de2Button : SKSpriteNode!
    private var e2Button : SKSpriteNode!
    private var f2Button : SKSpriteNode!
    private var fe2Button : SKSpriteNode!
    private var g2Button : SKSpriteNode!
    private var ge2Button : SKSpriteNode!
    private var a3Button : SKSpriteNode!
    private var ae3Button : SKSpriteNode!
    private var b3Button : SKSpriteNode!
    private var c3Button : SKSpriteNode!
    private var ce3Button : SKSpriteNode!
    private var d3Button : SKSpriteNode!
    private var de3Button : SKSpriteNode!
    private var e3Button : SKSpriteNode!
    private var f3Button : SKSpriteNode!
    private var fe3Button : SKSpriteNode!
    private var g3Button : SKSpriteNode!
    private var ge3Button : SKSpriteNode!
    private var a4Button : SKSpriteNode!
    private var ae4Button : SKSpriteNode!
    private var b4Button : SKSpriteNode!
    private var c4Button : SKSpriteNode!
    private var ce4Button : SKSpriteNode!
    private var d4Button : SKSpriteNode!
    private var de4Button : SKSpriteNode!
    private var e4Button : SKSpriteNode!
    private var f4Button : SKSpriteNode!
    private var fe4Button : SKSpriteNode!
    private var g4Button : SKSpriteNode!
    private var ge4Button : SKSpriteNode!
    private var a5Button : SKSpriteNode!
    private var ae5Button : SKSpriteNode!
    private var b5Button : SKSpriteNode!
    private var c5Button : SKSpriteNode!
    private var ce5Button : SKSpriteNode!
    private var d5Button : SKSpriteNode!
    private var de5Button : SKSpriteNode!
    private var e5Button : SKSpriteNode!
    private var f5Button : SKSpriteNode!
    private var fe5Button : SKSpriteNode!
    private var g5Button : SKSpriteNode!
    private var ge5Button : SKSpriteNode!
    private var a6Button : SKSpriteNode!
    private var ae6Button : SKSpriteNode!
    private var b6Button : SKSpriteNode!
    private var c6Button : SKSpriteNode!
    private var ce6Button : SKSpriteNode!
    private var d6Button : SKSpriteNode!
    private var de6Button : SKSpriteNode!
    private var e6Button : SKSpriteNode!
    private var f6Button : SKSpriteNode!
    private var fe6Button : SKSpriteNode!
    private var g6Button : SKSpriteNode!
    private var ge6Button : SKSpriteNode!
    private var a7Button : SKSpriteNode!
    private var ae7Button : SKSpriteNode!
    private var b7Button : SKSpriteNode!
    private var c7Button : SKSpriteNode!
    
    private var recordLabel : SKLabelNode!
    private var labelSettingLabel : SKLabelNode!
    private var scrollingSpeedLabel : SKLabelNode!
    private var keyboardSizeLabel : SKLabelNode!
    private var aboutLabel : SKLabelNode!
    private var recordingLabel : SKLabelNode!
    
    private var touchBar : SKSpriteNode!
    private var labelsNode: SKNode!
    
    private var menu : SKSpriteNode!
    private var setting : SKSpriteNode!
    private var settingHelper : SKSpriteNode!
    private var labelSetting : SKSpriteNode!
    private var labelSettingHelper : SKSpriteNode!
    private var scrollingSpeedIcon : SKSpriteNode!
    private var keyboardSizeNumber : SKLabelNode!
    
    private var record : SKSpriteNode!
    private var recordHelper : SKSpriteNode!
    private var recordNode : SKNode!
    private var recordList : SKNode!
    
    private let scrollingSpeedIconName = "scrollingSpeedIconHelp"
    private let sizePlusIconName = "keySizePlus"
    private let sizeMinusIconName = "keySizeMinus"
    private let recordUsedOnce = "recordUsedOnce"
    
    private var state : AppState = .playing {
        didSet {
            if state != .recording && lastAppState == .recording {
                recordingLabel.removeAction(forKey: "recordingAct")
                if recordingLabel.alpha != 0 {
                    recordingLabel.run(SKAction.fadeOut(withDuration: 0.1))
                } else {
                    recordingLabel.text = langDict["recordingEndText"]
                    recordingLabel.fontColor = UIColor.init(hex: 0xff6a71)
                }
                let fadeIn = SKAction.fadeIn(withDuration: 0.2)
                let fadeOut = SKAction.fadeOut(withDuration: 0.7)
                let wait0 = SKAction.wait(forDuration: 0.17)
                let wait1 = SKAction.wait(forDuration: 1)
                let act = SKAction.sequence([wait0, fadeIn, wait1, fadeOut])
                recordingLabel.run(act)
            } else {
                recordingLabel.alpha = 0
            }
            
            switch state {
            case .recording:
                let angle : CGFloat = 2 * CGFloat(M_PI)
                let act = SKAction.rotate(byAngle: angle, duration: 4.2)
                let rpt = SKAction.repeatForever(act)
                record.run(rpt, withKey: "repeat")
                
                recordingLabel.text = langDict["recordingText"]
                recordingLabel.fontColor = UIColor.init(hex: 0x00ff81)
                let fadeIn = SKAction.fadeIn(withDuration: 0.9)
                fadeIn.timingMode = SKActionTimingMode.easeInEaseOut
                let fadeOut = SKAction.fadeOut(withDuration: 0.8)
                fadeOut.timingMode = SKActionTimingMode.easeInEaseOut
                let wait0 = SKAction.wait(forDuration: 1)
                let wait1 = SKAction.wait(forDuration: 0.3)
                let sequence = SKAction.sequence([fadeIn, wait0, fadeOut, wait1])
                let rpt1 = SKAction.repeatForever(sequence)
                recordingLabel.run(rpt1, withKey: "recordingAct")
            case .playing:
                self.saveRecord()
                record.removeAction(forKey: "repeat")
                record.zRotation = record.zRotation.remainder(dividingBy: CGFloat(M_PI))
                record.run(SKAction.rotate(toAngle: 0, duration: 0.28))
            case .record:
                UserDefaults.standard.set(true, forKey: recordUsedOnce)
            default:
                break
            }
            lastAppState = state
        }
    }
    private var touchDownState: AppState = .playing
    private var lastKeys = [Int : String]()
    
    private var touchBarHash : Int = 0
    private var lastTouchPos : CGPoint = CGPoint(x: 0, y: 0)
    private var keyboardPos : CGPoint!
    private var startRecordTime : TimeInterval = 0.0
    private var checked = false
    private var scrollingSpeed : CGFloat = 1
    private var touchDownNodeName : String = ""
    private var touchDownPos : CGPoint = CGPoint(x: 0, y: 0)
    private var touchDownRecordPosY : CGFloat = 0
    private var touchDownTimeStamp : TimeInterval = 0
    private var touchMoved = false
    
    private var recordArray = [[String : TimeInterval]]()
    private var recordArrays = [[[String : TimeInterval]]]()
    private var totalRecords : Int = 0
    
    private var langDict = [String : String]()
    
    override func didMove(to view: SKView) {
        
        /* Create shape node to use during mouse interaction
         let w = (self.size.width + self.size.height) * 0.05
         self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
         
         if let spinnyNode = self.spinnyNode {
         spinnyNode.lineWidth = 2.5
         
         spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
         spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
         SKAction.fadeOut(withDuration: 0.5),
         SKAction.removeFromParent()]))
         }
         */
        
        let langID : String = NSLocale.current.languageCode as String!
        
        switch langID {
        case "zh":
            langDict = zhDict
        default:
            langDict = enDict
        }
        
        // node connection
        keyboardNode = self.childNode(withName: "keyboard")
        a0Button = keyboardNode.childNode(withName: "A0Button") as! SKSpriteNode
        b0Button = keyboardNode.childNode(withName: "B0Button") as! SKSpriteNode
        c0Button = keyboardNode.childNode(withName: "C0Button") as! SKSpriteNode
        d0Button = keyboardNode.childNode(withName: "D0Button") as! SKSpriteNode
        e0Button = keyboardNode.childNode(withName: "E0Button") as! SKSpriteNode
        f0Button = keyboardNode.childNode(withName: "F0Button") as! SKSpriteNode
        g0Button = keyboardNode.childNode(withName: "G0Button") as! SKSpriteNode
        a1Button = keyboardNode.childNode(withName: "A1Button") as! SKSpriteNode
        b1Button = keyboardNode.childNode(withName: "B1Button") as! SKSpriteNode
        c1Button = keyboardNode.childNode(withName: "C1Button") as! SKSpriteNode
        d1Button = keyboardNode.childNode(withName: "D1Button") as! SKSpriteNode
        e1Button = keyboardNode.childNode(withName: "E1Button") as! SKSpriteNode
        f1Button = keyboardNode.childNode(withName: "F1Button") as! SKSpriteNode
        g1Button = keyboardNode.childNode(withName: "G1Button") as! SKSpriteNode
        a2Button = keyboardNode.childNode(withName: "A2Button") as! SKSpriteNode
        b2Button = keyboardNode.childNode(withName: "B2Button") as! SKSpriteNode
        c2Button = keyboardNode.childNode(withName: "C2Button") as! SKSpriteNode
        d2Button = keyboardNode.childNode(withName: "D2Button") as! SKSpriteNode
        e2Button = keyboardNode.childNode(withName: "E2Button") as! SKSpriteNode
        f2Button = keyboardNode.childNode(withName: "F2Button") as! SKSpriteNode
        g2Button = keyboardNode.childNode(withName: "G2Button") as! SKSpriteNode
        a3Button = keyboardNode.childNode(withName: "A3Button") as! SKSpriteNode
        b3Button = keyboardNode.childNode(withName: "B3Button") as! SKSpriteNode
        c3Button = keyboardNode.childNode(withName: "C3Button") as! SKSpriteNode
        d3Button = keyboardNode.childNode(withName: "D3Button") as! SKSpriteNode
        e3Button = keyboardNode.childNode(withName: "E3Button") as! SKSpriteNode
        f3Button = keyboardNode.childNode(withName: "F3Button") as! SKSpriteNode
        g3Button = keyboardNode.childNode(withName: "G3Button") as! SKSpriteNode
        a4Button = keyboardNode.childNode(withName: "A4Button") as! SKSpriteNode
        b4Button = keyboardNode.childNode(withName: "B4Button") as! SKSpriteNode
        c4Button = keyboardNode.childNode(withName: "C4Button") as! SKSpriteNode
        d4Button = keyboardNode.childNode(withName: "D4Button") as! SKSpriteNode
        e4Button = keyboardNode.childNode(withName: "E4Button") as! SKSpriteNode
        f4Button = keyboardNode.childNode(withName: "F4Button") as! SKSpriteNode
        g4Button = keyboardNode.childNode(withName: "G4Button") as! SKSpriteNode
        a5Button = keyboardNode.childNode(withName: "A5Button") as! SKSpriteNode
        b5Button = keyboardNode.childNode(withName: "B5Button") as! SKSpriteNode
        c5Button = keyboardNode.childNode(withName: "C5Button") as! SKSpriteNode
        d5Button = keyboardNode.childNode(withName: "D5Button") as! SKSpriteNode
        e5Button = keyboardNode.childNode(withName: "E5Button") as! SKSpriteNode
        f5Button = keyboardNode.childNode(withName: "F5Button") as! SKSpriteNode
        g5Button = keyboardNode.childNode(withName: "G5Button") as! SKSpriteNode
        a6Button = keyboardNode.childNode(withName: "A6Button") as! SKSpriteNode
        b6Button = keyboardNode.childNode(withName: "B6Button") as! SKSpriteNode
        c6Button = keyboardNode.childNode(withName: "C6Button") as! SKSpriteNode
        d6Button = keyboardNode.childNode(withName: "D6Button") as! SKSpriteNode
        e6Button = keyboardNode.childNode(withName: "E6Button") as! SKSpriteNode
        f6Button = keyboardNode.childNode(withName: "F6Button") as! SKSpriteNode
        g6Button = keyboardNode.childNode(withName: "G6Button") as! SKSpriteNode
        a7Button = keyboardNode.childNode(withName: "A7Button") as! SKSpriteNode
        b7Button = keyboardNode.childNode(withName: "B7Button") as! SKSpriteNode
        c7Button = keyboardNode.childNode(withName: "C7Button") as! SKSpriteNode
        ae0Button = keyboardNode.childNode(withName: "A0#Button") as! SKSpriteNode
        ce0Button = keyboardNode.childNode(withName: "C0#Button") as! SKSpriteNode
        de0Button = keyboardNode.childNode(withName: "D0#Button") as! SKSpriteNode
        fe0Button = keyboardNode.childNode(withName: "F0#Button") as! SKSpriteNode
        ge0Button = keyboardNode.childNode(withName: "G0#Button") as! SKSpriteNode
        ae1Button = keyboardNode.childNode(withName: "A1#Button") as! SKSpriteNode
        ce1Button = keyboardNode.childNode(withName: "C1#Button") as! SKSpriteNode
        de1Button = keyboardNode.childNode(withName: "D1#Button") as! SKSpriteNode
        fe1Button = keyboardNode.childNode(withName: "F1#Button") as! SKSpriteNode
        ge1Button = keyboardNode.childNode(withName: "G1#Button") as! SKSpriteNode
        ae2Button = keyboardNode.childNode(withName: "A2#Button") as! SKSpriteNode
        ce2Button = keyboardNode.childNode(withName: "C2#Button") as! SKSpriteNode
        de2Button = keyboardNode.childNode(withName: "D2#Button") as! SKSpriteNode
        fe2Button = keyboardNode.childNode(withName: "F2#Button") as! SKSpriteNode
        ge2Button = keyboardNode.childNode(withName: "G2#Button") as! SKSpriteNode
        ae3Button = keyboardNode.childNode(withName: "A3#Button") as! SKSpriteNode
        ce3Button = keyboardNode.childNode(withName: "C3#Button") as! SKSpriteNode
        de3Button = keyboardNode.childNode(withName: "D3#Button") as! SKSpriteNode
        fe3Button = keyboardNode.childNode(withName: "F3#Button") as! SKSpriteNode
        ge3Button = keyboardNode.childNode(withName: "G3#Button") as! SKSpriteNode
        ae4Button = keyboardNode.childNode(withName: "A4#Button") as! SKSpriteNode
        ce4Button = keyboardNode.childNode(withName: "C4#Button") as! SKSpriteNode
        de4Button = keyboardNode.childNode(withName: "D4#Button") as! SKSpriteNode
        fe4Button = keyboardNode.childNode(withName: "F4#Button") as! SKSpriteNode
        ge4Button = keyboardNode.childNode(withName: "G4#Button") as! SKSpriteNode
        ae5Button = keyboardNode.childNode(withName: "A5#Button") as! SKSpriteNode
        ce5Button = keyboardNode.childNode(withName: "C5#Button") as! SKSpriteNode
        de5Button = keyboardNode.childNode(withName: "D5#Button") as! SKSpriteNode
        fe5Button = keyboardNode.childNode(withName: "F5#Button") as! SKSpriteNode
        ge5Button = keyboardNode.childNode(withName: "G5#Button") as! SKSpriteNode
        ae6Button = keyboardNode.childNode(withName: "A6#Button") as! SKSpriteNode
        ce6Button = keyboardNode.childNode(withName: "C6#Button") as! SKSpriteNode
        de6Button = keyboardNode.childNode(withName: "D6#Button") as! SKSpriteNode
        fe6Button = keyboardNode.childNode(withName: "F6#Button") as! SKSpriteNode
        ge6Button = keyboardNode.childNode(withName: "G6#Button") as! SKSpriteNode
        ae7Button = keyboardNode.childNode(withName: "A7#Button") as! SKSpriteNode
        
        recordingLabel = self.childNode(withName: "recordingLabel") as! SKLabelNode
        recordLabel = self.childNode(withName: "//recordLabel") as! SKLabelNode
        labelSettingLabel = self.childNode(withName: "//labelSettingLabel") as! SKLabelNode
        scrollingSpeedLabel = self.childNode(withName: "//scrollingSpeedLabel") as! SKLabelNode
        keyboardSizeLabel = self.childNode(withName: "//keyboardSizeLabel") as! SKLabelNode
        aboutLabel = self.childNode(withName: "//aboutLabel") as! SKLabelNode
        
        touchBar = self.childNode(withName: "touchBarSprite") as! SKSpriteNode
        labelsNode = keyboardNode.childNode(withName: "labelsNode")
        
        setting = self.childNode(withName: "settingIcon") as! SKSpriteNode
        settingHelper = setting.childNode(withName: "settingIconHelper") as! SKSpriteNode
        menu = setting.childNode(withName: "menuBg") as! SKSpriteNode
        labelSettingHelper = labelSettingLabel.childNode(withName: "labelSettingHelper") as! SKSpriteNode
        labelSetting = menu.childNode(withName: "//labelSetting") as! SKSpriteNode
        scrollingSpeedIcon = menu.childNode(withName: "//scrollingSpeedIcon") as! SKSpriteNode
        keyboardSizeNumber = menu.childNode(withName: "keyboardSizeNumber") as! SKLabelNode
        
        record = self.childNode(withName: "recordIcon") as! SKSpriteNode
        recordHelper = record.childNode(withName: "recordIconHelper") as! SKSpriteNode
        recordNode = self.childNode(withName: "recordBgNode")
        recordList = recordNode.childNode(withName: "//recordList")
        
        // initial codes
        recordLabel.text = langDict["recordLabel"]
        labelSettingLabel.text = langDict["labelson"]
        scrollingSpeedLabel.text = langDict["scrollingSpeedLabel"]
        keyboardSizeLabel.text = langDict["keyboardSizeLabel"]
        aboutLabel.text = langDict["aboutLabel"]
        
        keyboardPos = keyboardNode.position
        
        let defaults = UserDefaults.standard
        if let array = defaults.array(forKey: recordArrayKey) {
            recordArrays = array as! [[[String : TimeInterval]]]
            totalRecords = defaults.integer(forKey: totalRecordsKey)
            var m = 0
            for i in 0..<totalRecords {
                if let time = defaults.string(forKey: "time" + String(i + 1)) {
                    let _ = addRecordLabel(num: i, time: time, labelID: m)
                    m += 1
                }
            }
        } else {
            defaults.set(recordArrays, forKey: recordArrayKey)
            defaults.set(totalRecords, forKey: totalRecordsKey)
        }
        
        let recordUsedBool = defaults.value(forKey: recordUsedOnce)
        if recordUsedBool == nil || !(recordUsedBool as! Bool) {
            self.initGuide()
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint, touch : UITouch) {
        
        let node = atPoint(pos)
        
        touchDownState = state
        if let name = node.name {
            touchDownNodeName = name
            touchDownPos = pos
            switch state {
            case .playing, .recording:
                if name.contains("Button") || name.contains("Label") {
                    playKeys(nodeName: name, touch: touch)
                } else if node == touchBar {
                    lastTouchPos = pos
                } else if node == settingHelper {
                    if state == .playing {
                        state = .menuShowing
                    }
                } else if node == recordHelper {
                    if state == .playing {
                        state = .recordShowing
                    }
                }
            case .menu:
                if node == settingHelper {
                    state = .menuHiding
                }
            case .record:
                if node == recordHelper {
                    state = .recordHiding
                } else if touchDownPos.x > record.position.x {
                    touchDownRecordPosY = recordList.position.y
                    touchDownTimeStamp = touch.timestamp
                }
            default:
                break
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint, touch : UITouch) {
        /* touch moving effects
         if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.blue
         self.addChild(n)
         }
         */
        
        
        let node = atPoint(pos)
        let dis = hypotf(Float(pos.x - touchDownPos.x), Float(pos.y - touchDownPos.y));
        touchMoved = dis > 23
        
        switch state {
        case .playing, .recording:
            if touch.hashValue == touchBarHash {
                if node == touchBar {
                    let posX = keyboardNode.position.x + (lastTouchPos.x - pos.x) * scrollingSpeed
                    let n = scaleDict[Int(keyboardSizeNumber.text!)!]!
                    if posX > rightBorder * n {
                        keyboardNode.position.x = rightBorder * n
                    } else if posX < leftBorder * n {
                        keyboardNode.position.x = leftBorder * n
                    } else {
                        keyboardNode.position.x = posX
                    }
                }
                
                lastTouchPos = pos
            }
            if touchDownNodeName == touchBar.name! {
                touchBarHash = touch.hashValue
            }
            if let name = node.name {
                if name.contains("Button") || name.contains("Label") {
                    playKeysHelp(name: name, touch: touch)
                }
            }
        case .menuShowing:
            if node == settingHelper {
                setting.position.x = pos.x
            } else if menu.position.x != showMenuX {
                showMenu()
                state = .menu
            }
        case .menuHiding:
            if node == settingHelper {
                setting.position.x = pos.x
            } else if menu.position.x != hideMenuX {
                hideMenu()
                state = .playing
            }
        case .menu:
            if touchDownNodeName == scrollingSpeedIconName {
                let total: CGFloat = scrollingLineWidth * 2
                let sx = scrollingSpeedIcon.position.x + scrollingLineWidth
                scrollingSpeed = sx / total * (scrollingMax - scrollingMin) + scrollingMin
                
                var posX = pos.x + menu.size.width / 2
                if posX > 115 {
                    posX = 115
                } else if posX < -115 {
                    posX = -115
                }
                scrollingSpeedIcon.position.x = posX
            }
            
        case .recordShowing:
            if node == recordHelper {
                record.position.x = pos.x
                recordNode.position.x = pos.x
            } else if record.position.x != showRecordX {
                showRecord()
                state = .record
            }
        case .recordHiding:
            if node == recordHelper {
                record.position.x = pos.x
                recordNode.position.x = pos.x - deltaHidingRecordX
            } else if record.position.x != hideRecordX {
                hideRecord()
                state = .playing
            }
        case .record:
            if touchDownPos.x > record.position.x {
                var deltaY = touchDownPos.y - touch.location(in: self).y + touchDownRecordPosY
                let y = CGFloat(recordArrays.count - 7) * recordListDeltaY
                
                if deltaY < 0 {
                    deltaY = 0
                } else if y > 0 && deltaY > y {
                    deltaY = y
                } else if y < 0 {
                    deltaY = 0
                }
                
                recordList.position.y = deltaY
            }
        case .tutorial:
            break
        }
        
    }
    
    func touchUp(atPoint pos : CGPoint, touch : UITouch) {
        let node = atPoint(pos)
        
        switch state {
        case .playing:
            if node == settingHelper && touchDownNodeName == node.name! {
                showMenu()
            }
        case .recording:
            if node == recordHelper && touchDownNodeName == node.name! {
                stopRecord()
            }
        case .menuShowing:
            if menu.position.x != showMenuX {
                showMenu()
            }
        case .menuHiding:
            if menu.position.x != hideMenuX {
                hideMenu()
            }
        case .menu:
            let x = showMenuX + menu.size.width / 2
            if (node == settingHelper || pos.x > x) && touchDownState != .playing && touchDownPos.x > x {
                hideMenu()
            } else if let _ = node.name {
                menuFunctions(node: node)
            }
        case .recordShowing:
            if record.position.x == hideRecordX {
                state = .recording
            } else if record.position.x != showRecordX {
                showRecord()
                
            }
        case .recordHiding:
            if record.position.x != hideRecordX {
                hideRecord()
            }
        case .record:
            let x = width / 2 - (recordNode.childNode(withName: "recordBg") as! SKSpriteNode).size.width
            
            if (node == recordHelper || pos.x < x) && touchDownState != .playing && touchDownPos.x < x {
                hideRecord()
            } else if let name = node.name {
                if let id = Int(name) {
                    if !touchMoved {
                        var m = 0
                        for i in 0...totalRecords {
                            if let node = recordList.childNode(withName: String(i)) as? SKLabelNode {
                                let chars = (node.text!).characters
                                let str = String(chars.split(separator: ".").first!)
                                
                                if node.alpha == 1 && Int(str)! < id  {
                                    m += 1
                                }
                            }
                        }
                        
                        touch.timestamp - touchDownTimeStamp > 0.56 ? removeRecord(id: id, labelID: m) : recordFunctions(node: node, labelID: m)
                    }
                } else if name == "recordLabel" {
                    if touch.timestamp - touchDownTimeStamp > 0.56 && !touchMoved {
                        removeAllRecords()
                    }
                }
            }
        case .tutorial:
            break;
        }
        
        touchMoved = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self), touch: t) }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self), touch: t)}
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self), touch: t) }
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self), touch: t) }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if state != .recording {
            if recordingLabel.alpha < 0.001 && recordingLabel.text! != "Recording ends" {
                recordingLabel.text = langDict["recordingEndText"]
                recordingLabel.fontColor = UIColor.init(hex: 0xff6a71)
            }
        }
        
        checkKeysColor()
        if state == .menuShowing {
            if menu.position.x == showMenuX {
                state = .menu
            }
        } else if state == .menuHiding {
            if menu.position.x == hideMenuX {
                state = .playing
            }
        }
        if state == .recordShowing {
            if recordNode.position.x == showRecordX {
                state = .record
            }
        } else if state == .recordHiding {
            if recordNode.position.x == hideRecordX {
                state = .playing
            }
        }
        
    }
    
    func checkKeysColor() -> Void {
        for child in keyboardNode.children {
            if let child = child as? SKSpriteNode {
                if !child.hasActions() {
                    if (child.name?.contains("#"))! {
                        child.color = UIColor.init(hex: 0x3C3939)
                    } else {
                        child.color = UIColor.init(hex: 0xFEFEFE)
                    }
                }
            }
        }
        
    }
    
    func playKeys(nodeName: String, touch: UITouch) -> Void {
        
        lastKeys[touch.hashValue] = nodeName
        
        switch nodeName {
        case "A0Button", "A0Label": playKey(name: "A0", touch: touch)
        case "B0Button", "B0Label": playKey(name: "B0", touch: touch)
        case "C0Button", "C0Label": playKey(name: "C0", touch: touch)
        case "D0Button", "D0Label": playKey(name: "D0", touch: touch)
        case "E0Button", "E0Label": playKey(name: "E0", touch: touch)
        case "F0Button", "F0Label": playKey(name: "F0", touch: touch)
        case "G0Button", "G0Label": playKey(name: "G0", touch: touch)
        case "A1Button", "A1Label": playKey(name: "A1", touch: touch)
        case "B1Button", "B1Label": playKey(name: "B1", touch: touch)
        case "C1Button", "C1Label": playKey(name: "C1", touch: touch)
        case "D1Button", "D1Label": playKey(name: "D1", touch: touch)
        case "E1Button", "E1Label": playKey(name: "E1", touch: touch)
        case "F1Button", "F1Label": playKey(name: "F1", touch: touch)
        case "G1Button", "G1Label": playKey(name: "G1", touch: touch)
        case "A2Button", "A2Label": playKey(name: "A2", touch: touch)
        case "B2Button", "B2Label": playKey(name: "B2", touch: touch)
        case "C2Button", "C2Label": playKey(name: "C2", touch: touch)
        case "D2Button", "D2Label": playKey(name: "D2", touch: touch)
        case "E2Button", "E2Label": playKey(name: "E2", touch: touch)
        case "F2Button", "F2Label": playKey(name: "F2", touch: touch)
        case "G2Button", "G2Label": playKey(name: "G2", touch: touch)
        case "A3Button", "A3Label": playKey(name: "A3", touch: touch)
        case "B3Button", "B3Label": playKey(name: "B3", touch: touch)
        case "C3Button", "C3Label": playKey(name: "C3", touch: touch)
        case "D3Button", "D3Label": playKey(name: "D3", touch: touch)
        case "E3Button", "E3Label": playKey(name: "E3", touch: touch)
        case "F3Button", "F3Label": playKey(name: "F3", touch: touch)
        case "G3Button", "G3Label": playKey(name: "G3", touch: touch)
        case "A4Button", "A4Label": playKey(name: "A4", touch: touch)
        case "B4Button", "B4Label": playKey(name: "B4", touch: touch)
        case "C4Button", "C4Label": playKey(name: "C4", touch: touch)
        case "D4Button", "D4Label": playKey(name: "D4", touch: touch)
        case "E4Button", "E4Label": playKey(name: "E4", touch: touch)
        case "F4Button", "F4Label": playKey(name: "F4", touch: touch)
        case "G4Button", "G4Label": playKey(name: "G4", touch: touch)
        case "A5Button", "A5Label": playKey(name: "A5", touch: touch)
        case "B5Button", "B5Label": playKey(name: "B5", touch: touch)
        case "C5Button", "C5Label": playKey(name: "C5", touch: touch)
        case "D5Button", "D5Label": playKey(name: "D5", touch: touch)
        case "E5Button", "E5Label": playKey(name: "E5", touch: touch)
        case "F5Button", "F5Label": playKey(name: "F5", touch: touch)
        case "G5Button", "G5Label": playKey(name: "G5", touch: touch)
        case "A6Button", "A6Label": playKey(name: "A6", touch: touch)
        case "B6Button", "B6Label": playKey(name: "B6", touch: touch)
        case "C6Button", "C6Label": playKey(name: "C6", touch: touch)
        case "D6Button", "D6Label": playKey(name: "D6", touch: touch)
        case "E6Button", "E6Label": playKey(name: "E6", touch: touch)
        case "F6Button", "F6Label": playKey(name: "F6", touch: touch)
        case "G6Button", "G6Label": playKey(name: "G6", touch: touch)
        case "A7Button", "A7Label": playKey(name: "A7", touch: touch)
        case "B7Button", "B7Label": playKey(name: "B7", touch: touch)
        case "C7Button", "C7Label": playKey(name: "C7", touch: touch)
        case "A0#Button": playKey(name: "A0#", touch: touch)
        case "C0#Button": playKey(name: "C0#", touch: touch)
        case "D0#Button": playKey(name: "D0#", touch: touch)
        case "F0#Button": playKey(name: "F0#", touch: touch)
        case "G0#Button": playKey(name: "G0#", touch: touch)
        case "A1#Button": playKey(name: "A1#", touch: touch)
        case "C1#Button": playKey(name: "C1#", touch: touch)
        case "D1#Button": playKey(name: "D1#", touch: touch)
        case "F1#Button": playKey(name: "F1#", touch: touch)
        case "G1#Button": playKey(name: "G1#", touch: touch)
        case "A2#Button": playKey(name: "A2#", touch: touch)
        case "C2#Button": playKey(name: "C2#", touch: touch)
        case "D2#Button": playKey(name: "D2#", touch: touch)
        case "F2#Button": playKey(name: "F2#", touch: touch)
        case "G2#Button": playKey(name: "G2#", touch: touch)
        case "A3#Button": playKey(name: "A3#", touch: touch)
        case "C3#Button": playKey(name: "C3#", touch: touch)
        case "D3#Button": playKey(name: "D3#", touch: touch)
        case "F3#Button": playKey(name: "F3#", touch: touch)
        case "G3#Button": playKey(name: "G3#", touch: touch)
        case "A4#Button": playKey(name: "A4#", touch: touch)
        case "C4#Button": playKey(name: "C4#", touch: touch)
        case "D4#Button": playKey(name: "D4#", touch: touch)
        case "F4#Button": playKey(name: "F4#", touch: touch)
        case "G4#Button": playKey(name: "G4#", touch: touch)
        case "A5#Button": playKey(name: "A5#", touch: touch)
        case "C5#Button": playKey(name: "C5#", touch: touch)
        case "D5#Button": playKey(name: "D5#", touch: touch)
        case "F5#Button": playKey(name: "F5#", touch: touch)
        case "G5#Button": playKey(name: "G5#", touch: touch)
        case "A6#Button": playKey(name: "A6#", touch: touch)
        case "C6#Button": playKey(name: "C6#", touch: touch)
        case "D6#Button": playKey(name: "D6#", touch: touch)
        case "F6#Button": playKey(name: "F6#", touch: touch)
        case "G6#Button": playKey(name: "G6#", touch: touch)
        case "A7#Button": playKey(name: "A7#", touch: touch)
        default:
            break
        }
    }
    
    func playKeysHelp(name: String, touch: UITouch) -> Void {
        var nodeName = name
        if name.contains("Label") {
            let index = name.index(name.startIndex, offsetBy: 2)
            nodeName = name.substring(to: index) + "Button"
        }
        
        if lastKeys[touch.hashValue] != nodeName {
            playKeys(nodeName: nodeName, touch: touch)
            checked = false
        }
    }
    
    func playKey(name: String, touch: UITouch) -> Void {
        
        // key color transition thread
        DispatchQueue.main.async {
            let keyNodeName = name + "Button"
            let node = self.keyboardNode.childNode(withName: keyNodeName) as! SKSpriteNode
            var originColor = UIColor.init(hex: 0xFEFEFE)
            var transColor = originColor
            
            if keyNodeName[keyNodeName.startIndex] == "A" {
                transColor = UIColor.init(hex: 0xFF0033)
                if keyNodeName.contains("#") {
                    transColor = UIColor.init(hex: 0xFF331A)
                    originColor = UIColor.init(hex: 0x3C3939)
                }
            } else if keyNodeName[keyNodeName.startIndex] == "B" {
                transColor = UIColor.init(hex: 0xFF6600)
            } else if keyNodeName[keyNodeName.startIndex] == "C" {
                transColor = UIColor.init(hex: 0xFFCC33)
                if keyNodeName.contains("#") {
                    transColor = UIColor.init(hex: 0x809933)
                    originColor = UIColor.init(hex: 0x3C3939)
                }
            } else if keyNodeName[keyNodeName.startIndex] == "D" {
                transColor = UIColor.init(hex: 0x006633)
                if keyNodeName.contains("#") {
                    transColor = UIColor.init(hex: 0x008080)
                    originColor = UIColor.init(hex: 0x3C3939)
                }
            } else if keyNodeName[keyNodeName.startIndex] == "E" {
                transColor = UIColor.init(hex: 0x0099CC)
            } else if keyNodeName[keyNodeName.startIndex] == "F" {
                transColor = UIColor.init(hex: 0x065279)
                if keyNodeName.contains("#") {
                    transColor = UIColor.init(hex: 0x364389)
                    originColor = UIColor.init(hex: 0x3C3939)
                }
            } else if keyNodeName[keyNodeName.startIndex] == "G" {
                transColor = UIColor.init(hex: 0x663399)
                if keyNodeName.contains("#") {
                    transColor = UIColor.init(hex: 0xB31A66)
                    originColor = UIColor.init(hex: 0x3C3939)
                }
            }
            
            let colorizeTo = SKAction.colorize(with: transColor, colorBlendFactor: 1, duration: 0.032)
            let colorizeStay = SKAction.colorize(with: transColor, colorBlendFactor: 1, duration: 0.144)
            let colorizeBack = SKAction.colorize(with: originColor, colorBlendFactor: 0, duration: 0.42)
            let colorize = SKAction.sequence([colorizeTo, colorizeStay, colorizeBack])
            colorize.timingMode = .easeIn
            
            node.run(colorize)
        }
        
        // sound playing thread
        DispatchQueue.main.async {
            self.run(SKAction(named: name)!)
            if self.state == .recording {
                self.recordArray.append([name: touch.timestamp])
            }
        }
    }
    
    func showMenu() -> Void {
        state = .menuShowing
        
        let actMenu = SKAction.move(to: CGPoint(x: showMenuX, y: menuY), duration: 0.32)
        actMenu.timingMode = SKActionTimingMode.easeOut
        menu.run(actMenu)
        
        let actSet = SKAction.move(to: CGPoint(x: showSettingX, y: settingY), duration: 0.32)
        actSet.timingMode = SKActionTimingMode.easeOut
        setting.run(actSet)
    }
    
    func hideMenu() -> Void {
        state = .menuHiding
        
        let actMenu = SKAction.move(to: CGPoint(x: hideMenuX, y: menuY), duration: 0.32)
        actMenu.timingMode = SKActionTimingMode.easeOut
        menu.run(actMenu)
        
        let actSet = SKAction.move(to: CGPoint(x: hideSettingX, y: settingY), duration: 0.32)
        actSet.timingMode = SKActionTimingMode.easeOut
        setting.run(actSet)
    }
    
    func menuFunctions(node: SKNode) -> Void {
        if node.name! == touchDownNodeName {
            if node == labelSettingHelper{
                if labelsNode.isHidden {
                    labelsNode.isHidden = false
                    labelSettingLabel.text = langDict["labelson"]
                    let act = SKAction.fadeIn(withDuration: 0.3)
                    act.timingMode = SKActionTimingMode.easeOut
                    labelSetting.run(act)
                } else {
                    labelsNode.isHidden = true
                    labelSettingLabel.text = langDict["labelsoff"]
                    let act = SKAction.fadeOut(withDuration: 0.3)
                    act.timingMode = SKActionTimingMode.easeOut
                    labelSetting.run(act)
                }
            } else if node.name! == sizePlusIconName || node.name! == sizeMinusIconName {
                var n = Int(keyboardSizeNumber.text!)!
                if node.name! == sizePlusIconName {
                    n += 1
                    if n > scaleMax { n = scaleMax }
                    keyboardSizeNumber.text = String(n)
                } else {
                    n -= 1
                    if n < scaleMin { n = scaleMin }
                    keyboardSizeNumber.text = String(n)
                }
                let scaleAct = SKAction.scale(to: scaleDict[n]!, duration: 0.12)
                scaleAct.timingMode = SKActionTimingMode.easeIn
                keyboardNode.run(scaleAct)
            } else if node.name! == "aboutLabel" {
                if let about = self.childNode(withName: "aboutText") as? SKLabelNode {
                    aboutLabelAction(about: about)
                } else {
                    let about0 = SKLabelNode.init(text: langDict["aboutText"])
                    about0.name = "aboutText"
                    about0.fontSize = 56
                    about0.fontColor = UIColor(hex: 0xFEFEFE)
                    about0.position = CGPoint(x: 0, y: 0)
                    about0.zPosition = 30
                    about0.alpha = 0
                    let bg = SKShapeNode.init(rect: CGRect.init(x: -600, y: -333, width: 1200, height: 666), cornerRadius: 0)
                    about0.addChild(bg)
                    bg.zPosition = -1
                    bg.position = CGPoint(x: 0, y: 0)
                    bg.fillColor = UIColor(hex: 0x212020)
                    bg.strokeColor = UIColor(hex: 0x212020)
                    bg.alpha = 0.84
                    
                    self.addChild(about0)
                    
                    aboutLabelAction(about: about0)
                }
            }
        }
    }
    
    func aboutLabelAction(about: SKLabelNode) -> Void {
        let unhide = SKAction.unhide()
        unhide.duration = 0.1
        let fadeIn = SKAction.fadeIn(withDuration: 0.48)
        let wait = SKAction.wait(forDuration: 1.84)
        let fadeOut = SKAction.fadeOut(withDuration: 0.48)
        let hide = SKAction.hide()
        hide.duration = 0.1
        about.run(SKAction.sequence([unhide, fadeIn, wait, fadeOut, hide]))
    }
    
    func showRecord() -> Void {
        state = .recordShowing
        
        let actRecord = SKAction.move(to: CGPoint(x: showRecordX, y: settingY), duration: 0.32)
        actRecord.timingMode = SKActionTimingMode.easeOut
        recordNode.run(actRecord)
        
        let actIcon = SKAction.move(to: CGPoint(x: showRecordIconX, y: settingY), duration: 0.32)
        actIcon.timingMode = SKActionTimingMode.easeOut
        record.run(actIcon)
    }
    
    func hideRecord() -> Void {
        state = .recordHiding
        touchDownRecordPosY = 0
        
        var actions = Array<SKAction>()
        let rotate = SKAction.rotate(toAngle: 0, duration: 0.32)
        let actIcon = SKAction.move(to: CGPoint(x: hideRecordX, y: settingY), duration: 0.32)
        actIcon.timingMode = SKActionTimingMode.easeOut
        actions.append(rotate)
        actions.append(actIcon)
        record.run(SKAction.group(actions))
        
        let actRecord = SKAction.move(to: CGPoint(x: hideRecordX, y: settingY), duration: 0.32)
        actRecord.timingMode = SKActionTimingMode.easeOut
        recordNode.run(actRecord)
    }
    
    func stopRecord() -> Void {
        state = .playing
    }
    
    func saveRecord() -> Void {
        if recordArray.count > 0 {
            let defaults = UserDefaults.standard
            recordArrays.append(recordArray)
            defaults.set(recordArrays, forKey: recordArrayKey)
            defaults.set(addRecordLabel(num: totalRecords, time: nil, labelID: recordArrays.count - 1), forKey: "time" + String(totalRecords + 1))
            totalRecords += 1
            defaults.set(totalRecords, forKey: totalRecordsKey)
            recordArray.removeAll()
        }
    }
    
    func addRecordLabel(num: Int, time: String?, labelID: Int) -> String {
        let id = String(describing: num + 1)
        let date = NSDate()
        let calendar = NSCalendar.current
        let year = String(calendar.component(.year, from: date as Date))
        let month = correctDateNum(num: calendar.component(.month, from: date as Date))
        let day = correctDateNum(num: calendar.component(.day, from: date as Date))
        let hour = correctDateNum(num: calendar.component(.hour, from: date as Date))
        let minute = correctDateNum(num: calendar.component(.minute, from: date as Date))
        let time = time ?? year + month + day + hour + minute
        
        let label = SKLabelNode.init(text: id + ". " + time)
        let name = id
        if recordList.childNode(withName: name) == nil {
            recordList.addChild(label)
            label.position = CGPoint(x: recordListX, y: recordListY - recordListDeltaY * CGFloat(labelID))
            label.name = id
            let count = label.text!.characters.count
            if count < 17 {
                label.fontSize = 32
            } else if count < 18 {
                label.fontSize = 31
            } else {
                label.fontSize = 29
            }
            label.zPosition = 10
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        }
        
        return time
    }
    
    func correctDateNum(num: Int) -> String {
        return num < 10 ? "0" + String(num) : String(num)
    }
    
    func recordFunctions(node: SKNode, labelID: Int) -> Void {
        let name = node.name!
        if name == touchDownNodeName {
            if let _ = Int(name) {
                var actions = [SKAction]()
                let record = recordArrays[labelID]
                if record.count > 0 {
                    let firstTimeStamp = record.first!.values.first!
                    for note in record {
                        let key = note.keys.first!
                        let timeStamp = note[key]! - firstTimeStamp
                        let wait = SKAction.wait(forDuration: timeStamp)
                        let play = SKAction(named: key)
                        let act = SKAction.sequence([wait, play!])
                        actions.append(act)
                    }
                }
                self.removeAllActions()
                self.run(SKAction.group(actions))
            }
        }
    }

    func removeRecord(id: Int, labelID: Int) {
        // todo: alert delete 
        let defaults = UserDefaults.standard
        
        let node = recordList.childNode(withName: String(id)) as! SKLabelNode
        node.run(SKAction.fadeOut(withDuration: 0.23))
        
        for i in 0...totalRecords {
            if let node = recordList.childNode(withName: String(i)) as? SKLabelNode {
                if i > id {
                    node.run(SKAction.move(by: CGVector(dx: 0, dy: recordListDeltaY), duration: 0.2))
                }
            }
        }
        
        recordArrays.remove(at: labelID)
        defaults.set(recordArrays, forKey: recordArrayKey)
        defaults.removeObject(forKey: "time" + String(id))
    }
    
    func removeAllRecords() -> Void {
        let defaults = UserDefaults.standard
        for i in 0...totalRecords {
            if let node = recordList.childNode(withName: String(i)) as? SKLabelNode {
                node.name = nil
                node.run(SKAction.fadeOut(withDuration: 0.23))
            }
            let timeKey = "time" + String(i)
            if let _ = defaults.string(forKey: timeKey) {
                defaults.removeObject(forKey: timeKey)
            }
        }
        totalRecords = 0
        recordArrays.removeAll()
        defaults.set(totalRecords, forKey: totalRecordsKey)
        defaults.set(recordArrays, forKey: recordArrayKey)
        
    }
    
    // another way to play sound, no use in this app
    func play(fileName: String) -> Void {
        
        // private
        var mp3Dict = [String: AVAudioPlayer]()

        let index1 = fileName.index(fileName.startIndex, offsetBy: 1)
        let index2 = fileName.index(fileName.startIndex, offsetBy: 2)
        let nameNum = Int(fileName.substring(to: index2).substring(from: index1))
        var name = fileName.substring(to: index1)
        
        var num = 0
        
        switch name {
        case "A":
            num = 1
        case "B":
            num = 3
        case "C":
            num = 4
        case "D":
            num = 6
        case "E":
            num = 7
        case "F":
            num = 9
        case "G":
            num = 11
        default:
            break
        }
        
        if fileName.characters.count == 2 {
            num += 12 * nameNum!
        } else {
            num += 12 * nameNum! + 1
            name += "#"
        }
        
        if num < 10 {
            name = "0" + String(num) + "-" + name
        } else {
            name = String(num) + "-" + name
        }
        
        if let player = mp3Dict[name] {
            player.play()
        } else {
            if let path = Bundle.main.path(forResource: name, ofType: "mp3") {
                let url = NSURL(fileURLWithPath: path)
                do {
                    let sound = try AVAudioPlayer(contentsOf: url as URL)
                    mp3Dict[name] = sound
                    sound.play(atTime: 0)
                } catch {
                    print("!!! Error loading mp3 file")
                }
            }
        }
    }
    
    func initGuide() {
        
    }
    
}


// extension class of UIColor
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


let enDict : [String: String] = [
    "labelson": "Labels on",
    "labelsoff": "Labels off",
    "scrollingSpeedLabel": "Scrolling speed",
    "keyboardSizeLabel": "Keyboard size",
    "aboutLabel": "About",
    "aboutText": "Powered by UIC Homebrew Computer Club",
    "recordLabel": "Record",
    "recordingText": "Recording",
    "recordingEndText": "Recording ends"
]

let zhDict : [String: String] = [
    "labelson": "标签已开",
    "labelsoff": "标签已关",
    "scrollingSpeedLabel": "键盘滑动速度",
    "keyboardSizeLabel": "键盘大小",
    "aboutLabel": "关于",
    "aboutText": "UIC 计算机俱乐部出品",
    "recordLabel": "记录",
    "recordingText": "正在录制",
    "recordingEndText": "录制结束"
]

