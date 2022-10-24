//
//  Carrito+CoreDataProperties.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/1/20.
//
//

import Foundation
import CoreData


extension Carrito {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Carrito> {
        return NSFetchRequest<Carrito>(entityName: "Carrito")
    }

    @NSManaged public var idServicio: String?
    @NSManaged public var nombreServicio: String?
    @NSManaged public var precio: String?
    @NSManaged public var cantidad: Int16
    @NSManaged public var rutaImagen: String?
    @NSManaged public var precioFinal: Int16

}

extension Carrito : Identifiable {

}
