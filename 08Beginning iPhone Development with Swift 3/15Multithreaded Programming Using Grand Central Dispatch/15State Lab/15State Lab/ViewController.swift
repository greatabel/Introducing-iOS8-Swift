import UIKit

class ViewController: UIViewController {

    private var label: UILabel!
    private var smiley: UIImage!
    private var smileyView: UIImageView!
    private var segmentedControl: UISegmentedControl!
    private var index = 0

    private var animate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bounds = view.bounds
        let labelFrame = CGRect(origin: CGPoint(x: bounds.origin.x, y:bounds.midY - 50),
                                size: CGSize(width: bounds.size.width, height: 100))
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Helvetica", size:70)
        label.text = "嘿嘿!"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear

        // smiley.png is 84 x 84
        let smileyFrame = CGRect(x: bounds.midX - 42,
                                 y: bounds.midY/2 - 42, width: 84, height: 84)
        smileyView = UIImageView(frame:smileyFrame)
        smileyView.contentMode = UIViewContentMode.center
        let smileyPath =
            Bundle.main.path(forResource: "smiley", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley

        segmentedControl =
            UISegmentedControl(items: ["One","Two", "Three", "Four"])
        segmentedControl.frame = CGRect(x: bounds.origin.x + 20, y: 50,
                                        width: bounds.size.width - 40, height: 30)
        segmentedControl.addTarget(self, action: #selector(ViewController.selectionChanged(_:)),
                                   for: UIControlEvents.valueChanged)

        index = UserDefaults.standard.integer(forKey: "index")
        segmentedControl.selectedSegmentIndex = index

        view.addSubview(segmentedControl)

        view.addSubview(smileyView)

        view.addSubview(label)
//        rotateLabelDown()

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(ViewController.applicationWillResignActive),
                           name: Notification.Name.UIApplicationWillResignActive, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationDidBecomeActive),
                           name: Notification.Name.UIApplicationDidBecomeActive, object: nil)

        center.addObserver(self, selector: #selector(ViewController.applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

    }

    func selectionChanged(_ sender:UISegmentedControl) {
        index = segmentedControl.selectedSegmentIndex;
    }

    func applicationWillResignActive() {
        print("VC: \(#function)")
        animate = false
    }

    func applicationDidBecomeActive() {
        print("VC: \(#function)")
        animate = true
        rotateLabelDown()
    }

    func applicationDidEnterBackground() {
        print("VC: \(#function)")
        self.smiley = nil
        self.smileyView.image = nil

        UserDefaults.standard.set(self.index,
                                  forKey:"index")

        let app = UIApplication.shared
        var taskId = UIBackgroundTaskInvalid
        let id = app.beginBackgroundTask() {
            print("Background task ran out of time and was terminated.")
            app.endBackgroundTask(taskId)
        }
        taskId = id
        if taskId == UIBackgroundTaskInvalid {
            print("Failed to start background task!")
            return
        }
        DispatchQueue.global(qos: .default).async {
            print("Starting background task with " +
                "\(app.backgroundTimeRemaining) seconds remaining")
            self.smiley = nil;
            self.smileyView.image = nil;
            // simulate a lengthy (25 seconds) procedure
            Thread.sleep(forTimeInterval: 25)
            print("Finishing background task with " +
                "\(app.backgroundTimeRemaining) seconds remaining")
            app.endBackgroundTask(taskId)
        }
    }

    func applicationWillEnterForeground() {
        print("VC: \(#function)")
        let smileyPath =
            Bundle.main.path(forResource:"smiley", ofType:"png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func rotateLabelDown() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        },
                       completion: {(Bool) -> Void in
                        self.rotateLabelUp()
        } )
    }

    func rotateLabelUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: 0)
        },
                       completion: {(Bool) -> Void in
                        if self.animate {
                            self.rotateLabelDown()
                        }
        } )
    }



}

