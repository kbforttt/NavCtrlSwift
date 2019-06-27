protocol DAO {
    
    // company methods
    func addCompany(name: String, ticker: String, imageUrl: String)
    func editCompany(company: CompanyMO, name: String, ticker: String, imageUrl: String)
    func deleteCompany(company: CompanyMO)
    func getCompanies()-> [CompanyMO]
    
    // product methods
    func addProduct(name: String, imageUrl: String, productUrl: String)
    func editProduct(companyIndex: Int, productIndex: Int, name: String, imageUrl: String, productUrl: String)
    func deleteProduct(companyIndex: Int, productIndex: Int)
    func getProducts(companyIndex: Int)-> [ProductMO]
    
}
