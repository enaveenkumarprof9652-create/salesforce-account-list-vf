({
    doInit : function(component, event, helper) {
        // Set columns as a proper JS array
        component.set("v.columns", [
            { label:'First Name', fieldName:'FirstName', type:'text' },
            { label:'Last Name', fieldName:'LastName', type:'text' },
            { label:'Email', fieldName:'Email', type:'email' },
            { label:'Edit', type:'button', typeAttributes:{ label:'Edit', name:'edit', variant:'brand' } },
            { label:'Delete', type:'button', typeAttributes:{ label:'Delete', name:'delete', variant:'destructive' } }
        ]);

        helper.loadData(component);
    },

    searchContacts : function(component, event, helper) {
        component.set("v.pageNumber", 1); // reset to first page on search
        helper.loadData(component);
    },

    openNewModal : function(component) {
        component.set("v.isEdit", false);
        component.set("v.contactRecord", {'sObjectType':'Contact'});
        component.set("v.isModalOpen", true);
    },

    closeModal : function(component) {
        component.set("v.isModalOpen", false);
    },

    saveRecord : function(component, event, helper) {
        helper.saveRecordHelper(component);
    },

    handleRowAction : function(component, event, helper) {
        let action = event.getParam("action").name;
        let row = event.getParam("row");

        if(action === "edit"){
            helper.editContact(component, row);
        }
        else if(action === "delete"){
            helper.deleteContact(component, row);
        }
    },

    nextPage : function(component, event, helper) {
        component.set("v.pageNumber", component.get("v.pageNumber") + 1);
        helper.loadData(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.pageNumber", component.get("v.pageNumber") - 1);
        helper.loadData(component);
    }
})