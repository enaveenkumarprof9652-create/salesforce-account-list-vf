# salesforce-account-list-vf
A simple Visualforce page example that displays a list of Account records with features to include pagination, filtering, and actions.
The page includes basic functionality such as:
A Visualforce page
A corresponding Apex controller to retrieve the Account records
**Explanation:
Visualforce Page:**
The page uses the <apex:page> tag with a controller attribute pointing to the AccountListController class.
The page displays a title, and then uses an <apex:pageBlock> and <apex:pageBlockTable> to create a simple table.
The value="{!accounts}" binds the list of Account records fetched from the controller, and the var="acc" defines a variable for each individual Account in the table.
The <apex:column> tags display specific fields (Account Name and Industry).

**Apex Controller:**
The AccountListController class has a property accounts to hold the list of Account records.
The constructor of the controller executes a SOQL query to fetch the Name and Industry of the top 10 Accounts.
These records are then displayed on the Visualforce page.

**How to Use:**
Create the Visualforce page in Salesforce by navigating to Setup > Visualforce Pages and create a new page named AccountListPage with the provided code.
Create the Apex controller by going to Setup > Apex Classes and create a new class called AccountListController with the given code.
You can now access the page by navigating to /apex/AccountListPage in your Salesforce org.

**Features we'll add:**
Pagination: We'll add the ability to navigate through multiple pages of Account records.
Filtering: Users can filter the Account list by Industry.
Actions: We'll add buttons for editing an Account or deleting an Account

**Explanation of Enhancements:**
**Pagination:**
We added pagination logic using LIMIT and OFFSET in the SOQL query. The currentPage and pageSize variables control the pagination.
Methods next() and previous() are provided to navigate between pages.
The totalRecords variable holds the total number of records for pagination control.
**Filtering:**
A industryFilter property is added to allow users to filter the accounts by Industry.
The filterAccounts() method is responsible for dynamically adjusting the SOQL query based on the filter and page.
Users can input the Industry to filter the accounts, and the filter applies when they click the "Filter" button.
**Actions (Edit/Delete):**
Each account has an Edit and Delete link in the last column. The Edit link navigates to the standard Salesforce account detail page.
The Delete link allows users to delete an Account record, after which the list is refreshed.
**Pagination Controls:**
The "Previous" and "Next" links are displayed based on whether there are more pages to show. These links are rendered conditionally using hasPrevious and hasNext methods.

**How It Works:**
**Filtering:**
Users can type in an Industry name to filter the accounts. After filtering, the table displays only the matching accounts, limited to the pageSize number of records.
**Pagination:**
Clicking "Next" or "Previous" will load the next or previous set of Account records, with the filter still applied.
**Edit/Delete:**
The "Edit" button takes users to the record's standard detail page, and the "Delete" button deletes the record and reloads the page with the remaining accounts.
