public virtual class MKDN_ND_Node implements MKDN_IsNullableIntf{
    public MKDN_ND_NodeTypeEnum nodeType {get; protected set;}
    public String value {get; protected set;} 
    public Integer consumed {get; protected set;} 
    
    public MKDN_ND_Node(MKDN_ND_NodeTypeEnum nodeType, String value, Integer consumed) {
    	if (nodeType == null) {
    		throw new MKDN_ND_InvalidNodeException('Type must have values; value is: ' + value);
    	} 
    	
    	if (value == null) {
    		throw new MKDN_ND_InvalidNodeException('Value must have values; type is: ' + nodeType);
    	} 

    	this.nodeType = nodeType;
    	this.value = value;
    	this.consumed = consumed;
    }
    
    protected MKDN_ND_Node() {
    }

    public virtual Boolean isNull() {
    	return false;
    }
}