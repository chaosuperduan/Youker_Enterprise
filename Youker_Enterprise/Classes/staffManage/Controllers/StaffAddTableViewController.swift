//

//

import UIKit
import SnapKit
class StaffAddTableViewController: BaseTableViewController {
    
    var url:String?
    let titles = ["手动添加","扫码添加"]
    let imgs = ["finger","coder"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpui()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "staff", for: indexPath)

        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "staff")
        }
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.textColor = UIColor.gray
        let imgV:UIImageView = UIImageView.init(image: UIImage.init(named: imgs[indexPath.row]))
      
       cell.contentView.addSubview(imgV)
  
        imgV.snp_makeConstraints { (make) in
        make.right.equalTo(cell.contentView).offset(-20)
        make.width.equalTo(31)
        make.height.equalTo(31)
        make.centerY.equalTo(cell.contentView.centerY)

        }
        
        

        return cell
    }
  
    
    func setUpui(){
     self.navigationItem.title = "添加企业员工"
     tableView.register(UITableViewCell.self, forCellReuseIdentifier: "staff")
     tableView.tableFooterView = UIView()
     self.tableView.rowHeight = 64
     self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: .plain, target: self, action: #selector(back))
        
    }
    
    @objc func back(){
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roleid = UserAccount.loadUserAccount()?.role_Type
        
        
        if indexPath.row == 0 {
            
            //权限校验。
           
            
            if(roleid == 125 || roleid == 126 || roleid == 131){
                
                UserAccount.loadUserAccount()?.role_Id
                let vc = AddViewController()
                vc.type = addType.ADD_EMPLOYEE
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
              
                
            }
                
            
                
        }else{
            
            
            if(roleid == 125 || roleid == 126 || roleid == 131){
                 showCodeView()
                
            }else{
                self.ReqType = RequestResultType.LIMIT
                
            }
    
            
          
            
        }
    }
    //获取
    
    
    //MARK:弹出邀请URL
    func showCodeView(){
        let popView = ZXPopView.init(frame: self.view.bounds)
        let codeV = CodeView.LoadFromNib()
        codeV.frame = CGRect.init(x: 0, y: kScreenH-234, width: KScreenW, height: 234)
        
        codeV.url = self.url
        codeV.setUpUI()
        popView.contenView = codeV
        
        popView.showInView(view: self.view)
        
        
        
    }
    

}
