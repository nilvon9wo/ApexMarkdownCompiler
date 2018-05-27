public class MKDN_VST_EmphasisVisitor implements MKDN_VST_VisitorIntf {
	private static MKDN_VST_EmphasisVisitor INSTANCE;

    public static MKDN_VST_EmphasisVisitor getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_VST_EmphasisVisitor();
    	} 
    	return INSTANCE; 
    }	 
    
    public String visit (MKDN_ND_Node node) { 
    	return '<em>' + node.value + '</em>';
    }    
}