import UIKit

class FilmsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let networkService = NetworkService()
    var loader: UIView? = nil
    
    var films: [Docs?] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loader!.removeFromSuperview()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        networkService.getFilms { docs in
            self.films = docs
        }
        
        loader = Loader().getLoader(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height + 100)
        
        view.addSubview(loader!)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FilmsCell", bundle: nil), forCellReuseIdentifier: "FilmsCell")
        tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell") as! FilmsCell
        if films.isEmpty {
            return cell
        }
        guard let film = films[indexPath.row] else {
            return cell
        }
        cell.configure(image: film.poster!.posterData, title: film.name!, shortDescription: (film.shortDescription ?? film.description)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let film = films[indexPath.row] else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmDescriptionController") as! FilmDescriptionController
        
        destination.film = film
        destination.needToGetData = false
       
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
