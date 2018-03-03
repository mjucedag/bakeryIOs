import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var error: UILabel!
    let group = DispatchGroup()
    
    @IBAction func login(_ sender: UIButton) {
        error.isHidden = true
        error.text = ""
        guard tfUser.text != "" && tfPassword.text != "" else {
            if tfUser.text == ""{
                tfUser.layer.borderColor = UIColor.red.cgColor
                tfUser.layer.borderWidth = 1.5
                error.text! += "Fill your username \n"
            }
            if tfPassword.text == "" {
                tfPassword.layer.borderColor = UIColor.red.cgColor
                tfPassword.layer.borderWidth = 1.5
                error.text! += "Fill your password"
            }
            error.isHidden = false
            return
        }
        tfUser.layer.borderColor = UIColor.white.cgColor
        tfUser.layer.borderWidth = 1.0
        
        tfPassword.layer.borderColor = UIColor.white.cgColor
        tfPassword.layer.borderWidth = 1.0
        
        //hacer la conexion
        if !connect() {return}
        
        print(DataBase.member)
        
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    func connect() ->Bool{
        let con = DBConnection()
        let user = tfUser.text!
        let password = tfPassword.text!
        
        con.getData(table: "product", user: user, password: password, products: &DataBase.products)
        
        let connected = con.connect()
        if !connected {showError(msg: con.getError()); return false}
        
        con.getData(table: "product")
        
        print("productos = \(DataBase.products.count)")
        let p = DataBase.products
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

