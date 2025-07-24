import { LightningElement } from 'lwc';

export default class SpeciesTile extends LightningElement {
    specie = { /* esta es una propiedad, que va a guardar el estado de mi componente */
        Name: "Jazmin",
        Description: "Olorosa y bonita planta trepadora",
        Image_URL__c: "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
        Location__c: "Indoors, Outdoors",
    };
}