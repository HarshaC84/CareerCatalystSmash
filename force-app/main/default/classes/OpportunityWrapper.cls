global class OpportunityWrapper implements Comparable {

    public Opportunity oppy;
    public Boolean isSortByAmount;

    // Constructor
    public OpportunityWrapper(Opportunity op,Boolean isSortByAmount) {
        oppy = op;
        this.isSortByAmount = isSortByAmount;
    }

    // Compare opportunities based on the opportunity amount.
    global Integer compareTo(Object compareTo) {
        // Cast argument to OpportunityWrapper
        OpportunityWrapper compareToOppy = (OpportunityWrapper)compareTo;

        // The return value of 0 indicates that both elements are equal.
        Integer returnValue = 0;
        if(isSortByAmount){
            if (oppy.Amount > compareToOppy.oppy.Amount) {
                // Set return value to a positive value.
                returnValue = 1;
            } else if (oppy.Amount < compareToOppy.oppy.Amount) {
                // Set return value to a negative value.
                returnValue = -1;
            }
        }
        else{
            if (oppy.CloseDate > compareToOppy.oppy.CloseDate) {
                // Set return value to a positive value.
                returnValue = 1;
            } else if (oppy.CloseDate < compareToOppy.oppy.CloseDate) {
                // Set return value to a negative value.
                returnValue = -1;
            }
        }
        
        return returnValue;       
    }
    
}