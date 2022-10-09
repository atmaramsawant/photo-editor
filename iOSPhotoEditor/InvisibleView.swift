////

//InvisibleView

//iOSPhotoEditor

//Created by: Atmaram Sawant on 09/10/22

//

//

import Foundation
import UIKit


class InvisibleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.backgroundColor = .clear
    }
}
