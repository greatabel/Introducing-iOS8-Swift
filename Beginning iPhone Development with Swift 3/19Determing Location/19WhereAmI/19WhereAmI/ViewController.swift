import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private var previousPoint: CLLocation?
    private var totalMovementDistance = CLLocationDistance(0)
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var horizontalAccuracyLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var verticalAccuracyLabel: UILabel!
    @IBOutlet var distanceTraveledLabel: UILabel!
    @IBOutlet var mapView:MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

