//
//  Adicionales+CoreDataClass.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 28/01/21.
//
//

import Foundation
import CoreData

@objc(Adicionales)
public class Adicionales: NSManagedObject {

    func copy(id: Int, servicio: Servicio, cant: Int16) {
        idPedido = Int16(id)
        idServicio = String(servicio.idServicio)
        nombreServicio = servicio.nombreServicio
        precio = servicio.precio
        let precioInt = Int16(precio ?? "0") ?? 0
        precioFinal = cant * precioInt
        cantidad = cant
        rutaImagen = servicio.rutaImagen
        idAdicional = "\(id)-\(servicio.idServicio)"
        servicioAdicional = "\(servicio.idServicio)|\(servicio.precio)|\(cantidad)"
    }

    class func agregarServicio(id: Int, idServicio: String, inContext context:NSManagedObjectContext) -> Adicionales {
        let idAdicional = "\(id)-\(idServicio)"
        let request = NSFetchRequest<Adicionales>(entityName: "Adicionales")
        let predicate = NSPredicate(format: "idAdicional=%@", idAdicional)
        request.predicate = predicate

        do {
            let resultado = try context.fetch(request)
            if let adicional = resultado.first {
                return adicional
            }
            return Adicionales(context: context)
        } catch(let ex) {
            print(ex)
            return Adicionales(context: context)
        }
    }
    
    class func listasAdicionalesById(id: Int, inContext context:NSManagedObjectContext) -> [Adicionales] {
        let idPedido = Int16(id)
        let request = NSFetchRequest<Adicionales>(entityName: "Adicionales")
        let predicate = NSPredicate(format: "idPedido == %i",idPedido)
        request.predicate = predicate
        let order = NSSortDescriptor(key: "idServicio", ascending: true)
        request.sortDescriptors = [order]

        let resultado = try? context.fetch(request)
        return resultado ?? []
    }

    class func cantidadById(id: Int, idServicio:String, inContext context:NSManagedObjectContext) -> Int16 {
        let idPedido = Int16(id)
        let request = NSFetchRequest<Adicionales>(entityName: "Adicionales")
        let predicate1 = NSPredicate(format: "idServicio contains[c] '\(idServicio)'")
        let predicate2 = NSPredicate(format: "idPedido == %i",idPedido)
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        request.predicate = predicates

        let resultado = try? context.fetch(request)
        return resultado?.first?.cantidad ?? 0
    }

    class func calcularTotalById(id: Int, inContext context:NSManagedObjectContext) -> Int16 {
        let idPedido = Int16(id)
        let request = NSFetchRequest<Adicionales>(entityName: "Adicionales")
        let predicate = NSPredicate(format: "idPedido == %i",idPedido)
        request.predicate = predicate
        
        let resultado = try? context.fetch(request)

        if (resultado == nil) {
            return 0
        }

        var total:Int16 = 0
        for servicio in resultado! {
            let precio = servicio.precioFinal
            let cantidad = servicio.cantidad
            total = total + precio * cantidad
        }

        return total
    }

    class func eliminarServicioById(id: Int, idServicio:String, inContext context:NSManagedObjectContext) {
        let idPedido = Int16(id)
        let request : NSFetchRequest<Adicionales> = Adicionales.fetchRequest()
        let predicate1 = NSPredicate(format: "idServicio contains[c] '\(idServicio)'")
        let predicate2 = NSPredicate(format: "idPedido == %i",idPedido)
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        request.predicate = predicates

        let deleteBatch = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteBatch)
            print("éxito borrando el Servicio del Adicionales")
        } catch {
            print("error borrando el Servicio del Adicionales\(error)")
        }
    }

    class func eliminarServiciosById(id: Int, inContext context:NSManagedObjectContext) {
        let idPedido = Int16(id)
        let request : NSFetchRequest<Adicionales> = Adicionales.fetchRequest()
        let predicate = NSPredicate(format: "idPedido == %i",idPedido)
        request.predicate = predicate
        
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteBatch)
            print("éxito borrando el Adicionales")
        } catch {
            print("error borrando el Adicionales\(error)")
        }
    }
}
