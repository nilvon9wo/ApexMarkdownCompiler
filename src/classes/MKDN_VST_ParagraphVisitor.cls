public class MKDN_VST_ParagraphVisitor implements MKDN_VST_VisitorIntf {
	private static MKDN_VST_ParagraphVisitor INSTANCE;
	MKDN_VST_SentenceVisitor sentenceVisitor;

    private MKDN_VST_ParagraphVisitor(MKDN_VST_SentenceVisitor sentenceVisitor){
    	this.sentenceVisitor = sentenceVisitor;
    }
    
    private MKDN_VST_ParagraphVisitor(){
    	this(MKDN_VST_SentenceVisitor.getInstance());
    }
	
    public static MKDN_VST_ParagraphVisitor getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_VST_ParagraphVisitor();
    	} 
    	return INSTANCE; 
    }	 
    public String visit (MKDN_ND_Node node) {
		MKDN_ND_ParagraphNode paragraphNode;
		try {
			paragraphNode = (MKDN_ND_ParagraphNode) node;
		}
		catch (System.TypeException ex) {
			throw new MKDN_VST_UnexpectedNodeException ('ParagraphVisitor supports only MKDN_ND_ParagraphNode, received: ' + node, ex);
		}

		List<String> stringList = new List<String>(); 	
		for (MKDN_ND_Node sentence : paragraphNode.sentenceList) {  
			stringList.add('<p>' + this.sentenceVisitor.visit(sentence) + '</p>');
		}	
    	return String.join(stringList, '');
    }
}