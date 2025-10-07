/**
* @File Name : AccountListController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 8, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 8, 2025 |   | Initial Version
**/

public class AccountListController {
    public List<Account> accounts { get; set; }
    public String industryFilter { get; set; }

    public Integer pageSize { get; set; }
    public Integer currentPage { get; set; }
    public Integer totalRecords { get; set; }

    public AccountListController() {
        pageSize = 5;
        currentPage = 1;
        filterAccounts();
    }
	public void filterAccounts() {
    Integer offsetVal = (currentPage - 1) * pageSize;
    String filter = industryFilter != null && industryFilter.trim() != '' ? '%' + industryFilter + '%' : null;

    // Query to get paginated Accounts
    String query = 'SELECT Id, Name, Industry FROM Account';
    if (filter != null) {
        query += ' WHERE Industry LIKE :filter';
    }
    query += ' LIMIT :pageSize OFFSET :offsetVal';

    accounts = Database.query(query);

    // Query to count total records
    if (filter != null) {
        totalRecords = [SELECT COUNT() FROM Account WHERE Industry LIKE :filter];
    } else {
        totalRecords = [SELECT COUNT() FROM Account];
    }
}


    public void next() {
        if ((currentPage * pageSize) < totalRecords) {
            currentPage++;
            filterAccounts();
        }
    }

    public void previous() {
        if (currentPage > 1) {
            currentPage--;
            filterAccounts();
        }
    }

    public PageReference editAccount() {
        String accountId = ApexPages.currentPage().getParameters().get('accountId');
        return new PageReference('/' + accountId);
    }

    public void deleteAccount() {
        String accountId = ApexPages.currentPage().getParameters().get('accountId');
        if (accountId != null) {
            try {
                delete [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
            } catch (Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error deleting account: ' + e.getMessage()));
            }
            filterAccounts(); // Refresh list after deletion
        }
    }

    public Boolean getHasPrevious() {
        return currentPage > 1;
    }

    public Boolean getHasNext() {
        return (currentPage * pageSize) < totalRecords;
    }
}