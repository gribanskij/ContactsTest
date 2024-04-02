//
//  ViewController.swift
//  ContactsTest
//
//  Created by Дмитрий Грибанский on 27.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var contacts:[ContactProtocol] = []{
        didSet {
            contacts.sort{ $0.title < $1.title}
        }
    }
    
    var userDefaults = UserDefaults.standard
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
    
    
    private func loadContacts(){
        
        contacts.append(Contact(title: "Саня техосмотр", phone: "+7999924525235"))
        contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781235345435"))
        contacts.append(Contact(title: "Сильвестр", phone: "+78003774744"))

    
    }
    
    @IBAction func showNewContactAlert(){
        
        
        let alertController = UIAlertController(title: "Создайте новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
        alertController.addTextField{ textField in
            textField.text = "Имя"
        }
        alertController.addTextField {textField in
            textField.text = " Номер телефона"
        }
        
        let createButton = UIAlertAction(title: "Создать", style: .default){
            _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text else {
                return
            }
            let contact = Contact (title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        self.present (alertController,animated: true,completion: nil)
        
        
    }


}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell"){
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell =  reuseCell 
            
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
    
        }
        
    
        configure(cell: &cell, for: indexPath)
        
    
        return cell
    }
    
}

extension ViewController {
    
    func configure (cell:inout UITableViewCell, for indexPath:IndexPath){
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration =  configuration
    
        
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //print ("Определяем доступные действия для сстроки \(indexPath.row)")
        let actionDelete = UIContextualAction (style: .destructive, title: "Удалить"){_,_,_ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        
        return actions
    }
    
    
}
