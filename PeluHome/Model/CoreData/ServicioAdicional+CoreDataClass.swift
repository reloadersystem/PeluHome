//
//  ServicioAdicional+CoreDataClass.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 29/01/21.
//
//

import Foundation
import CoreData

@objc(ServicioAdicional)
public class ServicioAdicional: NSManagedObject {
    
    func copy(id: Int, tot: Int16, servicios: String) {
        idPedido = Int16(id)
        total = tot
        detalle = servicios
    }

    class func agregarServicio(id: Int, inContext context:NSManagedObjectContext) -> ServicioAdicional {
        let idPedido = Int16(id)
        let request = NSFetchRequest<ServicioAdicional>(entityName: "ServicioAdicional")
        let predicate = NSPredicate(format: "idPedido == %i",idPedido)
        request.predicate = predicate

        do {
            let resultado = try context.fetch(request)
            if let adicional = resultado.first {
                return adicional
            }
            return ServicioAdicional(context: context)
        } catch(let ex) {
            print(ex)
            return ServicioAdicional(context: context)
        }
    }

    class func obtenerTotalById(id: Int, inContext context:NSManagedObjectContext) -> Int16 {
        let idPedido = Int16(id)
        let request = NSFetchRequest<ServicioAdicional>(entityName: "ServicioAdicional")
        let predicate = NSPredicate(format: "idPedido == %i",idPedido)
        request.predicate = predicate

        let resultado = try? context.fetch(request)
 
        return resultado?.first?.total ?? 0
    }
    
    class func obtenerDetalleById(id: Int, inContext context:NSManagedObjectContext) -> String {
        let idPedido = Int16(id)
        let request = NSFetchRequest<ServicioAdicional>(entityName: "ServicioAdicional")
        let predicate = NSPredicate(format: "idPedido == %i",idPedido)
        request.predicate = predicate

        let resultado = try? context.fetch(request)
 
        return resultado?.first?.detalle ?? ""
    }
}
