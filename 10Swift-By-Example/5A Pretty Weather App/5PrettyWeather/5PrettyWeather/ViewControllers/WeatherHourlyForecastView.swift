import UIKit
import Cartography

class WeatherHourlyForecastView: UIView {

    static var HEIGHT: CGFloat {
        get { return 60 }
    }
    private var didSetupConstraints = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        if didSetupConstraints {
            super.updateConstraints()
            return
        }
        layoutView()
        super.updateConstraints()
        didSetupConstraints = true
    }

}

private extension WeatherHourlyForecastView {
    func setup() {

    }
}
private extension WeatherHourlyForecastView {
    func layoutView() {
        constrain(self) {
            $0.height == CurrentWeatherView.HEIGHT
        }
    }
}
private extension WeatherHourlyForecastView {
    func style() {
        backgroundColor = UIColor.green
    }
}
