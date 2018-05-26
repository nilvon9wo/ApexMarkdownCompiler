public virtual class MKDN_TKN_Token implements MKDN_IsNullableIntf {
    public MKDN_TKN_TokenTypeEnum tokenType {get; protected set;}
    public String value {get; protected set;} 
    
    public MKDN_TKN_Token(MKDN_TKN_TokenTypeEnum tokenType, String value) {
    	if (tokenType == null) {
    		throw new MKDN_TKN_InvalidTokenException('Type must have values; value is: ' + value);
    	} 
    	
    	if (value == null) {
    		throw new MKDN_TKN_InvalidTokenException('Value must have values; type is: ' + tokenType);
    	}     	
    	
    	this.tokenType = tokenType;
    	this.value = value;
    }
    
    protected MKDN_TKN_Token() {
    }

    public Integer length() {
    	return value.length();
    }
     
    public virtual Boolean isNull() {
    	return false;
    }
    
    public Boolean isPresent() {
    	return true;
    }
    
    public override String toString() {
    	return '<type:' + this.tokenType + ', value:' + this.value + '>';
    }
}