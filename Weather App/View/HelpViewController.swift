//
//  HelpViewController.swift
//  Weather App
//
//  Created by Akshay  Chavan on 30/03/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadHTMLString("<p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><strong>1.&nbsp;</strong><strong>Home Screen :</strong></p><p>The first screen is the Home screen. In the search bar, you can enter the place or city name and tap on the search button on the keyboard. It will fetch the information from the server and display the location details on the City screen.</p><p>On the Home screen at the navigation bar on the top right there is a button for settings you can use that button to configure your custom settings.</p><p>Below the search bar, there is a table view. This table view will show all the locations that we have bookmarked from the City screen. If the location is bookmarked and it is there in table view if we select the location then it will redirect to the City screen and will display the weather information.</p><p>To delete the perticular location you can swipe the cell from left to right</p><p>Below the table view, there is a button with the title search location. We can use this button to get the location from MapView. Tapping on this button will redirect us to the MapView screen.</p><p><br></p><p><br></p><p><strong>2. Settings</span></strong><strong>&nbsp;Screen :</strong></span></p><p>The settings screen will have only one setting right now that is customizing the unit of measurement. There are 3 units provided for customization.&nbsp;</span></p><ol><li>Standard&nbsp;</li><li>Imperial&nbsp;</li><li>Metric</li></ol><p>By default the UOM is Metric. At the end, there is a button that is Apply Settings we can use that button to save our changed settings.</p><p><br></p><p><strong>3. MapView</span></strong><strong>&nbsp;Screen :</strong></span></p><p>The MapView screen has the map. You can zoom the map and select the location that you want to know the weather of and it will drop a pin on the selected location. To see the information after selection you have to tap on the Done button. You can select the Cancel button to cancel the selection process or to dismiss the MapView.</p><p><br></p><p><strong>4. City Screen</span></strong><span ><strong>&nbsp;:</strong></span></p><p>The City Screen has the Bookmark button at the top right on the navigation bar. You can bookmark the city by tapping on the bookmark button. Once the city is bookmarked you can see the city on the Home screen.</p><p>The information is divided into multiple parts. The first part of the screen below the navigation bar shows the information of today&apos;s or we can say current weather information of city.&nbsp;</p><p>After Today&apos;s weather information you can see the text as a 5-day forecast. Below that text, you can see the weather information for the next 5 days. It is a table view having 5 cells and each cell is having the UICollection view you can scroll horizontally to see the weather details of different time during a day.</p>", baseURL: nil)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
