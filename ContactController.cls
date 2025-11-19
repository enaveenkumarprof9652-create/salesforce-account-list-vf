public class ContactController {

    @AuraEnabled(cacheable=false)
    public static Map<String, Object> getContacts(String searchKey, Integer pageNumber, Integer pageSize) {

        if (searchKey == null) searchKey = '';
        if (pageNumber == null) pageNumber = 1;
        if (pageSize == null) pageSize = 5;

        Integer offsetValue = (pageNumber - 1) * pageSize;

        String likeSearch = '%' + searchKey + '%';

        List<Contact> contacts = [
            SELECT Id, FirstName, LastName, Email
            FROM Contact
            WHERE FirstName LIKE :likeSearch 
               OR LastName LIKE :likeSearch
               OR Email LIKE :likeSearch
            ORDER BY LastName
            LIMIT :pageSize OFFSET :offsetValue
        ];

        Integer totalCount = [
            SELECT COUNT()
            FROM Contact
            WHERE FirstName LIKE :likeSearch 
               OR LastName LIKE :likeSearch
               OR Email LIKE :likeSearch
        ];

        return new Map<String, Object>{
            'contacts' => contacts,
            'totalRecords' => totalCount
        };
    }

    @AuraEnabled
    public static void saveContact(Contact con) {
        upsert con;
    }

    @AuraEnabled
    public static void deleteContact(Id contactId) {
        delete [SELECT Id FROM Contact WHERE Id = :contactId];
    }
}