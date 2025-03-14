enum TabType: CaseIterable {
    case catalog
//    case cart
    case profile
    
    var title: String {
        switch self {
        case .catalog:
            return "Catalog"
//        case .cart:
//            return "Cart"
        case .profile:
            return "Profile"
        
        }
    }
    
    var imageName: String {
        switch self {
        case .catalog:
            return "house"
//        case .cart:
//            return "bell"
        case .profile:
            return "person"
        }
    }
}
