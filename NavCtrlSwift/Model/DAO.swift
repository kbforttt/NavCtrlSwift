protocol DAO {
    
    func addCompany(name: String, ticker: String, imageUrl: String)
    
    func deleteCompany(index: Int)
    
    func getCompanies()-> [CompanyMO]
    
}
