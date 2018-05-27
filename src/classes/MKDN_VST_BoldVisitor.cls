public class MKDN_VST_BoldVisitor implements MKDN_VST_VisitorIntf {
	private static MKDN_VST_BoldVisitor INSTANCE;

    public static MKDN_VST_BoldVisitor getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_VST_BoldVisitor();
    	} 
    	return INSTANCE; 
    }	 
    
    public String visit (MKDN_ND_Node node) {
    	return '<strong>' + node.value + '</strong>';
    }    
}