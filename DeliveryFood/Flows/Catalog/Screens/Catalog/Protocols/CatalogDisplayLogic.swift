extension Catalog.Screen.Catalog {
    protocol DisplayLogic: AnyObject {
        func update(sections: [Section])
    }
}
