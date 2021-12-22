//
//  GETFilms_TableViewController.swift
//  GETPeople_GETFilms
//
//  Created by Atheer Alahmari on 18/05/1443 AH.
//

import UIKit

class GETFilms_TableViewController: UITableViewController {

    // Hardcoded data for now
    var films :[String] = []
    override func viewDidLoad()  {
        super.viewDidLoad()
        // specify the url that we will be sending the GET request to
        let url = URL(string: "https://swapi.dev/api/films/?format=json")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        
                        let resultsArray = results as! NSArray
                        
                        for object in resultsArray {
                            if let jsonObject = object as? NSDictionary{
                                self.films.append(jsonObject["title"] as! String)
                            }
                        }
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch {
                print(error)
            }
        })
        
        task.resume()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "GETFilms_TableViewController"), for: indexPath)

        cell.textLabel?.text = films[indexPath.row]

        return cell
    }
    

}
