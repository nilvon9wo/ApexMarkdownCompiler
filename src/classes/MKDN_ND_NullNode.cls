public class MKDN_ND_NullNode extends MKDN_ND_Node{
	private static MKDN_ND_NullNode INSTANCE;
	
    private MKDN_ND_NullNode(){
    }
     
    public static MKDN_ND_NullNode getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_ND_NullNode(); 
    	} 
    	return INSTANCE; 
    }

    public override Boolean isNull() {
    	return true;
    }
}