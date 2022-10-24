//
//  Adicionales+CoreDataProperties.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 28/01/21.
//
//

import Foundation
import CoreData


extension Adicionales {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Adicionales> {
        return NSFetchRequest<Adicionales>(entityName: "Adicionales")
    }

    @NSManaged public var cantidad: Int16
    @NSManaged public var idPedido: Int16
    @NSManaged public var idServicio: String?
    @NSManaged public var nombreServicio: String?
    @NSManaged public var precioFinal: Int16
    @NSManaged public var precio: String?
    @NSManaged public var rutaImagen: String?
    @NSManaged public var idAdicional: String?
    @NSManaged public var servicioAdicional: String?

}

extension Adicionales : Identifiable {

}
