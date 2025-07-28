import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class SpeciesTile extends NavigationMixin(LightningElement) {
    @api specie; // la anotación api nos indica que esta variable recibe datos de un componente padre

    //specie.location__c = "Indoors"
    //specie.location__c = "Outdoors"
    //specie.location__c = "Indoors, outdoors"

    get isIndoors(){
        return this.specie.Location__c.includes('Indoors');
    }

    get isOutdoors(){
        return this.specie.Location__c.includes('Outdoors');
    }

    navigateToRecordViewPage() {
        // View a custom object record.
        this[NavigationMixin.Navigate]({
          type: "standard__recordPage",
          attributes: {
            recordId: this.specie.Id,
            objectApiName: "Species__c", // objectApiName is optional
            actionName: "view",
          },
        });
      }
    
}