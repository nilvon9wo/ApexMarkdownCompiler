public class MKDN_VST_BodyVisitor implements MKDN_VST_VisitorIntf {
	private static MKDN_VST_BodyVisitor INSTANCE;
	MKDN_VST_ParagraphVisitor paragraphVisitor;

    private MKDN_VST_BodyVisitor(MKDN_VST_ParagraphVisitor paragraphVisitor){
    	this.paragraphVisitor = paragraphVisitor;
    }
    
    private MKDN_VST_BodyVisitor(){
    	this(MKDN_VST_ParagraphVisitor.getInstance());
    }
	
    public static MKDN_VST_BodyVisitor getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_VST_BodyVisitor();
    	} 
    	return INSTANCE; 
    }	 
    public String visit (MKDN_ND_Node node) {
		MKDN_ND_BodyNode bodyNode;
		try {
			bodyNode = (MKDN_ND_BodyNode) node;
		}
		catch (System.TypeException ex) {
			throw new MKDN_VST_UnexpectedNodeException ('BodyVisitor supports only MKDN_ND_BodyNode, received: ' + node, ex);
		}

		List<String> stringList = new List<String>(); 	
		for (MKDN_ND_Node paragraph : bodyNode.paragraphList) {
			stringList.add(this.paragraphVisitor.visit(paragraph));
		}	
    	return String.join(stringList, '');
    }
}