public virtual class MKDN_TKN_Token {
    public MKDN_TokenTypeEnum tokenType {get; protected set;}
    public String value {get; protected set;} 
    
    public MKDN_TKN_Token(MKDN_TokenTypeEnum tokenType, String value) {
    	if (tokenType == null || value == null) {
    		throw new MKDN_InvalidTokenException('Type and value must both have values.');
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