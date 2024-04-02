//
//  Contact.swift
//  ContactsTest
//
//  Created by Дмитрий Грибанский on 29.03.2024.
//

import Foundation

protocol ContactProtocol {

    var title: String {get set}
    var phone: String {get set}

}


struct Contact: ContactProtocol {
    var title: String
    var phone: String
    
}
