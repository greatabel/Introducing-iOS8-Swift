import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var levelNumber: Int
    private var playerLives: Int
    private var finished = false

    private let playerNode: PlayerNode = PlayerNode()
    private let enemies = SKNode()
    private let playerBullets = SKNode()

    class func scene(size:CGSize, levelNumber:Int) -> GameScene {
        return GameScene(size: size, levelNumber: levelNumber)
    }

    override convenience init(size:CGSize) {
        self.init(size: size, levelNumber: 1)
    }

    init(size:CGSize, levelNumber:Int) {
        self.levelNumber = levelNumber
        self.playerLives = 5
        super.init(size: size)
        backgroundColor = SKColor.lightGray
        let lives = SKLabelNode(fontNamed: "Courier")
        lives.fontSize = 16
        lives.fontColor = SKColor.black
        lives.name = "LivesLabel"
        lives.text = "Lives: \(playerLives)"
        lives.verticalAlignmentMode = .top
        lives.horizontalAlignmentMode = .right
        lives.position = CGPoint(x: frame.size.width,
                                 y: frame.size.height)
        addChild(lives)
        let level = SKLabelNode(fontNamed: "Courier")
        level.fontSize = 16
        level.fontColor = SKColor.black
        level.name = "LevelLabel"
        level.text = "Level \(levelNumber)"
        level.verticalAlignmentMode = .top
        level.horizontalAlignmentMode = .left
        level.position = CGPoint(x: 0, y: frame.height)
        addChild(level)

        playerNode.position = CGPoint(x: frame.midX, y: frame.height * 0.1)
        addChild(playerNode)
        addChild(enemies)
        spawnEnemies()
        addChild(playerBullets)
    }

    required init?(coder aDecoder: NSCoder) {
        levelNumber = aDecoder.decodeInteger(forKey: "level")
        playerLives = aDecoder.decodeInteger(forKey: "playerLives")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(Int(levelNumber), forKey: "level")
        aCoder.encode(playerLives, forKey: "playerLives")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            if location.y < frame.height * 0.2 {
                let target = CGPoint(x: location.x, y: playerNode.position.y)
                playerNode.moveToward(target)
            } else {
                let bullet = BulletNode.bullet(from: playerNode.position, toward: location)
                playerBullets.addChild(bullet)
            }

        }
    }

    override func update(_ currentTime: TimeInterval) {
        if finished {
            return
        }
        updateBullets()
        updateEnemies()
        checkForNextLevel()
    }

    private func updateBullets() {
        var bulletsToRemove:[BulletNode] = []
        for bullet in playerBullets.children as! [BulletNode] {
            // Remove any bullets that have moved off-screen
            if !frame.contains(bullet.position) {
                // Mark bullet for removal
                bulletsToRemove.append(bullet)
                continue
            }
            // Apply thrust to remaining bullets
            bullet.applyRecurringForce()
        }
        playerBullets.removeChildren(in: bulletsToRemove)
    }

    private func updateEnemies() {
        var enemiesToRemove: [EnemyNode] = []
        for node in enemies.children as! [EnemyNode] {
            if !frame.contains(node.position) {
                enemiesToRemove.append(node)
            }
        }
        enemies.removeChildren(in: enemiesToRemove)
    }

    private func checkForNextLevel() {
        if enemies.children.isEmpty {
            goToNextLevel()
        }
    }

    private func goToNextLevel() {
    }

    private func spawnEnemies() {
        let count = Int(log(Float(levelNumber))) + levelNumber
//        print("--spawnEnemies count: \(count)")
        for _ in 0..<count {
            let enemy = EnemyNode()
            let size = frame.size;
            let x = arc4random_uniform(UInt32(size.width * 0.8))
                + UInt32(size.width * 0.1)
            let y = arc4random_uniform(UInt32(size.height * 0.5))
                + UInt32(size.height * 0.5)
            enemy.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            enemies.addChild(enemy)
        }
    }




}
