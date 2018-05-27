public class MKDN_VST_TextVisitor implements MKDN_VST_VisitorIntf {
	private static MKDN_VST_TextVisitor INSTANCE;

    public static MKDN_VST_TextVisitor getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_VST_TextVisitor();
    	} 
    	return INSTANCE; 
    }	 
    
    public String visit (MKDN_ND_Node node) {
    	return node.value; 
    }    
}