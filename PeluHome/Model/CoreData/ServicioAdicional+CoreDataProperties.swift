//
//  ServicioAdicional+CoreDataProperties.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 29/01/21.
//
//

import Foundation
import CoreData


extension ServicioAdicional {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServicioAdicional> {
        return NSFetchRequest<ServicioAdicional>(entityName: "ServicioAdicional")
    }

    @NSManaged public var idPedido: Int16
    @NSManaged public var detalle: String?
    @NSManaged public var total: Int16

}

extension ServicioAdicional : Identifiable {

}
