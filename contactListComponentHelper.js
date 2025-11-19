({
    loadData : function(component) {
        var action = component.get("c.getContacts");
        action.setParams({
            searchKey : component.get("v.searchKey") || '',
            pageNumber: component.get("v.pageNumber"),
            pageSize  : component.get("v.pageSize")
        });

        action.setCallback(this, function(res){
            if(res.getState() === "SUCCESS"){
                let result = res.getReturnValue();
                component.set("v.contacts", result.contacts);
                component.set("v.totalRecords", result.totalRecords);
                component.set("v.totalPages", Math.ceil(result.totalRecords / component.get("v.pageSize")));
            } else if(res.getState() === "ERROR") {
                console.error(res.getError());
            }
        });

        $A.enqueueAction(action);
    },

    saveRecordHelper : function(component) {
        let rec = component.get("v.contactRecord");

        if(!rec.LastName){
            this.showToast("Error", "Last Name is required", "error");
            return;
        }

        var action = component.get("c.saveContact");
        action.setParams({ con : rec });

        action.setCallback(this, (res)=>{
            if(res.getState() === "SUCCESS"){
                this.showToast("Success", "Contact saved successfully", "success");
                component.set("v.isModalOpen", false);
                this.loadData(component);
            } else if(res.getState() === "ERROR") {
                console.error(res.getError());
            }
        });

        $A.enqueueAction(action);
    },

    editContact : function(component, row) {
        component.set("v.isEdit", true);
        component.set("v.contactRecord", row);
        component.set("v.isModalOpen", true);
    },

    deleteContact : function(component, row) {
        var action = component.get("c.deleteContact");
        action.setParams({ contactId : row.Id });

        action.setCallback(this, res=>{
            if(res.getState() === "SUCCESS"){
                this.showToast("Deleted", "Contact deleted", "success");
                this.loadData(component);
            } else if(res.getState() === "ERROR") {
                console.error(res.getError());
            }
        });

        $A.enqueueAction(action);
    },

    showToast : function(title, message, type) {
        let toast = $A.get("e.force:showToast");
        toast.setParams({
            title: title,
            message: message,
            type: type
        });
        toast.fire();
    }
})