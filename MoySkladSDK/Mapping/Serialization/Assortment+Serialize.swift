//
//  Assortment+Serialize.swift
//  MoyskladiOSRemapSDK
//
//  Created by Vladislav on 16.10.17.
//  Copyright © 2017 Andrey Parshakov. All rights reserved.
//

import Foundation

extension MSAssortment {
    public func dictionary(metaOnly: Bool = true) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        dict["meta"] = meta.dictionary()
        guard !metaOnly else { return dict }
        
        dict.merge(info.dictionary())
        dict.merge(id.dictionary())
        
        dict["accountId"] = accountId
        dict["shared"] = shared
        dict["group"] = serialize(entity: group, metaOnly: true)
        dict["owner"] = serialize(entity: owner, metaOnly: true)
        dict["productFolder"] = serialize(entity: productFolder, metaOnly: true)
        dict["supplier"] = serialize(entity: supplier, metaOnly: true)
        dict["uom"] = serialize(entity: uom, metaOnly: true)

        if !assortmentInfo.dictionary().isEmpty {
            dict["assortmentInfo"] = assortmentInfo.dictionary()
        }
        
        if let alcohol = alcohol?.dictionary() {
            dict["alcohol"] = alcohol
        }
        
        if let buyPrice = buyPrice?.dictionary() {
            dict["buyPrice"] = buyPrice
        }
        
        if let image = image?.dictionary() {
            dict["image"] = image
        }
        
        dict["country"] = country?.objectMeta().dictionary() ?? NSNull()
        dict["code"] = code ?? ""
        dict["externalCode"] = externalCode ?? ""
        dict["archived"] = archived
        dict["pathName"] = pathName ?? ""
        dict["vat"] = vat ?? 0
        dict["effectiveVat"] = effectiveVat ?? 0
        dict["article"] = article ?? ""
        dict["weighed"] = weighed
        dict["weight"] = weight 
        dict["volume"] = volume
        dict["modificationsCount"] = modificationsCount ?? 0
        dict["minimumBalance"] = minimumBalance ?? 0
        dict["isSerialTrackable"] = isSerialTrackable
        dict["stock"] = stock ?? 0
        dict["reserve"] = reserve ?? 0
        dict["inTransit"] = inTransit ?? 0
        dict["quantity"] = quantity ?? 0
        dict["description"] = description ?? ""
        dict["salePrices"] = salePrices.map { $0.dictionary() }
        dict["barcodes"] = barcodes
        dict["attributes"] = attributes?.flatMap { $0.value() }.map { $0.dictionary(metaOnly: false) }
        
        return dict
    }
    
    public func requestUrl() -> MSApiRequest? {
        return MSApiRequest.product
    }
    
    public func deserializationError() -> MSError {
        return MSError.genericError(errorText: LocalizedStrings.incorrectProductResponse.value)
    }
}

extension MSPrice {
    public func dictionary() -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        dict["priceType"] = priceType ?? ""
        dict["value"] = value.minorUnits
        
        if type(of: serialize(entity: currency, metaOnly: true)) != type(of: NSNull()) {
            dict["currency"] = serialize(entity: currency, metaOnly: true)
        }
        
        return dict
    }
}

extension MSAlcohol {
    public func dictionary() -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        dict["excise"] = excise
        dict["type"] = type ?? ""
        dict["strength"] = strength ?? 0
        dict["volume"] = volume ?? 0
        
        return dict
    }
}

extension MSAssortmentInfo {
    public func dictionary() -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        dict["productFolder"] = serialize(entity: productFolder, metaOnly: true)
        dict["product"] = serialize(entity: product, metaOnly: true)
        
        if components.count > 0 {
            dict["components"] = components.flatMap { $0.value() }.map { $0.dictionary(metaOnly: false) }
        }
        
        return dict
    }
}

extension MSProduct {
    public func dictionary(metaOnly: Bool = true) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        dict["meta"] = meta.dictionary()
        guard !metaOnly else { return dict }
        
        dict.merge(info.dictionary())
        dict.merge(id.dictionary())
        
        dict["accountId"] = accountId
        dict["shared"] = shared
        dict["article"] = article ?? ""
        dict["code"] = code ?? ""
        dict["description"] = description ?? ""
        dict["productFolder"] = serialize(entity: productFolder, metaOnly: true)
        dict["supplier"] = serialize(entity: supplier, metaOnly: true)
        dict["salePrices"] = salePrices.map { $0.dictionary() }
        
        if let buyPrice = buyPrice?.dictionary() {
            dict["buyPrice"] = buyPrice
        }
        
        if let image = image?.dictionary() {
            dict["image"] = image
        }
        
        return dict
    }
}

extension MSImage {
    public func dictionary() -> Dictionary<String, Any> {
        var dict = [String: Any]()
    
        dict["title"] = title
        dict["filename"] = filename
        dict["size"] = size
        dict["miniatureUrl"] = miniatureUrl.absoluteString
        dict["tinyUrl"] = tinyUrl?.absoluteString ?? ""
        
        return dict
    }
}

extension MSBundleComponent {
    public func dictionary(metaOnly: Bool = true) -> Dictionary<String, Any> {
        var dict = [String: Any]()
        
        dict["meta"] = meta.dictionary()
        guard !metaOnly else { return dict }
        
        dict.merge(id.dictionary())
        
        dict["accountId"] = accountId
        dict["quantity"] = quantity
        dict["assortment"] = serialize(entity: assortment, metaOnly: false)
       
        return dict
    }
}