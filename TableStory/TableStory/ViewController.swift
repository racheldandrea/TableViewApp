//
//  ViewController.swift
//  TableStory
//
//  Created by D'Andrea, Rachel E on 3/17/25.
//

import UIKit
import MapKit


//array objects of our data.
let data = [
    Item(name: "Red Yucca", Genus: "Hesperaloe parviflora", desc: "With its graceful, arching leaves and breathtaking fiery red flower spikes, Red Yucca adds a touch of Southwestern charm to any landscape.", lat: 29.7132, long: -98.1264, imageName: "redyucca2"),
    
    Item(name: "Coral Honeysuckle", Genus: "Lonicera", desc: "Clump-forming vine. Great species for hummingbirds. The red flowers are prolific for about a month in May/June followed by sporadic flowering the rest of the season.", lat: 29.6221, long: -98.0246, imageName: "coralhoneysuckle2"),
    
    Item(name: "Flame Acanthus", Genus: "Anisacanthus", desc: "The Flame Acanthus is a deciduous Texas native shrub best known for its red tubular flowers that are beloved by hummingbirds.", lat: 29.6977, long: -98.1074, imageName: "flameacanthus2"),
    
    Item(name: "Four-Nerve Daisy", Genus: "Hymenoxys; Cass", desc: "This Texas native perennial has long narrow leaves of gray-green foliage that form a clump from which the flower stems arise. When in full bloom, Four Nerve Daisy can appear covered with flowers and the individual flowers are long lasting.", lat: 29.6306, long: -98.1034, imageName: "fournervedaisy"),
    
    Item(name: "Snakeherb", Genus: "Dyschoriste", desc: "perennial plant with lavender to purple flowers that bloom in late spring and early summer.", lat: 29.7026, long: -98.1255, imageName: "snakeherb2")
   
]

struct Item {
    var name: String
    var Genus: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}





class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    
    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       
       //Add image references
                   let image = UIImage(named: item.imageName)
                   cell?.imageView?.image = image
                   cell?.imageView?.layer.cornerRadius = 10
                   cell?.imageView?.layer.borderWidth = 5
                   cell?.imageView?.layer.borderColor = UIColor.white.cgColor
                   
    
       return cell!
   }
       
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
      
    // add this function to original ViewController
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //add this code in viewDidLoad function in the original ViewController, below the self statements

            //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 29.6306, longitude: -98.1034)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }

              
        
    }


}

