//
//  Carrito+CoreDataClass.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/1/20.
//
//

import Foundation
import CoreData

@objc(Carrito)
public class Carrito: NSManagedObject {
    
    func copy(servicio: Servicio, cant: Int16) {
        idServicio = String(servicio.idServicio)
        nombreServicio = servicio.nombreServicio
        precio = servicio.precio
        let precioInt = Int16(precio ?? "0") ?? 0
        precioFinal = cant * precioInt
        cantidad = cant
        rutaImagen = servicio.rutaImagen
    }

    class func agregarServicio(idServicio: String, inContext context:NSManagedObjectContext) -> Carrito {
        let request = NSFetchRequest<Carrito>(entityName: "Carrito")
        let predicate = NSPredicate(format: "idServicio=%@", idServicio)
        request.predicate = predicate

        do {
            let resultado = try context.fetch(request)
            if let carrito = resultado.first {
                return carrito
            }
            return Carrito(context: context)
        } catch(let ex) {
            print(ex)
            return Carrito(context: context)
        }
    }

    class func listarServicios(inContext context:NSManagedObjectContext) -> [Carrito] {
        let request = NSFetchRequest<Carrito>(entityName: "Carrito")
        let order = NSSortDescriptor(key: "idServicio", ascending: true)
        request.sortDescriptors = [order]

        let resultado = try? context.fetch(request)
        return resultado ?? []
    }

    class func obtenerServicios(inContext context:NSManagedObjectContext) -> Int {
        let request = NSFetchRequest<Carrito>(entityName: "Carrito")
        let resultado = try? context.fetch(request)
        return resultado?.count ?? 0
    }

    class func cantidadById(idServicio:String, inContext context:NSManagedObjectContext) -> Int16 {
        let request = NSFetchRequest<Carrito>(entityName: "Carrito")
        let predicate = NSPredicate(format: "idServicio contains[c] '\(idServicio)'")
        request.predicate = predicate

        let resultado = try? context.fetch(request)
        return resultado?.first?.cantidad ?? 0
    }

    class func calcularTotal(inContext context:NSManagedObjectContext) -> Int16 {
        let request = NSFetchRequest<Carrito>(entityName: "Carrito")

        let resultado = try? context.fetch(request)

        if (resultado == nil) {
            return 0
        }

        var total:Int16 = 0
        for servicio in resultado! {
            let precio = servicio.precioFinal
            total = total + precio
        }

        return total
    }

    class func eliminarServicio(idServicio:String, inContext context:NSManagedObjectContext) {
        let request : NSFetchRequest<Carrito> = Carrito.fetchRequest()
        let predicate = NSPredicate(format: "idServicio contains[c] '\(idServicio)'")
        request.predicate = predicate

        let deleteBatch = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteBatch)
            print("éxito borrando el Servicio del Carrito")
        } catch {
            print("error borrando el Servicio del Carrito\(error)")
        }
    }

    class func eliminarServicios(inContext context:NSManagedObjectContext) {
        let request : NSFetchRequest<Carrito> = Carrito.fetchRequest()
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteBatch)
            print("éxito borrando el Carrito")
        } catch {
            print("error borrando el Carrito\(error)")
        }
    }
}
