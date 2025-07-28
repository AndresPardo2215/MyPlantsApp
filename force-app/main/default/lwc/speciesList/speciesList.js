import { LightningElement, wire } from 'lwc';
import getFilteredSpecies from '@salesforce/apex/SpeciesService.getFilteredSpecies';

export default class SpeciesList extends LightningElement {
    //PROPERTIES
    searchText='';

    //LIFECYCLE HOOKS


    //WIRE
    @wire(getFilteredSpecies, {searchText: '$searchText'})
    species; //esto es una variable que nos permite recibir datos de un componente padre es una propiedad


    //METHODS
    handleInputChange(event) {
        const searchTextAux = event.target.value;
        console.log('texto recibido:' + searchTextAux);
        if(searchTextAux.length >= 3 || searchTextAux === ''){
            this.searchText = searchTextAux;
        }
    }
}